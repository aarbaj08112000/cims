<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Categories_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function add_categories($insert_data = array()) {
        $this->db->where('category_name', $insert_data['category_name']);
        $query = $this->db->get('categories');
        if ($query->num_rows() > 0) {
            return -1;
        } else {
            $this->db->insert("categories", $insert_data);
            return $this->db->insert_id();
        }
    }

    public function update_categories($update_data = array(), $category_id = 0) {
        $this->db->where('category_id', $category_id);
        $this->db->update('categories', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }

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

    public function get_categories_ssp($postData) {
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
        $this->db->from('categories c');
        $this->db->where("c.is_delete", 0);
        return $this->db->count_all_results();
    }

    private function _get_datatables_query($postData) {
        // DataTables column indices (must match JS columns array):
        // 0 = # (virtual row number – orderable:false, searchable:false)
        // 1 = category_name
        // 2 = status
        // 3 = action   (orderable:false, searchable:false)
        $column_search = array(null, 'c.category_name', 'c.status', null);
        $column_order  = array(null, 'c.category_name', 'c.status', null);

        $this->db->select('c.category_id, c.category_name, c.parent_category_id, c.status, p.category_name as parent_name');
        $this->db->from('categories c');
        $this->db->join('categories p', 'c.parent_category_id = p.category_id', 'left');
        $this->db->where("c.is_delete", 0);

        // Global search – skip null (non-searchable) columns
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

        // Ordering – safely resolve column index; fall back to default
        if (isset($postData['order'][0]['column'])) {
            $col_idx = (int) $postData['order'][0]['column'];
            $dir     = (isset($postData['order'][0]['dir']) && strtolower($postData['order'][0]['dir']) === 'asc') ? 'ASC' : 'DESC';
            if (isset($column_order[$col_idx]) && $column_order[$col_idx] !== null) {
                $this->db->order_by($column_order[$col_idx], $dir);
            } else {
                $this->db->order_by('c.category_id', 'DESC');
            }
        } else {
            $this->db->order_by('c.category_id', 'DESC');
        }
    }
}
