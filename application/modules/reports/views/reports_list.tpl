<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
/* Make entire month input clickable */
#report_month_filter {
    cursor: pointer;
}
</style>
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
            <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-chart-pie"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Reports</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Reports</span>
            <i class="ti ti-chevron-right"></i>
            <span>Analytics & Insights</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right d-flex align-items-center">
        <input type="month" id="report_month_filter" class="form-control me-3" style="width: 200px; border-radius: 8px; font-weight: 500;" value="<%$current_month%>">
      </div>

    </div>

    <!-- Stats Row -->
    <div class="d-flex align-items-center mb-4">
        <div class="rounded p-2 me-3" style="background-color: rgba(115, 103, 240, 0.1); color: #7367f0; display: inline-flex;">
            <i class="ti ti-chart-bar fs-4"></i>
        </div>
        <h4 class="text-primary fw-bold mb-0 me-3" style="letter-spacing: 0.5px;">Overall Values</h4>
        <div class="flex-grow-1" style="height: 2px; background: linear-gradient(90deg, rgba(115, 103, 240, 0.15) 0%, rgba(255,255,255,0) 100%); border-radius: 2px;"></div>
    </div>
    <div class="row mb-4 g-4 card-stats-row">
        <!-- Total Sales Card -->
        <div class="col-lg-3 col-md-6">
          <div class="card card-stat-item border-0 shadow-lg h-100 overflow-hidden bg-primary-gradient">
            <div class="card-body p-3 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">TOTAL SALES</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['total_sales']|number_format:2%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-currency-dollar text-white fs-3"></i>
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
            <div class="card-body p-3 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">TOTAL PURCHASES</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['total_purchases']|number_format:2%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-shopping-cart text-white fs-3"></i>
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
            <div class="card-body p-3 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">INVENTORY VALUE</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['total_valuation']|number_format:2%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-building-warehouse text-white fs-3"></i>
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
            <div class="card-body p-3 position-relative">
              <div class="d-flex justify-content-between align-items-start">
                <div>
                  <h6 class="text-white opacity-75 fw-medium mb-1">LOW STOCK</h6>
                  <h3 class="text-white mb-0 display-6 fw-bold"><%$stats['low_stock_count']%></h3>
                </div>
                <div class="stat-icon-wrapper bg-white-transparent rounded-circle d-flex align-items-center justify-content-center">
                  <i class="ti ti-alert-triangle text-white fs-3"></i>
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

