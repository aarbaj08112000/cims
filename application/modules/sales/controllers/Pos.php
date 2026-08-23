<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pos extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Sales_model');
        $this->load->model('customer/Customer_model');
    }

    public function index()
    {
        $this->load->model('settings/Settings_model');
        $settings = $this->Settings_model->get_all_settings();
        foreach ($settings as $setting) {
            $data['settings'][$setting['name']] = $setting;
        }

        $data['base_url'] = base_url();
        $data['customers'] = $this->Customer_model->get_customer();
        // Generate a temporary bill number
        $data['bill_no'] = 'POS-' . time();
        $this->smarty->loadView('pos_billing.tpl', $data, 'Yes', 'Yes');
    }

    public function get_product_ajax()
    {
        $barcode = $this->input->post('barcode');
        $product = $this->Sales_model->get_product_by_barcode($barcode);

        if ($product) {
            echo json_encode(['success' => 1, 'product' => $product]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Product not found']);
        }
    }

    public function search_products_ajax()
    {
        $term = $this->input->get('term');
        $products = $this->Sales_model->search_products($term);

        $results = [];
        foreach ($products as $p) {
            $results[] = [
                'id' => $p['product_id'],
                'label' => $p['name'] . ' (' . $p['product_code'] . ')',
                'value' => $p['name'],
                'product' => $p
            ];
        }
        echo json_encode($results);
    }

    public function save_bill()
    {
        $ret_arr = ['success' => 1, 'msg' => ''];

        $customer_name = $this->input->post('customer_name');
        $customer_mobile = $this->input->post('customer_mobile');
        $bill_no = $this->input->post('bill_no');
        $sales_date = date('Y-m-d');
        $payment_mode = $this->input->post('payment_mode');

        $products = $this->input->post('product_id');
        $qtys = $this->input->post('qty');
        $prices = $this->input->post('price');
        $item_totals = $this->input->post('total');
        $subtotal = $this->input->post('subtotal');
        $grand_total = $this->input->post('grand_total');

        if (empty(trim((string) $customer_name))) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Customer Name is required.';
            echo json_encode($ret_arr);
            return;
        }

        if (empty($products)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Please add at least one item to the bill.';
            echo json_encode($ret_arr);
            return;
        }

        $master_data = [
            'customer_name' => $customer_name,
            'customer_phone_number' => $customer_mobile,
            'bill_no' => $bill_no,
            'sales_date' => $sales_date,
            'total_amount' => $subtotal,
            'payable_amount' => $grand_total,
            'paid_amount' => $grand_total,
            'payment_status' => 'Paid',
            'payment_mode' => $payment_mode,
            'added_date' => date('Y-m-d H:i:s'),
            'added_by' => $this->session->userdata('user_id')
        ];

        $details_data = [];
        foreach ($products as $key => $product_id) {
            $qty = (int) ($qtys[$key] ?? 1);
            $price = (float) ($prices[$key] ?? 0);

            // Defensively handle row total: if provided as string, cast it; if empty or zero, calculate it
            $row_total = isset($item_totals[$key]) && $item_totals[$key] !== "" ? (float) $item_totals[$key] : ($qty * $price);

            $details_data[] = [
                'product_id' => $product_id,
                'qty' => $qty,
                'sale_price' => $price,
                'total_amount' => $row_total
            ];
        }

        $sales_id = $this->Sales_model->save_sale($master_data, $details_data);

        if ($sales_id) {
            $ret_arr['msg'] = 'POS bill saved successfully!';
            $ret_arr['sales_id'] = $sales_id;
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to save transaction.';
        }

        echo json_encode($ret_arr);
    }

    public function get_bill_print_ajax()
    {
        $sales_id = $this->input->post('sales_id');
        $data['received_amount'] = (float) $this->input->post('received_amount');
        $data['change_amount'] = (float) $this->input->post('change_amount');

        $data['sale'] = $this->Sales_model->get_sale_master($sales_id);
        $data['items'] = $this->Sales_model->get_sale_items($sales_id);
        $data['base_url'] = base_url();

        // Fetch settings for company branding
        $this->load->model('settings/Settings_model');
        $settings = $this->Settings_model->get_all_settings();
        foreach ($settings as $setting) {
            $data['settings'][$setting['name']] = $setting;
        }

        // Generate real barcode image as base64 data URI
        $bill_no = $data['sale']['bill_no'] ?? 'UNKNOWN';
        $data['barcode_img'] = $this->_generate_barcode_base64($bill_no);

        $html = $this->smarty->fetch('pos_bill_print.tpl', $data);
        echo json_encode(['success' => 1, 'html' => $html]);
    }

    /**
     * Generate a Code128 barcode PNG and return it as a base64 data URI.
     */
    private function _generate_barcode_base64($text)
    {
        $this->load->library('Barcode_gen');
        $tmp_path = FCPATH . 'uploads/tmp_barcode_' . md5($text) . '.png';
        $this->barcode_gen->generate($text, $tmp_path);
        if (file_exists($tmp_path)) {
            $img_data = base64_encode(file_get_contents($tmp_path));
            unlink($tmp_path);
            return 'data:image/png;base64,' . $img_data;
        }
        return '';
    }

    public function download_receipt_pdf($sales_id, $action = 'inline')
    {
        $data['sale'] = $this->Sales_model->get_sale_master($sales_id);
        $data['items'] = $this->Sales_model->get_sale_items($sales_id);
        $data['base_url'] = base_url();
        $data['is_pdf'] = true;

        $this->load->model('settings/Settings_model');
        $settings = $this->Settings_model->get_all_settings();
        foreach ($settings as $setting) {
            $data['settings'][$setting['name']] = $setting;
        }

        // Generate real barcode image as base64 data URI
        $bill_no = $data['sale']['bill_no'] ?? 'UNKNOWN';
        $data['barcode_img'] = $this->_generate_barcode_base64($bill_no);
        $data['gar_dark'] = "#000000";
        $data['gar_light'] = "#000000";
        $data['gar_light2'] = "#000000";
        $html = $this->smarty->fetch('pos_bill_print_pdf.tpl', $data);

        if ($action == 'html') {
            echo $html;
            return;
        }

        $this->load->library('Pdf');
        $pdf = new Pdf();
        $pdf->loadHtml($html);
        // Calculate dynamic height: base height + (item count * row height)
        $base_height = 580;
        $item_height = 40;
        $item_count = isset($data['items']) ? count($data['items']) : 0;
        $dynamic_height = $base_height + ($item_count * $item_height);

        // Set paper width to accommodate 96dpi px-to-pt scaling differences in Dompdf, with dynamic height for thermal rolls
        $pdf->setPaper(array(0, 0, 260, $dynamic_height), 'portrait');
        $pdf->render();
        
        $attachment = ($action == 'download') ? 1 : 0;
        $pdf->stream('POS_Receipt_' . $bill_no . '.pdf', ['Attachment' => $attachment]);
    }
}
