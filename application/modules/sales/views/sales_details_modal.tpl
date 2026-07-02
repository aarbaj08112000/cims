<style>
/* Modal Specific Overrides */
.sales-modal-header {
    background: linear-gradient(135deg, var(--cat-primary-light) 0%, #fff 100%);
    border-bottom: 1px solid var(--cat-border-color);
    padding: 1.25rem 1.5rem;
}
.sales-modal-title {
    font-weight: 700;
    color: var(--cat-heading-color);
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.sales-modal-title i {
    color: var(--cat-primary);
    font-size: 1.4rem;
}
.sales-info-card {
    background: var(--cat-bg-light);
    border-radius: var(--cat-radius);
    padding: 1.25rem;
    height: 100%;
    border: 1px solid var(--cat-border-color);
}
.sales-info-label {
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    color: var(--cat-text-muted);
    margin-bottom: 0.25rem;
    letter-spacing: 0.5px;
}
.sales-info-value {
    font-size: 1rem;
    font-weight: 600;
    color: var(--cat-heading-color);
}
</style>

<div class="modal-header sales-modal-header">
    <h5 class="sales-modal-title">
        <i class="ti ti-file-invoice"></i> 
        Invoice Details: <%$sale['bill_no']%>
    </h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body p-4">
    <!-- Summary Cards -->
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="sales-info-card d-flex align-items-center gap-3">
                <div class="cat-page-icon" style="background: var(--cat-primary-light); color: var(--cat-primary); width: 48px; height: 48px; font-size: 1.2rem;">
                    <i class="ti ti-user"></i>
                </div>
                <div>
                    <div class="sales-info-label">Customer Info</div>
                    <div class="sales-info-value"><%$sale['customer_phone_number']|default:'Walk-in'%></div>
                    <div class="text-muted small mt-1"><i class="ti ti-calendar me-1"></i> <%$sale['sales_date']|date_format:'%d %b %Y'%></div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="sales-info-card d-flex align-items-center gap-3">
                <div class="cat-page-icon" style="background: var(--cat-success-light); color: var(--cat-success); width: 48px; height: 48px; font-size: 1.2rem;">
                    <i class="ti ti-currency-rupee"></i>
                </div>
                <div>
                    <div class="sales-info-label">Payment Summary</div>
                    <div class="sales-info-value text-success" style="font-size: 1.15rem;">₹<%$sale['payable_amount']|number_format:2%></div>
                    <div class="mt-1">
                        <span class="cat-badge <%if $sale['payment_mode'] == 'Cash'%>cat-badge-active<%else%>cat-badge-inactive<%/if%>">
                            <span class="cat-badge-dot"></span> Mode: <%$sale['payment_mode']%>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <h6 class="fw-bold mb-3 d-flex align-items-center gap-2"><i class="ti ti-packages text-primary"></i> Ordered Items</h6>
    <div class="table-responsive" style="border-radius: var(--cat-radius); border: 1px solid var(--cat-border-color); overflow: hidden;">
        <table class="table table-hover mb-0">
            <thead class="bg-light">
                <tr>
                    <th class="text-uppercase text-muted" style="font-size: 0.75rem; letter-spacing: 0.5px;">Product</th>
                    <th class="text-center text-uppercase text-muted" style="font-size: 0.75rem; letter-spacing: 0.5px;">Qty</th>
                    <th class="text-end text-uppercase text-muted" style="font-size: 0.75rem; letter-spacing: 0.5px;">Sale Price</th>
                    <th class="text-end text-uppercase text-muted" style="font-size: 0.75rem; letter-spacing: 0.5px;">Total</th>
                </tr>
            </thead>
            <tbody>
                <%foreach from=$items item=item%>
                    <tr>
                        <td>
                            <div class="fw-bold text-dark"><%$item['product_name']%></div>
                            <small class="text-muted"><%$item['product_code']%></small>
                        </td>
                        <td class="text-center align-middle">
                            <span class="cat-badge cat-badge-active px-2 py-1"><%$item['qty']%></span>
                        </td>
                        <td class="text-end align-middle fw-medium">₹<%$item['sale_price']|number_format:2%></td>
                        <td class="text-end align-middle fw-bold">₹<%$item['total_amount']|number_format:2%></td>
                    </tr>
                <%/foreach%>
            </tbody>
            <tfoot class="bg-light">
                <tr>
                    <th colspan="3" class="text-end py-2 fw-bold text-muted">Subtotal:</th>
                    <th class="text-end py-2 fw-bold text-muted">₹<%$sale['total_amount']|number_format:2%></th>
                </tr>
                <tr>
                    <th colspan="3" class="text-end py-2 fw-bold text-muted">Discount:</th>
                    <th class="text-end py-2 fw-bold text-muted">₹<%$sale['discount_amount']|number_format:2%></th>
                </tr>
                <tr>
                    <th colspan="3" class="text-end py-3 fw-bold">Grand Total:</th>
                    <th class="text-end py-3 text-success h5 mb-0 fw-bold">₹<%$sale['payable_amount']|number_format:2%></th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
