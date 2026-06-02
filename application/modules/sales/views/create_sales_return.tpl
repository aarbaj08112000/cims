<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="<%base_url('sales_return_list')%>" class="backlisting-link">
            <i class="ti ti-chevrons-right"></i>
            <em>Sales Return</em>
          </a>
        </h1>
        <br>
        <span>Initiate Sales Return</span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
      <a href="<%base_url('sales_return_list')%>" class="btn btn-seconday" title="Return List">
        <i class="ti ti-list"></i> Return List
      </a>
    </div>

    <form id="salesReturnForm" action="<%base_url('save_sales_return')%>" method="POST">
      <div class="card mb-4">
        <div class="card-body">
          <div class="row">
            <div class="col-md-4 mb-3">
              <label class="form-label">Original Sales Bill <span class="text-danger">*</span></label>
              <%if isset($sale) && $sale%>
                <input type="hidden" name="sales_id" value="<%$sale.sales_id%>">
                <input type="text" class="form-control" value="#<%$sale.bill_no%>" readonly>
              <%else%>
                <select name="sales_id" id="sales_id" class="form-control select2 required-input">
                  <option value="">Select Bill No</option>
                  <%foreach from=$sales item=val%>
                    <option value="<%$val['sales_id']%>"><%$val['bill_no']%> (<%$val['customer_phone_number']|default:'Walk-in'%>)</option>
                  <%/foreach%>
                </select>
              <%/if%>
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Return Number <span class="text-danger">*</span></label>
              <input type="text" name="return_no" class="form-control required-input" value="SR-<%rand(1000,9999)%>" readonly>
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Return Date <span class="text-danger">*</span></label>
              <input type="date" name="return_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
            <div class="col-md-12 mb-3">
              <label class="form-label">Reason for Return</label>
              <textarea name="remarks" class="form-control" rows="2" placeholder="Enter reason for return..."></textarea>
            </div>
          </div>
        </div>
      </div>

      <div class="card" id="returnItemsCard">
        <div class="card-header border-bottom">
          <h5 class="mb-0">Returnable Items</h5>
          <small class="text-muted">Enter quantity to return for each item.</small>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="returnItemsTable">
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
                <%if isset($items) && $items%>
                  <%foreach from=$items item=item%>
                  <tr>
                    <td>
                      <strong><%$item.product_name%></strong><br>
                      <small class="text-muted"><%$item.product_code%></small>
                      <input type="hidden" name="product_id[]" value="<%$item.product_id%>">
                    </td>
                    <td><%$item.qty%></td>
                    <td>0</td>
                    <td class="available-qty fw-bold"><%$item.qty%></td>
                    <td>
                      <input type="number" name="return_qty[]" class="form-control return-qty" min="0" max="<%$item.qty%>" value="0">
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
