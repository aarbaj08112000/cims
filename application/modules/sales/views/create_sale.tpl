<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
.btn-icon-danger {
    color: #ff3e1d;
    background-color: rgba(255, 62, 29, 0.1);
    border: none;
    width: 35px;
    height: 35px;
    border-radius: 8px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
}
.btn-icon-danger:hover {
    background-color: #ff3e1d;
    color: #fff;
}
.btn-icon-danger:hover .ti-trash {
    background-color: #ff3e1d;
    color: #fff;
}
</style>
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left d-flex align-items-center">
        <div class="cat-page-icon me-3">
          <i class="ti ti-shopping-cart fs-3 text-primary"></i>
        </div>
        <div>
          <h1 class="cat-page-title mb-1">Create Sales Bill</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <a href="<%$base_url%>sales_list">Sales History</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <span>Create</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right d-flex align-items-center">
        <a href="<%$base_url%>sales_list" class="cat-btn cat-btn-outline" title="Sales List">
          <i class="ti ti-list"></i> Sales List
        </a>
      </div>
    </div>

    <form id="salesForm" action="<%$base_url%>save_sale" method="POST">
      <!-- Master Form Card -->
      <div class="cat-card mb-4">
        <div class="cat-card-header d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
          <h5 class="mb-0 fw-bold"><i class="ti ti-file-info me-2 text-primary fs-4"></i> Sales Details</h5>
        </div>
        <div class="cat-card-body">
          <div class="row g-3">
            <div class="col-md-3">
              <label class="form-label">Customer Mobile Number <span class="text-danger">*</span></label>
              <input type="text" name="customer_mobile" class="form-control required-input" placeholder="Enter Mobile No" maxlength="15">
            </div>
            <div class="col-md-3">
              <label class="form-label">Bill Number <span class="text-danger">*</span></label>
              <input type="text" name="bill_no" class="form-control required-input" value="INV-<%rand(1000,9999)%>">
            </div>
            <div class="col-md-3">
              <label class="form-label">Sales Date <span class="text-danger">*</span></label>
              <input type="date" name="sales_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
            <div class="col-md-3">
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

      <!-- Items Table Card -->
      <div class="cat-table-card mb-4">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center bg-light">
            <h5 class="mb-0 fw-bold"><i class="ti ti-packages me-2 text-primary fs-4"></i> Ordered Items</h5>
            <button type="button" class="cat-btn cat-btn-primary btn-sm" id="addSaleRow">
              <i class="ti ti-plus"></i> Add Item
            </button>
          </div>
          <div class="table-responsive">
            <table class="table table-hover mb-0" id="salesTable">
              <thead class="bg-light">
                <tr>
                  <th style="width: 35%;">Product <span class="text-danger">*</span></th>
                  <th style="width: 15%;">Stock Available</th>
                  <th style="width: 15%;">Quantity <span class="text-danger">*</span></th>
                  <th style="width: 15%;">Sale Price <span class="text-danger">*</span></th>
                  <th style="width: 15%;">Total</th>
                  <th style="width: 50px;" class="text-center">Action</th>
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
                    <input type="text" class="form-control stock-display bg-light text-center" readonly value="0">
                  </td>
                  <td>
                    <input type="number" name="qty[]" class="form-control qty-input required-input text-center" min="1" value="1">
                  </td>
                  <td>
                    <input type="number" name="price[]" class="form-control price-input required-input text-end" step="0.01" value="0">
                  </td>
                  <td>
                    <input type="number" name="total[]" class="form-control total-input bg-light text-end fw-bold" readonly value="0">
                  </td>
                  <td class="text-center">
                    <button type="button" class="btn-icon-danger remove-sale-row" title="Remove"><i class="ti ti-trash"></i></button>
                  </td>
                </tr>
              </tbody>
              <tfoot class="bg-light border-top">
                <tr>
                  <th colspan="4" class="text-end h5 fw-bold pt-3 pb-3">Grand Total:</th>
                  <th class="pt-3 pb-3">
                    <input type="number" name="grand_total" id="grand_total" class="form-control bg-white text-end text-primary h5 fw-bold mb-0 border-0 shadow-none" readonly value="0">
                  </th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="card-footer text-end mt-3 pb-4">
            <button type="submit" class="cat-btn cat-btn-primary" style="height: 44px; padding: 0 24px; font-size: 15px;">
              <i class="ti ti-check me-2"></i> Generate Sales Bill
            </button>
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
       <input type="text" class="form-control stock-display bg-light text-center" readonly value="0">
    </td>
    <td>
      <input type="number" name="qty[]" class="form-control qty-input required-input text-center" min="1" value="1">
    </td>
    <td>
      <input type="number" name="price[]" class="form-control price-input required-input text-end" step="0.01" value="0">
    </td>
    <td>
      <input type="number" name="total[]" class="form-control total-input bg-light text-end fw-bold" readonly value="0">
    </td>
    <td class="text-center">
      <button type="button" class="btn-icon-danger  remove-sale-row" title="Remove"><i class="ti ti-trash"></i></button>
    </td>
  </tr>
</script>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales.js"></script>
