<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Purchase_return extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Purchase_return_model');
        $this->load->model('Purchase_model');
    }

    public function index() {
        $data['returns'] = $this->Purchase_return_model->get_returns();
        $data['base_url'] = base_url();
        $this->smarty->loadView('purchase_return_list.tpl', $data, 'Yes', 'Yes');
    }

    public function create_return() {
        $data['base_url'] = base_url();
        $data['purchases'] = $this->Purchase_model->get_purchases(); // To select which bill to return against
        $this->smarty->loadView('create_purchase_return.tpl', $data, 'Yes', 'Yes');
    }

    public function get_purchase_items_for_return() {
        $purchase_id = $this->input->post('purchase_id');
        $items = $this->Purchase_return_model->get_returnable_items($purchase_id);
        $purchase = $this->Purchase_model->get_purchase_master($purchase_id);
        
        if (!empty($items)) {
            echo json_encode(['success' => 1, 'items' => $items, 'purchase' => $purchase]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'No returnable items found for this bill or it might be fully returned.']);
        }
    }

    public function save_return() {
        $ret_arr = ['success' => 1, 'msg' => ''];
        
        $purchase_id = $this->input->post('purchase_id');
        
        $max_id = $this->db->select_max('return_id')->get('purchase_return_master')->row()->return_id;
        $next_id = $max_id + 1;
        $return_no = 'RET-' . date('Ymd') . sprintf('%03d', $next_id);
        
        $return_date = $this->input->post('return_date');
        $remarks = $this->input->post('remarks');
        
        $products = $this->input->post('product_id');
        $qtys = $this->input->post('return_qty');
        $prices = $this->input->post('price');
        $item_totals = $this->input->post('total');

        if (empty($products)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Please add at least one item to return.';
            echo json_encode($ret_arr);
            return;
        }

        $total_return_amount = array_sum($item_totals);

        $master_data = [
            'purchase_id'         => $purchase_id,
            'return_no'           => $return_no,
            'return_date'         => $return_date,
            'total_return_amount' => $total_return_amount,
            'remarks'             => $remarks,
            'added_date'          => date('Y-m-d H:i:s'),
            'added_by'            => $this->session->userdata('user_id')
        ];

        $details_data = [];
        foreach ($products as $key => $product_id) {
            if ($qtys[$key] > 0) {
                $details_data[] = [
                    'product_id'     => $product_id,
                    'qty'            => $qtys[$key],
                    'purchase_price' => $prices[$key],
                    'total_amount'   => $item_totals[$key]
                ];
            }
        }

        if (empty($details_data)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Return quantity must be greater than zero.';
            echo json_encode($ret_arr);
            return;
        }

        $return_id = $this->Purchase_return_model->save_return($master_data, $details_data);

        if ($return_id) {
            $ret_arr['msg'] = 'Purchase return recorded successfully and stock updated.';
            $ret_arr['return_id'] = encode_id($return_id);
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to save return transaction.';
        }

        echo json_encode($ret_arr);
    }

    public function return_details($return_id = '') {
        $return_id = !empty($return_id) ? $return_id : $this->uri->segment(2);
        $return_id = decode_id($return_id);
        $data['return'] = $this->Purchase_return_model->get_return_master($return_id);
        
        if (empty($data['return'])) {
            show_404();
            return;
        }
        
        $data['items'] = $this->Purchase_return_model->get_return_items($return_id);
        $data['base_url'] = base_url();
        $this->smarty->loadView('purchase_return_details.tpl', $data, 'Yes', 'Yes');
    }

    public function return_details_ajax() {
        $return_id = decode_id($this->input->post('return_id'));
        $data['return'] = $this->Purchase_return_model->get_return_master($return_id);
        $data['items'] = $this->Purchase_return_model->get_return_items($return_id);
        
        $html = $this->smarty->fetch('purchase_return_details_modal.tpl', $data);
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

    public function print_pdf($return_id) {
        $return_id = decode_id($return_id);
        if (empty($return_id)) {
            show_404();
            return;
        }

        $data['return'] = $this->Purchase_return_model->get_return_master($return_id);
        $data['items'] = $this->Purchase_return_model->get_return_items($return_id);

        if (empty($data['return'])) {
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

        $html = $this->smarty->loadView('purchase_return_print_pdf.tpl', $data, 'No', 'No', TRUE);

        $this->load->library('Pdf');
        $pdf = new Pdf();
        $options = $pdf->getOptions();
        $options->set('isRemoteEnabled', true);
        $options->set('isFontSubsettingEnabled', true);
        $options->set('defaultFont', 'DejaVu Sans'); 
        $pdf->setOptions($options);
        
        $pdf->loadHtml($html);
        $pdf->setPaper('A4', 'portrait');
        $pdf->render();
        
        $attachment = $this->input->get('download') == 1 ? 1 : 0;
        $pdf->stream('Purchase_Return_' . $data['return']['return_no'] . '.pdf', ['Attachment' => $attachment]);
    }
}
