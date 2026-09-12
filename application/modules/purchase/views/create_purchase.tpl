<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
/* Purchase form - matching create_purchase_return style */
.sale-info-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 12.5px;
    font-weight: 500;
    background: var(--cat-primary-light);
    color: var(--cat-primary);
}
.sale-info-badge i { font-size: 14px; }

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

/* Grand total box */
.grand-total-box {
    background: linear-gradient(135deg, var(--cat-primary) 0%, var(--cat-primary-hover) 100%);
    color: #fff;
    border-radius: var(--cat-radius);
    padding: 16px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 4px;
}
.grand-total-box .total-label {
    font-size: 14px;
    font-weight: 500;
    opacity: 0.9;
}
.grand-total-box .total-value {
    font-size: 24px;
    font-weight: 700;
    letter-spacing: -0.5px;
}
</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left d-flex align-items-center">
        <div class="cat-page-icon me-3">
          <i class="ti ti-shopping-cart-plus fs-3 text-primary"></i>
        </div>
        <div>
          <h1 class="cat-page-title mb-1">Create Purchase Bill</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <a href="<%$base_url%>purchase_list">Purchase</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <span>Create</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right d-flex align-items-center">
        <a href="<%base_url('purchase_list')%>" class="cat-btn cat-btn-outline" title="Purchase List">
          <i class="ti ti-list"></i> Purchase List
        </a>
      </div>
    </div>

    <form id="purchaseForm" action="<%base_url('save_purchase')%>" method="POST">
      <!-- Bill Information Card -->
      <div class="cat-card mb-4 card p-4">
        <div class="cat-card-header d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
          <h5 class="mb-0 fw-bold"><i class="ti ti-file-info me-2 text-primary fs-4"></i> Bill Information</h5>
          <span class="sale-info-badge"><i class="ti ti-shopping-cart-plus"></i> New Purchase</span>
        </div>
        <div class="cat-card-body">
          <div class="row g-3">
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

      <!-- Purchase Items Card -->
      <div class="cat-table-card mb-4">
        <div class="card shadow-sm">
          <div class="card-header d-flex justify-content-between align-items-center bg-light">
            <h5 class="mb-0 fw-bold"><i class="ti ti-packages me-2 text-primary fs-4"></i> Purchase Items</h5>
            <button type="button" class="cat-btn cat-btn-primary btn-sm" id="addRow">
              <i class="ti ti-plus"></i> Add Row
            </button>
          </div>
          <div class="table-responsive">
            <table class="table table-hover mb-0" id="purchaseTable">
              <thead class="bg-light">
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
                    <input type="number" name="total[]" class="form-control bg-light text-end fw-bold total-input" readonly value="0">
                  </td>
                  <td class="text-center">
                    <button type="button" class="btn-icon-danger remove-row" title="Remove"><i class="ti ti-trash"></i></button>
                  </td>
                </tr>
              </tbody>
            </table>
            <!-- Hidden input for form submission -->
            <input type="hidden" name="grand_total" id="grand_total" value="0">
          </div>

          <!-- Summary Panel -->
          <div class="px-4 pb-3 pt-2">
            <div class="d-flex justify-content-end">
              <div style="min-width: 300px;">
                <div class="grand-total-box mt-2">
                  <div class="total-label">
                    <i class="ti ti-calculator me-2"></i> Grand Total
                  </div>
                  <div class="total-value" id="grand_total_display">0.00</div>
                </div>
              </div>
            </div>
          </div>

          <!-- Submit Button -->
          <div class="card-footer text-end mt-0 pb-4 border-0">
            <button type="submit" class="cat-btn cat-btn-primary" style="height: 44px; padding: 0 24px; font-size: 15px;">
              <i class="ti ti-device-floppy me-2"></i> Save Purchase Bill
            </button>
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
      <input type="number" name="total[]" class="form-control bg-light text-end fw-bold total-input" readonly value="0">
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
