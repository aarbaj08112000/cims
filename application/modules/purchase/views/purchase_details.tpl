<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="<%base_url('purchase_list')%>" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Purchase History</em></a>
            <i class="ti ti-chevrons-right" ></i>
            <em >Detail</em>
          </h1>
          <br>
          <span >Purchase Bill: <%$purchase['bill_no']%></span>
        </div>
      </nav>

    <div class="row">
        <!-- Supplier & Bill Info -->
        <div class="col-md-12 mb-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Transaction Information</h5>
                    <span class="badge <%if $purchase['status'] == 'Completed' %>bg-label-success<%else%>bg-label-warning<%/if %>"><%$purchase['status']%></span>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 border-end">
                            <h6 class="text-muted mb-2">Supplier Details</h6>
                            <p class="mb-1"><strong><%$purchase['supplier_name']%></strong></p>
                            <p class="mb-1 text-muted small"><i class="ti ti-phone me-1"></i><%$purchase['phone']|default:'N/A'%></p>
                            <p class="mb-1 text-muted small"><i class="ti ti-mail me-1"></i><%$purchase['email']|default:'N/A'%></p>
                            <p class="mb-1 text-muted small"><i class="ti ti-map-pin me-1"></i><%$purchase['address']|default:'N/A'%></p>
                            <%if $purchase['gst_number']%>
                                <p class="mb-0 text-muted small"><i class="ti ti-id me-1"></i>GST: <%$purchase['gst_number']%></p>
                            <%/if%>
                        </div>
                        <div class="col-md-6 ps-md-4">
                            <h6 class="text-muted mb-2">Bill Summary</h6>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Bill Number:</span>
                                <span class="fw-bold"><%$purchase['bill_no']%></span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Purchase Date:</span>
                                <span><%$purchase['purchase_date']|date_format:'%d-%m-%Y'%></span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Added On:</span>
                                <span class="text-muted small"><%$purchase['added_date']|date_format:'%d-%m-%Y %H:%M'%></span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span class="h6 mb-0">Total Amount:</span>
                                <span class="h6 mb-0 text-primary">₹<%$purchase['total_amount']|number_format:2%></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Items Table -->
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Itemized Breakdown</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Product Name</th>
                                    <th>Product Code</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-end">Unit Price</th>
                                    <th class="text-end">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%assign var='idx' value=1%>
                                <%foreach from=$items item=item%>
                                    <tr>
                                        <td><%$idx++%></td>
                                        <td><strong><%$item['product_name']%></strong></td>
                                        <td><span class="badge bg-label-secondary"><%$item['product_code']%></span></td>
                                        <td class="text-center"><%$item['qty']%></td>
                                        <td class="text-end">₹<%$item['purchase_price']|number_format:2%></td>
                                        <td class="text-end fw-bold">₹<%$item['total_amount']|number_format:2%></td>
                                    </tr>
                                <%/foreach%>
                            </tbody>
                            <tfoot class="table-light">
                                <tr>
                                    <th colspan="5" class="text-end h6 mb-0">Grand Total:</th>
                                    <th class="text-end h6 mb-0 text-primary">₹<%$purchase['total_amount']|number_format:2%></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="card-footer border-top text-end">
                    <button class="btn btn-label-secondary me-2" onclick="window.print()"><i class="ti ti-printer me-1"></i> Print Bill</button>
                    <a href="<%base_url('purchase_list')%>" class="btn btn-outline-secondary">Back to List</a>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
