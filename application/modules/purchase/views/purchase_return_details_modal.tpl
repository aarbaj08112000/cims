<div class="modal-header border-bottom pb-3">
    <h5 class="modal-title fw-bold d-flex align-items-center text-dark">
        <i class="ti ti-receipt-refund fs-4 me-2 text-danger"></i> 
        Return Details: <span class="text-danger ms-1"><%$return['return_no']%></span>
    </h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body bg-light-subtle pt-4 pb-0">
    <div class="row mb-4 g-3">
        <!-- Supplier & Bill Card -->
        <div class="col-md-6">
            <div class="p-3 bg-white border rounded shadow-sm h-100">
                <h6 class="text-uppercase text-muted fw-bold mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">
                    <i class="ti ti-building-store text-danger me-1"></i> Supplier & Bill
                </h6>
                <h6 class="mb-2 fw-bold text-dark"><%$return['supplier_name']%></h6>
                <div class="d-flex align-items-center mb-1 text-muted small">
                    <i class="ti ti-receipt me-2"></i> Original Bill: <span class="fw-medium text-dark ms-1"><%$return['original_bill_no']%></span>
                </div>
                <div class="d-flex align-items-center mb-1 text-muted small">
                    <i class="ti ti-calendar me-2"></i> Return Date: <span class="fw-medium text-dark ms-1"><%$return['return_date']|date_format:'%d-%m-%Y'%></span>
                </div>
            </div>
        </div>
        <!-- Remarks & Total Card -->
        <div class="col-md-6">
            <div class="p-3 bg-white border rounded shadow-sm h-100 flex-column d-flex">
                <h6 class="text-uppercase text-muted fw-bold mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">
                    <i class="ti ti-notes text-danger me-1"></i> Remarks & Summary
                </h6>
                <div class="mb-3 small text-muted">
                    <%$return['remarks']|default:'<span class="fst-italic text-secondary">No remarks provided.</span>'%>
                </div>
                <div class="d-flex justify-content-between mt-auto pt-3 border-top align-items-center">
                    <span class="fw-bold text-dark">Total Refund:</span>
                    <span class="h5 mb-0 fw-bold text-danger">₹<%$return['total_return_amount']|number_format:2%></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Items Table -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="bg-light">
                    <tr>
                        <th class="text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Product</th>
                        <th class="text-center text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Returned Qty</th>
                        <th class="text-end text-uppercase text-muted fw-bold" style="font-size: 0.75rem;">Return Price</th>
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
                        <th colspan="3" class="text-end fw-bold align-middle">Total Refundable:</th>
                        <th class="text-end h6 mb-0 fw-bold text-danger">₹<%$return['total_return_amount']|number_format:2%></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<div class="modal-footer border-top bg-light pt-3 pb-3">
    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Close</button>
</div>
