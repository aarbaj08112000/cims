<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Banner_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
	public function add_banner($insert_data = array()){
        $this->db->insert("banners", $insert_data);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
	public function get_banner(){
        $this->db->select('b.*');
        $this->db->from('banners as b');
        $this->db->where("b.is_delete",'0');
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function update_banner($update_data = array(),$banners_id = 0){
       
        $this->db->where('banners_id', $banners_id);
        $this->db->update('banners', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
       
        return $affected_rows;
    }

}
