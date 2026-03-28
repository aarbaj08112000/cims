<div class="row mb-5">
    <div class="col-12 text-center mb-4">
        <h3 class="fw-bold mb-1">Sales Return Details</h3>
        <p class="text-muted">#<%$return.return_no%></p>
    </div>
    <div class="col-md-6">
        <div class="mb-4">
            <span class="text-muted text-uppercase fs-tiny fw-bold">Customer Info</span>
            <h5 class="fw-bold mb-1"><%$return.customer_name|default:'Walk-in Customer'%></h5>
            <p class="mb-1"><%$return.mobile_number|default:'No Phone'%></p>
            <p class="mb-0"><%$return.address1|default:'No Address'%></p>
        </div>
    </div>
    <div class="col-md-6 text-md-end">
        <div class="mb-4">
            <span class="text-muted text-uppercase fs-tiny fw-bold">Reference Info</span>
            <p class="mb-1 fw-bold">Original Bill: <span class="text-primary">#<%$return.original_bill_no%></span></p>
            <p class="mb-1">Return Date: <span class="fw-bold"><%$return.return_date|date_format:"%d %b %Y"%></span></p>
            <p class="mb-0">Logged Date: <span class="fw-bold"><%$return.added_date|date_format:"%d %b %Y %H:%I"%></span></p>
        </div>
    </div>
</div>

<div class="table-responsive mb-4">
    <table class="table table-bordered table-sm text-nowrap">
        <thead class="bg-light">
            <tr>
                <th>Product</th>
                <th class="text-center">Returned Qty</th>
                <th class="text-end">Sale Price</th>
                <th class="text-end">Total</th>
            </tr>
        </thead>
        <tbody>
            <%foreach from=$items item=item%>
            <tr>
                <td>
                    <%$item.product_name%>
                    <small class="d-block text-muted"><%$item.product_code%></small>
                </td>
                <td class="text-center fw-bold"><%$item.qty%></td>
                <td class="text-end"><%$settings.company_currency.value|default:'$'%><%$item.sale_price|number_format:2%></td>
                <td class="text-end fw-bold"><%$settings.company_currency.value|default:'$'%><%$item.total_amount|number_format:2%></td>
            </tr>
            <%/foreach%>
        </tbody>
        <tfoot>
            <tr>
                <th colspan="3" class="text-end fs-5">Total Return Amount:</th>
                <th class="text-end fs-5 text-primary">
                    <%$settings.company_currency.value|default:'$'%><%$return.total_return_amount|number_format:2%>
                </th>
            </tr>
        </tfoot>
    </table>
</div>

<%if $return.remarks%>
<div class="bg-light p-3 rounded mb-4">
    <span class="text-muted text-uppercase fs-tiny fw-bold d-block mb-1">Remarks</span>
    <p class="mb-0 italic"><%$return.remarks%></p>
</div>
<%/if%>

<div class="col-12 text-center mt-3">
    <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">Close</button>
</div>
