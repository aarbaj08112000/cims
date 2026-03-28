<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Purchase_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->load->model('product/Product_model');
    }

    public function save_purchase($master_data, $details_data) {
        $this->db->trans_start();

        // 1. Insert into purchase_master
        $this->db->insert('purchase_master', $master_data);
        $purchase_id = $this->db->insert_id();

        // 2. Insert into purchase_details and update stock
        foreach ($details_data as $row) {
            $row['purchase_id'] = $purchase_id;
            $this->db->insert('purchase_details', $row);

            // 3. Update stock in product_master and stock_master
            $remarks = "Purchase Bill No: " . $master_data['bill_no'];
            $this->Product_model->update_stock($row['product_id'], $row['qty'], $master_data['added_by'], $remarks);
        }

        $this->db->trans_complete();
        return $this->db->trans_status() ? $purchase_id : false;
    }

    public function get_purchases() {
        $this->db->select('pm.*, sm.supplier_name');
        $this->db->from('purchase_master pm');
        $this->db->join('supplier_master sm', 'pm.supplier_id = sm.supplier_id', 'left');
        $this->db->order_by('pm.purchase_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_purchase_master($purchase_id) {
        $this->db->select('pm.*, sm.supplier_name, sm.phone, sm.email, sm.address, sm.gst_number');
        $this->db->from('purchase_master pm');
        $this->db->join('supplier_master sm', 'pm.supplier_id = sm.supplier_id', 'left');
        $this->db->where('pm.purchase_id', $purchase_id);
        $query = $this->db->get();
        return $query->row_array();
    }

    public function get_purchase_items($purchase_id) {
        $this->db->select('pd.*, pm.name as product_name, pm.product_code');
        $this->db->from('purchase_details pd');
        $this->db->join('product_master pm', 'pd.product_id = pm.product_id', 'left');
        $this->db->where('pd.purchase_id', $purchase_id);
        $query = $this->db->get();
        return $query->result_array();
    }
}
