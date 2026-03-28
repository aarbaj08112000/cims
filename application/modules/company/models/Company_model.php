<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Company_model extends CI_Model {
    public function get_company() {
    $this->db->from('company_master');
    $this->db->limit(1);   // Only one company
    $query = $this->db->get();
    return $query->row_array();  
}


    public function insert_company($data) {
        $this->db->insert('company_master', $data);
        return $this->db->insert_id();
    }

    public function update_company($data, $id) {
        $this->db->where('company_id', $id);
        return $this->db->update('company_master', $data);
    }
}
