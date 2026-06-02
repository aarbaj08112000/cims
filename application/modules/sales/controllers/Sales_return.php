<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sales_return extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Sales_return_model');
        $this->load->model('Sales_model');
    }

    public function index() {
        $data['returns'] = $this->Sales_return_model->get_sales_returns();
        $data['base_url'] = base_url();
        $this->smarty->loadView('sales_return_list.tpl', $data, 'Yes', 'Yes');
    }

    public function create_sales_return($sales_id = null) {
        $data['base_url'] = base_url();

        if (empty($sales_id)) {
            // No sales_id provided - show bill selection form (like Purchase Return)
            $data['sales'] = $this->Sales_model->get_sales();
            $this->smarty->loadView('create_sales_return.tpl', $data, 'Yes', 'Yes');
        } else {
            // sales_id provided - show pre-filled return form
            $data['sale'] = $this->Sales_model->get_sale_master($sales_id);
            $data['items'] = $this->Sales_model->get_sale_items($sales_id);

            if (empty($data['sale'])) {
                redirect('sales_list');
            }

            $this->smarty->loadView('create_sales_return.tpl', $data, 'Yes', 'Yes');
        }
    }

    public function get_sale_items_for_return() {
        $sales_id = $this->input->post('sales_id');

        if (empty($sales_id)) {
            echo json_encode(['success' => 0, 'msg' => 'Invalid sales ID.']);
            return;
        }

        $items = $this->Sales_return_model->get_returnable_items($sales_id);

        if (!empty($items)) {
            echo json_encode(['success' => 1, 'items' => $items]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'No returnable items found for this bill or it might be fully returned.']);
        }
    }

    public function save_sales_return() {
        $ret_arr = ['success' => 1, 'msg' => ''];
        
        $sales_id = $this->input->post('sales_id');
        $return_no = 'SR-' . time();
        $return_date = $this->input->post('return_date');
        $remarks = $this->input->post('remarks');
        
        $products = $this->input->post('product_id');
        $qtys = $this->input->post('return_qty') ? $this->input->post('return_qty') : $this->input->post('qty');
        $prices = $this->input->post('price');
        $item_totals = $this->input->post('total');

        if (empty($products)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Please select at least one item to return.';
            echo json_encode($ret_arr);
            return;
        }

        $total_return_amount = array_sum($item_totals);

        $master_data = [
            'sales_id'            => $sales_id,
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
                    'product_id' => $product_id,
                    'qty'        => $qtys[$key],
                    'sale_price' => $prices[$key],
                    'total_amount'=> $item_totals[$key]
                ];
            }
        }

        if (empty($details_data)) {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Return quantity must be greater than zero.';
            echo json_encode($ret_arr);
            return;
        }

        $return_id = $this->Sales_return_model->save_sales_return($master_data, $details_data);

        if ($return_id) {
            $ret_arr['msg'] = 'Sales return processed successfully and stock restored.';
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to process sales return.';
        }

        echo json_encode($ret_arr);
    }

    public function return_details_ajax() {
        $return_id = $this->input->post('return_id');
        $data['return'] = $this->Sales_return_model->get_sales_return_master($return_id);
        $data['items'] = $this->Sales_return_model->get_sales_return_items($return_id);
        
        $html = $this->smarty->fetch('sales_return_details_modal.tpl', $data);
        echo json_encode(['success' => 1, 'html' => $html]);
    }
}
