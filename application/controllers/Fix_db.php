<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Fix_db extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function index() {
        // Fix sales_details
        $sales_details = $this->db->get('sales_details')->result_array();
        foreach ($sales_details as $sd) {
            $correct_total = $sd['qty'] * $sd['sale_price'];
            if ($sd['total_amount'] != $correct_total) {
                $this->db->where('sale_detail_id', $sd['sale_detail_id']);
                $this->db->update('sales_details', ['total_amount' => $correct_total]);
            }
        }

        // Fix sales_master
        $sales = $this->db->get('sales_master')->result_array();
        foreach ($sales as $sale) {
            // Get sum of correct totals
            $this->db->select_sum('total_amount');
            $this->db->where('sales_id', $sale['sales_id']);
            $sum = $this->db->get('sales_details')->row()->total_amount;
            
            if ($sum > 0) {
                // Keep the existing tax calculation ratio? The user just entered 1322.98 which was 2.5% of 52919.
                $tax = $sale['tax_amount'];
                $discount = $sale['discount_amount'];
                $payable = $sum + $tax - $discount;
                
                $this->db->where('sales_id', $sale['sales_id']);
                $this->db->update('sales_master', [
                    'total_amount' => $sum,
                    'payable_amount' => $payable,
                    'paid_amount' => $payable
                ]);
            }
        }

        echo "DB Fix Completed";
    }
}