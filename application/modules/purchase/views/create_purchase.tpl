<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
.form-label {
    font-weight: 600;
    color: #4b4b5a;
    margin-bottom: 8px;
    font-size: 0.9rem;
}
.form-control {
    border-radius: 8px;
    border: 1px solid #e1e5eb;
    padding: 0.65rem 1rem;
    transition: all 0.2s;
}
.form-control:focus {
    border-color: #7239ea;
    box-shadow: 0 0 0 0.25rem rgba(114, 57, 234, 0.1);
}
.form-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.04);
    border: none;
    overflow: hidden;
    margin-bottom: 1.5rem;
}
.form-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    border-bottom: 1px solid #f1f1f4;
    padding: 1.5rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.form-body {
    padding: 2rem;
}
.table-purchase {
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #e4e6ef;
}
.table-purchase thead th {
    background-color: #f8f9fa;
    color: #5e6278;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.8rem;
    letter-spacing: 0.5px;
    padding: 1rem;
    border-bottom: 1px solid #e4e6ef;
}
.table-purchase tbody td {
    vertical-align: middle;
    padding: 1rem;
    border-bottom: 1px solid #e4e6ef;
}
.table-purchase tfoot th {
    background-color: #f8f9fa;
    padding: 1rem;
    font-weight: 700;
    font-size: 1.1rem;
    color: #3f4254;
}
.total-input {
    background-color: #f5f8fa;
    font-weight: 600;
    color: #7239ea;
    border-color: #e4e6ef;
}
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
</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-shopping-cart-plus"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Create Purchase Bill</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>purchase_list">Purchase</a>
            <i class="ti ti-chevron-right"></i>
            <span>Create</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%base_url('purchase_list')%>" class="cat-btn cat-btn-outline" title="Purchase List">
           <i class="ti ti-list"></i> Purchase List
        </a>
      </div>
    </div>

    <form id="purchaseForm" action="<%base_url('save_purchase')%>" method="POST">
      <!-- Top Section: Bill Info -->
      <div class="form-card">
        <div class="form-header">
          <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-receipt fs-3 me-2 text-primary"></i> Bill Information</h5>
        </div>
        <div class="form-body">
          <div class="row g-4">
            <div class="col-md-4">
              <label class="form-label">Supplier <span class="text-danger">*</span></label>
              <select name="supplier_id" class="form-control select2 required-input">
                <option value="">Select Supplier</option>
                <%foreach from=$suppliers item=val%>
                    <option value="<%$val['supplier_id']%>"><%$val['supplier_name']%></option>
                <%/foreach%>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Bill Number <span class="text-danger">*</span></label>
              <input type="text" name="bill_no" class="form-control required-input" placeholder="Enter Bill No">
            </div>
            <div class="col-md-4">
              <label class="form-label">Purchase Date <span class="text-danger">*</span></label>
              <input type="date" name="purchase_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
          </div>
        </div>
      </div>

      <!-- Bottom Section: Items -->
      <div class="form-card">
        <div class="form-header">
          <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-box fs-3 me-2 text-primary"></i> Purchase Items</h5>
          <button type="button" class="cat-btn cat-btn-primary" id="addRow">
            <i class="ti ti-plus"></i> Add Row
          </button>
        </div>
        <div class="form-body">
          <div class="table-responsive">
            <table class="table w-100 table-purchase" id="purchaseTable">
              <thead>
                <tr>
                  <th style="width: 40%;">Product <span class="text-danger">*</span></th>
                  <th>Quantity <span class="text-danger">*</span></th>
                  <th>Purchase Price <span class="text-danger">*</span></th>
                  <th>Total</th>
                  <th style="width: 80px;" class="text-center">Action</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <select name="product_id[]" class="form-control select2 product-select required-input">
                      <option value="">Choose Product</option>
                      <%foreach from=$products item=p%>
                        <option value="<%$p['product_id']%>" data-price="<%$p['purchase_price']%>"><%$p['name']%> (<%$p['product_code']%>)</option>
                      <%/foreach%>
                    </select>
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
                  <td class="text-center">
                    <button type="button" class="btn-icon-danger remove-row" title="Remove"><i class="ti ti-trash"></i></button>
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="3" class="text-end align-middle">Grand Total:</th>
                  <th>
                    <input type="number" name="grand_total" id="grand_total" class="form-control fs-5" readonly value="0">
                  </th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="mt-5 text-end">
            <button type="submit" class="cat-btn cat-btn-primary px-5 py-3 fs-6"><i class="ti ti-device-floppy me-2"></i> Save Purchase Bill</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- Template for new row -->
<script type="text/html" id="rowTemplate">
  <tr>
    <td>
      <select name="product_id[]" class="form-control select2 product-select required-input">
        <option value="">Choose Product</option>
        <%foreach from=$products item=p%>
          <option value="<%$p['product_id']%>" data-price="<%$p['purchase_price']%>"><%$p['name']%> (<%$p['product_code']%>)</option>
        <%/foreach%>
      </select>
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
    <td class="text-center">
      <button type="button" class="btn-icon-danger remove-row" title="Remove"><i class="ti ti-trash"></i></button>
    </td>
  </tr>
</script>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/purchase.js"></script>
