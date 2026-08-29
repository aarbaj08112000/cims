<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Reports_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Get Sales Summary Statistics (KPIs)
     */
    public function get_sales_summary($from_date = '', $to_date = '') {
        $this->db->select('
            COUNT(sales_id) as total_entries,
            SUM(total_amount) as grand_total,
            SUM(CASE WHEN LOWER(payment_mode) = "cash" THEN total_amount ELSE 0 END) as total_cash,
            SUM(CASE WHEN LOWER(payment_mode) = "upi" THEN total_amount ELSE 0 END) as total_upi,
            SUM(CASE WHEN LOWER(payment_mode) != "cash" AND LOWER(payment_mode) != "upi" THEN total_amount ELSE 0 END) as total_card
        ');
        $this->db->from('sales_master');
        
        if (!empty($from_date)) {
            $this->db->where('sales_date >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('sales_date <=', $to_date);
        }
        
        $result = $this->db->get()->row_array();
        return [
            'total_entries' => $result['total_entries'] ?? 0,
            'grand_total'   => $result['grand_total'] ?? 0,
            'total_cash'    => $result['total_cash'] ?? 0,
            'total_upi'     => $result['total_upi'] ?? 0,
            'total_card'    => $result['total_card'] ?? 0
        ];
    }

    /**
     * Server-side DataTables for Sales Report
     */
    public function get_sales_report_datatables($postData) {
        $from_date = isset($postData['from_date']) ? $postData['from_date'] : '';
        $to_date = isset($postData['to_date']) ? $postData['to_date'] : '';

        // Columns mapping
        $columns = [
            0 => 'sales_date',
            1 => 'customer_name',
            2 => 'mobile_number',
            3 => 'payment_mode',
            4 => 'total_amount'
        ];

        // Apply base filters
        $this->db->from('sales_master sm');
        if (!empty($from_date)) {
            $this->db->where('sm.sales_date >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('sm.sales_date <=', $to_date);
        }

        // Clone DB instance for total records (without search)
        $db_total = clone $this->db;
        $db_total->select('COUNT(sm.sales_id) as count');
        $recordsTotal = $db_total->get()->row()->count;

        // Apply filtering
        if (!empty($postData['search']['value'])) {
            $search = $postData['search']['value'];
            $this->db->group_start();
            $this->db->like('sm.customer_name', $search);
            $this->db->or_like('sm.mobile_number', $search);
            $this->db->or_like('sm.payment_mode', $search);
            $this->db->group_end();
        }

        // Clone DB instance for filtered records and grand total
        $db_filtered = clone $this->db;
        $db_filtered->select('
            COUNT(sm.sales_id) as count, 
            SUM(sm.total_amount) as sum_total,
            SUM(CASE WHEN LOWER(sm.payment_mode) = "cash" THEN sm.total_amount ELSE 0 END) as total_cash,
            SUM(CASE WHEN LOWER(sm.payment_mode) = "upi" THEN sm.total_amount ELSE 0 END) as total_upi,
            SUM(CASE WHEN LOWER(sm.payment_mode) != "cash" AND LOWER(sm.payment_mode) != "upi" THEN sm.total_amount ELSE 0 END) as total_card
        ');
        $filteredResult = $db_filtered->get()->row();
        $recordsFiltered = $filteredResult->count;
        $sumTotal = $filteredResult->sum_total;
        $totalCash = $filteredResult->total_cash;
        $totalUpi = $filteredResult->total_upi;
        $totalCard = $filteredResult->total_card;

        // Ordering
        if (isset($postData['order'][0]['column'])) {
            $colIdx = (int)$postData['order'][0]['column'];
            $dir = $postData['order'][0]['dir'] === 'asc' ? 'ASC' : 'DESC';
            $orderCol = $columns[$colIdx] ?? 'sm.sales_date';
            if ($orderCol) {
                $this->db->order_by($orderCol, $dir);
            }
        } else {
            $this->db->order_by('sm.sales_date', 'DESC');
            $this->db->order_by('sm.sales_id', 'DESC');
        }

        // Pagination
        $limit = intval($postData['length']);
        $start = intval($postData['start']);
        if ($limit > 0) {
            $this->db->limit($limit, $start);
        }

        // Fetch data
        $this->db->select('sm.*');
        $data = $this->db->get()->result_array();

        // Prepare rows for DataTables
        $rows = [];
        foreach ($data as $row) {
            $rows[] = [
                date('d M Y', strtotime($row['sales_date'])),
                $row['customer_name'] ? htmlspecialchars($row['customer_name']) : 'Walk-in Customer',
                $row['mobile_number'] ? htmlspecialchars($row['mobile_number']) : '-',
                $row['payment_mode'] ? htmlspecialchars($row['payment_mode']) : 'Cash',
                number_format($row['total_amount'], 2)
            ];
        }
        return [
            'draw' => isset($postData['draw']) ? intval($postData['draw']) : 0,
            'recordsTotal' => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'grand_total' => $sumTotal ? number_format($sumTotal, 2) : '0.00',
            'total_entries' => $recordsFiltered,
            'total_cash' => isset($totalCash) && $totalCash ? number_format($totalCash, 0) : '0',
            'total_upi' => isset($totalUpi) && $totalUpi ? number_format($totalUpi, 0) : '0',
            'total_card' => isset($totalCard) && $totalCard ? number_format($totalCard, 0) : '0',
            'data' => $rows
        ];
    }

    /**
     * Get Purchase Summary Statistics (KPIs)
     */
    public function get_purchase_summary($from_date = '', $to_date = '') {
        $this->db->select('
            COUNT(purchase_id) as total_entries,
            SUM(total_amount) as grand_total
        ');
        $this->db->from('purchase_master');
        
        if (!empty($from_date)) {
            $this->db->where('purchase_date >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('purchase_date <=', $to_date);
        }
        
        $result = $this->db->get()->row_array();
        
        $grand_total = $result['grand_total'] ?? 0;
        
        return [
            'total_entries' => $result['total_entries'] ?? 0,
            'grand_total'   => $grand_total,
            'total_cash'    => $grand_total, // Defaulting all purchases to Cash as before
            'total_upi'     => 0,
            'total_card'    => 0
        ];
    }

    /**
     * Server-side DataTables for Purchase Report
     */
    public function get_purchase_report_datatables($postData) {
        $from_date = isset($postData['from_date']) ? $postData['from_date'] : '';
        $to_date = isset($postData['to_date']) ? $postData['to_date'] : '';

        // Columns mapping
        $columns = [
            0 => 'purchase_date',
            1 => 'supplier_name',
            2 => 'contact_number',
            3 => null, // Payment mode doesn't exist in DB, it's just Cash
            4 => 'total_amount'
        ];

        // Apply base filters
        $this->db->from('purchase_master pm');
        $this->db->join('supplier_master s', 'pm.supplier_id = s.supplier_id', 'left');
        
        if (!empty($from_date)) {
            $this->db->where('pm.purchase_date >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('pm.purchase_date <=', $to_date);
        }

        // Clone DB instance for total records (without search)
        $db_total = clone $this->db;
        $db_total->select('COUNT(pm.purchase_id) as count');
        $recordsTotal = $db_total->get()->row()->count;

        // Apply filtering
        if (!empty($postData['search']['value'])) {
            $search = $postData['search']['value'];
            $this->db->group_start();
            $this->db->like('s.supplier_name', $search);
            // Since contact_number doesn't exist in purchase_master, remove it from search too? 
            // Wait, we need to be careful if contact_number exists or not.
            // But let's just remove payment_mode for sure.
            $this->db->group_end();
        }

        // Clone DB instance for filtered records and grand total
        $db_filtered = clone $this->db;
        $db_filtered->select('COUNT(pm.purchase_id) as count, SUM(pm.total_amount) as sum_total');
        $filteredResult = $db_filtered->get()->row();
        $recordsFiltered = $filteredResult->count;
        $sumTotal = $filteredResult->sum_total;

        // Ordering
        if (isset($postData['order'][0]['column'])) {
            $colIdx = (int)$postData['order'][0]['column'];
            $dir = $postData['order'][0]['dir'] === 'asc' ? 'ASC' : 'DESC';
            $orderCol = $columns[$colIdx] ?? 'pm.purchase_date';
            if ($orderCol) {
                $this->db->order_by($orderCol, $dir);
            }
        } else {
            $this->db->order_by('pm.purchase_date', 'DESC');
            $this->db->order_by('pm.purchase_id', 'DESC');
        }

        // Pagination
        $limit = intval($postData['length']);
        $start = intval($postData['start']);
        if ($limit > 0) {
            $this->db->limit($limit, $start);
        }

        // Fetch data
        $this->db->select('pm.*, s.supplier_name');
        $data = $this->db->get()->result_array();

        // Prepare rows for DataTables
        $rows = [];
        foreach ($data as $row) {
            $rows[] = [
                date('d M Y', strtotime($row['purchase_date'])),
                $row['supplier_name'] ? htmlspecialchars($row['supplier_name']) : '-',
                isset($row['contact_number']) && $row['contact_number'] ? htmlspecialchars($row['contact_number']) : '-',
                'Cash', // Default to Cash
                number_format($row['total_amount'], 2)
            ];
        }

        return [
            'draw' => isset($postData['draw']) ? intval($postData['draw']) : 0,
            'recordsTotal' => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'grand_total' => $sumTotal ? number_format($sumTotal, 2) : '0.00',
            'total_entries' => $recordsFiltered,
            'total_cash' => $sumTotal ? number_format($sumTotal, 0) : '0',
            'total_upi' => '0',
            'total_card' => '0',
            'data' => $rows
        ];
    }

    /**
     * Get Stock Valuation Data
     */

    /**
     * Server-side DataTables for Stock Valuation Report
     * Expects DataTables POST parameters.
     */
    public function get_stock_valuation_datatables($postData) {
        // Columns mapping (index => db column)
        $columns = [
            0 => null, // # column (virtual)
            1 => 'p.product_code',
            2 => 'p.product_name',
            3 => 'c.category_name',
            4 => 'b.brand_name',
            5 => 'p.qty',
            6 => 'p.purchase_price',
            7 => '(p.qty * p.purchase_price)'
        ];

        // Total records
        $this->db->select('COUNT(*) as count');
        $this->db->from('product_master p');
        $this->db->join('categories c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands b', 'p.brand_id = b.brand_id', 'left');
        $totalResult = $this->db->get()->row();
        $recordsTotal = $totalResult->count;

        // Apply filtering
        if (!empty($postData['search']['value'])) {
            $search = $postData['search']['value'];
            $this->db->group_start();
            $this->db->like('p.product_code', $search);
            $this->db->or_like('p.product_name', $search);
            $this->db->or_like('c.category_name', $search);
            $this->db->or_like('b.brand_name', $search);
            $this->db->group_end();
        }
        // Records after filtering
        $this->db->select('COUNT(*) as count');
        $this->db->from('product_master p');
        $this->db->join('categories c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands b', 'p.brand_id = b.brand_id', 'left');
        $recordsFiltered = $this->db->get()->row()->count;

        // Ordering
        if (isset($postData['order'][0]['column'])) {
            $colIdx = (int)$postData['order'][0]['column'];
            $dir = $postData['order'][0]['dir'] === 'asc' ? 'ASC' : 'DESC';
            $orderCol = $columns[$colIdx] ?? 'p.product_code';
            if ($orderCol) {
                $this->db->order_by($orderCol, $dir);
            }
        }

        // Pagination
        $limit = intval($postData['length']);
        $start = intval($postData['start']);
        $this->db->limit($limit, $start);

        // Fetch data
        $this->db->select('p.product_code, p.product_name, c.category_name, b.brand_name, p.qty, p.purchase_price');
        $this->db->from('product_master p');
        $this->db->join('categories c', 'p.category_id = c.category_id', 'left');
        $this->db->join('brands b', 'p.brand_id = b.brand_id', 'left');
        $data = $this->db->get()->result_array();

        // Prepare rows for DataTables
        $rows = [];
        $rowNumber = $start + 1;
        foreach ($data as $row) {
            $totalValue = $row['qty'] * $row['purchase_price'];
            $rows[] = [
                $rowNumber++,
                $row['product_code'],
                $row['product_name'],
                $row['category_name'],
                $row['brand_name'],
                $row['qty'],
                number_format($row['purchase_price'], 2),
                number_format($totalValue, 2)
            ];
        }

        return [
            'draw' => intval($postData['draw']),
            'recordsTotal' => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data' => $rows
        ];
    }

    public function get_stock_valuation_report() {
        $this->db->select('p.*, p.name as product_name, c.category_name, b.brand_name, (p.qty * p.purchase_price) as valuation');
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

    /**
     * Get All Stock Adjustment Entries
     */
    public function get_stock_adjustment_report($from_date = '', $to_date = '', $product_id = '') {
        $this->db->select('sm.stock_id, sm.added_date, sm.qty, sm.previous_qty, sm.new_qty, sm.remarks, p.name as product_name, p.product_code, u.user_name as adjusted_by');
        $this->db->from('stock_master sm');
        $this->db->join('product_master p', 'sm.product_id = p.product_id', 'left');
        $this->db->join('userinfo u', 'sm.added_by = u.id', 'left');

        if (!empty($from_date)) {
            $this->db->where('DATE(sm.added_date) >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('DATE(sm.added_date) <=', $to_date);
        }
        if (!empty($product_id)) {
            $this->db->where('sm.product_id', $product_id);
        }

        $this->db->order_by('sm.stock_id', 'DESC');
        return $this->db->get()->result_array();
    }
}

