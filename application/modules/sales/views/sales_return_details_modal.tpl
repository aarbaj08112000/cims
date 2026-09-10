<style>
/* Custom Styles for Premium Modal */
.modal-premium {
    font-family: 'Inter', 'Roboto', sans-serif;
    color: #334155;
}
.modal-premium .modal-header-custom {
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    padding: 2rem;
    border-radius: 0.5rem 0.5rem 0 0;
    border-bottom: 1px solid #e2e8f0;
    position: relative;
    overflow: hidden;
}
.modal-premium .modal-header-custom::before {
    content: '';
    position: absolute;
    top: -50px;
    right: -50px;
    width: 150px;
    height: 150px;
    background: rgba(59, 130, 246, 0.05);
    border-radius: 50%;
}
.modal-premium .header-icon {
    width: 60px;
    height: 60px;
    background: #fff;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.1);
    margin: 0 auto 1rem auto;
    color: #3b82f6;
    font-size: 28px;
}
.modal-premium .info-card {
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    padding: 1.25rem;
    height: 100%;
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
}
.modal-premium .info-card:hover {
    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08);
    transform: translateY(-2px);
    border-color: #cbd5e1;
}
.modal-premium .info-label {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #64748b;
    font-weight: 700;
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
.modal-premium .table-container {
    background: #fff;
    border-radius: 12px;
    border: 1px solid #e2e8f0;
    overflow: hidden;
    margin-top: 1.5rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
}
.modal-premium table.modern-table {
    margin-bottom: 0;
    border-collapse: separate;
    border-spacing: 0;
}
.modal-premium table.modern-table thead th {
    background: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    color: #475569;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.8rem;
    letter-spacing: 0.02em;
    padding: 1rem;
}
.modal-premium table.modern-table tbody td {
    padding: 1rem;
    vertical-align: middle;
    border-bottom: 1px solid #f1f5f9;
    color: #334155;
}
.modal-premium table.modern-table tbody tr:last-child td {
    border-bottom: none;
}
.modal-premium table.modern-table tbody tr:hover {
    background-color: #f8fafc;
}
.modal-premium .total-row {
    background: #f8fafc;
    border-top: 2px solid #e2e8f0;
}
.modal-premium .amount-highlight {
    font-size: 1.25rem;
    color: #ef4444;
    font-weight: 700;
}
.modal-premium .remarks-box {
    background: #f8fafc;
    border-left: 4px solid #94a3b8;
    padding: 1rem;
    border-radius: 0 8px 8px 0;
    margin-top: 1.5rem;
}
.modal-premium .btn-close-custom {
    background: #f1f5f9;
    color: #475569;
    border: none;
    padding: 0.75rem 2rem;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.2s;
    text-decoration: none;
}
.modal-premium .btn-close-custom:hover {
    background: #e2e8f0;
    color: #1e293b;
}
.modal-premium .badge-custom {
    background: #e2e8f0;
    color: #475569;
    padding: 0.25rem 0.75rem;
    border-radius: 999px;
    font-size: 0.8rem;
    font-weight: 600;
}
.modal-premium .bg-label-primary-soft {
    background: #dbeafe;
    color: #2563eb;
}
.letter-spacing-1 {
    letter-spacing: 1px;
}

/* Custom Scrollbar */
.modal-premium .p-4::-webkit-scrollbar {
    width: 6px;
}
.modal-premium .p-4::-webkit-scrollbar-track {
    background: transparent;
}
.modal-premium .p-4::-webkit-scrollbar-thumb {
    background-color: #cbd5e1;
    border-radius: 10px;
}
.modal-premium .p-4::-webkit-scrollbar-thumb:hover {
    background-color: #94a3b8;
}
</style>

<div class="modal-premium">
    <div class="modal-header-custom text-center position-relative">
        <button type="button" class="btn-close position-absolute top-0 end-0 m-3" data-bs-dismiss="modal" aria-label="Close"></button>
        <div class="header-icon">
            <i class="ti ti-arrow-back-up"></i>
        </div>
        <h3 class="fw-bold mb-2 text-dark">Sales Return Details</h3>
        <span class="badge-custom">#<%$return.return_no%></span>
    </div>
    
    <div class="p-4" style="max-height: 65vh; overflow-y: auto; overflow-x: hidden;">
        <div class="row g-4 mb-2">
            <div class="col-md-6">
                <div class="info-card">
                    <div class="info-label">
                        <i class="ti ti-user text-primary"></i> Customer Information
                    </div>
                    <h5 class="fw-bold mb-2 text-dark"><%$return.customer_name|default:'Walk-in Customer'%></h5>
                    <div class="d-flex align-items-center mb-1 text-muted">
                        <i class="ti ti-phone me-2"></i> <%$return.mobile_number|default:'No Phone'%>
                    </div>
                    <div class="d-flex align-items-center text-muted">
                        <i class="ti ti-map-pin me-2"></i> <%$return.address1|default:'No Address'%>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="info-card">
                    <div class="info-label">
                        <i class="ti ti-file-info text-info"></i> Reference Details
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Original Bill</span>
                        <span class="fw-bold text-primary">#<%$return.original_bill_no%></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Return Date</span>
                        <span class="fw-bold text-dark"><%$return.return_date|date_format:"%d %b %Y"%></span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted">Logged On</span>
                        <span class="fw-bold text-dark"><%$return.added_date|date_format:"%d %b %Y %H:%I"%></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table modern-table w-100">
                    <thead>
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
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded p-2 me-3 text-secondary">
                                        <i class="ti ti-box"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark"><%$item.product_name%></div>
                                        <small class="text-muted"><%$item.product_code%></small>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="badge bg-label-primary-soft px-3 py-2 rounded-pill fw-bold"><%$item.qty%></span>
                            </td>
                            <td class="text-end text-muted fw-medium">₹<%$item.sale_price|number_format:2%></td>
                            <td class="text-end fw-bold text-dark">₹<%$item.total_amount|number_format:2%></td>
                        </tr>
                        <%/foreach%>
                    </tbody>
                    <tfoot>
                        <tr class="total-row">
                            <th colspan="3" class="text-end text-uppercase text-muted letter-spacing-1 pt-3 pb-3">
                                Total Return Amount
                            </th>
                            <th class="text-end pt-3 pb-3">
                                <span class="amount-highlight">₹<%$return.total_return_amount|number_format:2%></span>
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <%if $return.remarks%>
        <div class="remarks-box d-flex">
            <i class="ti ti-message-dots text-secondary fs-4 me-3 mt-1"></i>
            <div>
                <strong class="text-secondary text-uppercase fs-tiny d-block mb-1">Remarks</strong>
                <p class="mb-0 text-dark fst-italic"><%$return.remarks%></p>
            </div>
        </div>
        <%/if%>

        <div class="text-center mt-4 mb-2">
            <button type="button" class="btn-close-custom" data-bs-dismiss="modal">
                <i class="ti ti-x me-1"></i> Close Details
            </button>
        </div>
    </div>
</div>
