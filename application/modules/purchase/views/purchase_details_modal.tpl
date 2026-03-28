<div class="modal-header border-bottom">
    <h5 class="modal-title">Purchase Bill: <%$purchase['bill_no']%></h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body">
    <div class="row mb-4">
        <div class="col-md-6">
            <h6 class="text-muted mb-2">Supplier Info</h6>
            <p class="mb-1"><strong><%$purchase['supplier_name']%></strong></p>
            <p class="mb-1 text-muted small"><%$purchase['phone']|default:'N/A'%></p>
            <p class="mb-1 text-muted small"><i class="ti ti-map-pin me-1"></i><%$purchase['address']|default:'N/A'%></p>
            <%if $purchase['gst_number']%>
                <p class="mb-0 text-muted small">GST: <%$purchase['gst_number']%></p>
            <%/if%>
        </div>
        <div class="col-md-6 text-md-end">
            <h6 class="text-muted mb-2">Bill Summary</h6>
            <p class="mb-1">Date: <strong><%$purchase['purchase_date']|date_format:'%d-%m-%Y'%></strong></p>
            <p class="mb-1">Status: <span class="badge <%if $purchase['status'] == 'Completed' %>bg-label-success<%else%>bg-label-warning<%/if %>"><%$purchase['status']%></span></p>
            <p class="mb-0 h6 text-primary mt-2">Total: ₹<%$purchase['total_amount']|number_format:2%></p>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-sm table-hover">
            <thead class="table-light">
                <tr>
                    <th>Product</th>
                    <th class="text-center">Qty</th>
                    <th class="text-end">Price</th>
                    <th class="text-end">Total</th>
                </tr>
            </thead>
            <tbody>
                <%foreach from=$items item=item%>
                    <tr>
                        <td>
                            <div class="d-flex flex-column">
                                <span class="fw-bold"><%$item['product_name']%></span>
                                <small class="text-muted"><%$item['product_code']%></small>
                            </div>
                        </td>
                        <td class="text-center"><%$item['qty']%></td>
                        <td class="text-end">₹<%$item['purchase_price']|number_format:2%></td>
                        <td class="text-end">₹<%$item['total_amount']|number_format:2%></td>
                    </tr>
                <%/foreach%>
            </tbody>
            <tfoot>
                <tr class="table-light">
                    <th colspan="3" class="text-end">Grand Total:</th>
                    <th class="text-end text-primary">₹<%$purchase['total_amount']|number_format:2%></th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">Close</button>
    <a href="<%base_url('purchase_details/')%><%$purchase['purchase_id']%>" class="btn btn-primary">Full View / Print</a>
</div>
