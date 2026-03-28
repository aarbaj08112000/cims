<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sales extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Sales_model');
        $this->load->model('customer/Customer_model');
    }

    public function index() {
        $data['sales'] = $this->Sales_model->get_sales();
        $data['base_url'] = base_url();
        $this->smarty->loadView('sales_list.tpl', $data, 'Yes', 'Yes');
    }

    public function create_sale() {
        $data['base_url'] = base_url();
        $data['customers'] = $this->Customer_model->get_customer();
        $data['products'] = $this->Customer_model->get_products(); // Reusing the same function which fetches all products
        $this->smarty->loadView('create_sale.tpl', $data, 'Yes', 'Yes');
    }

    public function save_sale() {
        $ret_arr = ['success' => 1, 'msg' => ''];
        
        $customer_mobile = $this->input->post('customer_mobile');
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

        $master_data = [
            'customer_phone_number' => $customer_mobile,
            'bill_no'               => $bill_no,
            'sales_date'            => $sales_date,
            'total_amount'          => $total_amount,
            'payable_amount'        => $total_amount,
            'paid_amount'           => $total_amount,
            'payment_status'        => 'Paid',
            'payment_mode'          => $payment_mode,
            'added_date'            => date('Y-m-d H:i:s'),
            'added_by'              => $this->session->userdata('user_id')
        ];

        $details_data = [];
        foreach ($products as $key => $product_id) {
            $details_data[] = [
                'product_id' => $product_id,
                'qty'        => $qtys[$key],
                'sale_price' => $prices[$key],
                'total_amount'=> $item_totals[$key]
            ];
        }

        $sales_id = $this->Sales_model->save_sale($master_data, $details_data);

        if ($sales_id) {
            $ret_arr['msg'] = 'Sales bill saved successfully and stock deducted.';
        } else {
            $ret_arr['success'] = 0;
            $ret_arr['msg'] = 'Failed to save sales transaction.';
        }

        echo json_encode($ret_arr);
    }

    public function sales_details_ajax() {
        $sales_id = $this->input->post('sales_id');
        $data['sale'] = $this->Sales_model->get_sale_master($sales_id);
        $data['items'] = $this->Sales_model->get_sale_items($sales_id);
        
        $html = $this->smarty->fetch('sales_details_modal.tpl', $data);
        echo json_encode(['success' => 1, 'html' => $html]);
    }
}
