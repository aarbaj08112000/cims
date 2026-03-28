<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Sales</em></a>
          </h1>
          <br>
          <span >Create Sales Bill</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <a href="<%base_url('sales_list')%>" class="btn btn-seconday" title="Sales List">
           <i class="ti ti-list"></i> Sales List
        </a>
      </div>

    <form id="salesForm" action="<%base_url('save_sale')%>" method="POST">
      <div class="card mb-4">
        <div class="card-body">
          <div class="row">
            <div class="col-md-3 mb-3">
              <label class="form-label">Customer Mobile Number <span class="text-danger">*</span></label>
              <input type="text" name="customer_mobile" class="form-control required-input" placeholder="Enter Mobile No" maxlength="15">
            </div>
            <div class="col-md-3 mb-3">
              <label class="form-label">Bill Number <span class="text-danger">*</span></label>
              <input type="text" name="bill_no" class="form-control required-input" value="INV-<%rand(1000,9999)%>">
            </div>
            <div class="col-md-3 mb-3">
              <label class="form-label">Sales Date <span class="text-danger">*</span></label>
              <input type="date" name="sales_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
            <div class="col-md-3 mb-3">
              <label class="form-label">Payment Mode</label>
              <select name="payment_mode" class="form-control select2">
                <option value="Cash">Cash</option>
                <option value="UPI">UPI</option>
                <option value="Card">Card</option>
                <option value="Net Banking">Net Banking</option>
              </select>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center border-bottom">
          <h5 class="mb-0">Ordered Items</h5>
          <button type="button" class="btn btn-primary btn-sm" id="addSaleRow">
            <i class="ti ti-plus"></i> Add Item
          </button>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="salesTable">
              <thead>
                <tr>
                  <th style="width: 40%;">Product <span class="text-danger">*</span></th>
                  <th>Stock Available</th>
                  <th>Quantity <span class="text-danger">*</span></th>
                  <th>Sale Price <span class="text-danger">*</span></th>
                  <th>Total</th>
                  <th style="width: 50px;">Action</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <select name="product_id[]" class="form-control select2 product-select required-input">
                      <option value="">Choose Product</option>
                      <%foreach from=$products item=p%>
                        <option value="<%$p['product_id']%>" data-price="<%$p['sale_price']%>" data-stock="<%$p['qty']%>"><%$p['name']%> (<%$p['product_code']%>)</option>
                      <%/foreach%>
                    </select>
                  </td>
                  <td>
                    <input type="text" class="form-control stock-display" readonly value="0">
                  </td>
                  <td>
                    <input type="number" name="qty[]" class="form-control qty-input required-input" min="1" value="1">
                  </td>
                  <td>
                    <input type="number" name="price[]" class="form-control price-input required-input" step="0.01" value="0">
                  </td>
                  <td>
                    <input type="number" name="total[]" class="form-control total-input" readonly value="0">
                  </td>
                  <td>
                    <button type="button" class="btn btn-label-danger btn-icon remove-sale-row"><i class="ti ti-trash"></i></button>
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="4" class="text-end">Grand Total:</th>
                  <th>
                    <input type="number" name="grand_total" id="grand_total" class="form-control" readonly value="0">
                  </th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="mt-4 text-end">
            <button type="submit" class="btn btn-success btn-lg">Generate Sales Bill</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>

<script type="text/html" id="saleRowTemplate">
  <tr>
    <td>
      <select name="product_id[]" class="form-control select2 product-select required-input">
        <option value="">Choose Product</option>
        <%foreach from=$products item=p%>
          <option value="<%$p['product_id']%>" data-price="<%$p['sale_price']%>" data-stock="<%$p['qty']%>"><%$p['name']%> (<%$p['product_code']%>)</option>
        <%/foreach%>
      </select>
    </td>
    <td>
       <input type="text" class="form-control stock-display" readonly value="0">
    </td>
    <td>
      <input type="number" name="qty[]" class="form-control qty-input required-input" min="1" value="1">
    </td>
    <td>
      <input type="number" name="price[]" class="form-control price-input required-input" step="0.01" value="0">
    </td>
    <td>
      <input type="number" name="total[]" class="form-control total-input" readonly value="0">
    </td>
    <td>
      <button type="button" class="btn btn-label-danger btn-icon remove-sale-row"><i class="ti ti-trash"></i></button>
    </td>
  </tr>
</script>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales.js"></script>
