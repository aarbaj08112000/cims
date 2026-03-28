<div class="modal-header border-bottom">
    <h5 class="modal-title">Return Details: <%$return['return_no']%></h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body">
    <div class="row mb-4">
        <div class="col-md-6 border-end">
            <h6 class="text-muted mb-2">Supplier & Bill</h6>
            <p class="mb-1"><strong><%$return['supplier_name']%></strong></p>
            <p class="mb-1 text-muted small">Original Bill: <strong><%$return['original_bill_no']%></strong></p>
            <p class="mb-0 text-muted small">Return Date: <%$return['return_date']|date_format:'%d-%m-%Y'%></p>
        </div>
        <div class="col-md-6 ps-md-4">
            <h6 class="text-muted mb-2">Remarks</h6>
            <p class="mb-1 small"><%$return['remarks']|default:'No remarks'%></p>
            <p class="mb-0 h6 text-danger mt-2">Total Return: ₹<%$return['total_return_amount']|number_format:2%></p>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-sm table-hover">
            <thead class="table-light">
                <tr>
                    <th>Product</th>
                    <th class="text-center">Returned Qty</th>
                    <th class="text-end">Return Price</th>
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
                        <td class="text-end">₹<%$item['purchase_price']|number_format:2%></td>
                        <td class="text-end">₹<%$item['total_amount']|number_format:2%></td>
                    </tr>
                <%/foreach%>
            </tbody>
            <tfoot>
                <tr class="table-light">
                    <th colspan="3" class="text-end">Total Refundable:</th>
                    <th class="text-end text-danger h6 mb-0">₹<%$return['total_return_amount']|number_format:2%></th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
