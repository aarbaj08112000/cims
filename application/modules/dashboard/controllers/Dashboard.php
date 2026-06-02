<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Dashboard extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Dashboard_model');
    }
	public function index() {
		$data['stats'] = $this->Dashboard_model->get_summary_stats();
        
        // Monthly Sales and Orders
        $monthly_sales = $this->Dashboard_model->get_monthly_sales();
        $data['monthly_sales_labels'] = array_column($monthly_sales, 'month_year');
        $data['monthly_sales_values'] = array_column($monthly_sales, 'total_sales');
        $data['monthly_order_values'] = array_column($monthly_sales, 'order_count');
        
        // Category Distribution
        $cat_dist = $this->Dashboard_model->get_category_distribution();
        $data['cat_labels'] = array_column($cat_dist, 'category_name');
        $data['cat_values'] = array_map('intval', array_column($cat_dist, 'product_count'));

        // Sales Trend
        $sales_trend = $this->Dashboard_model->get_sales_trend();
        $data['trend_labels'] = array_column($sales_trend, 's_date');
        $data['trend_values'] = array_column($sales_trend, 'daily_sales');

        // Recent Activity
        $data['recent_sales'] = $this->Dashboard_model->get_recent_sales(10);
        $data['recent_products'] = $this->Dashboard_model->get_recently_added_products(5);
        $data['low_stock_alerts'] = $this->Dashboard_model->get_low_stock_details(5);
        
        // Current Month Highlights
        $data['curr_month_stats'] = $this->Dashboard_model->get_current_month_stats();
        
		$this->smarty->loadView('dashboard.tpl', $data,"Yes","Yes");
	}
}
