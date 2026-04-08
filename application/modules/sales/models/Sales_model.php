<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sales_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->model('product/Product_model');
    }

    public function save_sale($master_data, $details_data) {
        $this->db->trans_start();

        // 1. Insert into sales_master
        $this->db->insert('sales_master', $master_data);
        $sales_id = $this->db->insert_id();

        // 2. Insert into sales_details and update stock
        foreach ($details_data as $row) {
            $row['sales_id'] = $sales_id;
            $this->db->insert('sales_details', $row);

            // 3. Decrease stock (pass negative qty)
            $remarks = "Sale Bill No: " . $master_data['bill_no'];
            $this->Product_model->update_stock($row['product_id'], -$row['qty'], $master_data['added_by'], $remarks);
        }

        $this->db->trans_complete();
        return $this->db->trans_status() ? $sales_id : false;
    }

    public function get_sales() {
        $this->db->select('s.*');
        $this->db->from('sales_master s');
        $this->db->order_by('s.sales_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_sale_master($sales_id) {
        $this->db->select('s.*');
        $this->db->from('sales_master s');
        $this->db->where('s.sales_id', $sales_id);
        $query = $this->db->get();
        return $query->row_array();
    }

    public function get_sale_items($sales_id) {
        $this->db->select('sd.*, p.name as product_name, p.product_code');
        $this->db->from('sales_details sd');
        $this->db->join('product_master p', 'sd.product_id = p.product_id', 'left');
        $this->db->where('sd.sales_id', $sales_id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_product_by_barcode($barcode) {
        $this->db->select('product_id, name, price, qty, line_bar_code, product_code');
        $this->db->from('product_master');
        $this->db->where('line_bar_code', $barcode);
        $this->db->where('is_delete', '0');
        $query = $this->db->get();
        return $query->row_array();
    }

    public function search_products($term) {
        $this->db->select('product_id, name, price, qty, line_bar_code, product_code');
        $this->db->from('product_master');
        $this->db->group_start();
        $this->db->like('name', $term);
        $this->db->or_like('product_code', $term);
        $this->db->or_like('line_bar_code', $term);
        $this->db->group_end();
        $this->db->where('is_delete', '0');
        $this->db->limit(10);
        $query = $this->db->get();
        return $query->result_array();
    }
}
