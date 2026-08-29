<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-report-money"></i></div>
        <div>
          <h1 class="cat-page-title">Sales Report</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Reports</span>
            <i class="ti ti-chevron-right"></i>
            <span>Sales Report</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <button id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
      </div>
    </div>

    
    <!-- Summary Cards -->
    <div class="row g-3 mb-4">
      <div class="col-md-3">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#e8e6fb; color:#7367f0;">
                  <i class="ti ti-list-details"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">Total Entries</div>
                  <div id="kpi-total-entries" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;"><%$summary.total_entries%></div>
              </div>
          </div>
      </div>
      <div class="col-md-3">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#e8f8f0; color:#27ae60;">
                  <i class="ti ti-cash"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">Cash Total</div>
                  <div id="kpi-total-cash" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;">₹<%$summary.total_cash|number_format:0%></div>
              </div>
          </div>
      </div>
      <div class="col-md-3">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#fff0e1; color:#fd7e14;">
                  <i class="ti ti-device-mobile"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">UPI Total</div>
                  <div id="kpi-total-upi" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;">₹<%$summary.total_upi|number_format:0%></div>
              </div>
          </div>
      </div>
      <div class="col-md-3">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#fdecea; color:#e74c3c;">
                  <i class="ti ti-credit-card"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">Other (Card) Total</div>
                  <div id="kpi-total-card" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;">₹<%$summary.total_card|number_format:0%></div>
              </div>
          </div>
      </div>
    </div>

    <!-- Filter Card -->
    <div class="card border-0 shadow-sm mb-4" style="border-radius:12px;">
      <form method="POST" action="<%$base_url%>sales_report" id="filter-form">
      <div class="card-body p-3">
        <div class="row g-3 align-items-end">
          <div class="col-md-3">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">From Date</label>
            <input type="date" name="from_date" class="form-control" value="<%$from_date%>">
          </div>
          <div class="col-md-3">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">To Date</label>
            <input type="date" name="to_date" class="form-control" value="<%$to_date%>">
          </div>
          <div class="col-md-4">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Search</label>
            <input type="text" id="search-filter-input" class="form-control" placeholder="Search customer, contact, mode…">
          </div>
          <div class="col-md-2">
            <button type="submit" class="cat-btn cat-btn-primary w-100">
              <i class="ti ti-filter"></i> Apply
            </button>
          </div>
        </div>
      </div>
      </form>
    </div>

    <!-- Sales Report Table -->
    <div class="cat-table-card">
      <table class="table table-hover mb-0 w-100" id="salesReportTable">
        <thead>
          <tr>
            <th>Date</th>
            <th>Customer Name</th>
            <th>Contact</th>
            <th>Payment Mode</th>
            <th class="text-end">Total Amount</th>
          </tr>
        </thead>
        <tbody>
          <!-- Populated by DataTables Server-Side Processing -->
        </tbody>
        <tfoot>
          <tr>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th class="text-end" style="border-top: 1px solid var(--cat-border);">Grand Total:</th>
            <th id="grand-total-footer" class="text-primary text-end" style="font-size: 1.1rem; color: #c0392b !important; border-top: 1px solid var(--cat-border);">0.00</th>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales_report.js"></script>
<style>
  #salesReportTable tfoot th {
    background-color: var(--cat-gray-50) !important;
    font-family: var(--cat-font);
    font-weight: 600;
    padding: 16px !important;
  }
  @media print {
    .cat-btn, .cat-search-box, .cat-page-header-right, form, .sidebar, .navbar, .cat-breadcrumb { display: none !important; }
    .cat-table-card { border: none !important; box-shadow: none !important; }
    .content-wrapper { padding: 0 !important; margin: 0 !important; }
  }

  .adj-summary-card {
    background: #fff; border-radius: 12px; border: 1px solid #e2e6ef;
    padding: 1.2rem 1.5rem; box-shadow: 0 2px 16px rgba(91,95,199,.07);
    display: flex; align-items: center; gap: 1rem;
  }
  .adj-summary-icon {
    width: 50px; height: 50px; border-radius: 10px;
    display: flex; align-items: center; justify-content: center; font-size: 1.4rem; flex-shrink: 0;
  }
</style>
