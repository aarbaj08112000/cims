<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get Summary Statistics
     */
    public function get_summary_stats() {
        $stats = [];
        
        // 1. Total Sales
        $this->db->select_sum('total_amount');
        $query = $this->db->get('sales_master');
        $stats['total_sales'] = (float)($query->row()->total_amount ?? 0);

        // 2. Total Purchases
        $this->db->select_sum('total_amount');
        $query = $this->db->get('purchase_master');
        $stats['total_purchases'] = (float)($query->row()->total_amount ?? 0);

        // 3. Total Inventory Valuation
        $this->db->select('SUM(qty * purchase_price) as total_valuation');
        $this->db->from('product_master');
        $this->db->where('is_delete', '0');
        $query = $this->db->get();
        $stats['total_inventory_valuation'] = (float)($query->row()->total_valuation ?? 0);

        // 4. Low Stock Count
        $this->db->where('qty <= alert_qty');
        $this->db->where('is_delete', '0');
        $stats['low_stock_count'] = $this->db->count_all_results('product_master');

        // 5. Total Products
        $this->db->where('is_delete', '0');
        $stats['total_products'] = (int)$this->db->count_all_results('product_master');

        // 6. Total Categories
        $this->db->where('status', 'Active');
        $stats['total_categories'] = (int)$this->db->count_all_results('categories');

        // 7. Total Customers
        $stats['total_customers'] = (int)$this->db->count_all_results('customer_master');

        // 8. Total Suppliers
        $stats['total_suppliers'] = (int)$this->db->count_all_results('supplier_master');

        // 9. Total Orders Count
        $stats['total_orders_count'] = (int)$this->db->count_all_results('sales_master');

        // 10. Total Stock Count (Sum of Qty)
        $this->db->select_sum('qty');
        $this->db->where('is_delete', '0');
        $query = $this->db->get('product_master');
        $stats['total_stock_qty'] = (float)($query->row()->qty ?? 0);

        return $stats;
    }

    /**
     * Get Monthly Sales for Chart (Last 12 Months)
     */
    public function get_monthly_sales() {
        $current_year = date('Y');
        
        // Initialize array for all 12 months of the current year
        $monthly_data = [];
        for ($m = 1; $m <= 12; $m++) {
            $month_num = str_pad($m, 2, '0', STR_PAD_LEFT);
            $ym = "$current_year-$month_num";
            $month_name = date('M', strtotime($ym . "-01"));
            $monthly_data[$ym] = [
                'ym' => $ym,
                'month_year' => $month_name,
                'total_sales' => 0,
                'order_count' => 0
            ];
        }

        $query = $this->db->query("
            SELECT 
                DATE_FORMAT(sales_date, '%Y-%m') as ym,
                DATE_FORMAT(sales_date, '%b') as month_year,
                SUM(total_amount) as total_sales,
                COUNT(sales_id) as order_count
            FROM sales_master
            WHERE YEAR(sales_date) = ?
            GROUP BY ym, month_year
            ORDER BY ym ASC
        ", [$current_year]);
        
        $results = $query->result_array();

        // Merge results into our initialized array
        foreach ($results as $row) {
            if (isset($monthly_data[$row['ym']])) {
                $monthly_data[$row['ym']]['total_sales'] = (float)$row['total_sales'];
                $monthly_data[$row['ym']]['order_count'] = (int)$row['order_count'];
            }
        }

        return array_values($monthly_data);
    }

    /**
     * Get Category Distribution for Pie Chart
     */
    public function get_category_distribution() {
        $query = $this->db->query("
            SELECT c.category_name, COUNT(pm.product_id) as product_count
            FROM categories c
            LEFT JOIN product_master pm ON c.category_id = pm.category_id AND pm.is_delete = '0'
            WHERE c.status = 'Active'
            GROUP BY c.category_id
            HAVING product_count > 0
            ORDER BY product_count DESC
            LIMIT 5
        ");
        return $query->result_array();
    }

    /**
     * Get Stock Movement / Trend (Simplified to Sales by Date for last 15 days)
     */
    public function get_sales_trend() {
        // Create a list of dates for the last 15 days
        $dates = [];
        for ($i = 14; $i >= 0; $i--) {
            $dates[date('Y-m-d', strtotime("-$i days"))] = 0;
        }

        $this->db->select('DATE(sales_date) as s_date, SUM(total_amount) as daily_sales');
        $this->db->from('sales_master');
        $this->db->where('sales_date >=', date('Y-m-d', strtotime('-14 days')));
        $this->db->group_by('s_date');
        $this->db->order_by('s_date', 'ASC');
        $query = $this->db->get();
        $results = $query->result_array();

        // Merge with our dates list to ensure all dates are present
        foreach ($results as $row) {
            $dates[$row['s_date']] = (float)$row['daily_sales'];
        }

        // Format for output
        $final_trend = [];
        foreach ($dates as $date => $sales) {
            $final_trend[] = [
                's_date' => $date,
                'daily_sales' => $sales
            ];
        }

        return $final_trend;
    }

    /**
     * Get Recent Sales
     */
    public function get_recent_sales($limit = 5) {
        $this->db->select('s.*, c.full_name as customer_name');
        $this->db->from('sales_master s');
        $this->db->join('customer_master c', 's.customer_id = c.customer_id', 'left');
        $this->db->order_by('s.sales_date', 'DESC');
        $this->db->limit($limit);
        return $this->db->get()->result_array();
    }

    /**
     * Get Recently Added Products
     */
    public function get_recently_added_products($limit = 5) {
        $this->db->select('*');
        $this->db->from('product_master');
        $this->db->where('is_delete', '0');
        $this->db->order_by('product_id', 'DESC');
        $this->db->limit($limit);
        return $this->db->get()->result_array();
    }

    /**
     * Get Detailed Low Stock Alerts
     */
    public function get_low_stock_details($limit = 5) {
        $this->db->select('name as product_name, qty, alert_qty');
        $this->db->from('product_master');
        $this->db->where('qty <= alert_qty');
        $this->db->where('is_delete', '0');
        $this->db->order_by('qty', 'ASC');
        $this->db->limit($limit);
        return $this->db->get()->result_array();
    }

    /**
     * Get Top Selling Products
     */
    public function get_top_selling_products($limit = 5) {
        $this->db->select('pm.name as product_name, pm.product_code, SUM(sd.qty) as total_qty, SUM(sd.total_amount) as total_amount');
        $this->db->from('sales_details sd');
        $this->db->join('product_master pm', 'sd.product_id = pm.product_id', 'left');
        $this->db->group_by('pm.product_id');
        $this->db->order_by('total_qty', 'DESC');
        $this->db->limit($limit);
        return $this->db->get()->result_array();
    }

    /**
     * Get Current Month Sales and Orders
     */
    public function get_current_month_stats() {
        $this->db->select('SUM(total_amount) as month_sales, COUNT(sales_id) as month_orders');
        $this->db->from('sales_master');
        $this->db->where('MONTH(sales_date)', date('m'));
        $this->db->where('YEAR(sales_date)', date('Y'));
        return $this->db->get()->row_array();
    }
}
