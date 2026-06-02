<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Reports extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Reports_model');
    }

    public function index() {
        $data['stats'] = $this->Reports_model->get_summary_stats();
        $data['base_url'] = base_url();
        // Default reports can be pre-loaded if needed, but we'll use AJAX for performance
        $this->smarty->loadView('reports_list.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * Dedicated Sales Report Page
     */
    public function sales_report() {
        // Prefer POST values (clean URL) but fallback to GET for backward compatibility
        $from_date = $this->input->post('from_date') ?: ($this->input->get('from_date') ?: date('Y-m-01'));
        $to_date = $this->input->post('to_date') ?: ($this->input->get('to_date') ?: date('Y-m-d'));

        $data['sales'] = $this->Reports_model->get_sales_report($from_date, $to_date);
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['base_url'] = base_url();

        $this->smarty->loadView('sales_report.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * Dedicated Purchase Report Page
     */
    public function purchase_report() {
        $from_date = $this->input->post('from_date') ?: ($this->input->get('from_date') ?: date('Y-m-01'));
        $to_date = $this->input->post('to_date') ?: ($this->input->get('to_date') ?: date('Y-m-d'));
        
        $data['purchases'] = $this->Reports_model->get_purchase_report($from_date, $to_date);
        $data['from_date'] = $from_date;
        $data['to_date'] = $to_date;
        $data['base_url'] = base_url();
        
        $this->smarty->loadView('purchase_report.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * Dedicated Stock Valuation Report Page
     */
    public function stock_valuation_report() {
        $data['stock'] = $this->Reports_model->get_stock_valuation_report();
        $data['base_url'] = base_url();
        
        $this->smarty->loadView('stock_valuation_report.tpl', $data, 'Yes', 'Yes');
    }

    /**
     * AJAX: Get Sales Report
     */
    public function get_sales_report_ajax() {
        $from_date = $this->input->post('from_date');
        $to_date = $this->input->post('to_date');
        
        $data['sales'] = $this->Reports_model->get_sales_report($from_date, $to_date);
        $html = $this->smarty->fetch('sales_report_table.tpl', $data);
        
        echo json_encode(['success' => 1, 'html' => $html]);
    }

    /**
     * AJAX: Get Purchase Report
     */
    public function get_purchase_report_ajax() {
        $from_date = $this->input->post('from_date');
        $to_date = $this->input->post('to_date');
        
        $data['purchases'] = $this->Reports_model->get_purchase_report($from_date, $to_date);
        $html = $this->smarty->fetch('purchase_report_table.tpl', $data);
        
        echo json_encode(['success' => 1, 'html' => $html]);
    }

    /**
     * AJAX: Get Stock Valuation Report
     */
    public function get_stock_valuation_ajax() {
        $data['stock'] = $this->Reports_model->get_stock_valuation_report();
        $html = $this->smarty->fetch('stock_valuation_table.tpl', $data);
        
        echo json_encode(['success' => 1, 'html' => $html]);
    }

    /**
     * AJAX: Server-side DataTables for Stock Valuation Report
     */
    public function get_stock_valuation_datatables() {
        // DataTables sends parameters via POST
        $postData = $this->input->post();
        $result = $this->Reports_model->get_stock_valuation_datatables($postData);
        // Expected format from model: ['draw'=>..., 'recordsTotal'=>..., 'recordsFiltered'=>..., 'data'=>...]
        echo json_encode($result);
    }
}
