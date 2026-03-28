<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Reports_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get Sales Report Data
     */
    public function get_sales_report($from_date = '', $to_date = '') {
        $this->db->select('sm.*');
        $this->db->from('sales_master sm');
        
        if (!empty($from_date)) {
            $this->db->where('sm.sales_date >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('sm.sales_date <=', $to_date);
        }
        
        $this->db->order_by('sm.sales_date', 'DESC');
        $this->db->order_by('sm.sales_id', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Get Purchase Report Data
     */
    public function get_purchase_report($from_date = '', $to_date = '') {
        $this->db->select('pm.*, s.supplier_name');
        $this->db->from('purchase_master pm');
        $this->db->join('supplier_master s', 'pm.supplier_id = s.supplier_id', 'left');
        
        if (!empty($from_date)) {
            $this->db->where('pm.purchase_date >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('pm.purchase_date <=', $to_date);
        }
        
        $this->db->order_by('pm.purchase_date', 'DESC');
        $this->db->order_by('pm.purchase_id', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Get Stock Valuation Data
     */
    public function get_stock_valuation_report() {
        $this->db->select('p.*, c.category_name, b.brand_name, (p.qty * p.purchase_price) as valuation');
        $this->db->from('product_master p');
        $this->db->join('categories c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands b', 'p.brand_id = b.brand_id', 'left');
        $this->db->order_by('valuation', 'DESC');
        return $this->db->get()->result_array();
    }

    /**
     * Get Summary Statistics for Dashboard
     */
    public function get_summary_stats() {
        $stats = [];
        
        // 1. Total Sales
        $this->db->select_sum('total_amount');
        $query = $this->db->get('sales_master');
        $stats['total_sales'] = $query->row()->total_amount ?? 0;

        // 2. Total Purchases
        $this->db->select_sum('total_amount');
        $query = $this->db->get('purchase_master');
        $stats['total_purchases'] = $query->row()->total_amount ?? 0;

        // 3. Total Inventory Valuation
        $this->db->select('SUM(qty * purchase_price) as total_valuation');
        $this->db->from('product_master');
        $this->db->where('is_delete', '0');
        $query = $this->db->get();
        $stats['total_valuation'] = $query->row()->total_valuation ?? 0;

        // 4. Low Stock Count
        $this->db->where('qty <= alert_qty');
        $this->db->where('is_delete', '0');
        $stats['low_stock_count'] = $this->db->count_all_results('product_master');

        return $stats;
    }
}
