<div class="receipt-outer-wrap no-print">
    <div class="receipt-inner shadow-2xl">
        <div id="thermal-receipt" class="pos-receipt-v2">
            <!-- Header section with Brand Identity -->
            <div class="header-section text-center">
                <h1 class="main-title" style="font-size:20px; font-weight: 500;">Code Crafter Infotech</h1>
                <div class="contact-details mt-2" style="margin-top:0px;">
                    <span style="font-size:14px;"><i class="ti ti-phone-call"></i> +91 9988776655</span>
                    <span class="mx-2" style="font-size:14px;margin-left:7px;margin-right:3px;">|</span>
                    <span style="font-size:14px;"><i class="ti ti-world"></i> www.codecrafter.com</span>
                </div>
            </div>

            <div class="ornamental-divider my-4">
                <span><i class="ti ti-scissors"></i></span>
            </div>

            <!-- Transaction Details -->
            <div class="transaction-meta mb-4">
                <div class="meta-row">
                    <span class="m-label">BILL NUMBER</span>
                    <span class="m-value highlight">#<%$sale.bill_no%></span>
                </div>
                <div class="meta-row">
                    <span class="m-label">DATE & TIME</span>
                    <span class="m-value"><%$sale.sales_date|date_format:"%d %b %Y"%> | <%$smarty.now|date_format:"%H:%M"%></span>
                </div>
                <div class="meta-row">
                    <span class="m-label">CUSTOMER</span>
                    <span class="m-value"><%$sale.customer_phone_number|default:'Walk-In Customer'%></span>
                </div>
            </div>
            

            <!-- Items Table -->
            <div class="items-table-wrap" style="margin-top:10px;border-top: 1px solid #00000;padding-top: 5px;">
                <table class="item-table">
                    <thead>
                        <tr>
                            <th class="text-start" style="font-size:15px;font-weight: 500;">ITEM DESCRIPTION</th>
                            <th class="text-center" style="font-size:15px;font-weight: 500;">QTY</th>
                            <th class="text-end" style="font-size:15px;font-weight: 500;">TOTAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%foreach from=$items item=item%>
                        <tr class="item-row">
                            <td class="text-start" style="font-size:15px;">
                                <div class="p-name"><%$item.product_name%></div>
                                <span class="p-rate text-muted" style="font-size:13px;">@ <span class="rupees_block">₹</span> <%$item.sale_price|number_format:2%></span>
                            </td>
                            <td class="text-center p-qty" style="font-size:15px;">× <%$item.qty%></td>
                            <td class="text-end p-total" style="font-size:15px;"><span class="rupees_block">₹</span> <%$item.total_amount|number_format:2%></td>
                        </tr>
                        <%/foreach%>
                    </tbody>
                </table>
            </div>


            <!-- Financials Summary -->
            <div class="summary-section" style="margin-top:0px;">
                <div class="summary-line" style="margin-top:10px;font-size:11px;">
                    <span>SUBTOTAL</span>
                    <span class="fw-bold" style="font-size:15px;"><span class="rupees_block">₹</span> <%$sale.total_amount|number_format:2%></span>
                </div>
                <%if $settings['pos_tax_enabled']['value']|default:'Yes' == 'Yes'%>
                <div class="summary-line" style="margin-top:10px;font-size:11px;">
                    <span>GST (<%$settings['pos_tax_percentage']['value']|default:'2.5'%>%)</span>
                    <span style="font-size:15px;"><span class="rupees_block">₹</span> <%($sale.total_amount * ($settings['pos_tax_percentage']['value']|default:'2.5' / 100))|number_format:2%></span>
                </div>
                <%/if%>
                <div class="net-payable-box my-3 p-2 rounded" style="<%if $is_pdf|default:false%>background-color:#e8e6fb !important; padding:10px;<%/if%>">
                    <div class="summary-line net-row p-2 rounded" style="margin-top:4px;">
                        <span class="net-label" style="color: #000000 !important; font-size:13px;">NET PAYABLE AMOUNT</span>
                        <span class="net-value fw-bolder" style="color: #000000 !important; font-size:16px;">₹<%$sale.payable_amount|number_format:2%></span>
                    </div>
                </div>
            </div>

            <!-- Verification Stamp -->
            <div class="stamp-wrap text-center" style="margin: 10px 10px 10px 10px;">
                <div class="verification-stamp" style="width:100%;">
                    <i class="ti ti-circle-check-filled success-icon"></i>
                    <span class="stamp-text">PAID & VERIFIED</span>
                </div>
            </div>

            <!-- Footer & Barcode -->
            <div class="footer-wrap text-center mt-2">
                <div class="footer-note mb-4">
                    <strong style="font-size:17px;">Thank you for your visit!</strong><br>
                    <span class="text-muted small">Items once sold can be exchanged within 7 days.</span>
                </div>
                <div class="barcode-container" style="margin-top:12px; clear:both;">
                    <%if $barcode_img|default:''%>
                    <img src="<%$barcode_img%>" alt="Barcode" style="width:120px; height:110px; display:block; margin:9px 5px;">
                    <%else%>
                    <div class="design-barcode"></div>
                    <%/if%>
                    <div class="barcode-id font-monospace" style="margin-top:4px; font-size:12px; letter-spacing:2px; color:<%$gar_light2%>;"><%$sale.bill_no%></div>
                </div>
                <div class="version-tag" style="margin-top:6px; font-size:12px;color:<%$gar_dark%>;">Generated by CIMS System</div>
            </div>
        </div>
    </div>

    <%if !$is_pdf|default:false%>
    <!-- Floating Print Button -->
    <div class="print-trigger-overlay p-4">
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-primary btn-lg w-50 shadow-lg print-btn-v2 d-flex align-items-center justify-content-center" onclick="window.print();">
                <i class="ti ti-printer me-2 fs-3"></i> PRINT
            </button>
            <a href="<%$base_url%>sales/Pos/download_receipt_pdf/<%$sale.sales_id%>/download" class="btn btn-dark btn-lg w-50 shadow-lg print-btn-v2 d-flex align-items-center justify-content-center" style="text-decoration: none;">
                <i class="ti ti-download me-2 fs-3"></i> DOWNLOAD
            </a>
        </div>
        <div class="text-center mt-2 small text-muted">Thermal PDF Download available</div>
    </div>
    <%/if%>
