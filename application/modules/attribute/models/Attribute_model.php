<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Attribute_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function add_attribute($insert_data = array()) {
        $this->db->where('attribute_name', $insert_data['attribute_name']);
        $this->db->where('is_delete', 0);
        $query = $this->db->get('attributes');
        if ($query->num_rows() > 0) {
            return -1;
        } else {
            $this->db->insert("attributes", $insert_data);
            return $this->db->insert_id();
        }
    }

    public function update_attributes($update_data = array(), $attribute_id = 0) {
        $this->db->where('attribute_id', $attribute_id);
        $this->db->update('attributes', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }

    public function get_attributes() {
        $this->db->select('a.attribute_id, a.attribute_name, a.attribute_code, a.status');
        $this->db->from('attributes as a');
        $this->db->where("a.is_delete", 0);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_attributes_ssp($postData) {
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
        $this->db->from('attributes a');
        $this->db->where("a.is_delete", 0);
        return $this->db->count_all_results();
    }

    private function _get_datatables_query($postData) {
        $column_search = array(null, 'a.attribute_name', 'a.attribute_code', 'a.status', null);
        $column_order  = array(null, 'a.attribute_name', 'a.attribute_code', 'a.status', null);

        $this->db->select('a.attribute_id, a.attribute_name, a.attribute_code, a.status');
        $this->db->from('attributes a');
        $this->db->where("a.is_delete", 0);

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
                $this->db->order_by('a.attribute_id', 'DESC');
            }
        } else {
            $this->db->order_by('a.attribute_id', 'DESC');
        }
    }
}
