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

/* Mobile Responsive Table Card Layout */
@media (max-width: 768px) {
    /* Disable horizontal scroll wrapper since we stack */
    .table-responsive {
        overflow-x: visible !important;
    }
    .table-responsive.text-nowrap {
        white-space: normal !important;
    }
    
    #salesTable {
        border: 0;
        width: 100% !important;
    }
    #salesTable thead {
        display: none;
    }
    #salesTable tbody tr {
        display: flex;
        flex-direction: column;
        gap: 16px;
        border: 1px solid var(--cat-border);
        border-radius: var(--cat-radius);
        margin-bottom: 20px;
        background: var(--cat-white);
        padding: 20px;
        box-shadow: 0 4px 15px rgba(91, 95, 199, 0.08);
    }
    #salesTable tbody td {
        display: flex;
        flex-direction: column;
        border: none !important;
        padding: 0 !important;
        text-align: left !important;
    }
    #salesTable tbody td::before {
        content: attr(data-label);
        font-weight: 600;
        font-size: 11.5px;
        color: var(--cat-gray-500);
        margin-bottom: 6px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    /* Target inputs AND Select2 generated spans */
    #salesTable tbody td > .select2-container,
    #salesTable tbody td > input {
        width: 100% !important;
        max-width: 100% !important;
        margin: 0;
        text-align: left !important;
        background: var(--cat-gray-50) !important;
        border: 1px solid var(--cat-gray-200) !important;
        border-radius: 6px;
    }
    
    #salesTable tbody td > .select2-container .select2-selection {
        background: var(--cat-gray-50) !important;
        border: none !important;
    }

    #salesTable tbody td[data-label="Action"] {
        margin-top: 5px;
    }
    #salesTable tbody td > .btn-icon-danger {
        width: 100%;
        margin: 0;
        height: 44px;
        border-radius: 8px;
        background: var(--cat-danger-light);
    }
    #salesTable tbody td > .btn-icon-danger::after {
        content: "Remove Item";
        margin-left: 8px;
        font-weight: 600;
        font-size: 14px;
    }
    
    /* Footer layout for mobile */
    #salesTable tfoot {
        display: block;
    }
    #salesTable tfoot tr {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        border: 1px solid var(--cat-border);
        padding: 16px;
        margin-bottom: 12px;
        background: var(--cat-white);
        border-radius: var(--cat-radius);
        box-shadow: 0 2px 8px rgba(0,0,0,0.03);
        gap: 8px;
    }
    #salesTable tfoot th {
        display: block;
        padding: 0 !important;
        border: none !important;
        width: 100% !important;
        text-align: left !important;
        background: transparent !important;
    }
    #salesTable tfoot th[colspan="4"] {
        font-size: 12px;
        color: var(--cat-gray-500);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        background: transparent !important;
    }
    #salesTable tfoot th:nth-child(2) {
        max-width: 100%;
        background: transparent !important;
    }
    #salesTable tfoot th.mobile-hide {
        display: none !important;
    }
    #salesTable tfoot input {
        width: 100% !important;
        text-align: left !important;
        background: var(--cat-gray-50) !important;
        border: 1px solid var(--cat-border) !important;
        padding: 10px 14px;
        border-radius: 6px;
        font-size: 16px;
    }
    #salesTable tfoot tr:last-child input#grand_total {
        color: var(--cat-primary) !important;
        background: var(--cat-primary-light) !important;
        border-color: var(--cat-primary) !important;
        font-size: 18px;
    }
}
</style>
<style>
/* Sales form badge and stat chips - matching create_sales_return style */
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

