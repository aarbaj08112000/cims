<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Purchase_return_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->model('product/Product_model');
    }

    public function save_return($master_data, $details_data) {
        $this->db->trans_start();

        // 1. Insert into purchase_return_master
        $this->db->insert('purchase_return_master', $master_data);
        $return_id = $this->db->insert_id();

        // 2. Insert into purchase_return_details and update stock
        foreach ($details_data as $row) {
            $row['return_id'] = $return_id;
            $this->db->insert('purchase_return_details', $row);

            // 3. Decrease stock (pass negative qty)
            $remarks = "Purchase Return No: " . $master_data['return_no'] . " (Original Bill: " . $master_data['purchase_id'] . ")";
            $this->Product_model->update_stock($row['product_id'], -$row['qty'], $master_data['added_by'], $remarks);
        }

        $this->db->trans_complete();
        return $this->db->trans_status() ? $return_id : false;
    }

    public function get_returns() {
        $this->db->select('prm.*, pm.bill_no as original_bill_no, sm.supplier_name');
        $this->db->from('purchase_return_master prm');
        $this->db->join('purchase_master pm', 'prm.purchase_id = pm.purchase_id', 'left');
        $this->db->join('supplier_master sm', 'pm.supplier_id = sm.supplier_id', 'left');
        $this->db->order_by('prm.return_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_return_master($return_id) {
        $this->db->select('prm.*, pm.bill_no as original_bill_no, sm.supplier_name, sm.phone, sm.address');
        $this->db->from('purchase_return_master prm');
        $this->db->join('purchase_master pm', 'prm.purchase_id = pm.purchase_id', 'left');
        $this->db->join('supplier_master sm', 'pm.supplier_id = sm.supplier_id', 'left');
        $this->db->where('prm.return_id', $return_id);
        $query = $this->db->get();
        return $query->row_array();
    }

    public function get_return_items($return_id) {
        $this->db->select('prd.*, p.name as product_name, p.product_code');
        $this->db->from('purchase_return_details prd');
        $this->db->join('product_master p', 'prd.product_id = p.product_id', 'left');
        $this->db->where('prd.return_id', $return_id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_returnable_items($purchase_id) {
        $this->db->select('pd.*, p.name as product_name, p.product_code, 
            (pd.qty - COALESCE(SUM(prd.qty), 0)) as available_qty');
        $this->db->from('purchase_details pd');
        $this->db->join('product_master p', 'pd.product_id = p.product_id', 'left');
        $this->db->join('purchase_return_master prm', 'pd.purchase_id = prm.purchase_id', 'left');
        $this->db->join('purchase_return_details prd', 'prm.return_id = prd.return_id AND pd.product_id = prd.product_id', 'left');
        $this->db->where('pd.purchase_id', $purchase_id);
        $this->db->group_by('pd.purchase_detail_id');
        $this->db->having('available_qty >', 0);
        $query = $this->db->get();
        return $query->result_array();
    }
}
