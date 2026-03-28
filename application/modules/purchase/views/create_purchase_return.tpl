<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="<%base_url('purchase_return_list')%>" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Purchase Return</em></a>
          </h1>
          <br>
          <span >Initiate Purchase Return</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <a href="<%base_url('purchase_return_list')%>" class="btn btn-seconday" title="Return List">
           <i class="ti ti-list"></i> Return List
        </a>
      </div>

    <form id="purchaseReturnForm" action="<%base_url('save_purchase_return')%>" method="POST">
      <div class="card mb-4">
        <div class="card-body">
          <div class="row">
            <div class="col-md-4 mb-3">
              <label class="form-label">Original Purchase Bill <span class="text-danger">*</span></label>
              <select name="purchase_id" id="purchase_id" class="form-control select2 required-input">
                <option value="">Select Bill No</option>
                <%foreach from=$purchases item=val%>
                    <option value="<%$val['purchase_id']%>"><%$val['bill_no']%> (<%$val['supplier_name']%>)</option>
                <%/foreach%>
              </select>
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Return Number <span class="text-danger">*</span></label>
              <input type="text" name="return_no" class="form-control required-input" value="RET-<%rand(1000,9999)%>" readonly>
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Return Date <span class="text-danger">*</span></label>
              <input type="date" name="return_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
            <div class="col-md-12 mb-3">
                <label class="form-label">Reason for Return</label>
                <textarea name="remarks" class="form-control" rows="2" placeholder="Enter reason..."></textarea>
            </div>
          </div>
        </div>
      </div>

      <div class="card" id="returnItemsCard" style="display:none;">
        <div class="card-header border-bottom">
          <h5 class="mb-0">Returnable Items</h5>
          <small class="text-muted">Enter quantity to return for each item.</small>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="returnTable">
              <thead>
                <tr>
                  <th style="width: 40%;">Product</th>
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
                  <th colspan="5" class="text-end">Grand Total Return Amount:</th>
                  <th>
                    <input type="number" name="grand_total" id="grand_total" class="form-control" readonly value="0">
                  </th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="mt-4 text-end">
            <button type="submit" class="btn btn-danger btn-lg">Submit Return Transaction</button>
          </div>
        </div>
      </div>

      <div id="noItemsMsg" class="alert alert-warning text-center" style="display:none;">
          No returnable items found for this bill or it might be fully returned.
      </div>
    </form>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/purchase_return.js"></script>
