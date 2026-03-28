<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Stock extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Stock_model');
        $this->load->model('product/Product_model');
    }

    public function index() {
        $data['stock_levels'] = $this->Stock_model->get_current_stock();
        $data['base_url'] = base_url();
        $this->smarty->loadView('stock_list.tpl', $data, 'Yes', 'Yes');
    }

    public function stock_ledger_ajax() {
        $product_id = $this->input->post('product_id');
        $data['ledger'] = $this->Stock_model->get_stock_ledger($product_id);
        $product_data = $this->Product_model->get_products_details($product_id);
        $data['product'] = !empty($product_data) ? $product_data[0] : [];
        
        $html = $this->smarty->fetch('stock_ledger_modal.tpl', $data);
        echo json_encode(['success' => 1, 'html' => $html]);
    }
}
