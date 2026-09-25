<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />

<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Tax Configuration -->
    <input type="hidden" id="pos_tax_enabled" value="<%$settings['pos_tax_enabled']['value']|default:'Yes'%>">
    <input type="hidden" id="pos_tax_percentage" value="<%$settings['pos_tax_percentage']['value']|default:'2.5'%>">
    <input type="hidden" id="pos_receipt_print_type" value="<%$settings['pos_receipt_print_type']['value']|default:'PDF'%>">

    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left d-flex align-items-center">
        <div class="cat-page-icon me-3">
          <i class="ti ti-shopping-cart fs-3" style="color: var(--cat-primary);"></i>
        </div>
        <div>
          <h1 class="cat-page-title mb-1">POS Billing</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <a href="<%$base_url%>sales_list">Sales History</a>
            <i class="ti ti-chevron-right mx-1"></i>
            <span>POS</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right d-flex align-items-center">
        <span class="sale-info-badge py-2 px-3 fs-6">
          <i class="ti ti-receipt me-1"></i> Bill No: <span id="bill_no_display"><%$bill_no%></span>
        </span>
      </div>
    </div>

    <div class="row g-4">
        <!-- Left Side: Product Scanning and Table -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 h-100" style="border-radius: var(--cat-radius);">
                <div class="card-header bg-white border-bottom py-3">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h5 class="mb-0 fw-bold" style="color: var(--cat-gray-900);"><i class="ti ti-packages me-2" style="color: var(--cat-primary);"></i>Products & Billing</h5>
                        </div>
                        <div class="col-md-6 text-md-end mt-2 mt-md-0">
                            <span class="badge py-2 px-3" style="background: var(--cat-primary-light); color: var(--cat-primary); font-weight: 600;">Bill No: <span id="bill_no_display_card"><%$bill_no%></span></span>
                        </div>
                    </div>
                </div>
                <div class="card-body p-4">
                    <!-- Scanner and Search Bar -->
                    <div class="row mb-4 g-3">
                        <div class="col-md-6">
                            <div class="input-group input-group-merge shadow-none border rounded">
                                <span class="input-group-text border-0 bg-transparent"><i class="ti ti-scan" style="color: var(--cat-primary);"></i></span>
                                <input type="text" id="barcode_scan" class="form-control border-0 bg-transparent" placeholder="Scan Barcode Here..." autofocus>
                                <button class="btn btn-outline-primary border-0 border-start" type="button" id="start_mobile_scan" title="Scan with Camera">
                                    <i class="ti ti-camera"></i>
                                </button>
                            </div>
                            <small class="text-muted mt-1 d-block"><i class="ti ti-info-circle me-1"></i>Automatically adds product on scan</small>
                            <div id="qr-reader" class="mt-3 rounded" style="display: none; overflow: hidden; border: 2px solid var(--cat-primary);"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group input-group-merge shadow-none border rounded">
                                <span class="input-group-text border-0 bg-transparent"><i class="ti ti-search text-secondary"></i></span>
                                <input type="text" id="product_search" class="form-control border-0 bg-transparent" placeholder="Search Product by Name...">
                            </div>
                        </div>
                    </div>

                    <!-- Items Table -->
                    <div class="table-responsive" style="min-height: 400px;">
                        <table class="table table-hover border-top" id="pos_table">
                            <thead>
                                <tr>
                                    <th width="50%">Product</th>
                                    <th width="15%" class="text-center">Price</th>
                                    <th width="15%" class="text-center">Qty</th>
                                    <th width="15%" class="text-end">Total</th>
                                    <th width="5%" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody id="pos_items_body">
                                <tr id="empty_state_row">
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <div class="py-4">
                                            <i class="ti ti-shopping-cart-x ti-xl mb-2 d-block opacity-25"></i>
                                            Scan barcode or search products to add items
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side: Order Summary and Payment -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0 mb-4" style="border-radius: var(--cat-radius); overflow: hidden;">
                <div class="card-header py-3" style="background: linear-gradient(135deg, var(--cat-primary) 0%, var(--cat-primary-hover) 100%);">
                    <h5 class="mb-0 text-white fw-bold"><i class="ti ti-user me-2"></i>Customer Details</h5>
                </div>
                <div class="card-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Customer Name</label>
                        <div class="input-group input-group-merge">
                            <span class="input-group-text"><i class="ti ti-user"></i></span>
                            <input type="text" id="pos_customer_name" class="form-control" placeholder="Enter Customer Name" value="">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Customer Mobile Number</label>
                        <div class="input-group input-group-merge">
                            <span class="input-group-text"><i class="ti ti-device-mobile"></i></span>
                            <input type="text" id="pos_customer_mobile" class="form-control" placeholder="Enter Mobile Number (Optional)" value="">
                        </div>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm border-0" style="border-radius: var(--cat-radius); border-top: 3px solid var(--cat-primary) !important; overflow: hidden;">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold" style="color: var(--cat-gray-900);"><i class="ti ti-calculator me-2" style="color: var(--cat-primary);"></i>Order Summary</h5>
                </div>
                <div class="card-body p-4">
                    <div class="summary-details">
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Total Items</span>
                            <span id="total_items_count" class="fw-bold">0</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Subtotal</span>
                            <span id="subtotal_display" class="fw-bold">0.00</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted" id="tax_label">Tax (<%if $settings['pos_tax_enabled']['value']|default:'Yes' == 'Yes'%><%$settings['pos_tax_percentage']['value']|default:'2.5'%><%else%>0<%/if%>%)</span>
                            <span id="tax_display" class="fw-bold">0.00</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="text-muted fw-bold">Discount</span>
                            <div class="input-group w-60 shadow-sm">
                                <input type="text" id="discount_input" class="form-control form-control-lg text-end fw-bold text-primary" value="0" style="font-size: 1.1rem;">
                            </div>
                        </div>
                        <hr class="my-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0 text-primary fw-bold">Grand Total</h4>
                            <h4 id="grand_total_display" class="mb-0 text-primary fw-bold font-monospace">0.00</h4>
                        </div>
                        <hr class="my-4">
                        <div class="d-none justify-content-between align-items-center mb-4">
                            <span class="text-muted fw-bold">Received Amount</span>
                            <div class="input-group w-60 shadow-sm">
                                <input type="number" id="received_amount_input" class="form-control form-control-lg text-end fw-bold text-success" value="0" style="font-size: 1.1rem;">
                            </div>
                        </div>
                        <div class="d-none justify-content-between align-items-center p-3 bg-light rounded mb-0">
                            <span class="text-muted fw-bold fs-5">Change</span>
                            <span id="change_display" class="fw-bold text-danger fs-4 font-monospace">0.00</span>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold d-block mb-3">Payment Mode</label>
                        <div class="d-flex gap-2 payment-modes">
                            <input type="radio" class="btn-check" name="payment_mode" id="pm_cash" value="Cash" checked>
                            <label class="btn btn-outline-primary flex-grow-1 py-2" for="pm_cash">
                                <i class="ti ti-cash me-1"></i> Cash
                            </label>
                            
                            <input type="radio" class="btn-check" name="payment_mode" id="pm_card" value="Card">
                            <label class="btn btn-outline-primary flex-grow-1 py-2" for="pm_card">
                                <i class="ti ti-credit-card me-1"></i> Card
                            </label>

                            <input type="radio" class="btn-check" name="payment_mode" id="pm_upi" value="UPI">
                            <label class="btn btn-outline-primary flex-grow-1 py-2" for="pm_upi">
                                <i class="ti ti-qrcode me-1"></i> UPI
                            </label>
                        </div>
                    </div>

                    <button class="cat-btn cat-btn-primary w-100 py-3 shadow-sm mt-2" id="save_pos_bill_btn" style="height: 50px; font-size: 1.05rem; font-weight: 600;">
                        <i class="ti ti-device-floppy me-2 fs-5"></i>
                        <span>Pay & Complete Order</span>
                    </button>
                    <div class="text-center mt-3">
                        <small class="text-muted"><kbd>F2</kbd> keyboard shortcut to save</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>

