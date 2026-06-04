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
</style>

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-receipt-refund"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Initiate Purchase Return</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>purchase_return_list">Purchase Return</a>
            <i class="ti ti-chevron-right"></i>
            <span>Initiate</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%base_url('purchase_return_list')%>" class="cat-btn cat-btn-outline" title="Return List">
           <i class="ti ti-list"></i> Return List
        </a>
      </div>
    </div>

    <form id="purchaseReturnForm" action="<%base_url('save_purchase_return')%>" method="POST">
      <!-- Top Section: Bill Info -->
      <div class="form-card">
        <div class="form-header">
          <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-receipt fs-3 me-2 text-primary"></i> Return Information</h5>
        </div>
        <div class="form-body">
          <div class="row g-4">
            <div class="col-md-4">
              <label class="form-label">Original Purchase Bill <span class="text-danger">*</span></label>
              <select name="purchase_id" id="purchase_id" class="form-control select2 required-input">
                <option value="">Select Bill No</option>
                <%foreach from=$purchases item=val%>
                    <option value="<%$val['purchase_id']%>"><%$val['bill_no']%> (<%$val['supplier_name']%>)</option>
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
                <textarea name="remarks" class="form-control" rows="2" placeholder="Enter reason..."></textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- Bottom Section: Items -->
      <div class="form-card" id="returnItemsCard" style="display:none;">
        <div class="form-header flex-column align-items-start">
          <h5 class="mb-1 fw-bold d-flex align-items-center text-dark"><i class="ti ti-box fs-3 me-2 text-primary"></i> Returnable Items</h5>
          <small class="text-muted ms-4 ps-2">Enter quantity to return for each item.</small>
        </div>
        <div class="form-body">
          <div class="table-responsive">
            <table class="table w-100 table-purchase" id="returnTable">
              <thead>
                <tr>
                  <th style="width: 30%;">Product</th>
                  <th>Stocked Qty</th>
                  <th>Available to Return</th>
                  <th style="width: 150px;">Return Qty</th>
                  <th>Price</th>
                  <th>Total</th>
                </tr>
              </thead>
              <tbody id="returnItemBody">
                <!-- AJAX items here -->
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="5" class="text-end align-middle">Grand Total Return Amount:</th>
                  <th>
                    <input type="number" name="grand_total" id="grand_total" class="form-control fs-5" readonly value="0">
                  </th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="mt-5 text-end">
            <button type="submit" class="cat-btn cat-btn-primary px-5 py-3 fs-6"><i class="ti ti-check me-2"></i> Submit Return Transaction</button>
          </div>
        </div>
      </div>

      <div id="noItemsMsg" class="alert alert-warning text-center mt-4" style="display:none; border-radius: 12px; padding: 1.5rem;">
          <i class="ti ti-alert-circle fs-2 mb-2"></i><br>
          No returnable items found for this bill or it might be fully returned.
      </div>
    </form>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/purchase_return.js"></script>
