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
        <button id="btn-open-filter" class="cat-btn cat-btn-primary" data-bs-toggle="offcanvas" data-bs-target="#filterOffcanvas" aria-controls="filterOffcanvas" title="Filters">
          <i class="ti ti-filter"></i>
        </button>
        <button id="btn-export-excel" class="cat-btn cat-btn-outline">
          <i class="ti ti-file-spreadsheet"></i> Export Excel
        </button>
        <button id="btn-export-pdf" class="cat-btn cat-btn-outline-red">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-outline" onclick="window.location.href='<%$base_url%>stock_adjustment_report'" title="Refresh">
          <i class="ti ti-refresh"></i>
        </button>
      </div>
    </div>

    <!-- Summary Cards -->
    <div class="row g-3 mb-4" id="adj-summary-cards">
      <!-- Filled via JS after table loads -->
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
        <form id="filterForm" action="javascript:void(0);" class="d-flex flex-column h-100">
          <div class="flex-grow-1">
            <div class="mb-3">
              <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Date Range</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="ti ti-calendar"></i></span>
                <input type="text" id="date_range_picker" class="form-control" placeholder="Select Date Range">
              </div>
              <input type="hidden" name="from_date" id="adj-from-date" value="<%$from_date%>">
              <input type="hidden" name="to_date" id="adj-to-date" value="<%$to_date%>">
            </div>
            <div class="mb-3">
              <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Search</label>
              <input type="text" id="adj-search" class="form-control" placeholder="Search product, user, remarks…">
            </div>
          </div>
          <div class="border-top pt-3 mt-3 d-flex gap-2">
            <button type="button" id="btn-reset-filter" class="cat-btn cat-btn-outline w-50">
              <i class="ti ti-rotate-2"></i> Reset
            </button>
            <button id="btn-apply-filter" class="cat-btn cat-btn-primary w-50">
              <i class="ti ti-filter"></i> Apply
            </button>
          </div>
        </form>
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
<script src="<%$base_url%>public/js/admin_panel/stock_adjustment_report.js?v=3"></script>
