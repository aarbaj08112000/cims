<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Purchase</em></a>
          </h1>
          <br>
          <span >Create Purchase Bill</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-4">
        <a href="<%base_url('purchase_list')%>" class="btn btn-seconday" title="Purchase List">
           <i class="ti ti-list"></i> Purchase List
        </a>
      </div>

    <form id="purchaseForm" action="<%base_url('save_purchase')%>" method="POST">
      <div class="card mb-4">
        <div class="card-body">
          <div class="row">
            <div class="col-md-4 mb-3">
              <label class="form-label">Supplier <span class="text-danger">*</span></label>
              <select name="supplier_id" class="form-control select2 required-input">
                <option value="">Select Supplier</option>
                <%foreach from=$suppliers item=val%>
                    <option value="<%$val['supplier_id']%>"><%$val['supplier_name']%></option>
                <%/foreach%>
              </select>
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Bill Number <span class="text-danger">*</span></label>
              <input type="text" name="bill_no" class="form-control required-input" placeholder="Enter Bill No">
            </div>
            <div class="col-md-4 mb-3">
              <label class="form-label">Purchase Date <span class="text-danger">*</span></label>
              <input type="date" name="purchase_date" class="form-control required-input" value="<%$smarty.now|date_format:'%Y-%m-%d'%>">
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h5 class="mb-0">Purchase Items</h5>
          <button type="button" class="btn btn-primary btn-sm" id="addRow">
            <i class="ti ti-plus"></i> Add Row
          </button>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-bordered" id="purchaseTable">
              <thead>
                <tr>
                  <th style="width: 40%;">Product <span class="text-danger">*</span></th>
                  <th>Quantity <span class="text-danger">*</span></th>
                  <th>Purchase Price <span class="text-danger">*</span></th>
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
                  <td>
                    <button type="button" class="btn btn-label-danger btn-icon remove-row"><i class="ti ti-trash"></i></button>
                  </td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="3" class="text-end">Grand Total:</th>
                  <th>
                    <input type="number" name="grand_total" id="grand_total" class="form-control" readonly value="0">
                  </th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="mt-4 text-end">
            <button type="submit" class="btn btn-success btn-lg">Save Purchase Bill</button>
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
    <td>
      <button type="button" class="btn btn-label-danger btn-icon remove-row"><i class="ti ti-trash"></i></button>
    </td>
  </tr>
</script>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/purchase.js"></script>
