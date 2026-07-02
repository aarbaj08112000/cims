<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-adjustments-horizontal"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Stock Adjustment Report</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%base_url('reports')%>">Reports</a>
            <i class="ti ti-chevron-right"></i>
            <span>Stock Adjustments</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <button id="btn-export-csv" class="cat-btn cat-btn-outline">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button id="btn-export-pdf" class="cat-btn cat-btn-outline-red">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
      </div>
    </div>

    <!-- Summary Cards -->
    <div class="row g-3 mb-4" id="adj-summary-cards">
      <!-- Filled via JS after table loads -->
    </div>

    <!-- Filter Card -->
    <div class="card border-0 shadow-sm mb-4" style="border-radius:12px;">
      <div class="card-body p-3">
        <div class="row g-3 align-items-end">
          <div class="col-md-3">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">From Date</label>
            <input type="date" id="adj-from-date" class="form-control" value="<%$from_date%>">
          </div>
          <div class="col-md-3">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">To Date</label>
            <input type="date" id="adj-to-date" class="form-control" value="<%$to_date%>">
          </div>
          <div class="col-md-4">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Search</label>
            <input type="text" id="adj-search" class="form-control" placeholder="Search product, user, remarks…">
          </div>
          <div class="col-md-2">
            <button id="btn-apply-filter" class="cat-btn cat-btn-primary w-100">
              <i class="ti ti-filter"></i> Apply
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Table -->
    <div class="cat-table-card">
      <div id="adj-table-container">
        <div class="text-center py-5 text-muted"><i class="ti ti-loader-2 ti-spin fs-3"></i><br>Loading…</div>
      </div>
    </div>

  </div>
</div>

<style>
.adj-change-badge {
  display: inline-flex; align-items: center; gap: 4px;
  padding: 3px 10px; border-radius: 20px; font-size: 0.78rem; font-weight: 600;
}
.adj-add    { background: #e8f8f0; color: #27ae60; }
.adj-reduce { background: #fdecea; color: #e74c3c; }
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

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/stock_adjustment_report.js"></script>