<!-- Grand Totals Row -->
<div class="card bg-white shadow-sm border-0 mb-4" style="border-radius: 16px;">
    <div class="card-body p-4">
        <div class="d-flex align-items-center mb-4">
        <div class="rounded p-2 me-3 d-flex align-items-center justify-content-center" style="background-color: #fff; color: #7367f0; border: 1px solid rgba(0,0,0,0.08); width: 42px; height: 42px;">
            <i class="ti ti-calendar-event fs-4"></i>
        </div>
        <div>
            <h4 class="text-primary fw-bold mb-0" id="dynamic-month-title" style="letter-spacing: 0.5px;"><span id="dynamic-month-name" class="text-capitalize"><%$current_month|date_format:"%B"%></span> Month Value</h4>
            <div class="text-muted mt-1" style="font-size: 0.8rem;">Monthly summary of your key business metrics.</div>
        </div>
    </div>
        <div class="row mb-2 g-4">
        <!-- Sales Card -->
        <div class="col-lg-4 col-md-6">
            <div class="card bg-white shadow-sm h-100" style="border-radius: 12px; border: 1px solid rgba(0,0,0,0.05);">
                <div class="card-body p-4 pb-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="d-flex align-items-center">
                            <div class="rounded p-2 me-3 d-flex align-items-center justify-content-center" style="background-color: rgba(115, 103, 240, 0.1); color: #7367f0; width: 48px; height: 48px;">
                                <i class="ti ti-currency-rupee fs-3"></i>
                            </div>
                            <div>
                                <h6 class="text-muted fw-semibold mb-1" style="font-size: 0.75rem; letter-spacing: 0.5px; text-transform: uppercase;">Sales Grand Total</h6>
                                <h3 class="text-dark fw-bold mb-0" id="card-sales-total" style="font-size: 1.8rem; letter-spacing: -0.5px;">₹<%$current_sales_total|number_format:2%></h3>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="text-success fw-bold d-flex align-items-center justify-content-end" style="font-size: 0.85rem;"><i class="ti ti-trending-up me-1"></i> +12%</div>
                            <div class="text-muted" style="font-size: 0.7rem;">vs last month</div>
                        </div>
                    </div>
                    
                    <div class="progress mb-3" style="height: 6px; border-radius: 6px; background-color: rgba(115, 103, 240, 0.1);">
                        <div class="progress-bar" role="progressbar" style="width: 75%; background-color: #7367f0; border-radius: 6px;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    
                    <div class="pt-3 border-top border-light d-flex align-items-center text-muted" style="font-size: 0.8rem;">
                        <i class="ti ti-receipt me-2 fs-6"></i> Total revenue generated this month
                    </div>
                </div>
            </div>
        </div>

        <!-- Purchase Card -->
        <div class="col-lg-4 col-md-6">
            <div class="card bg-white shadow-sm h-100" style="border-radius: 12px; border: 1px solid rgba(0,0,0,0.05);">
                <div class="card-body p-4 pb-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="d-flex align-items-center">
                            <div class="rounded p-2 me-3 d-flex align-items-center justify-content-center" style="background-color: rgba(0, 207, 232, 0.1); color: #00cfe8; width: 48px; height: 48px;">
                                <i class="ti ti-shopping-cart fs-3"></i>
                            </div>
                            <div>
                                <h6 class="text-muted fw-semibold mb-1" style="font-size: 0.75rem; letter-spacing: 0.5px; text-transform: uppercase;">Purchase Grand Total</h6>
                                <h3 class="text-dark fw-bold mb-0" id="card-purchase-total" style="font-size: 1.8rem; letter-spacing: -0.5px;">₹<%$current_purchase_total|number_format:2%></h3>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="text-success fw-bold d-flex align-items-center justify-content-end" style="font-size: 0.85rem;"><i class="ti ti-trending-up me-1"></i> +8%</div>
                            <div class="text-muted" style="font-size: 0.7rem;">vs last month</div>
                        </div>
                    </div>
                    
                    <div class="progress mb-3" style="height: 6px; border-radius: 6px; background-color: rgba(0, 207, 232, 0.1);">
                        <div class="progress-bar" role="progressbar" style="width: 65%; background-color: #00cfe8; border-radius: 6px;" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    
                    <div class="pt-3 border-top border-light d-flex align-items-center text-muted" style="font-size: 0.8rem;">
                        <i class="ti ti-shopping-cart-plus me-2 fs-6"></i> Total amount spent on purchases
                    </div>
                </div>
            </div>
        </div>

        <!-- Inventory Card -->
        <div class="col-lg-4 col-md-6">
            <div class="card bg-white shadow-sm h-100" style="border-radius: 12px; border: 1px solid rgba(0,0,0,0.05);">
                <div class="card-body p-4 pb-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="d-flex align-items-center">
                            <div class="rounded p-2 me-3 d-flex align-items-center justify-content-center" style="background-color: rgba(40, 199, 111, 0.1); color: #28c76f; width: 48px; height: 48px;">
                                <i class="ti ti-building-warehouse fs-3"></i>
                            </div>
                            <div>
                                <h6 class="text-muted fw-semibold mb-1" style="font-size: 0.75rem; letter-spacing: 0.5px; text-transform: uppercase;">Inventory Valuation</h6>
                                <h3 class="text-dark fw-bold mb-0" id="card-inventory-total" style="font-size: 1.8rem; letter-spacing: -0.5px;">₹<%$stats['total_valuation']|number_format:2%></h3>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="text-success fw-bold d-flex align-items-center justify-content-end" style="font-size: 0.85rem;"><i class="ti ti-trending-up me-1"></i> +5%</div>
                            <div class="text-muted" style="font-size: 0.7rem;">vs last month</div>
                        </div>
                    </div>
                    
                    <div class="progress mb-3" style="height: 6px; border-radius: 6px; background-color: rgba(40, 199, 111, 0.1);">
                        <div class="progress-bar" role="progressbar" style="width: 50%; background-color: #28c76f; border-radius: 6px;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    
                    <div class="pt-3 border-top border-light d-flex align-items-center text-muted" style="font-size: 0.8rem;">
                        <i class="ti ti-stack me-2 fs-6"></i> Total value of current stock
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</div>

    <div class="row">
        <div class="col-12">
          <div class="cat-table-card shadow-sm border-0 overflow-hidden">
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
                <!-- Filter removed as per requirement -->
                <div id="sales-report-container" class="mt-3">
                    <!-- AJAX Table Load -->
                </div>
              </div>

              <!-- Purchase Report Tab -->
              <div class="tab-pane fade" id="navs-purchase" role="tabpanel">
                 <!-- Filter removed as per requirement -->
                <div id="purchase-report-container" class="mt-3">
                    <!-- AJAX Table Load -->
                </div>
              </div>

              <!-- Stock Valuation Tab -->
              <div class="tab-pane fade" id="navs-stock" role="tabpanel">
                <!-- Filter removed as per requirement -->
                <div id="stock-report-container" class="mt-3">
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
    max-height: 500px;
    overflow-y: auto;
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
    position: sticky;
    top: 0;
    z-index: 1;
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
<script src="<%$base_url%>public/js/admin_panel/reports.js?v=4"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var monthFilter = document.getElementById('report_month_filter');
    if (monthFilter) {
        monthFilter.addEventListener('click', function(e) {
            try {
                if (typeof this.showPicker === 'function') {
                    this.showPicker();
                }
            } catch (err) {
                // Ignore if showPicker fails
            }
        });
        // Prevent keyboard from popping up on mobile since it's a picker
        monthFilter.addEventListener('focus', function(e) {
            e.preventDefault();
        });
    }
});
</script>
