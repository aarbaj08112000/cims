<div class="container-xxl flex-grow-1 container-p-y">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold py-3 mb-0"><span class="text-muted fw-light">Sales /</span> Create Sales Return</h4>
        <a href="sales_list" class="btn btn-secondary btn-sm"><i class="ti ti-arrow-left me-1"></i> Back to Sales</a>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card bg-white border-0 shadow-sm">
                <form id="salesReturnForm">
                    <input type="hidden" name="sales_id" value="<%$sale.sales_id%>">
                    <div class="card-header bg-white border-0 py-4">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Customer</label>
                                <p class="fw-bold fs-5 mb-0"><%$sale.full_name|default:'Walk-in'%></p>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Original Bill No</label>
                                <p class="fw-bold fs-5 mb-0">#<%$sale.bill_no%></p>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Sale Date</label>
                                <p class="fw-bold fs-5 mb-0"><%$sale.sales_date|date_format:"%d %b %Y"%></p>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Return Date</label>
                                <input type="date" name="return_date" class="form-control" value="<%$smarty.now|date_format:'%Y-%m-%d'%>" required>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive p-3">
                        <table class="table table-bordered">
                            <thead class="bg-light">
                                <tr>
                                    <th>Product</th>
                                    <th class="text-center">Sold Qty</th>
                                    <th class="text-center">Return Qty</th>
                                    <th class="text-end">Price</th>
                                    <th class="text-end">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%foreach from=$items item=item%>
                                <tr>
                                    <td>
                                        <%$item.product_name%>
                                        <small class="d-block text-muted"><%$item.product_code%></small>
                                        <input type="hidden" name="product_id[]" value="<%$item.product_id%>">
                                        <input type="hidden" name="price[]" value="<%$item.sale_price%>">
                                    </td>
                                    <td class="text-center"><%$item.qty%></td>
                                    <td style="width: 150px;">
                                        <input type="number" name="qty[]" class="form-control text-center return-qty" 
                                               min="0" max="<%$item.qty%>" value="0" data-price="<%$item.sale_price%>">
                                    </td>
                                    <td class="text-end"><%$settings.company_currency.value|default:'$'%><%$item.sale_price|number_format:2%></td>
                                    <td class="text-end fw-bold">
                                        <%$settings.company_currency.value|default:'$'%><span class="item-total">0.00</span>
                                        <input type="hidden" name="total[]" class="item-total-input" value="0">
                                    </td>
                                </tr>
                                <%/foreach%>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="4" class="text-end fs-5">Grand Total Return Amount:</th>
                                    <th class="text-end fs-5 text-primary">
                                        <%$settings.company_currency.value|default:'$'%><span id="grandTotal">0.00</span>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="card-footer bg-white border-0 py-4">
                        <div class="mb-3">
                            <label class="form-label text-uppercase fs-tiny fw-bold">Return Remarks</label>
                            <textarea name="remarks" class="form-control" rows="2" placeholder="Reason for return..."></textarea>
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary px-5 btn-lg shadow-sm">
                                <i class="ti ti-check me-1"></i> Process Return
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    function calculateTotals() {
        var grandTotal = 0;
        $('.return-qty').each(function() {
            var qty = parseFloat($(this).val()) || 0;
            var price = parseFloat($(this).data('price')) || 0;
            var total = qty * price;
            
            $(this).closest('tr').find('.item-total').text(total.toLocaleString(undefined, { minimumFractionDigits: 2 }));
            $(this).closest('tr').find('.item-total-input').val(total);
            grandTotal += total;
        });
        $('#grandTotal').text(grandTotal.toLocaleString(undefined, { minimumFractionDigits: 2 }));
    }

    $(document).on('input', '.return-qty', function() {
        var max = parseFloat($(this).attr('max'));
        var val = parseFloat($(this).val());
        if (val > max) {
            $(this).val(max);
        }
        calculateTotals();
    });

    $('#salesReturnForm').on('submit', function(e) {
        e.preventDefault();
        
        var hasQty = false;
        $('.return-qty').each(function() {
            if (parseFloat($(this).val()) > 0) hasQty = true;
        });

        if (!hasQty) {
            Swal.fire('Error', 'Please enter at least one item quantity to return.', 'error');
            return;
        }

        Swal.fire({
            title: 'Confirm Return?',
            text: "This will restore stock to inventory and process the return.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#7367f0',
            confirmButtonText: 'Yes, Process It!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: base_url + 'save_sales_return',
                    type: 'POST',
                    data: $('#salesReturnForm').serialize(),
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            Swal.fire('Success', response.msg, 'success').then(() => {
                                window.location.href = base_url + 'sales_return_list';
                            });
                        } else {
                            Swal.fire('Error', response.msg, 'error');
                        }
                    }
                });
            }
        });
    });
});
</script>