</div>

<style>
/* Modern Receipt Styling V2 */
.receipt-outer-wrap {
    perspective: 1000px;
}
.receipt-inner {
    max-width: 85mm;
    margin: 0 auto;
    border-radius: 16px;
    background: #fff;
    max-height: 80vh;
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: #7367f0 #f0f0f0;
}
.rupees_block {
    font-family: DejaVu Sans, sans-serif;
}
<%if $is_pdf|default:false%>
body { margin: 0; padding: 0; }
.pos-receipt-v2 {
    width: 280px;
    box-sizing: border-box;
    padding: 16px 16px;
    background: #fff;
    font-family: Arial, sans-serif;
    color: #2b2b2b;
    margin: 0 auto;
    font-size:13px;
}
<%else%>
.pos-receipt-v2 {
    width: 100%;
    max-width: 85mm;
    box-sizing: border-box;
    padding: 8px 8px;
    background: #fff;
    font-family: 'Outfit', 'Inter', sans-serif;
    color: #2b2b2b;
    margin: 0 auto;
}
<%/if%>

/* Bootstrap fallbacks for Dompdf */
.text-center { text-align: center; }
.text-start { text-align: left; }
.text-end { text-align: right; }
.text-primary { color: #7367f0 !important; }
.fw-bold { font-weight: 500; }
.fw-bolder { font-weight: 500; }
.text-muted { color: <%$gar_light2%>; }
.small { font-size: 1em; }
.my-3 { margin-top: 1rem; margin-bottom: 1rem; }
.mt-4 { margin-top: 1.5rem; }

/* Header */
.brand-logo {
    max-height: 55px;
    filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
}
.    {
    font-size: 1.725rem;
    font-weight: 500;
    letter-spacing: -0.5px;
    margin: 0;
    color: #111;
}
.sub-header {
    font-size: 0.925rem;
    color: #777;
    margin: 4px 0 0 0;
    font-weight: 500;
}
.contact-details {
    font-size: 0.825rem;
    color: <%$gar_dark%> !important;
}

/* Dividers */
<%if !$is_pdf|default:false%>
.ornamental-divider { display: flex; align-items: center; color: #00000; margin: 15px 0; }
.ornamental-divider::before, .ornamental-divider::after { content: ""; flex: 1; border-bottom: 2px dashed #00000; }
.ornamental-divider span { margin: 0 10px; font-size: 1.325rem; }
<%else%>
.ornamental-divider { text-align: center; border-top: 2px dashed #00000; margin: 15px 0; position: relative; padding-top: 10px; }
<%/if%>
.straight-divider { border-bottom: 1px solid #00000; margin: 15px 0; }

/* Meta */
.transaction-meta { background: #fff; padding-top: 15px; border-radius: 8px; border: none; }
<%if !$is_pdf|default:false%>
.meta-row { display: flex; justify-content: space-between; margin-bottom: 4px; border-bottom: 1px dotted #ececec; padding-bottom: 4px; }
.m-label { font-size: 0.775rem; color: <%$gar_light%>; font-weight: 500; }
.m-value { font-size: 0.975rem; font-weight: 500; color: #00000; }
<%else%>
.meta-row { display: table; width: 100%; margin-bottom: 4px; border-bottom: 1px dotted #0000; padding-bottom: 4px; }
.m-label { display: table-cell; text-align: left; font-size: 1.125rem; color: <%$gar_light%>; font-weight: 500; width: 40%; vertical-align: middle; }
.m-value { display: table-cell; text-align: right; font-size: 1.125rem; font-weight: 500; color: #00000; width: 55%; vertical-align: middle; }
<%/if%>
.meta-row:last-child { border: 0; padding: 0; margin: 0; }
.highlight { color: #000000; }

/* Table */
.item-table { width: 100%; border-collapse: collapse; }
.item-table th { font-size: 0.775rem; color: <%$gar_light2%>; padding-bottom: 10px; border-bottom: 1px solid #00000; }
.item-row td { padding: 12px 0; border-bottom: 1px solid #00000; vertical-align: top; }
.p-name { font-weight: 500; font-size: 0.975rem; line-height: 1.2; color: #111; }
.p-rate { font-size: 0.875rem; }
.p-qty { font-size: 0.925rem; font-weight: 500; color: #00000; }
.p-total { font-weight: 500; color: #111; font-size: 1.025rem; }

/* Summary */
<%if !$is_pdf|default:false%>
.summary-line { display: flex; justify-content: space-between; font-size: 0.925rem; margin-bottom: 6px; }
.breakdown-line { display: flex; justify-content: space-between; margin-bottom: 3px; font-size: 0.875rem; }
<%else%>
.summary-line { display: table; width: 100%; font-size: 0.925rem; margin-bottom: 6px; }
.summary-line > span:first-child { display: table-cell; text-align: left; vertical-align: middle; }
.summary-line > span:last-child { display: table-cell; text-align: right; font-weight: 500; vertical-align: middle; }
<%/if%>
<%if !$is_pdf|default:false%>
.net-payable-box { background: rgba(115, 103, 240, 0.05); }
.net-row { border: 2px solid rgba(115, 103, 240, 0.2); }
<%else%>
.net-payable-box { background-color: #e8e6fb; }
<%/if%>
.net-label { font-weight: 500; font-size: 0.975rem; }
.net-value { font-size: 1.425rem; }

/* Stamp */
<%if !$is_pdf|default:false%>
.verification-stamp {
    display: inline-flex;
    align-items: center;
    padding: 6px 16px;
    border: 3px solid #000000;
    border-radius: 6px;
    color: #000000;
    transform: rotate(-3deg);
    font-weight: 500;
}
<%else%>
.verification-stamp {
    display: inline-block;
    padding: 8px 10px;
    border: 3px solid #000000;
    border-radius: 6px;
    color: #000000;
    font-weight: 500;
}
<%/if%>
.success-icon { font-size: 1.525rem; margin-right: 8px; }
.stamp-text { font-size: 1.225rem; letter-spacing: 1px; }

/* Footer */
.footer-note { line-height: 1.4; }
<%if !$is_pdf|default:false%>
.design-barcode {
    width: 150px;
    height: 35px;
    background: repeating-linear-gradient(90deg, #222, #222 2px, #fff 2px, #fff 5px);
    margin: 0 auto;
}
<%else%>
.design-barcode {
    width: 150px;
    height: 35px;
    margin: 0 auto;
    overflow: hidden;
    text-align: center;
}
<%/if%>
.barcode-id { font-size: 0.825rem; color: <%$gar_light2%>; margin-top: 5px; letter-spacing: 3px; }

/* Print Styles */
@media print {
    body * { visibility: hidden; }
    .receipt-inner, .receipt-inner * {
        visibility: visible;
    }
    .receipt-inner {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        max-width: none;
        box-shadow: none !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    .pos-receipt-v2 {
        padding: 0;
        width: 100%;
    }
    .print-trigger-overlay { display: none !important; }
    .no-print { visibility: hidden; width: 0; height: 0; padding: 0; margin: 0; }
}

.print-btn-v2 {
    transition: all 0.3s ease;
}
.print-btn-v2:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 15px rgba(115, 103, 240, 0.4);
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap" rel="stylesheet">
