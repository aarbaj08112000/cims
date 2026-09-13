<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Unit_master_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function add_unit($insert_data = array()) {
        $this->db->where('unit_name', $insert_data['unit_name']);
        $this->db->where('is_delete', 0);
        $query = $this->db->get('unit_master');
        if ($query->num_rows() > 0) {
            return -1;
        } else {
            $this->db->insert("unit_master", $insert_data);
            return $this->db->insert_id();
        }
    }

    public function update_unit($update_data = array(), $unit_id = 0) {
        $this->db->where('unit_id', $unit_id);
        $this->db->update('unit_master', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }

    public function get_units() {
        $this->db->select('unit_id, unit_name, unit_code, status');
        $this->db->from('unit_master');
        $this->db->where("is_delete", 0);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }

    public function get_units_ssp($postData) {
        $this->_get_datatables_query($postData);
        if (isset($postData['length']) && $postData['length'] != -1) {
            $this->db->limit($postData['length'], $postData['start']);
        }
        $query = $this->db->get();
        return $query->result_array();
    }

    public function count_filtered($postData) {
        $this->_get_datatables_query($postData);
        $query = $this->db->get();
        return $query->num_rows();
    }

    public function count_all() {
        $this->db->from('unit_master');
        $this->db->where("is_delete", 0);
        return $this->db->count_all_results();
    }

    private function _get_datatables_query($postData) {
        $column_search = array(null, 'unit_name', 'unit_code', 'status', null);
        $column_order  = array(null, 'unit_name', 'unit_code', 'status', null);

        $this->db->select('unit_id, unit_name, unit_code, status');
        $this->db->from('unit_master');
        $this->db->where("is_delete", 0);

        $searchable = array_values(array_filter($column_search));
        $i = 0;
        if (isset($postData['search']['value']) && $postData['search']['value'] != '') {
            foreach ($searchable as $item) {
                if ($i === 0) {
                    $this->db->group_start();
                    $this->db->like($item, $postData['search']['value']);
                } else {
                    $this->db->or_like($item, $postData['search']['value']);
                }
                if (count($searchable) - 1 == $i) {
                    $this->db->group_end();
                }
                $i++;
            }
        }

        if (isset($postData['order'][0]['column'])) {
            $col_idx = (int) $postData['order'][0]['column'];
            $dir     = (isset($postData['order'][0]['dir']) && strtolower($postData['order'][0]['dir']) === 'asc') ? 'ASC' : 'DESC';
            if (isset($column_order[$col_idx]) && $column_order[$col_idx] !== null) {
                $this->db->order_by($column_order[$col_idx], $dir);
            } else {
                $this->db->order_by('unit_id', 'DESC');
            }
        } else {
            $this->db->order_by('unit_id', 'DESC');
        }
    }
}
