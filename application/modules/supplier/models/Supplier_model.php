<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Supplier_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function add_supplier($insert_data = array()) {
        $this->db->where('supplier_name', $insert_data['supplier_name']);
        $this->db->where('is_delete', 0);
        $query = $this->db->get('supplier_master');
        if ($query->num_rows() > 0) {
            return -1;
        } else {
            $this->db->insert("supplier_master", $insert_data);
            return $this->db->insert_id();
        }
    }
    
    public function update_supplier($update_data = array(), $supplier_id = 0) {
        $this->db->where('supplier_id', $supplier_id);
        $this->db->update('supplier_master', $update_data);
        return $this->db->affected_rows() > 0 ? 1 : 0;
    }

    public function get_suppliers() {
        $this->db->select('*'); 
        $this->db->from('supplier_master');
        $this->db->where("is_delete", 0);
        $this->db->order_by("supplier_id", "DESC");
        
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }

    public function get_supplier_by_id($supplier_id) {
        $this->db->where('supplier_id', $supplier_id);
        $this->db->where('is_delete', 0);
        $query = $this->db->get('supplier_master');
        return $query->row_array();
    }
}
