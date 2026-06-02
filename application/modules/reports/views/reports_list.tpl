<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Reports</em></a>
          </h1>
          <br>
          <span >Analytics & Insights</span>
        </div>
      <div class="row mb-5 g-4 card-stats-row">
        <!-- Total Sales Card -->
        <div class="col-lg-3 col-md-6">
          <div class="card card-stat-item border-0 shadow-lg h-100 overflow-hidden bg-primary-gradient">
            <div class="card-body p-4 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">TOTAL SALES</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['total_sales']|number_format:2%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-currency-dollar text-white fs-2"></i>
                </div>
              </div>
              <div class="mt-3">
                 <span class="badge bg-white-transparent text-white px-2 py-1">Overall Revenue</span>
              </div>
              <div class="card-shape"></div>
            </div>
          </div>
        </div>

        <!-- Total Purchases Card -->
        <div class="col-lg-3 col-md-6">
          <div class="card card-stat-item border-0 shadow-lg h-100 overflow-hidden bg-info-gradient">
            <div class="card-body p-4 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">TOTAL PURCHASES</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['total_purchases']|number_format:2%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-shopping-cart text-white fs-2"></i>
                </div>
              </div>
              <div class="mt-3">
                 <span class="badge bg-white-transparent text-white px-2 py-1">Stock Investment</span>
              </div>
              <div class="card-shape"></div>
            </div>
          </div>
        </div>

        <!-- Inventory Value Card -->
        <div class="col-lg-3 col-md-6">
          <div class="card card-stat-item border-0 shadow-lg h-100 overflow-hidden bg-success-gradient">
            <div class="card-body p-4 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">INVENTORY VALUE</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['total_valuation']|number_format:2%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-building-warehouse text-white fs-2"></i>
                </div>
              </div>
              <div class="mt-3">
                 <span class="badge bg-white-transparent text-white px-2 py-1">Current Assets</span>
              </div>
              <div class="card-shape"></div>
            </div>
          </div>
        </div>

        <!-- Low Stock Items Card -->
        <div class="col-lg-3 col-md-6">
          <div class="card card-stat-item border-0 shadow-lg h-100 overflow-hidden bg-danger-gradient">
            <div class="card-body p-4 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">LOW STOCK</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['low_stock_count']%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-alert-triangle text-white fs-2"></i>
                </div>
              </div>
              <div class="mt-3">
                 <span class="badge bg-white-transparent text-white px-2 py-1">Critical Alerts</span>
              </div>
              <div class="card-shape"></div>
            </div>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-12">
          <div class="card shadow-sm border-0 overflow-hidden">
            <div class="card-header bg-transparent border-0 pt-4 px-4 pb-0">
               <div class="nav-align-top">
                <ul class="nav nav-tabs nav-fill custom-tabs" role="tablist">
                  <li class="nav-item">
                    <button type="button" class="nav-link active py-3" role="tab" data-bs-toggle="tab" data-bs-target="#navs-sales" aria-controls="navs-sales" aria-selected="true" id="sales-report-tab">
                      <i class="tf-icons ti ti-trending-up ti-sm me-2"></i> SALES REPORT
                    </button>
                  </li>
                  <li class="nav-item">
                    <button type="button" class="nav-link py-3" role="tab" data-bs-toggle="tab" data-bs-target="#navs-purchase" aria-controls="navs-purchase" aria-selected="false" id="purchase-report-tab">
                      <i class="tf-icons ti ti-shopping-cart ti-sm me-2"></i> PURCHASE REPORT
                    </button>
                  </li>
                  <li class="nav-item">
                    <button type="button" class="nav-link py-3" role="tab" data-bs-toggle="tab" data-bs-target="#navs-stock" aria-controls="navs-stock" aria-selected="false" id="stock-report-tab">
                      <i class="tf-icons ti ti-box ti-sm me-2"></i> STOCK VALUATION
                    </button>
                  </li>
                </ul>
              </div>
            </div>
            <div class="tab-content border-0 shadow-none">
              <!-- Sales Report Tab -->
              <div class="tab-pane fade show active" id="navs-sales" role="tabpanel">
                <div class="row mb-4 align-items-end g-3 bg-light p-3 rounded-3">
                  <div class="col-md-4">
                    <label class="form-label fw-bold">From Date</label>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text"><i class="ti ti-calendar"></i></span>
                        <input type="date" id="sales_from_date" class="form-control" value="<%$smarty.now|date_format:'%Y-%m-01'%>">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-bold">To Date</label>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text"><i class="ti ti-calendar"></i></span>
                        <input type="date" id="sales_to_date" class="form-control" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <button type="button" class="btn btn-primary d-flex align-items-center justify-content-center w-100 py-2" id="filter-sales-btn">
                      <i class="ti ti-filter me-2 ti-xs"></i> GENERATE REPORT
                    </button>
                  </div>
                </div>
                <div id="sales-report-container" class="table-responsive text-nowrap mt-3 min-h-300">
                    <!-- AJAX Table Load -->
                </div>
              </div>

              <!-- Purchase Report Tab -->
              <div class="tab-pane fade" id="navs-purchase" role="tabpanel">
                 <div class="row mb-4 align-items-end g-3 bg-light p-3 rounded-3">
                  <div class="col-md-4">
                    <label class="form-label fw-bold">From Date</label>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text"><i class="ti ti-calendar"></i></span>
                        <input type="date" id="purchase_from_date" class="form-control" value="<%$smarty.now|date_format:'%Y-%m-01'%>">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <label class="form-label fw-bold">To Date</label>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text"><i class="ti ti-calendar"></i></span>
                        <input type="date" id="purchase_to_date" class="form-control" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
                    </div>
                  </div>
                  <div class="col-md-4">
                    <button type="button" class="btn btn-primary d-flex align-items-center justify-content-center w-100 py-2" id="filter-purchase-btn">
                      <i class="ti ti-filter me-2 ti-xs"></i> GENERATE REPORT
                    </button>
                  </div>
                </div>
                <div id="purchase-report-container" class="table-responsive text-nowrap mt-3 min-h-300">
                    <!-- AJAX Table Load -->
                </div>
              </div>

              <!-- Stock Valuation Tab -->
              <div class="tab-pane fade" id="navs-stock" role="tabpanel">
                <div class="text-end mb-4 bg-light p-3 rounded-3">
                    <button type="button" class="btn btn-primary d-inline-flex align-items-center" id="refresh-stock-btn">
                        <i class="ti ti-refresh me-2 ti-xs"></i> REFRESH VALUATION
                    </button>
                </div>
                <div id="stock-report-container" class="table-responsive text-nowrap mt-3 min-h-300">
                    <!-- AJAX Table Load -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
  </div>
