<div class="modal-header border-bottom pb-3">
    <h5 class="modal-title fw-bold d-flex align-items-center text-dark">
        <i class="ti ti-receipt fs-4 me-2 text-primary"></i> 
        Purchase Bill: <span class="text-primary ms-1"><%$purchase['bill_no']%></span>
    </h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body bg-light-subtle pt-4">
    <div class="row mb-4 g-3">
        <!-- Supplier Info Card -->
        <div class="col-md-6">
            <div class="p-3 bg-white border rounded shadow-sm h-100">
                <h6 class="text-uppercase text-muted fw-bold mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">
                    <i class="ti ti-truck text-primary me-1"></i> Supplier Info
                </h6>
                <h6 class="mb-2 fw-bold text-dark"><%$purchase['supplier_name']%></h6>
                <div class="d-flex align-items-center mb-1 text-muted small">
                    <i class="ti ti-phone me-2"></i> <%$purchase['phone']|default:'N/A'%>
                </div>
                <div class="d-flex align-items-start mb-1 text-muted small">
                    <i class="ti ti-map-pin me-2 mt-1"></i> <span><%$purchase['address']|default:'N/A'%></span>
                </div>
                <%if $purchase['gst_number']%>
                <div class="d-flex align-items-center mt-2 pt-2 border-top text-muted small">
                    <i class="ti ti-file-invoice me-2"></i> GST: <span class="fw-medium text-dark ms-1"><%$purchase['gst_number']%></span>
                </div>
                <%/if%>
            </div>
        </div>

        <!-- Bill Summary Card -->
        <div class="col-md-6">
            <div class="p-3 bg-white border rounded shadow-sm h-100">
                <h6 class="text-uppercase text-muted fw-bold mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">
                    <i class="ti ti-file-analytics text-primary me-1"></i> Bill Summary
                </h6>
                <div class="d-flex justify-content-between mb-2">
                    <span class="text-muted small">Date:</span>
                    <span class="fw-medium text-dark"><%$purchase['purchase_date']|date_format:'%d-%m-%Y'%></span>
                </div>
                <div class="d-flex justify-content-between mb-2 align-items-center">
                    <span class="text-muted small">Status:</span>
                    <%if $purchase['status'] == 'Completed' %>
                      <span class="cat-badge cat-badge-active" style="padding: 3px 8px; font-size: 0.7rem;">Completed</span>
                    <%elseif $purchase['status'] == 'Pending' %>
                      <span class="cat-badge cat-badge-low" style="padding: 3px 8px; font-size: 0.7rem;">Pending</span>
                    <%else %>
                      <span class="cat-badge cat-badge-inactive" style="padding: 3px 8px; font-size: 0.7rem;"><%$purchase['status']%></span>
                    <%/if %>
                </div>
                <div class="d-flex justify-content-between mt-3 pt-3 border-top align-items-center">
                    <span class="fw-bold text-dark">Total Amount:</span>
                    <span class="h5 mb-0 fw-bold text-success">₹<%$purchase['total_amount']|number_format:2%></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Items Table -->
    <div class="card shadow-sm border-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="bg-light">
                    <tr>
                        <th class="text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Product</th>
                        <th class="text-center text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Qty</th>
                        <th class="text-end text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Price</th>
                        <th class="text-end text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%foreach from=$items item=item%>
                        <tr>
                            <td>
                                <div class="d-flex flex-column">
                                    <span class="fw-bold text-dark"><%$item['product_name']%></span>
                                    <small class="text-muted"><%$item['product_code']%></small>
                                </div>
                            </td>
                            <td class="text-center align-middle"><span class="badge bg-label-secondary px-2"><%$item['qty']%></span></td>
                            <td class="text-end align-middle">₹<%$item['purchase_price']|number_format:2%></td>
                            <td class="text-end align-middle fw-medium">₹<%$item['total_amount']|number_format:2%></td>
                        </tr>
                    <%/foreach%>
                </tbody>
                <tfoot>
                    <tr class="bg-light">
                        <th colspan="3" class="text-end fw-bold align-middle">Grand Total:</th>
                        <th class="text-end h6 mb-0 fw-bold text-primary">₹<%$purchase['total_amount']|number_format:2%></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<div class="modal-footer border-top bg-light pt-3 pb-3">
    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Close</button>
    <a href="<%base_url('purchase_details/')%><%$purchase['purchase_id']%>" class="cat-btn cat-btn-primary px-4 text-white">
        <i class="ti ti-printer me-2"></i> Full View / Print
    </a>
</div>