/* Empty state for table */
.empty-state-row td {
    padding: 40px 16px !important;
}
.empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
}
.empty-state-icon {
    width: 56px;
    height: 56px;
    border-radius: 50%;
    background: var(--cat-gray-100);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: var(--cat-gray-300);
}
.empty-state-text {
    font-size: 14px;
    color: var(--cat-gray-500);
    font-weight: 500;
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
      <div class="cat-card mb-4 card p-4">
        <div class="cat-card-header d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
          <h5 class="mb-0 fw-bold"><i class="ti ti-file-info me-2 text-primary fs-4"></i> Sales Details</h5>
          <span class="sale-info-badge"><i class="ti ti-shopping-cart"></i> New Sale</span>
        </div>
        <div class="cat-card-body">
          <div class="row g-3">
            <div class="col-md-3">
              <label class="form-label">Customer Mobile Number <span class="text-danger">*</span></label>
              <input type="text" name="customer_mobile" class="form-control required-input" placeholder="Enter Mobile No" maxlength="15">
            </div>
            <div class="col-md-3">
              <label class="form-label">Customer Name <span class="text-danger">*</span></label>
              <input type="text" name="customer_name" id="customer_name" class="form-control required-input" placeholder="Enter Customer Name">
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
        <div class="card shadow-sm">
          <div class="card-header d-flex justify-content-between align-items-center bg-light">
            <h5 class="mb-0 fw-bold"><i class="ti ti-packages me-2 text-primary fs-4"></i> Ordered Items</h5>
            <button type="button" class="cat-btn cat-btn-primary btn-sm" id="addSaleRow">
              <i class="ti ti-plus"></i> Add Item
            </button>
          </div>
          <div class="table-responsive text-nowrap">
            <table class="table table-hover mb-0" id="salesTable">
              <thead class="bg-light">
                <tr>
                  <th style="min-width: 250px;">Product <span class="text-danger">*</span></th>
                  <th style="min-width: 120px;">Stock Available</th>
                  <th style="min-width: 120px;">Quantity <span class="text-danger">*</span></th>
                  <th style="min-width: 150px;">Sale Price <span class="text-danger">*</span></th>
                  <th style="min-width: 150px;">Total</th>
                  <th style="min-width: 80px;" class="text-center">Action</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td data-label="Product">
                    <select name="product_id[]" class="form-control select2 product-select required-input">
                      <option value="">Choose Product</option>
                      <%foreach from=$products item=p%>
                        <option value="<%$p['product_id']%>" data-price="<%$p['price']%>" data-stock="<%$p['qty']%>"><%$p['name']%> (<%$p['product_code']%>)</option>
                      <%/foreach%>
                    </select>
                  </td>
                  <td data-label="Stock">
                    <input type="text" class="form-control stock-display bg-light text-center" readonly value="0">
                  </td>
                  <td data-label="Quantity">
                    <input type="number" name="qty[]" class="form-control qty-input required-input text-center" min="1" value="">
                  </td>
                  <td data-label="Sale Price">
                    <input type="number" name="price[]" class="form-control price-input required-input text-end bg-light" step="0.01" value="0" readonly>
                  </td>
                  <td data-label="Total">
                    <input type="number" name="total[]" class="form-control total-input bg-light text-end fw-bold" readonly value="0">
                  </td>
                  <td data-label="Action" class="text-center">
                    <button type="button" class="btn-icon-danger remove-sale-row" title="Remove"><i class="ti ti-trash"></i></button>
                  </td>
                </tr>
              </tbody>
            </table>
            <!-- Hidden inputs for form submission -->
            <input type="hidden" name="sub_total" id="sub_total" value="0">
            <input type="hidden" name="grand_total" id="grand_total" value="0">
          </div>

          <!-- Summary Panel -->
          <div class="px-4 pb-3 pt-2">
            <div class="d-flex justify-content-end">
              <div style="min-width: 340px;">
                <!-- Subtotal row -->
                <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                  <span class="text-muted fw-500" style="font-size:14px;">Subtotal</span>
                  <span class="fw-bold" id="sub_total_display" style="font-size:15px;">0.00</span>
                </div>
                <!-- Discount row -->
                <div class="d-flex justify-content-between align-items-center py-2 border-bottom gap-3">
                  <span class="text-muted fw-500" style="font-size:14px; white-space:nowrap;">Discount Amount</span>
                  <input type="number" name="discount" id="discount"
                         class="form-control text-end"
                         style="max-width:150px; font-size:14px;"
                         step="0.01" min="0" value="0">
                </div>
                <!-- Grand Total gradient box -->
                <div class="grand-total-box mt-2">
                  <div class="total-label">
                    <i class="ti ti-calculator me-2"></i> Grand Total
                  </div>
                  <div class="total-value" id="grand_total_display">0.00</div>
                </div>
              </div>
            </div>
          </div>
          <div class="card-footer text-end mt-0 pb-4 border-0">
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
    <td data-label="Product">
      <select name="product_id[]" class="form-control select2 product-select required-input">
        <option value="">Choose Product</option>
        <%foreach from=$products item=p%>
          <option value="<%$p['product_id']%>" data-price="<%$p['price']%>" data-stock="<%$p['qty']%>"><%$p['name']%> (<%$p['product_code']%>)</option>
        <%/foreach%>
      </select>
    </td>
    <td data-label="Stock">
       <input type="text" class="form-control stock-display bg-light text-center" readonly value="0">
    </td>
    <td data-label="Quantity">
      <input type="number" name="qty[]" class="form-control qty-input required-input text-center" min="1" value="0">
    </td>
    <td data-label="Sale Price">
      <input type="number" name="price[]" class="form-control price-input required-input text-end bg-light" step="0.01" value="0" readonly>
    </td>
    <td data-label="Total">
      <input type="number" name="total[]" class="form-control total-input bg-light text-end fw-bold" readonly value="0">
    </td>
    <td data-label="Action" class="text-center">
      <button type="button" class="btn-icon-danger  remove-sale-row" title="Remove"><i class="ti ti-trash"></i></button>
    </td>
  </tr>
</script>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales.js"></script>
