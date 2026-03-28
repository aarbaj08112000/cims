<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Categories_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

	// public function add_categories($insert_data = array()){
    //     $this->db->insert("categories", $insert_data);
    //     $insert_id = $this->db->insert_id();
    //     return  $insert_id;
    // }

    public function add_categories($insert_data = array()) {
        $this->db->where('category_name', $insert_data['category_name']);
        $query = $this->db->get('categories');
        if ($query->num_rows() > 0) {
            return -1;
        }else{
            $this->db->insert("categories", $insert_data);
            return $this->db->insert_id();
        }
    
      
        
    }
    
    public function update_categories($update_data = array(),$category_id = 0){
     
        $this->db->where('category_id', $category_id);
        $this->db->update('categories', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }


    // public function get_categories(){
    //     $this->db->select('c.*');
    //     $this->db->from('categories as c');
    //     $this->db->where("c.status",'Active');
    //     $result_obj = $this->db->get();
    //     $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
    //     return $ret_data;
    // }

    public function get_categories() {
        $this->db->select('c.category_id, c.category_name, c.parent_category_id, c.status, 
                           p.category_name as parent_name'); 
        $this->db->from('categories as c');
        $this->db->join('categories as p', 'c.parent_category_id = p.category_id', 'left'); 
        $this->db->where("c.status", 'Active');
        
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    
}
