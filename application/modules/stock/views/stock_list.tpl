<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Stock Management</em></a>
          </h1>
          <br>
          <span >Inventory Status</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
         <input type="text" id="search-filter-input" placeholder="Search Stock..." class="form-control search-filter-input me-2">
         <!-- Manual adjustment modal can be triggered from here if needed -->
         <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#manualAdjustmentModal">
            <i class="ti ti-adjustments me-2"></i> Manual Adjustment
         </button>
      </div>



      <div class="card p-0 mt-0 w-100">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" id="stockListTable">
            <thead>
               <tr>
                  <th>Product</th>
                  <th>Category</th>
                  <th>Brand</th>
                  <th class="text-center">Current Stock</th>
                  <th class="text-center">Alert Qty</th>
                  <th>Unit</th>
                  <th>Status</th>
                  <th>Action</th>
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
                        <span class="badge bg-danger">Out of Stock</span>
                    <%elseif $val['current_stock'] <= $val['alert_qty']%>
                        <span class="badge bg-warning">Low Stock</span>
                    <%else%>
                        <span class="badge bg-success">In Stock</span>
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
