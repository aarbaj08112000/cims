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
            2 => 'customer_phone_number',
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
            $this->db->or_like('sm.customer_phone_number', $search);
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
                $row['customer_phone_number'] ? htmlspecialchars($row['customer_phone_number']) : '-',
                $row['payment_mode'] ? htmlspecialchars($row['payment_mode']) : 'Cash',
                number_format($row['total_amount'], 2)
            ];
        }
        return [
            "draw" => isset($postData["draw"]) ? intval($postData["draw"]) : 0,
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
     * Get Sales Report (simple list for AJAX table)
     */
    public function get_sales_report($from_date = '', $to_date = '') {
        $this->db->select('sm.sales_id, sm.bill_no, sm.sales_date, sm.customer_name, sm.customer_phone_number, sm.payment_mode, sm.total_amount, sm.payment_status');
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
            'total_cash'    => $grand_total, // Defaulting all purchases to Cash
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
            3 => null, // Payment mode doesn't exist in DB
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
                'Cash',
                number_format($row['total_amount'], 2)
            ];
        }

        return [
            "draw" => isset($postData["draw"]) ? intval($postData["draw"]) : 0,
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
     * Get Purchase Report (simple list for AJAX table)
     */
    public function get_purchase_report($from_date = '', $to_date = '') {
        $this->db->select('pm.purchase_id, pm.bill_no, pm.purchase_date, pm.total_amount, pm.payment_status, s.supplier_name');
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
            "draw" => intval($postData["draw"]),
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

    /**
     * Server-side DataTables for Product Activity Log Report
     */
    public function get_product_logs_datatables($postData) {
        $from_date   = isset($postData['from_date']) ? $postData['from_date'] : '';
        $to_date     = isset($postData['to_date']) ? $postData['to_date'] : '';
        $product_id  = isset($postData['product_id']) ? $postData['product_id'] : '';
        $action_type = isset($postData['action_type']) ? $postData['action_type'] : '';
        $created_by  = isset($postData['created_by']) ? $postData['created_by'] : '';

        $columns = [
            0 => 'pal.id',
            1 => 'pal.created_at',
            2 => 'pal.product_name',
            3 => 'pal.action_type',
            4 => 'pal.qty_change',
            5 => 'pal.price_change',
            6 => 'pal.reference_no',
            7 => 'pal.user_name',
            8 => 'pal.id'
        ];

        $this->db->from('product_activity_logs pal');

        if (!empty($from_date)) {
            $this->db->where('DATE(pal.created_at) >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('DATE(pal.created_at) <=', $to_date);
        }
        if (!empty($product_id)) {
            $this->db->where('pal.product_id', $product_id);
        }
        if (!empty($action_type)) {
            $this->db->where('pal.action_type', $action_type);
        }
        if (!empty($created_by)) {
            $this->db->where('pal.created_by', $created_by);
        }

        $db_total = clone $this->db;
        $db_total->select('COUNT(pal.id) as count');
        $query_total = $db_total->get();
        $recordsTotal = ($query_total && $query_total->num_rows() > 0) ? (int)$query_total->row()->count : 0;

        if (!empty($postData['search']['value'])) {
            $search = trim($postData['search']['value']);
            $this->db->group_start();
            $this->db->like('pal.product_name', $search);
            $this->db->or_like('pal.action_type', $search);
            $this->db->or_like('pal.reference_no', $search);
            $this->db->or_like('pal.user_name', $search);
            $this->db->or_like('pal.remarks', $search);
            $this->db->group_end();
        }

        $db_filtered = clone $this->db;
        $db_filtered->select('COUNT(pal.id) as count');
        $query_filtered = $db_filtered->get();
        $recordsFiltered = ($query_filtered && $query_filtered->num_rows() > 0) ? (int)$query_filtered->row()->count : 0;

        if (isset($postData['order'][0]['column'])) {
            $colIdx = (int)$postData['order'][0]['column'];
            $colName = isset($columns[$colIdx]) ? $columns[$colIdx] : 'pal.id';
            $dir = (isset($postData['order'][0]['dir']) && strtolower($postData['order'][0]['dir']) === 'asc') ? 'ASC' : 'DESC';
            $this->db->order_by($colName, $dir);
        } else {
            $this->db->order_by('pal.id', 'DESC');
        }

        $start  = isset($postData['start']) ? (int)$postData['start'] : 0;
        $length = isset($postData['length']) ? (int)$postData['length'] : 10;
        if ($length > 0) {
            $this->db->limit($length, $start);
        }

        $this->db->select('pal.*');
        $query = $this->db->get();
        $logs = $query ? $query->result_array() : [];

        $rows = [];
        $i = $start + 1;
        foreach ($logs as $log) {
            $action_badge = '';
            switch ($log['action_type']) {
                case 'created':
                    $action_badge = '<span class="badge bg-label-success"><i class="bx bx-plus-circle me-1"></i> Created</span>';
                    break;
                case 'updated':
                    $action_badge = '<span class="badge bg-label-warning"><i class="bx bx-edit me-1"></i> Updated</span>';
                    break;
                case 'stock_added':
                    $action_badge = '<span class="badge bg-label-info"><i class="bx bx-import me-1"></i> Stock In</span>';
                    break;
                case 'stock_removed':
                    $action_badge = '<span class="badge bg-label-danger"><i class="bx bx-export me-1"></i> Stock Out</span>';
                    break;
                case 'stock_adjusted':
                    $action_badge = '<span class="badge bg-label-primary"><i class="bx bx-slider me-1"></i> Adjusted</span>';
                    break;
                case 'sale':
                    $action_badge = '<span class="badge bg-label-success"><i class="bx bx-cart me-1"></i> Sale</span>';
                    break;
                case 'sale_return':
                    $action_badge = '<span class="badge bg-label-warning"><i class="bx bx-undo me-1"></i> Sale Return</span>';
                    break;
                case 'purchase':
                    $action_badge = '<span class="badge bg-label-primary"><i class="bx bx-shopping-bag me-1"></i> Purchase</span>';
                    break;
                case 'purchase_return':
                    $action_badge = '<span class="badge bg-label-secondary"><i class="bx bx-revision me-1"></i> Purchase Return</span>';
                    break;
                case 'deleted':
                    $action_badge = '<span class="badge bg-label-danger"><i class="bx bx-trash me-1"></i> Deleted</span>';
                    break;
                case 'restored':
                    $action_badge = '<span class="badge bg-label-info"><i class="bx bx-refresh me-1"></i> Restored</span>';
                    break;
                default:
                    $action_badge = '<span class="badge bg-label-secondary">' . htmlspecialchars($log['action_type']) . '</span>';
            }

            $qty = (float)$log['qty_change'];
            $qty_display = '-';
            if ($qty > 0) {
                $qty_display = '<span class="text-success fw-semibold">+' . number_format($qty, 2) . '</span>';
            } elseif ($qty < 0) {
                $qty_display = '<span class="text-danger fw-semibold">' . number_format($qty, 2) . '</span>';
            }

            $price = (float)$log['price_change'];
            $price_display = ($price != 0) ? 'Ê[' . number_format(abs($price), 2) : '-;';

            $old_json = htmlspecialchars(json_encode(json_decode($log['old_values'] ?? '[]')), ENT_QUOTES, 'UTF-8');
            $new_json = htmlspecialchars(json_encode(json_decode($log['new_values'] ?? '[]')), ENT_QUOTES, 'UTF-8');
            $remarks_safe = htmlspecialchars($log['remarks'] ?? '', ENT_QUOTES, 'UTF-8');

            $action_btn = '<button type="button" class="btn btn-sm btn-icon btn-outline-primary view-log-details" '
                . 'data-id="' . $log['id'] . '" '
                . 'data-title="' . htmlspecialchars($log['product_name']) . ' - ' . ucfirst($log['action_type']) . '" '
                . 'data-old="' . $old_json . '" '
                . 'data-new="' . $new_json . '" '
                . 'data-remarks="' . $remarks_safe . '" '
                . 'data-bs-toggle="tooltip" title="View Details">'
                . '<i class="bx bx-show-alt"></i></button>';

            $rows[] = [
                'sr_no'        => $i++,
                'created_at'   => '<span class="fw-medium">' . date('d M Y', strtotime($log['created_at'])) . '</span><br><small class="text-muted">' . date('h:i A', strtotime($log['created_at'])) . '</small>',
                'product_name' => '<span class="fw-bold text-heading">' . htmlspecialchars($log['product_name']) . '</span>',
                'action_type'  => $action_badge,
                'qty_change'   => $qty_display,
                'price_change' => $price_display,
                'old_values' => !empty($log['old_values']) ? '<span class="badge bg-label-secondary">' . htmlspecialchars($log['old_values']) . '</span>' : '-',
                'user_name'    => '<span class="fw-medium">' . htmlspecialchars($log['user_name'] ?? 'System Admin') . '</span>',
                'actions'      => $action_btn
            ];
        }

        return [
            "draw"            => isset($postData["draw"]) ? (int)$postData["draw"] : 1,
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $rows
        ];
    }

    /**
     * Get Product Log Stats (Summary Cards)
     */
        public function get_product_log_stats_filtered($from_date = '', $to_date = '', $product_id = '', $action_type = '', $created_by = '') {
        $this->db->from('product_activity_logs pal');

        if (!empty($from_date)) {
            $this->db->where('DATE(pal.created_at) >=', $from_date);
        }
        if (!empty($to_date)) {
            $this->db->where('DATE(pal.created_at) <=', $to_date);
        }
        if (!empty($product_id)) {
            $this->db->where('pal.product_id', $product_id);
        }
        if (!empty($action_type)) {
            $this->db->where('pal.action_type', $action_type);
        }
        if (!empty($created_by)) {
            $this->db->where('pal.created_by', $created_by);
        }

        $query = $this->db->get();
        $logs = $query ? $query->result_array() : [];

        $total = count($logs);
        $stock_in = 0;
        $stock_out = 0;
        $updates = 0;

        foreach ($logs as $l) {
            if (in_array($l['action_type'], array('stock_added', 'purchase', 'sale_return', 'created', 'restored'))) {
                $stock_in++;
            } elseif (in_array($l['action_type'], array('stock_removed', 'sale', 'purchase_return', 'deleted'))) {
                $stock_out++;
            }
            if ($l['action_type'] === 'updated' || $l['price_change'] != 0) {
                $updates++;
            }
        }

        return array(
            'total_activities'   => $total,
            'stock_in_events'    => $stock_in,
            'stock_out_events'   => $stock_out,
            'price_detail_edits' => $updates
        );
    }

    public function get_all_products_list() {
        $this->db->select('product_id as id, name as product_name, product_code');
        $this->db->from('product_master');
        $this->db->where('is_delete', '0');
        $this->db->order_by('name', 'ASC');
        $query = $this->db->get();
        return $query ? $query->result_array() : [];
    }

    /**
     * Get All Users Dropdown List
     */
    public function get_all_users_list() {
        $this->db->select('id, user_name');
        $this->db->from('userinfo');
        $this->db->where('status !=', 'Block');
        $this->db->order_by('user_name', 'ASC');
        $query = $this->db->get();
        $users = $query ? $query->result_array() : [];

        if (empty($users)) {
            $this->db->select('id, name as user_name');
            $this->db->from('users');
            $this->db->order_by('name', 'ASC');
            $query2 = $this->db->get();
            $users = $query2 ? $query2->result_array() : [];
        }

        return $users;
    }
}
