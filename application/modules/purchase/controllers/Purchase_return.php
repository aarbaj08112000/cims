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
        $return_no = $this->input->post('return_no');
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
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to save return transaction.';
        }

        echo json_encode($ret_arr);
    }

    public function return_details_ajax() {
        $return_id = $this->input->post('return_id');
        $data['return'] = $this->Purchase_return_model->get_return_master($return_id);
        $data['items'] = $this->Purchase_return_model->get_return_items($return_id);
        
        $html = $this->smarty->fetch('purchase_return_details_modal.tpl', $data);
        echo json_encode(['success' => 1, 'html' => $html]);
    }
}
