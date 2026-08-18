<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Product_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
     public function get_products(){
        $this->db->select('p.*');
        $this->db->from('product_master as p');
        $this->db->where('p.is_delete', "0");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_products_details($product_id = 0){
        $this->db->select('p.*, c.category_name, b.brand_name');
        $this->db->from('product_master as p');
        $this->db->join('categories as c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands as b', 'p.brand_id = b.brand_id', 'left');
        $this->db->where('p.product_id', $product_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    
    public function get_product_by_barcode_text($barcode){
        $this->db->select('p.*, c.category_name, b.brand_name');
        $this->db->from('product_master as p');
        $this->db->join('categories as c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands as b', 'p.brand_id = b.brand_id', 'left');
        $this->db->where('p.line_bar_code', $barcode);
        $this->db->where('p.is_delete', "0");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }
    
    public function get_products_image($product_id = 0){
        // Multiple images not required
        return [];
    }
    
    public function add_product($insert_data = array()){
        $this->db->insert("product_master", $insert_data);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }

    public function update_product($update_data = array(),$product_id = 0){
       
        $this->db->where('product_id', $product_id);
        $this->db->update('product_master', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
       
        return $affected_rows;
    }

   
    
    public function update_stock($product_id, $add_qty, $user_id, $remarks = '') {
        $this->db->trans_start();

        // 1. Get current quantity
        $this->db->select('qty');
        $this->db->where('product_id', $product_id);
        $query = $this->db->get('product_master');
        $current_qty = 0;
        if ($query->num_rows() > 0) {
            $row = $query->row();
            $current_qty = $row->qty;
        }

        $new_qty = $current_qty + $add_qty;

        // 2. Update product_master
        $this->db->where('product_id', $product_id);
        $this->db->update('product_master', ['qty' => $new_qty]);

        // 3. Insert into stock_master
        $stock_data = [
            'product_id'   => $product_id,
            'qty'          => $add_qty,
            'previous_qty' => $current_qty,
            'new_qty'      => $new_qty,
            'remarks'      => $remarks,
            'added_by'     => $user_id,
            'added_date'   => date('Y-m-d H:i:s')
        ];
        $this->db->insert('stock_master', $stock_data);

        $this->db->trans_complete();

        return $this->db->trans_status(); 
    }
}
