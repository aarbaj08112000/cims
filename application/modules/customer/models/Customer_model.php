<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Customer_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
     public function get_customer(){
        $this->db->select('c.*');
        $this->db->from('customer_master as c');
        $this->db->where('c.is_delete', "0");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_customer_details($customer_id = 0){
        $this->db->select('c.*');
        $this->db->from('customer_master as c');
        $this->db->where('c.customer_id', $customer_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_customer_product_invoice($customer_id = 0){
        $this->db->select('c.*');
        $this->db->from('customer_payments_invoice as c');
        $this->db->where('c.customer_id', $customer_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_customer_invoice_detail($customer_payments_id=0){
        $this->db->select('c.*');
        $this->db->from('customer_payments_invoice as c');
        $this->db->where('c.customer_payments_id', $customer_payments_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    
    public function add_customer($insert_data = array()){
        $this->db->insert("customer_master", $insert_data);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function insert_customer_product($data)
    {
        $this->db->insert('customer_product', $data);
        return $this->db->insert_id();
    }


    public function update_customer($update_data = array(),$customer_id = 0){
       
        $this->db->where('customer_id', $customer_id);
        $this->db->update('customer_master', $update_data);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
       
        return $affected_rows;
    }

     public function get_products(){
        $this->db->select('p.*');
        $this->db->from('product_master as p');
        $this->db->where('p.is_delete', "0");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    //  public function get_company(){
    //     $this->db->select('c.*');
    //     $this->db->from('company_master as c');
    //     $this->db->where('c.is_delete', "0");
    //     $result_obj = $this->db->get();
    //     $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
    //     return $ret_data;
    // }
    public function get_company($company_id = 0) {
    $this->db->select('c.*');
    $this->db->from('company_master as c');
    $this->db->where('c.is_delete', "0");

    if (!empty($company_id)) {
        $this->db->where('c.company_id', $company_id);
    }

    $result_obj = $this->db->get();
    $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
    return $ret_data;
}

    public function get_customer_product($customer_id = 0) {
        $this->db->select('c.*, p.name as product_name');
        $this->db->from('customer_product as c');
        $this->db->join('product_master as p', 'p.product_id = c.product_id', 'left');
        $this->db->where('c.customer_id', $customer_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

public function insert_payment_invoice($data) {
    $this->db->insert('customer_payments_invoice', $data);
    return $this->db->insert_id();
}

//  public function get_customer_product_invoice($customer_id = 0) {
//         $this->db->select('c.*, p.name as product_name');
//         $this->db->from('customer_payments_invoice as c');
//         $this->db->join('product_master as p', 'p.product_id = c.product_id', 'left');
//         $this->db->where('c.customer_id', $customer_id);
//         $result_obj = $this->db->get();
//         $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
//         return $ret_data;
//     }

public function update_customer_product_qty($customer_id, $product_id, $new_qty) {
    $this->db->where([
        'customer_id' => $customer_id,
        'product_id' => $product_id
    ]);
    return $this->db->update('customer_product', ['handover_qty' => $new_qty]);
}


public function get_products_by_ids($ids = []) {
    if(empty($ids)) return [];

    $this->db->select('product_id, name');
    $this->db->from('product_master');
    $this->db->where_in('product_id', $ids);
    $query = $this->db->get();
    return $query->result_array();
}

    
}