</div>

<style>
/* Stats Card Enhancements */
.bg-primary-gradient { background: linear-gradient(135deg, #7367f0 0%, #9e95f5 100%); }
.bg-info-gradient { background: linear-gradient(135deg, #00cfe8 0%, #70e4f4 100%); }
.bg-success-gradient { background: linear-gradient(135deg, #28c76f 0%, #48da89 100%); }
.bg-danger-gradient { background: linear-gradient(135deg, #ea5455 0%, #f08182 100%); }

.card-stat-item {
    transition: all 0.3s ease-in-out;
    cursor: default;
}
.card-stat-item:hover {
    transform: translateY(-10px);
    shadow: 0 15px 30px rgba(0,0,0,0.1) !important;
}

.stat-icon-wrapper {
    width: 54px;
    height: 54px;
    backdrop-filter: blur(4px);
    border: 1px solid rgba(255, 255, 255, 0.3);
}

.bg-white-transparent {
    background-color: rgba(255, 255, 255, 0.2);
}

.display-6 {
    font-size: 1.75rem;
    letter-spacing: -0.5px;
}

.card-shape {
    position: absolute;
    bottom: -20px;
    right: -20px;
    width: 100px;
    height: 100px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    z-index: 1;
}

/* Custom Modern Tab Styling */
.custom-tabs {
    background: #f1f2f6;
    padding: 8px;
    border-radius: 12px;
    border-bottom: none;
    gap: 10px;
}
.custom-tabs .nav-item {
    margin-bottom: 0;
}
.custom-tabs .nav-link {
    border: none !important;
    border-radius: 8px !important;
    font-weight: 600;
    color: #697a8d;
    letter-spacing: 0.5px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    background: transparent;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}
.custom-tabs .nav-link.active {
    background-color: #ffffff !important;
    color: #7367f0 !important;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05) !important;
    transform: translateY(-2px);
}
.custom-tabs .nav-link:hover:not(.active) {
    color: #7367f0;
    background-color: rgba(255, 255, 255, 0.5);
}
.custom-tabs .nav-link i {
    transition: transform 0.3s ease;
}
.custom-tabs .nav-link.active i {
    transform: scale(1.15);
    color: #7367f0;
}

.min-h-300 {
    min-height: 300px;
}
.bg-light {
    background-color: #f8f9fa !important;
}
.tab-content {
    padding: 1.5rem !important;
}
.card-header .nav-tabs {
    margin-bottom: 0;
}

/* Table Enhancements */
.table-responsive {
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
    border: 1px solid #e6e8eb;
    background: #ffffff;
    padding: 8px;
    transition: all 0.3s ease;
}

.table {
    margin-bottom: 0 !important;
}

.table thead th {
    background-color: #f8f9fb !important;
    text-transform: uppercase;
    font-size: 0.8rem !important;
    letter-spacing: 1px;
    font-weight: 700 !important;
    color: #4b465c !important;
    border-bottom: 2px solid #eaecf0 !important;
    border-top: none !important;
    padding: 16px 20px !important;
    vertical-align: middle !important;
}

.table tbody tr {
    transition: all 0.2s ease-in-out;
}

.table tbody tr:hover {
    background-color: rgba(115, 103, 240, 0.04) !important;
}

.table tbody td {
    padding: 16px 20px !important;
    vertical-align: middle !important;
    border-bottom: 1px solid #f0f2f5 !important;
    color: #5d596c;
}

/* Force perfect centering of icons inside table cells and badges */
.table td i, 
.table th i,
.table .badge i {
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    line-height: 1 !important;
    vertical-align: middle !important;
    height: 1em;
    width: 1em;
}

.table tbody tr:last-child td {
    border-bottom: none !important;
}

/* Footer styling */
.table tfoot tr th {
    padding: 16px 20px !important;
    border-top: 2px solid #eaecf0 !important;
    border-bottom: none !important;
}
</style>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/reports.js"></script>
