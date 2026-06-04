<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
/* ===================================================
   Purchase Details – Premium Dashboard
   =================================================== */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

:root {
    --pd-primary: #696cff;
    --pd-primary-dark: #5b5fc7;
    --pd-primary-light: #ededfa;
    --pd-success: #27ae60;
    --pd-success-light: #e8f8f0;
    --pd-warning: #f59e0b;
    --pd-warning-light: #fef3c7;
    --pd-danger: #e74c3c;
    --pd-danger-light: #fdecea;
    --pd-gray-50: #f8f9fc;
    --pd-gray-100: #f1f3f9;
    --pd-gray-200: #e2e6ef;
    --pd-gray-500: #8490a7;
    --pd-gray-700: #3d4f6f;
    --pd-gray-900: #1e293b;
    --pd-font: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    --pd-radius: 12px;
    --pd-shadow: 0 2px 20px rgba(0,0,0,0.06);
}

/* -- Stat Cards Row -- */
.pd-stat-card {
    background: #fff;
    border-radius: var(--pd-radius);
    box-shadow: var(--pd-shadow);
    border: 1px solid var(--pd-gray-200);
    padding: 1.25rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    transition: all 0.25s ease;
    height: 100%;
}
.pd-stat-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}
.pd-stat-icon {
    width: 52px;
    height: 52px;
    border-radius: var(--pd-radius);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.4rem;
    flex-shrink: 0;
}
.pd-stat-icon.purple  { background: var(--pd-primary-light); color: var(--pd-primary); }
.pd-stat-icon.green   { background: var(--pd-success-light); color: var(--pd-success); }
.pd-stat-icon.amber   { background: var(--pd-warning-light); color: var(--pd-warning); }
.pd-stat-icon.red     { background: var(--pd-danger-light);  color: var(--pd-danger); }
.pd-stat-label {
    font-family: var(--pd-font);
    font-size: 0.78rem;
    font-weight: 500;
    color: var(--pd-gray-500);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 2px;
}
.pd-stat-value {
    font-family: var(--pd-font);
    font-size: 1.35rem;
    font-weight: 700;
    color: var(--pd-gray-900);
    line-height: 1.2;
}
.pd-stat-value.text-primary { color: var(--pd-primary) !important; }

