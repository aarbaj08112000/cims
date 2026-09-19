<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sales_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('product/Product_model');
    }

    public function save_sale($master_data, $details_data)
    {
        $this->db->trans_start();

        // 1. Insert into sales_master
        $this->db->insert('sales_master', $master_data);
        $sales_id = $this->db->insert_id();

        // 2. Insert into sales_details and update stock
        foreach ($details_data as $row) {
            $row['sales_id'] = $sales_id;
            $this->db->insert('sales_details', $row);

            // 3. Decrease stock (pass negative qty)
            $remarks = "Sale Bill No: " . $master_data['bill_no'];
            $this->Product_model->update_stock($row['product_id'], -$row['qty'], $master_data['added_by'] ?? 1, $remarks);
        }

        $this->db->trans_complete();
        return $this->db->trans_status() ? $sales_id : false;
    }

    public function get_sales()
    {
        $this->db->select('s.*, s.customer_name, (SELECT curr.currency_symbol FROM sales_details sd JOIN product_master p ON p.product_id = sd.product_id JOIN currency_master curr ON curr.currency_id = p.selling_currency_id WHERE sd.sales_id = s.sales_id LIMIT 1) as currency_symbol', FALSE);
        $this->db->from('sales_master s');
        
        $this->db->order_by('s.sales_id', 'DESC');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_sale_master($sales_id)
    {
        $this->db->select('s.*, s.customer_name, (SELECT curr.currency_symbol FROM sales_details sd JOIN product_master p ON p.product_id = sd.product_id JOIN currency_master curr ON curr.currency_id = p.selling_currency_id WHERE sd.sales_id = s.sales_id LIMIT 1) as currency_symbol', FALSE);
        $this->db->from('sales_master s');
        
        $this->db->where('s.sales_id', $sales_id);
        $query = $this->db->get();
        return $query->row_array();
    }

   public function get_sale_items($sales_id)
    {
        $this->db->select('sd.*, p.name as product_name, p.product_code, b.brand_name, curr.currency_symbol');
        $this->db->from('sales_details sd');
        $this->db->join('product_master p', 'sd.product_id = p.product_id', 'left');
        $this->db->join('currency_master curr', 'curr.currency_id = p.selling_currency_id', 'left');
        $this->db->join('brands b', 'p.brand_id = b.brand_id', 'left');
        $this->db->where('sd.sales_id', $sales_id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_product_by_barcode($barcode)
    {
        $this->db->select('p.product_id, p.name, p.price, p.qty, p.line_bar_code, p.product_code, curr.currency_symbol');
        $this->db->from('product_master p');
        $this->db->join('currency_master curr', 'curr.currency_id = p.selling_currency_id', 'left');
        $this->db->where('p.line_bar_code', $barcode);
        $this->db->where('p.is_delete', '0');
        $query = $this->db->get();
        return $query->row_array();
    }
    
    public function search_products($term)
    {
        $this->db->select('p.product_id, p.name, p.price, p.qty, p.line_bar_code, p.product_code, curr.currency_symbol');
        $this->db->from('product_master p');
        $this->db->join('currency_master curr', 'curr.currency_id = p.selling_currency_id', 'left');
        $this->db->group_start();
        $this->db->like('p.name', $term);
        $this->db->or_like('p.product_code', $term);
        $this->db->or_like('p.line_bar_code', $term);
        $this->db->group_end();
        $this->db->where('p.is_delete', '0');
        $this->db->limit(20);
        $query = $this->db->get();
        return $query->result_array();
    }
}
