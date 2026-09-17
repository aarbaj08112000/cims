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
        <button type="button" id="export-excel" class="cat-btn cat-btn-outline" title="Export Excel">
          <i class="ti ti-file-spreadsheet"></i> Export Excel
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary text-white" data-bs-toggle="offcanvas" data-bs-target="#manualAdjustmentOffcanvas" aria-controls="manualAdjustmentOffcanvas" title="Manual Adjustment">
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
                            <a class="dropdown-item view-stock-ledger" href="<%base_url('stock/stock_ledger/')%><%$val['product_id']|encode_id%>">
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



<!-- Manual Adjustment Offcanvas (Right Sidebar) -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="manualAdjustmentOffcanvas" aria-labelledby="manualAdjustmentOffcanvasLabel" style="width: 420px;">
  <!-- Gradient Header -->
  <div class="offcanvas-header border-bottom-0 py-4" style="background: linear-gradient(135deg, #4f46e5 0%, #2b3252 100%); position: relative;">
    <div class="d-flex align-items-center gap-3">
      <div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 42px; height: 42px; background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.25);">
        <i class="ti ti-adjustments text-white fs-4"></i>
      </div>
      <div>
        <h5 class="offcanvas-title mb-0 text-white fw-bold" id="manualAdjustmentOffcanvasLabel">Manual Stock Adjustment</h5>
        <small class="text-white-50">Add or reduce stock directly</small>
      </div>
    </div>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"
      style="background-color: rgba(255,255,255,0.1); border-radius: 50%; padding: 0.5rem; opacity: 1;"></button>
  </div>

  <!-- Body -->
  <div class="offcanvas-body p-4">
    <form id="stockAdjustmentForm" action="<%base_url('update_stock')%>" method="POST">

      <!-- Product -->
      <div class="mb-4">
        <label class="form-label fw-semibold text-dark mb-2">Product <span class="text-danger">*</span></label>
        <select name="product_id" id="adjustment_product_id" class="form-control select2 required-input" data-placeholder="Choose Product">
          <option value=""></option>
          <%foreach from=$stock_levels item=val%>
            <option value="<%$val['product_id']%>" data-stock="<%$val['current_stock']%>"><%$val['name']%> (<%$val['product_code']%>)</option>
          <%/foreach%>
        </select>
        <div id="current_stock_display" class="mt-2 text-muted small" style="display: none;">
          Current / Old Stock: <span id="current_stock_val" class="fw-bold text-dark badge bg-label-secondary"></span>
        </div>
      </div>

      <!-- Quantity -->
      <div class="mb-4">
        <label class="form-label fw-semibold text-dark mb-2">Adjustment Quantity <span class="text-danger">*</span></label>
        <div class="input-group input-group-merge">
          <span class="input-group-text"><i class="ti ti-math-symbols"></i></span>
          <input type="number" name="qty" id="adjustment_qty" class="form-control required-input" step="1" placeholder="Use positive to add, negative to subtract">
        </div>
        <div class="form-text mt-1 text-muted">
          <i class="ti ti-info-circle me-1"></i> E.g.
          <span class="text-success fw-medium">+5</span> to add stock,
          <span class="text-danger fw-medium">-3</span> to reduce stock.
        </div>
      </div>

      <!-- Remarks -->
      <div class="mb-4">
        <label class="form-label fw-semibold text-dark mb-2">Remarks <span class="text-danger">*</span></label>
        <div class="input-group input-group-merge">
          <span class="input-group-text align-items-start pt-2"><i class="ti ti-notes"></i></span>
          <textarea name="remarks" class="form-control required-input" rows="3" placeholder="Reason for adjustment (e.g. damaged, found extra)..."></textarea>
        </div>
      </div>

      <!-- Actions pinned at bottom -->
      <div class="d-flex gap-3 mt-4 pt-3 border-top">
        <button type="button" class="btn btn-label-secondary flex-fill fw-medium" data-bs-dismiss="offcanvas">Cancel</button>
        <button type="submit" class="btn btn-primary flex-fill fw-medium shadow-sm">
          <i class="ti ti-device-floppy me-2"></i>Save Adjustment
        </button>
      </div>

    </form>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/stock.js?v=8"></script>