<!-- Receipt Modal -->
<div class="modal fade" id="receiptModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 85mm;">
        <div class="modal-content border-0">
            <div class="modal-header border-bottom-0 pb-0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0" id="receipt_content">
                <!-- Receipt HTML via AJAX -->
            </div>
        </div>
    </div>
</div>

<!-- Styles for POS Theme Alignment -->
<style>
/* Sales form badge matching theme */
.sale-info-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 12.5px;
    font-weight: 500;
    background: var(--cat-primary-light);
    color: var(--cat-primary);
}

.text-primary {
    color: var(--cat-primary) !important;
}

.bg-primary {
    background-color: var(--cat-primary) !important;
}

.btn-primary {
    background-color: var(--cat-primary) !important;
    border-color: var(--cat-primary) !important;
}

.btn-primary:hover, .btn-primary:focus {
    background-color: var(--cat-primary-hover) !important;
    border-color: var(--cat-primary-hover) !important;
}

.btn-outline-primary {
    color: var(--cat-primary) !important;
    border-color: var(--cat-primary) !important;
}

.btn-outline-primary:hover {
    background-color: var(--cat-primary) !important;
    border-color: var(--cat-primary) !important;
    color: #fff !important;
}

.payment-modes .btn-check:checked + .btn-outline-primary {
    background-color: var(--cat-primary) !important;
    border-color: var(--cat-primary) !important;
    color: #fff !important;
}

