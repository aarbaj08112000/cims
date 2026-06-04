<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-packages"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Stock Management</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Stock Management</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search Stock..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary text-white" data-bs-toggle="modal" data-bs-target="#manualAdjustmentModal" title="Manual Adjustment">
          <i class="ti ti-adjustments"></i> Manual Adjustment
        </button>
      </div>
    </div>



    <!-- Table Card -->
    <div class="cat-table-card">
      <table class="table table-hover mb-0 w-100" id="stockListTable">
        <thead class="bg-light">
               <tr>
                  <th>Product</th>
                  <th>Category</th>
                  <th>Brand</th>
                  <th class="text-center">Current Stock</th>
                  <th class="text-center">Alert Qty</th>
                  <th>Unit</th>
                  <th>Status</th>
                  <th class="text-center">Action</th>
               </tr>
            </thead>
            <tbody>
            <%if ($stock_levels) %>
              <%foreach from=$stock_levels item=val %>
               <tr>
                  <td>
                    <span class="d-block fw-bold"><%$val['name']%></span>
                    <small class="text-muted"><%$val['product_code']%></small>
                  </td>
                  <td><%$val['category_name']|default:'N/A'%></td>
                  <td><%$val['brand_name']|default:'N/A'%></td>
                  <td class="text-center">
                    <span class="badge <%if $val['current_stock'] <= $val['alert_qty']%>bg-label-danger<%else%>bg-label-success<%/if%> fs-6">
                        <%$val['current_stock']%>
                    </span>
                  </td>
                  <td class="text-center"><%$val['alert_qty']%></td>
                  <td><%$val['unit']%></td>
                  <td>
                    <%if $val['current_stock'] <= 0%>
                        <span class="cat-badge cat-badge-inactive">Out of Stock</span>
                    <%elseif $val['current_stock'] <= $val['alert_qty']%>
                        <span class="cat-badge" style="background: rgba(255, 152, 0, 0.1); color: #ff9800; border: 1px solid rgba(255, 152, 0, 0.2);">Low Stock</span>
                    <%else%>
                        <span class="cat-badge cat-badge-active">In Stock</span>
                    <%/if%>
                  </td>
                  <td class="text-center">
                    <div class="dropdown">
                        <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                            <i class="ti ti-dots-vertical" style="font-size: 1.25rem;"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item adjust-stock-btn" href="javascript:void(0);" data-id="<%$val['product_id']%>">
                                <i class="ti ti-adjustments me-1"></i> Adjust Stock
                            </a>
                            <a class="dropdown-item view-stock-ledger" href="javascript:void(0);" data-id="<%$val['product_id']%>">
                                <i class="ti ti-history me-1"></i> View History
                            </a>
                        </div>
                    </div>
                  </td>
               </tr>
              <%/foreach%>
            <%/if%>
            </tbody>
          </table>
      </div>
  </div>
</div>

<!-- Stock Ledger Modal -->
<div class="modal fade" id="stockLedgerModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content" id="stock-ledger-content">
      <!-- AJAX content -->
    </div>
  </div>
</div>

<!-- Manual Adjustment Modal -->
<div class="modal fade" id="manualAdjustmentModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-primary py-3">
        <h5 class="modal-title text-white">Manual Stock Adjustment</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <form id="stockAdjustmentForm" action="<%base_url('update_stock')%>" method="POST">
            <div class="mb-3">
                <label class="form-label">Product</label>
                <select name="product_id" id="adjustment_product_id" class="form-control select2 required-input" data-placeholder="Choose Product">
                    <option value=""></option>
                    <%foreach from=$stock_levels item=val%>
                        <option value="<%$val['product_id']%>"><%$val['name']%> (<%$val['product_code']%>)</option>
                    <%/foreach%>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Adjustment Quantity (Use positive to add, negative to subtract)</label>
                <input type="number" name="qty" id="adjustment_qty" class="form-control required-input" step="1">
            </div>
            <div class="mb-3">
                <label class="form-label">Remarks</label>
                <textarea name="remarks" class="form-control required-input" rows="2" placeholder="Reason for adjustment..."></textarea>
            </div>
            <div class="text-end">
                <button type="submit" class="btn btn-primary">Save Adjustment</button>
            </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/stock.js"></script>
