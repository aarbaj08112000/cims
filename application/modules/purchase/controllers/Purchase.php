<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Purchase extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Purchase_model');
        $this->load->model('supplier/Supplier_model');
        $this->load->model('product/Product_model');
    }

    public function index() {
        $data['purchases'] = $this->Purchase_model->get_purchases();
        $data['base_url'] = base_url();
        $this->smarty->loadView('purchase_list.tpl', $data, 'Yes', 'Yes'); // Assuming a list view exists later
    }

    public function create_purchase() {
        $data['base_url'] = base_url();
        $data['suppliers'] = $this->Supplier_model->get_suppliers();
        $data['products'] = $this->Product_model->get_products();
        $this->smarty->loadView('create_purchase.tpl', $data, 'Yes', 'Yes');
    }

    public function save_purchase() {
        $ret_arr = ['success' => 1, 'msg' => ''];
        
        $supplier_id = $this->input->post('supplier_id');
        $bill_no = $this->input->post('bill_no');
        $purchase_date = $this->input->post('purchase_date');
        $total_amount = $this->input->post('grand_total');
        
        $products = $this->input->post('product_id');
        $qtys = $this->input->post('qty');
        $prices = $this->input->post('price');
        $item_totals = $this->input->post('total');

        if (empty($products)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Please add at least one product.';
            echo json_encode($ret_arr);
            return;
        }

        $master_data = [
            'supplier_id'   => $supplier_id,
            'bill_no'       => $bill_no,
            'purchase_date' => $purchase_date,
            'total_amount'  => $total_amount,
            'added_date'    => date('Y-m-d H:i:s'),
            'added_by'      => $this->session->userdata('user_id'),
            'status'        => 'Completed'
        ];

        $details_data = [];
        foreach ($products as $key => $product_id) {
            $details_data[] = [
                'product_id'     => $product_id,
                'qty'            => $qtys[$key],
                'purchase_price' => $prices[$key],
                'total_amount'   => $item_totals[$key]
            ];
        }

        $purchase_id = $this->Purchase_model->save_purchase($master_data, $details_data);

        if ($purchase_id) {
            $ret_arr['msg'] = 'Purchase recorded successfully and stock updated.';
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to save purchase transaction.';
        }

        echo json_encode($ret_arr);
    }

    public function purchase_details() {
        $data['base_url'] = base_url();
        $purchase_id = $this->uri->segment(2);
        
        if (empty($purchase_id)) {
            redirect('purchase_list');
        }

        $data['purchase'] = $this->Purchase_model->get_purchase_master($purchase_id);
        $data['items'] = $this->Purchase_model->get_purchase_items($purchase_id);

        if (empty($data['purchase'])) {
            redirect('purchase_list');
        }

        $this->smarty->loadView('purchase_details.tpl', $data, 'Yes', 'Yes');
    }

    public function get_purchase_details_ajax() {
        $purchase_id = $this->input->post('purchase_id');
        
        $data['purchase'] = $this->Purchase_model->get_purchase_master($purchase_id);
        $data['items'] = $this->Purchase_model->get_purchase_items($purchase_id);
        
        $html = $this->smarty->fetch('purchase_details_modal.tpl', $data);
        
        echo json_encode(['success' => 1, 'html' => $html]);
    }

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

    public function print_pdf($purchase_id) {
        $purchase_id = (int)$purchase_id;
        if (empty($purchase_id)) {
            show_404();
            return;
        }

        $data['purchase'] = $this->Purchase_model->get_purchase_master($purchase_id);
        $data['items'] = $this->Purchase_model->get_purchase_items($purchase_id);

        if (empty($data['purchase'])) {
            show_404();
            return;
        }

        $this->load->model('company/Company_model');
        $comp_master = $this->Company_model->get_company();
        
        $data['company_name'] = !empty($comp_master['company_name']) ? $comp_master['company_name'] : 'Your Company';

        $address_parts = [];
        if (!empty($comp_master['address'])) $address_parts[] = $comp_master['address'];
        if (!empty($comp_master['city'])) $address_parts[] = $comp_master['city'];
        if (!empty($comp_master['state'])) $address_parts[] = $comp_master['state'] . (!empty($comp_master['pincode']) ? ' - ' . $comp_master['pincode'] : '');
        $data['company_address'] = implode(', ', $address_parts);

        $data['company_gst'] = !empty($comp_master['gst_number']) ? $comp_master['gst_number'] : '';

        $logo_path = !empty($comp_master['company_logo']) ? 'public/uploads/company/' . $comp_master['company_logo'] : '';
        $data['logo_base64'] = $this->_get_logo_base64($logo_path);

        $data['base_url'] = base_url();

        // Load the view and get HTML
        $html = $this->smarty->loadView('purchase_print_pdf.tpl', $data, 'No', 'No', TRUE);

        // Load PDF library
        $this->load->library('Pdf');
        $pdf = new Pdf();
        // Set Dompdf options to better support fonts/unicode if needed
        $options = $pdf->getOptions();
        $options->set('isRemoteEnabled', true);
        $options->set('isFontSubsettingEnabled', true);
        $options->set('defaultFont', 'DejaVu Sans'); // Setting DejaVu Sans for Rupee symbol support
        $pdf->setOptions($options);
        
        $pdf->loadHtml($html);
        $pdf->setPaper('A4', 'portrait');
        $pdf->render();
        
        // Output the generated PDF
        $attachment = $this->input->get('download') == 1 ? 1 : 0;
        $pdf->stream('Purchase_Bill_' . $data['purchase']['bill_no'] . '.pdf', ['Attachment' => $attachment]);
    }
}