/* -- Detail Cards -- */
.pd-detail-card {
    background: #fff;
    border-radius: var(--pd-radius);
    box-shadow: var(--pd-shadow);
    border: 1px solid var(--pd-gray-200);
    overflow: hidden;
    height: 100%;
    transition: box-shadow 0.25s ease;
}
.pd-detail-card:hover {
    box-shadow: 0 6px 24px rgba(0,0,0,0.09);
}
.pd-detail-header {
    background: linear-gradient(135deg, #f8f9fc 0%, #fff 100%);
    border-bottom: 1px solid var(--pd-gray-200);
    padding: 1rem 1.25rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.pd-detail-header h6 {
    font-family: var(--pd-font);
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--pd-gray-900);
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.pd-detail-header h6 i {
    color: var(--pd-primary);
    font-size: 1.2rem;
}
.pd-detail-body {
    padding: 1.25rem;
}

/* -- Info Rows inside cards -- */
.pd-info-row {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.6rem 0.75rem;
    border-radius: 8px;
    margin-bottom: 0.5rem;
    transition: all 0.2s ease;
    background: transparent;
}
.pd-info-row:last-child { margin-bottom: 0; }
.pd-info-row:hover {
    background: var(--pd-gray-50);
}
.pd-info-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: var(--pd-primary-light);
    color: var(--pd-primary);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    flex-shrink: 0;
}
.pd-info-content {
    flex: 1;
    min-width: 0;
}
.pd-info-label {
    font-family: var(--pd-font);
    font-size: 0.72rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.4px;
    color: var(--pd-gray-500);
    margin-bottom: 1px;
}
.pd-info-value {
    font-family: var(--pd-font);
    font-size: 0.9rem;
    font-weight: 600;
    color: var(--pd-gray-900);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* -- Status Badges -- */
.pd-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 12px;
    border-radius: 20px;
    font-family: var(--pd-font);
    font-size: 0.78rem;
    font-weight: 600;
    white-space: nowrap;
}
.pd-badge-dot {
    width: 7px;
    height: 7px;
    border-radius: 50%;
    flex-shrink: 0;
}
.pd-badge-success {
    background: var(--pd-success-light);
    color: var(--pd-success);
}
.pd-badge-success .pd-badge-dot { background: var(--pd-success); }
.pd-badge-warning {
    background: var(--pd-warning-light);
    color: #92400e;
}
.pd-badge-warning .pd-badge-dot { background: var(--pd-warning); }
.pd-badge-danger {
    background: var(--pd-danger-light);
    color: var(--pd-danger);
}
.pd-badge-danger .pd-badge-dot { background: var(--pd-danger); }

/* -- Products Table -- */
.pd-table-wrap {
    background: #fff;
    border-radius: var(--pd-radius);
    box-shadow: var(--pd-shadow);
    border: 1px solid var(--pd-gray-200);
    overflow: hidden;
}
.pd-table-header {
    background: linear-gradient(135deg, #f8f9fc 0%, #fff 100%);
    border-bottom: 1px solid var(--pd-gray-200);
    padding: 1rem 1.25rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.pd-table-header h6 {
    font-family: var(--pd-font);
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--pd-gray-900);
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.pd-table-header h6 i { color: var(--pd-primary); font-size: 1.2rem; }
.pd-items-count {
    font-family: var(--pd-font);
    font-size: 0.8rem;
    color: var(--pd-gray-500);
    background: var(--pd-gray-100);
    padding: 3px 10px;
    border-radius: 12px;
    font-weight: 500;
}
.pd-table-wrap table {
    width: 100%;
    border-collapse: collapse;
}
.pd-table-wrap thead tr { background: var(--pd-gray-50); }
.pd-table-wrap thead th {
    font-family: var(--pd-font);
    font-weight: 600;
    font-size: 0.72rem;
    text-transform: uppercase;
    letter-spacing: 0.6px;
    color: var(--pd-gray-500);
    padding: 12px 16px;
    border-bottom: 1.5px solid var(--pd-gray-200);
}
.pd-table-wrap tbody td {
    font-family: var(--pd-font);
    padding: 14px 16px;
    color: var(--pd-gray-700);
    vertical-align: middle;
    font-size: 0.88rem;
    border-bottom: 1px solid var(--pd-gray-100);
}
.pd-table-wrap tbody tr { transition: background 0.15s; }
.pd-table-wrap tbody tr:hover { background: var(--pd-gray-50); }
.pd-table-wrap tbody tr:last-child td { border-bottom: none; }

.pd-row-num {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 28px;
    height: 28px;
    border-radius: 6px;
    background: var(--pd-gray-100);
    font-size: 0.75rem;
    font-weight: 600;
    color: var(--pd-gray-500);
}
.pd-product-name { font-weight: 600; color: var(--pd-gray-900); }
.pd-product-code { font-size: 0.78rem; color: var(--pd-gray-500); }
.pd-qty-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 32px;
    padding: 4px 10px;
    border-radius: 6px;
    background: var(--pd-primary-light);
    color: var(--pd-primary);
    font-weight: 600;
    font-size: 0.85rem;
}
.pd-price { font-weight: 600; color: var(--pd-gray-700); }

/* -- Grand Total Footer -- */
.pd-grand-total {
    background: linear-gradient(135deg, var(--pd-primary-light) 0%, #f8f9fc 100%);
    padding: 1rem 1.5rem;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 1.5rem;
    border-top: 2px solid var(--pd-gray-200);
}
.pd-grand-total-label {
    font-family: var(--pd-font);
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--pd-gray-700);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
.pd-grand-total-value {
    font-family: var(--pd-font);
    font-size: 1.5rem;
    font-weight: 800;
    color: var(--pd-primary);
}

/* -- Responsive -- */
@media (max-width: 992px) {
    .pd-stat-card { padding: 1rem; }
    .pd-stat-icon { width: 44px; height: 44px; font-size: 1.2rem; }
    .pd-stat-value { font-size: 1.1rem; }
}
@media (max-width: 576px) {
    .pd-grand-total { flex-direction: column; gap: 0.5rem; text-align: right; }
    .pd-info-row { gap: 0.5rem; padding: 0.5rem; }
}
</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- ========== Page Header ========== -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-receipt"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Purchase Details</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>purchase_list">Purchase History</a>
            <i class="ti ti-chevron-right"></i>
            <span>Detail</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%$base_url%>purchase_list" class="cat-btn cat-btn-outline">
          <i class="ti ti-arrow-left"></i> Back to List
        </a>
        <button class="cat-btn cat-btn-primary" onclick="window.print()">
          <i class="ti ti-printer"></i> Print Bill
        </button>
      </div>
    </div>

    <!-- ========== Quick Stats Row ========== -->
    <div class="row g-3 mb-4">
      <!-- Total Amount -->
      <div class="col-xl-3 col-sm-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon purple">
            <i class="ti ti-currency-rupee"></i>
          </div>
          <div>
            <div class="pd-stat-label">Total Amount</div>
            <div class="pd-stat-value text-primary">₹ <%$purchase['total_amount']|number_format:2%></div>
          </div>
        </div>
      </div>
      <!-- Total Products -->
      <div class="col-xl-3 col-sm-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon green">
            <i class="ti ti-package"></i>
          </div>
          <div>
            <div class="pd-stat-label">Total Products</div>
            <div class="pd-stat-value"><%$items|@count%></div>
          </div>
        </div>
      </div>
      <!-- Total Quantity -->
      <div class="col-xl-3 col-sm-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon amber">
            <i class="ti ti-stack-2"></i>
          </div>
          <div>
            <div class="pd-stat-label">Total Quantity</div>
            <div class="pd-stat-value">
              <%assign var='totalQty' value=0%>
              <%foreach from=$items item=item%>
                <%assign var='totalQty' value=$totalQty+$item['qty']%>
              <%/foreach%>
              <%$totalQty%>
            </div>
          </div>
        </div>
      </div>
      <!-- Status -->
      <div class="col-xl-3 col-sm-6">
        <div class="pd-stat-card">
          <div class="pd-stat-icon <%if $purchase['status'] == 'Completed'%>green<%else%>red<%/if%>">
            <i class="ti ti-circle-check"></i>
          </div>
          <div>
            <div class="pd-stat-label">Purchase Status</div>
            <div>
              <%if $purchase['status'] == 'Completed'%>
                <span class="pd-badge pd-badge-success"><span class="pd-badge-dot"></span> <%$purchase['status']%></span>
              <%else%>
                <span class="pd-badge pd-badge-danger"><span class="pd-badge-dot"></span> <%$purchase['status']%></span>
              <%/if%>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ========== Detail Cards Row ========== -->
    <div class="row g-4 mb-4">

      <!-- Purchase Summary Card -->
      <div class="col-lg-4 col-md-6">
        <div class="pd-detail-card">
          <div class="pd-detail-header">
            <h6><i class="ti ti-file-description"></i> Purchase Summary</h6>
          </div>
          <div class="pd-detail-body">
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-hash"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Bill Number</div>
                <div class="pd-info-value"><%$purchase['bill_no']%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-calendar"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Purchase Date</div>
                <div class="pd-info-value"><%$purchase['purchase_date']|date_format:'%d %b %Y'%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-clock"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Added On</div>
                <div class="pd-info-value"><%$purchase['added_date']|date_format:'%d %b %Y, %H:%M'%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon" style="background: <%if $purchase['status'] == 'Completed'%>var(--pd-success-light)<%else%>var(--pd-danger-light)<%/if%>; color: <%if $purchase['status'] == 'Completed'%>var(--pd-success)<%else%>var(--pd-danger)<%/if%>;">
                <i class="ti ti-circle-check"></i>
              </div>
              <div class="pd-info-content">
                <div class="pd-info-label">Status</div>
                <div>
                  <%if $purchase['status'] == 'Completed'%>
                    <span class="pd-badge pd-badge-success"><span class="pd-badge-dot"></span> <%$purchase['status']%></span>
                  <%else%>
                    <span class="pd-badge pd-badge-danger"><span class="pd-badge-dot"></span> <%$purchase['status']%></span>
                  <%/if%>
                </div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-currency-rupee"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Amount</div>
                <div class="pd-info-value" style="color: var(--pd-primary); font-size: 1.05rem;">₹ <%$purchase['total_amount']|number_format:2%></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Supplier Information Card -->
      <div class="col-lg-4 col-md-6">
        <div class="pd-detail-card">
          <div class="pd-detail-header">
            <h6><i class="ti ti-building-store"></i> Supplier Information</h6>
          </div>
          <div class="pd-detail-body">
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-user-circle"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Supplier Name</div>
                <div class="pd-info-value"><%$purchase['supplier_name']%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-phone"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Mobile Number</div>
                <div class="pd-info-value"><%$purchase['phone']|default:'N/A'%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-mail"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Email Address</div>
                <div class="pd-info-value"><%$purchase['email']|default:'N/A'%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-map-pin"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Address</div>
                <div class="pd-info-value"><%$purchase['address']|default:'N/A'%></div>
              </div>
            </div>
            <%if $purchase['gst_number']%>
            <div class="pd-info-row">
              <div class="pd-info-icon"><i class="ti ti-file-invoice"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">GST Number</div>
                <div class="pd-info-value"><%$purchase['gst_number']%></div>
              </div>
            </div>
            <%/if%>
          </div>
        </div>
      </div>

      <!-- Quick Overview Card -->
      <div class="col-lg-4 col-md-12">
        <div class="pd-detail-card">
          <div class="pd-detail-header">
            <h6><i class="ti ti-chart-bar"></i> Quick Overview</h6>
          </div>
          <div class="pd-detail-body">
            <div class="pd-info-row">
              <div class="pd-info-icon green"><i class="ti ti-package"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Products</div>
                <div class="pd-info-value"><%$items|@count%> Items</div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon amber"><i class="ti ti-stack-2"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Total Quantity</div>
                <div class="pd-info-value"><%$totalQty%> Units</div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon purple"><i class="ti ti-receipt"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Bill Reference</div>
                <div class="pd-info-value"><%$purchase['bill_no']%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon purple"><i class="ti ti-currency-rupee"></i></div>
              <div class="pd-info-content">
                <div class="pd-info-label">Purchase Value</div>
                <div class="pd-info-value" style="color: var(--pd-primary); font-size: 1.05rem;">₹ <%$purchase['total_amount']|number_format:2%></div>
              </div>
            </div>
            <div class="pd-info-row">
              <div class="pd-info-icon" style="background: <%if $purchase['status'] == 'Completed'%>var(--pd-success-light)<%else%>var(--pd-danger-light)<%/if%>; color: <%if $purchase['status'] == 'Completed'%>var(--pd-success)<%else%>var(--pd-danger)<%/if%>;">
                <i class="ti ti-shield-check"></i>
              </div>
              <div class="pd-info-content">
                <div class="pd-info-label">Payment Status</div>
                <div>
                  <%if $purchase['status'] == 'Completed'%>
                    <span class="pd-badge pd-badge-success"><span class="pd-badge-dot"></span> Paid</span>
                  <%else%>
                    <span class="pd-badge pd-badge-warning"><span class="pd-badge-dot"></span> Pending</span>
                  <%/if%>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>

    <!-- ========== Products Table ========== -->
    <div class="pd-table-wrap mb-4">
      <div class="pd-table-header">
        <h6><i class="ti ti-list-details"></i> Purchased Items</h6>
        <span class="pd-items-count"><%$items|@count%> item<%if $items|@count > 1%>s<%/if%></span>
      </div>
      <div class="table-responsive">
        <table>
          <thead>
            <tr>
              <th style="width:50px">#</th>
              <th>Product</th>
              <th class="text-center" style="width:100px">Qty</th>
              <th class="text-end" style="width:140px">Unit Price</th>
              <th class="text-end" style="width:140px">Total</th>
            </tr>
          </thead>
          <tbody>
            <%assign var='idx' value=1%>
            <%foreach from=$items item=item%>
            <tr>
              <td><span class="pd-row-num"><%$idx%></span></td>
              <td>
                <div class="pd-product-name"><%$item['product_name']%></div>
                <div class="pd-product-code"><%$item['product_code']%></div>
              </td>
              <td class="text-center"><span class="pd-qty-badge"><%$item['qty']%></span></td>
              <td class="text-end pd-price">₹ <%$item['purchase_price']|number_format:2%></td>
              <td class="text-end pd-price">₹ <%$item['total_amount']|number_format:2%></td>
            </tr>
            <%assign var='idx' value=$idx+1%>
            <%/foreach%>
          </tbody>
        </table>
      </div>
      <div class="pd-grand-total">
        <span class="pd-grand-total-label">Grand Total</span>
        <span class="pd-grand-total-value">₹ <%$purchase['total_amount']|number_format:2%></span>
      </div>
    </div>

  </div>
</div>
