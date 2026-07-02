<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sales extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Sales_model');
        $this->load->model('customer/Customer_model');
    }

    public function index()
    {
        $data['sales'] = $this->Sales_model->get_sales();
        $data['base_url'] = base_url();
        $this->smarty->loadView('sales_list.tpl', $data, 'Yes', 'Yes');
    }

    public function create_sale()
    {
        $data['base_url'] = base_url();
        $data['customers'] = $this->Customer_model->get_customer();
        $data['products'] = $this->Customer_model->get_products();
        $this->smarty->loadView('create_sale.tpl', $data, 'Yes', 'Yes');
    }

    public function save_sale()
    {
        $ret_arr = ['success' => 1, 'msg' => ''];

        $customer_mobile = $this->input->post('customer_mobile');
        $customer_name = $this->input->post('customer_name');
        $bill_no = $this->input->post('bill_no');
        $sales_date = $this->input->post('sales_date');
        $payment_mode = $this->input->post('payment_mode');

        $products = $this->input->post('product_id');
        $qtys = $this->input->post('qty');
        $prices = $this->input->post('price');
        $item_totals = $this->input->post('total');

        if (empty($products)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Please add at least one item to the bill.';
            echo json_encode($ret_arr);
            return;
        }

        $total_amount = array_sum($item_totals);
        $discount = $this->input->post('discount') ? (float) $this->input->post('discount') : 0;

        $payable_amount = $total_amount - $discount;
        if ($payable_amount < 0) {
            $payable_amount = 0;
            $discount = $total_amount;
        }

        $master_data = [
            'customer_phone_number' => $customer_mobile,
            'customer_name' => $customer_name,
            'bill_no' => $bill_no,
            'sales_date' => $sales_date,
            'total_amount' => $total_amount,
            'discount_amount' => $discount,
            'payable_amount' => $payable_amount,
            'paid_amount' => $payable_amount,
            'payment_status' => 'Paid',
            'payment_mode' => $payment_mode,
            'added_date' => date('Y-m-d H:i:s'),
            'added_by' => $this->session->userdata('user_id')
        ];

        $details_data = [];
        foreach ($products as $key => $product_id) {
            $details_data[] = [
                'product_id' => $product_id,
                'qty' => $qtys[$key],
                'sale_price' => $prices[$key],
                'total_amount' => $item_totals[$key]
            ];
        }

        $sales_id = $this->Sales_model->save_sale($master_data, $details_data);

        if ($sales_id) {
            $ret_arr['msg'] = 'Sales bill saved successfully and stock deducted.';
            $ret_arr['sales_id'] = $sales_id;
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to save sales transaction.';
        }

        echo json_encode($ret_arr);
    }

    public function sales_details_ajax()
    {
        $sales_id = $this->input->post('sales_id');
        $data['sale'] = $this->Sales_model->get_sale_master($sales_id);
        $data['items'] = $this->Sales_model->get_sale_items($sales_id);

        $html = $this->smarty->fetch('sales_details_modal.tpl', $data);
        echo json_encode(['success' => 1, 'html' => $html]);
    }

    // -----------------------------------------------------------------------
    // Private helpers
    // -----------------------------------------------------------------------

    /**
     * Load all rows from config_setting as an associative array [name => value]
     */
    private function _get_company_settings()
    {
        $query = $this->db->select('name, value')->from('config_setting')->get();
        $settings = [];
        foreach ($query->result_array() as $row) {
            $settings[$row['name']] = $row['value'];
        }
        return $settings;
    }

    /**
     * Convert a server-relative logo path to an inline data: URI for PDF rendering
     */
    private function _get_logo_base64($logo_path)
    {
        if (empty($logo_path))
            return '';
        $abs = FCPATH . ltrim($logo_path, '/');
        if (file_exists($abs)) {
            $mime = mime_content_type($abs);
            return 'data:' . $mime . ';base64,' . base64_encode(file_get_contents($abs));
        }
        return '';
    }

    /**
     * Build the common data array required by the invoice template
     */
    private function _build_invoice_data($sales_id)
    {
        $this->load->model('company/Company_model');
        $comp_master = $this->Company_model->get_company();

        $data['sale'] = $this->Sales_model->get_sale_master($sales_id);
        $data['items'] = $this->Sales_model->get_sale_items($sales_id);
        $data['base_url'] = base_url();

        $data['company_name'] = !empty($comp_master['company_name']) ? $comp_master['company_name'] : 'Your Company';

        $address_parts = [];
        if (!empty($comp_master['address']))
            $address_parts[] = $comp_master['address'];
        if (!empty($comp_master['city']))
            $address_parts[] = $comp_master['city'];
        if (!empty($comp_master['state']))
            $address_parts[] = $comp_master['state'] . (!empty($comp_master['pincode']) ? ' - ' . $comp_master['pincode'] : '');
        $data['company_address'] = implode(', ', $address_parts);

        $data['company_gst'] = !empty($comp_master['gst_number']) ? $comp_master['gst_number'] : '';

        $logo_path = !empty($comp_master['company_logo']) ? 'public/uploads/company/' . $comp_master['company_logo'] : '';
        $data['logo_base64'] = $this->_get_logo_base64($logo_path);

        return $data;
    }

    // -----------------------------------------------------------------------
    // Invoice actions
    // -----------------------------------------------------------------------

    /**
     * Download Invoice as PDF via dompdf
     * Route: sales/download_invoice/{id}
     */
    public function download_invoice($sales_id)
    {
        $get_data = $this->input->get();
        $data = $this->_build_invoice_data($sales_id);

        if (empty($data['sale'])) {
            show_404();
            return;
        }

        $html = $this->smarty->loadView('sales_invoice_print.tpl', $data, 'No', 'No', TRUE);
        $this->load->library('Pdf');
        $pdf = new Pdf();
        $pdf->loadHtml($html);
        $pdf->setPaper('A4', 'portrait');
        $pdf->render();
        $pdf->stream('Invoice_' . $data['sale']['bill_no'] . '.pdf', ['Attachment' => 1]);
    }

    /**
     * Open Invoice in browser for printing (triggers window.print())
     * Route: sales/print_invoice/{id}
     */
    public function print_invoice($sales_id)
    {
        $data = $this->_build_invoice_data($sales_id);

        if (empty($data['sale'])) {
            show_404();
            return;
        }

        // Standalone HTML page — no site header/footer wrapper
        $html = $this->smarty->loadView('sales_invoice_print.tpl', $data, 'No', 'No', TRUE);

        $this->load->library('Pdf');
        $pdf = new Pdf();
        $pdf->loadHtml($html);
        $pdf->setPaper('A4', 'portrait');
        $pdf->render();
        $pdf->stream('Invoice_' . $data['sale']['bill_no'] . '.pdf', ['Attachment' => 0]);
    }
}
