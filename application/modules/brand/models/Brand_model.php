<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Brand_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function add_brand($insert_data = array()) {
        $this->db->where('brand_name', $insert_data['brand_name']);
        $this->db->where('is_delete', 0);
        $query = $this->db->get('brands');
        if ($query->num_rows() > 0) {
            return -1;
        }else{
            $this->db->insert("brands", $insert_data);
            return $this->db->insert_id();
        }
    }
    
    public function update_brands($update_data = array(),$brand_id = 0){
        $this->db->where('brand_id', $brand_id);
        $this->db->update('brands', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }

    public function get_brands() {
        $this->db->select('b.brand_id, b.brand_name, b.status'); 
        $this->db->from('brands as b');
        $this->db->where("b.is_delete", 0);
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
}
