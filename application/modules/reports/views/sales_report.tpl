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
        <button id="btn-open-filter" class="cat-btn cat-btn-primary" data-bs-toggle="offcanvas" data-bs-target="#filterOffcanvas" aria-controls="filterOffcanvas" title="Filters">
          <i class="ti ti-filter"></i>
        </button>
        <button id="export-excel" class="cat-btn cat-btn-outline" title="Export Excel">
          <i class="ti ti-file-spreadsheet"></i> Export Excel
        </button>
        <button id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-outline" onclick="window.location.href='<%$base_url%>sales_report'" title="Refresh">
          <i class="ti ti-refresh"></i>
        </button>
      </div>
    </div>

    
    <!-- Summary Cards -->
    <div class="row g-3 mb-4">
      <div class="col-xl col-md-4 col-sm-6">
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
      <div class="col-xl col-md-4 col-sm-6">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#e8f8f0; color:#5b5fc7;">
                  <i class="ti ti-report-money"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">Total Amount</div>
                  <div id="kpi-total-amount" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;"><%$summary.grand_total|number_format:0|default:'0'%></div>
              </div>
          </div>
      </div>
      <div class="col-xl col-md-4 col-sm-6">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#e8f8f0; color:#27ae60;">
                  <i class="ti ti-cash"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">Cash Total</div>
                  <div id="kpi-total-cash" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;"><%$summary.total_cash|number_format:0%></div>
              </div>
          </div>
      </div>
      <div class="col-xl col-md-4 col-sm-6">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#fff0e1; color:#fd7e14;">
                  <i class="ti ti-device-mobile"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">UPI Total</div>
                  <div id="kpi-total-upi" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;"><%$summary.total_upi|number_format:0%></div>
              </div>
          </div>
      </div>
      <div class="col-xl col-md-4 col-sm-6">
          <div class="adj-summary-card">
              <div class="adj-summary-icon" style="background:#fdecea; color:#e74c3c;">
                  <i class="ti ti-credit-card"></i>
              </div>
              <div>
                  <div style="font-size:0.75rem; font-weight:600; color:var(--cat-light); text-transform:uppercase; letter-spacing:1px; margin-bottom:4px;">Other Total</div>
                  <div id="kpi-total-card" style="font-size:1.6rem; font-weight:800; color:var(--cat-dark); line-height:1;"><%$summary.total_card|number_format:0%></div>
              </div>
          </div>
      </div>
    </div>

    <!-- Right Side Offcanvas Filter Sidebar -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="filterOffcanvas" aria-labelledby="filterOffcanvasLabel" style="width: 380px;">
      <div class="offcanvas-header border-bottom px-4 py-3">
        <h5 class="offcanvas-title fw-bold text-dark d-flex align-items-center gap-2" id="filterOffcanvasLabel">
          <i class="ti ti-adjustments-horizontal text-primary"></i> Filter Options
        </h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body p-4">
        <form method="POST" action="<%base_url("sales_report")%>" id="filter-form" class="d-flex flex-column h-100">
          <div class="flex-grow-1">
            <div class="mb-3">
              <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Date Range</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="ti ti-calendar"></i></span>
                <input type="text" id="date_range_picker" class="form-control" placeholder="Select Date Range">
              </div>
              <input type="hidden" name="from_date" id="filter_from_date" value="<%$from_date%>">
              <input type="hidden" name="to_date" id="filter_to_date" value="<%$to_date%>">
            </div>
            <div class="mb-3">
              <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Search</label>
              <input type="text" id="search-filter-input" class="form-control" placeholder="Search customer, contact, mode…">
            </div>
          </div>
          <div class="border-top pt-3 mt-3 d-flex gap-2">
            <button type="button" id="btn-reset-filter" class="cat-btn cat-btn-outline w-50">
              <i class="ti ti-rotate-2"></i> Reset
            </button>
            <button type="submit" class="cat-btn cat-btn-primary w-50">
              <i class="ti ti-filter"></i> Apply
            </button>
          </div>
        </form>
      </div>
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
      </table>
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales_report.js?v=6"></script>
<style>
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

