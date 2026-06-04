<!-- Updated Header and Form Layout -->
<div class="cat-page-header mb-4">
  <div class="cat-page-header-left">
    <div class="cat-page-icon"><i class="ti ti-receipt-refund"></i></div>
    <div>
      <h1 class="cat-page-title">Initiate Sales Return</h1>
      <nav class="cat-breadcrumb">
        <a href="<%$base_url%>">Home</a>
        <i class="ti ti-chevron-right"></i>
        <a href="<%$base_url%>sales_return_list">Sales Return</a>
        <i class="ti ti-chevron-right"></i>
        <span>Initiate</span>
      </nav>
    </div>
  </div>
  <div class="cat-page-header-right">
    <a href="<%$base_url%>sales_return_list" class="cat-btn cat-btn-outline" title="Return List"><i class="ti ti-list"></i> Return List</a>
  </div>
</div>

<form id="salesReturnForm" action="<%$base_url('save_sales_return')%>" method="POST">
  <!-- Top Section: Return Info -->
  <div class="form-card">
    <div class="form-header">
      <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-receipt fs-3 me-2 text-primary"></i> Return Information</h5>
    </div>
    <div class="form-body">
      <div class="row g-4">
        <div class="col-md-4">
          <label class="form-label">Original Sales Bill <span class="text-danger">*</span></label>
          <select name="sales_id" id="sales_id" class="form-control select2 required-input">
            <option value="">Select Bill No</option>
            <%foreach from=$sales item=val%>
              <option value="<%$val['sales_id']%>"><%$val['bill_no']%> (<%$val['customer_phone_number']|default:'Walk-in'%>)</option>
            <%/foreach%>
          </select>
        </div>
        <div class="col-md-4">
          <label class="form-label">Return Number <span class="text-danger">*</span></label>
          <input type="text" name="return_no" class="form-control required-input bg-light" value="SR-<%rand(1000,9999)%>" readonly>
        </div>
        <div class="col-md-4">
          <label class="form-label">Return Date <span class="text-danger">*</span></label>
          <input type="date" name="return_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
        </div>
        <div class="col-md-12">
          <label class="form-label">Reason for Return</label>
          <textarea name="remarks" class="form-control" rows="2" placeholder="Enter reason for return..."></textarea>
        </div>
      </div>
    </div>
  </div>

  <!-- Bottom Section: Returnable Items -->
  <div class="form-card" id="returnItemsCard" style="display:none;">
    <div class="form-header flex-column align-items-start">
      <h5 class="mb-1 fw-bold d-flex align-items-center text-dark"><i class="ti ti-box fs-3 me-2 text-primary"></i> Returnable Items</h5>
      <small class="text-muted ms-4 ps-2">Enter quantity to return for each item.</small>
    </div>
    <div class="form-body">
      <div class="table-responsive">
        <table class="table w-100 table-purchase" id="returnItemsTable">
          <thead>
            <tr>
              <th style="width: 30%;">Product</th>
              <th>Sold Qty</th>
              <th>Already Returned</th>
              <th>Available to Return</th>
              <th style="width: 150px;">Return Qty</th>
              <th>Price</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
            <tr><td colspan="7" class="text-center text-muted">Select an original bill to load items.</td></tr>
          </tbody>
          <tfoot>
            <tr>
              <th colspan="6" class="text-end fs-5">Grand Total Return Amount:</th>
              <th class="fs-5 text-primary"><span id="grand_total_display"><%$settings.company_currency.value|default:'$'%>0.00</span>
                <input type="hidden" name="total_return_amount" id="total_return_amount" value="0"></th>
            </tr>
          </tfoot>
        </table>
      </div>
<div class="container-xxl flex-grow-1 container-p-y">
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-receipt-refund"></i></div>
        <div>
          <h1 class="cat-page-title">Initiate Sales Return</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>sales_return_list">Sales Return</a>
            <i class="ti ti-chevron-right"></i>
            <span>Initiate</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%$base_url%>sales_return_list" class="cat-btn cat-btn-outline" title="Return List">
          <i class="ti ti-list"></i> Return List
        </a>
      </div>
    </div>

    <form id="salesReturnForm" action="<%$base_url%>save_sales_return" method="POST">
      <!-- Top Section: Return Info -->
      <div class="form-card">
        <div class="form-header">
          <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-receipt fs-3 me-2 text-primary"></i> Return Information</h5>
        </div>
        <div class="form-body">
          <div class="row g-4">
            <div class="col-md-4">
              <label class="form-label">Original Sales Bill <span class="text-danger">*</span></label>
              <select name="sales_id" id="sales_id" class="form-control select2 required-input">
                <option value="">Select Bill No</option>
                <%foreach from=$sales item=val%>
                  <option value="<%$val['sales_id']%>"><%$val['bill_no']%> (<%$val['customer_phone_number']|default:'Walk-in'%>)</option>
                <%/foreach%>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Return Number <span class="text-danger">*</span></label>
              <input type="text" name="return_no" class="form-control required-input bg-light" value="SR-<%rand(1000,9999)%>" readonly>
            </div>
            <div class="col-md-4">
              <label class="form-label">Return Date <span class="text-danger">*</span></label>
              <input type="date" name="return_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
            <div class="col-md-12">
              <label class="form-label">Reason for Return</label>
              <textarea name="remarks" class="form-control" rows="2" placeholder="Enter reason for return..."></textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- Bottom Section: Returnable Items -->
      <div class="form-card" id="returnItemsCard" style="display:none;">
        <div class="form-header flex-column align-items-start">
          <h5 class="mb-1 fw-bold d-flex align-items-center text-dark"><i class="ti ti-box fs-3 me-2 text-primary"></i> Returnable Items</h5>
          <small class="text-muted ms-4 ps-2">Enter quantity to return for each item.</small>
        </div>
        <div class="form-body">
          <div class="table-responsive">
            <table class="table w-100 table-purchase" id="returnItemsTable">
              <thead>
                <tr>
                  <th style="width: 30%;">Product</th>
                  <th>Sold Qty</th>
                  <th>Already Returned</th>
                  <th>Available to Return</th>
                  <th style="width: 150px;">Return Qty</th>
                  <th>Price</th>
                  <th>Total</th>
                </tr>
              </thead>
                    </td>
                    <td>
                      <%$settings.company_currency.value|default:'$'%><%$item.sale_price|number_format:2%>
                      <input type="hidden" name="price[]" class="price-text" value="<%$item.sale_price%>">
                    </td>
                    <td>
                      <input type="text" name="total[]" class="form-control row-total" value="0.00" readonly>
                    </td>
                  </tr>
                  <%/foreach%>
                <%else%>
                  <tr><td colspan="7" class="text-center text-muted">Select an original bill to load items.</td></tr>
                <%/if%>
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="6" class="text-end fs-5">Grand Total Return Amount:</th>
                  <th class="fs-5 text-primary">
                    <span id="grand_total_display"><%$settings.company_currency.value|default:'$'%>0.00</span>
                    <input type="hidden" name="total_return_amount" id="total_return_amount" value="0">
                  </th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="mt-4 text-end">
            <button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm">
              <i class="ti ti-check me-1"></i> Process Return
            </button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales_return.js"></script>