.input-group-merge.border:focus-within {
    border-color: var(--cat-primary) !important;
    box-shadow: 0 0 0 0.15rem rgba(91, 95, 199, 0.15) !important;
}

#pos_table thead th {
    background-color: var(--cat-primary-light) !important;
    color: var(--cat-primary) !important;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-weight: 600;
    padding: 12px 16px;
}

.payment-modes .btn {
    border-width: 1.5px;
}
.font-monospace {
    letter-spacing: -0.5px;
}
.qty-input {
    max-width: 80px;
    text-align: center;
}
</style>

<!-- Mobile Responsive POS Table Card Layout -->
<style>
@media (max-width: 768px) {
    /* Disable horizontal scroll wrapper since we stack */
    .table-responsive {
        overflow-x: visible !important;
    }
    
    #pos_table {
        border: 0;
        width: 100% !important;
    }
    #pos_table thead {
        display: none;
    }
    #pos_table tbody tr {
        display: flex;
        flex-direction: column;
        gap: 12px;
        border: 1px solid var(--cat-border);
        border-radius: var(--cat-radius);
        margin-bottom: 20px;
        background: var(--cat-white);
        padding: 15px;
        box-shadow: 0 4px 15px rgba(91, 95, 199, 0.08);
    }
    #pos_table tbody td {
        display: flex;
        flex-direction: column;
        border: none !important;
        padding: 0 !important;
        text-align: left !important;
    }
    #pos_table tbody td::before {
        content: attr(data-label);
        font-weight: 600;
        font-size: 11.5px;
        color: var(--cat-gray-500);
        margin-bottom: 4px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    #pos_table tbody td > input {
        width: 100% !important;
        max-width: 100% !important;
        margin: 0;
        text-align: left !important;
        background: var(--cat-gray-50) !important;
        border: 1px solid var(--cat-gray-200) !important;
        border-radius: 6px;
    }
    
    #pos_table tbody td[data-label="Total"] {
        margin-top: 5px;
        font-size: 16px;
        color: var(--cat-primary);
    }

    #pos_table tbody td[data-label="Action"] {
        margin-top: 10px;
    }
    #pos_table tbody td > .btn-label-danger {
        width: 100%;
        margin: 0;
        height: 44px;
        border-radius: 8px;
    }
    #pos_table tbody td > .btn-label-danger::after {
        content: "Remove Item";
        margin-left: 8px;
        font-weight: 600;
        font-size: 14px;
    }
    #empty_state_row {
        box-shadow: none !important;
        border: 1px dashed var(--cat-border) !important;
        padding: 40px 10px !important;
        align-items: center;
        background: transparent !important;
    }
    #empty_state_row td::before {
        content: none !important;
    }
}
</style>

<!-- Scripts -->
<script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>;
    var current_bill_no = <%$bill_no|@json_encode%>;
</script>

<!-- jQuery UI for product search -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<!-- HTML5 QRCode library for camera scanning -->
<script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>

<script src="<%$base_url%>public/js/admin_panel/pos_billing.js"></script>
