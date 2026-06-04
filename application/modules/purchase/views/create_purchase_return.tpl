<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
/* Purchase Return Specific Styles */
.return-info-badge {
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
.return-info-badge i { font-size: 14px; }

.return-stats-row {
    display: flex;
    gap: 16px;
    margin-bottom: 0;
}
.return-stat-chip {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 10px;
    background: var(--cat-gray-50);
    border: 1px solid var(--cat-border);
    font-size: 13px;
    color: var(--cat-gray-700);
    font-weight: 500;
}
.return-stat-chip i {
    font-size: 16px;
    color: var(--cat-primary);
}
.return-stat-chip .stat-value {
    font-weight: 700;
    color: var(--cat-gray-900);
}

/* Bill info panel that appears after selection */
.bill-info-panel {
    background: linear-gradient(135deg, var(--cat-primary-light) 0%, #f0f0ff 100%);
    border: 1px solid rgba(91, 95, 199, 0.15);
    border-radius: var(--cat-radius);
    padding: 16px 20px;
    margin-top: 16px;
    display: none;
}
.bill-info-panel .info-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    color: var(--cat-gray-700);
}
.bill-info-panel .info-item i {
    color: var(--cat-primary);
    font-size: 16px;
}
.bill-info-panel .info-item strong {
    color: var(--cat-gray-900);
}

/* Grand total styling */
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
.empty-state-sub {
    font-size: 12px;
    color: var(--cat-gray-300);
}
</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left d-flex align-items-center">
        <div class="cat-page-icon me-3">
          <i class="ti ti-receipt-refund fs-3 text-primary"></i>
        </div>
        <div>
          <h1 class="cat-page-title mb-1">Initiate Purchase Return</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <a href="<%$base_url%>purchase_return_list">Purchase Returns</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <span>Initiate</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right d-flex align-items-center">
        <a href="<%$base_url%>purchase_return_list" class="cat-btn cat-btn-outline" title="Return List">
          <i class="ti ti-list"></i> Return List
        </a>
      </div>
    </div>

    <form id="purchaseReturnForm" action="<%$base_url%>save_purchase_return" method="POST">
      <!-- Return Information Card -->
      <div class="cat-card mb-4 card p-4">
        <div class="cat-card-header d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
          <h5 class="mb-0 fw-bold"><i class="ti ti-file-info me-2 text-primary fs-4"></i> Return Information</h5>
          <span class="return-info-badge"><i class="ti ti-refresh"></i> New Return</span>
        </div>
        <div class="cat-card-body">
          <div class="row g-3">
            <div class="col-md-4">
              <label class="form-label">Original Purchase Bill <span class="text-danger">*</span></label>
              <select name="purchase_id" id="purchase_id" class="form-control select2 required-input">
                <option value="">Select Bill No</option>
                <%foreach from=$purchases item=val%>
                  <option value="<%$val['purchase_id']%>"><%$val['bill_no']%> (<%$val['supplier_name']|default:'Walk-in'%>)</option>
                <%/foreach%>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Return Number <span class="text-danger">*</span></label>
              <input type="text" name="return_no" class="form-control required-input bg-light" value="RET-<%rand(1000,9999)%>" readonly>
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

          <!-- Bill Info Panel (shown after bill selection via JS) -->
          <div class="bill-info-panel" id="billInfoPanel">
            <div class="row g-3">
              <div class="col-md-3">
                <div class="info-item">
                  <i class="ti ti-user"></i>
                  <span>Supplier: <strong id="billSupplier">—</strong></span>
                </div>
              </div>
              <div class="col-md-3">
                <div class="info-item">
                  <i class="ti ti-calendar"></i>
                  <span>Date: <strong id="billDate">—</strong></span>
                </div>
              </div>
              <div class="col-md-3">
                <div class="info-item">
                  <i class="ti ti-cash"></i>
                  <span>Bill Amount: <strong id="billAmount">—</strong></span>
                </div>
              </div>
              <div class="col-md-3">
                <div class="info-item">
                  <i class="ti ti-package"></i>
                  <span>Items: <strong id="billItems">—</strong></span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Returnable Items Table Card -->
      <div class="cat-table-card mb-4" id="returnItemsCard">
        <div class="card">
          <div class="card-header d-flex justify-content-between align-items-center bg-light">
            <h5 class="mb-0 fw-bold"><i class="ti ti-packages me-2 text-primary fs-4"></i> Returnable Items</h5>
            <div class="return-stats-row" id="returnStats">
              <span class="return-stat-chip">
                <i class="ti ti-box"></i>
                Total Items: <span class="stat-value" id="totalItemsCount">0</span>
              </span>
              <span class="return-stat-chip">
                <i class="ti ti-arrow-back-up"></i>
                Returning: <span class="stat-value" id="returningCount">0</span>
              </span>
            </div>
          </div>
          <div class="table-responsive">
            <table class="table table-hover mb-0" id="returnItemsTable">
              <thead class="bg-light">
                <tr>
                  <th style="width: 30%;">Product</th>
                  <th style="width: 12%;" class="text-center">Stocked Qty</th>
                  <th style="width: 12%;" class="text-center">Already Returned</th>
                  <th style="width: 12%;" class="text-center">Available</th>
                  <th style="width: 14%;" class="text-center">Return Qty <span class="text-danger">*</span></th>
                  <th style="width: 10%;" class="text-end">Price</th>
                  <th style="width: 10%;" class="text-end">Total</th>
                </tr>
              </thead>
              <tbody id="returnItemBody">
                <tr class="empty-state-row">
                  <td colspan="7">
                    <div class="empty-state">
                      <div class="empty-state-icon"><i class="ti ti-receipt-off"></i></div>
                      <span class="empty-state-text">No items to display</span>
                      <span class="empty-state-sub">Select an original purchase bill above to load returnable items</span>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Grand Total Footer -->
          <div class="card-footer p-3">
            <div class="grand-total-box">
              <div class="total-label">
                <i class="ti ti-calculator me-2"></i> Grand Total Return Amount
              </div>
              <div class="total-value">
                <span id="grand_total_display"><%$settings.company_currency.value|default:'$'%>0.00</span>
                <input type="hidden" name="total_return_amount" id="total_return_amount" value="0">
              </div>
            </div>
          </div>

          <!-- Submit Button -->
          <div class="card-footer text-end mt-0 pb-4 border-0">
            <button type="submit" class="cat-btn cat-btn-primary" style="height: 44px; padding: 0 24px; font-size: 15px;">
              <i class="ti ti-check me-2"></i> Process Return
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
<script src="<%$base_url%>public/js/admin_panel/purchase_return.js"></script>
