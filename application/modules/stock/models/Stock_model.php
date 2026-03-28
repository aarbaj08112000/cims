<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Stock_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_current_stock() {
        $this->db->select('p.product_id, p.name, p.product_code, p.qty as current_stock, p.alert_qty, p.unit, c.category_name, b.brand_name');
        $this->db->from('product_master p');
        $this->db->join('categories c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands b', 'p.brand_id = b.brand_id', 'left');
        $this->db->where('p.is_delete', '0');
        $this->db->order_by('p.qty', 'ASC');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_stock_ledger($product_id) {
        $this->db->select('s.*, u.user_name as added_by_name');
        $this->db->from('stock_master s');
        $this->db->join('userinfo u', 's.added_by = u.id', 'left');
        $this->db->where('s.product_id', $product_id);
        $this->db->order_by('s.stock_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }
}
