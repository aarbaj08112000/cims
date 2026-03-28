<div class="modal-header border-bottom">
    <h5 class="modal-title">Invoice Details: <%$sale['bill_no']%></h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body">
    <div class="row mb-4">
        <div class="col-md-6 border-end">
            <h6 class="text-muted mb-2">Customer Info</h6>
            <p class="mb-1">Phone: <strong><%$sale['customer_phone_number']|default:'Walk-in'%></strong></p>
            <p class="mb-0 text-muted small">Date: <%$sale['sales_date']|date_format:'%d-%m-%Y'%></p>
        </div>
        <div class="col-md-6 ps-md-4">
            <h6 class="text-muted mb-2">Payment Details</h6>
            <p class="mb-1 small">Mode: <span class="badge bg-label-info"><%$sale['payment_mode']%></span></p>
            <p class="mb-0 h6 text-success mt-2">Total Amount: ₹<%$sale['total_amount']|number_format:2%></p>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-sm table-hover">
            <thead class="table-light">
                <tr>
                    <th>Product</th>
                    <th class="text-center">Qty</th>
                    <th class="text-end">Sale Price</th>
                    <th class="text-end">Total</th>
                </tr>
            </thead>
            <tbody>
                <%foreach from=$items item=item%>
                    <tr>
                        <td>
                            <strong><%$item['product_name']%></strong><br>
                            <small class="text-muted"><%$item['product_code']%></small>
                        </td>
                        <td class="text-center"><%$item['qty']%></td>
                        <td class="text-end">₹<%$item['sale_price']|number_format:2%></td>
                        <td class="text-end">₹<%$item['total_amount']|number_format:2%></td>
                    </tr>
                <%/foreach%>
            </tbody>
            <tfoot>
                <tr class="table-light">
                    <th colspan="3" class="text-end">Grand Total:</th>
                    <th class="text-end text-success h6 mb-0">₹<%$sale['total_amount']|number_format:2%></th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
