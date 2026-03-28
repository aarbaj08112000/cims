<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sales_return_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->model('product/Product_model');
    }

    public function get_sales_returns() {
        $this->db->select('srm.*, sm.bill_no as original_bill_no, cm.full_name as customer_name');
        $this->db->from('sales_return_master srm');
        $this->db->join('sales_master sm', 'srm.sales_id = sm.sales_id', 'left');
        $this->db->join('customer_master cm', 'sm.customer_id = cm.customer_id', 'left');
        $this->db->order_by('srm.return_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function save_sales_return($master_data, $details_data) {
        $this->db->trans_start();

        // 1. Insert into sales_return_master
        $this->db->insert('sales_return_master', $master_data);
        $return_id = $this->db->insert_id();

        // 2. Insert into sales_return_details and RESTORE stock
        foreach ($details_data as $row) {
            $row['return_id'] = $return_id;
            $this->db->insert('sales_return_details', $row);

            // 3. Update stock (Add back to inventory)
            $remarks = "Sales Return ID: " . $return_id . " (Against Bill: " . $master_data['return_no'] . ")";
            $this->Product_model->update_stock($row['product_id'], $row['qty'], $master_data['added_by'], $remarks);
        }

        $this->db->trans_complete();
        return $this->db->trans_status() ? $return_id : false;
    }

    public function get_sales_return_master($return_id) {
        $this->db->select('srm.*, sm.bill_no as original_bill_no, cm.full_name as customer_name, cm.mobile_number, cm.address1');
        $this->db->from('sales_return_master srm');
        $this->db->join('sales_master sm', 'srm.sales_id = sm.sales_id', 'left');
        $this->db->join('customer_master cm', 'sm.customer_id = cm.customer_id', 'left');
        $this->db->where('srm.return_id', $return_id);
        $query = $this->db->get();
        return $query->row_array();
    }

    public function get_sales_return_items($return_id) {
        $this->db->select('srd.*, pm.name as product_name, pm.product_code');
        $this->db->from('sales_return_details srd');
        $this->db->join('product_master pm', 'srd.product_id = pm.product_id', 'left');
        $this->db->where('srd.return_id', $return_id);
        $query = $this->db->get();
        return $query->result_array();
    }
}
