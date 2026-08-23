<div class="receipt-outer-wrap no-print">
    <div class="receipt-inner shadow-2xl">
        <div id="thermal-receipt" class="pos-receipt-v2">
            <!-- Header section with Brand Identity -->
            <div class="header-section text-center">
                <h1 class="main-title" style="font-size: 1.2rem; font-weight: 700;">Code Crafter Infotech</h1>
                <div class="contact-details mt-2">
                    <span><i class="ti ti-phone-call"></i> +91 9988776655</span>
                    <span class="mx-2">|</span>
                    <span><i class="ti ti-world"></i> www.codecrafter.com</span>
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
            <div class="items-table-wrap">
                <table class="item-table">
                    <thead>
                        <tr>
                            <th class="text-start">ITEM DESCRIPTION</th>
                            <th class="text-center">QTY</th>
                            <th class="text-end">TOTAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%foreach from=$items item=item%>
                        <tr class="item-row">
                            <td class="text-start">
                                <div class="p-name"><%$item.product_name%></div>
                                <span class="p-rate text-muted">@ ₹<%$item.sale_price|number_format:2%></span>
                            </td>
                            <td class="text-center p-qty">× <%$item.qty%></td>
                            <td class="text-end p-total">₹<%$item.total_amount|number_format:2%></td>
                        </tr>
                        <%/foreach%>
                    </tbody>
                </table>
            </div>

            <div class="straight-divider my-3"></div>

            <!-- Financials Summary -->
            <div class="summary-section">
                <div class="summary-line">
                    <span>SUBTOTAL</span>
                    <span class="fw-bold">₹<%$sale.total_amount|number_format:2%></span>
                </div>
                <%if $settings['pos_tax_enabled']['value']|default:'Yes' == 'Yes'%>
                <div class="summary-line">
                    <span>GST (<%$settings['pos_tax_percentage']['value']|default:'2.5'%>%)</span>
                    <span>₹<%($sale.total_amount * ($settings['pos_tax_percentage']['value']|default:'2.5' / 100))|number_format:2%></span>
                </div>
                <%/if%>
                <div class="net-payable-box my-3 p-2 rounded" style="<%if $is_pdf|default:false%>background-color:#e8e6fb !important; padding:10px;<%/if%>">
                    <div class="summary-line net-row p-2 rounded" style="<%if $is_pdf|default:false%>border: 2px solid #ceccfc !important; background-color:#e8e6fb !important;<%/if%>">
                        <span class="net-label" style="color: #7367f0 !important; font-size: 0.75rem;">NET PAYABLE AMOUNT</span>
                        <span class="net-value fw-bolder" style="color: #7367f0 !important; font-size: 1.1rem;">₹<%$sale.payable_amount|number_format:2%></span>
                    </div>
                </div>
            </div>

            <!-- Verification Stamp -->
            <div class="stamp-wrap text-center" style="margin: 25px 0;">
                <div class="verification-stamp">
                    <i class="ti ti-circle-check-filled success-icon"></i>
                    <span class="stamp-text">PAID & VERIFIED</span>
                </div>
            </div>

            <!-- Footer & Barcode -->
            <div class="footer-wrap text-center mt-4">
                <div class="footer-note mb-4">
                    <strong>Thank you for your visit!</strong><br>
                    <span class="text-muted small">Items once sold can be exchanged within 7 days.</span>
                </div>
                <div class="barcode-container" style="margin-top: 12px;">
                    <%if $barcode_img|default:''%>
                    <img src="<%$barcode_img%>" alt="Barcode" style="width:160px; height:50px; display:block; margin:0 auto;">
                    <%else%>
                    <div class="design-barcode"></div>
                    <%/if%>
                    <div class="barcode-id font-monospace" style="margin-top:4px; font-size:0.65rem; letter-spacing:2px;"><%$sale.bill_no%></div>
                </div>
                <div class="version-tag" style="margin-top:8px; font-size:0.65rem; color:#999;">Generated by CIMS System</div>
            </div>
        </div>
    </div>

    <%if !$is_pdf|default:false%>
    <!-- Floating Print Button -->
    <div class="print-trigger-overlay p-4">
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-primary btn-lg w-50 shadow-lg print-btn-v2 d-flex align-items-center justify-content-center" onclick="printReceiptHTML()">
                <i class="ti ti-printer me-2 fs-3"></i> PRINT
            </button>
            <a href="<%$base_url%>sales/Pos/download_receipt_pdf/<%$sale.sales_id%>/download" class="btn btn-dark btn-lg w-50 shadow-lg print-btn-v2 d-flex align-items-center justify-content-center" style="text-decoration: none;">
                <i class="ti ti-download me-2 fs-3"></i> DOWNLOAD
            </a>
        </div>
        <div class="text-center mt-2 small text-muted">Thermal PDF Download available</div>
    </div>
    <script>
    function printReceiptHTML() {
        var printContents = document.getElementById('thermal-receipt').outerHTML;
        var iframe = document.createElement('iframe');
        iframe.name = "receiptPrintIframe";
        iframe.style.position = "absolute";
        iframe.style.width = "0px";
        iframe.style.height = "0px";
        iframe.style.border = "none";
        document.body.appendChild(iframe);
        
        var doc = iframe.contentWindow.document;
        doc.open();
        doc.write('<html><head><title>Print Receipt</title>');
        
        var styles = document.getElementsByTagName('style');
        for (var i = 0; i < styles.length; i++) {
            doc.write(styles[i].outerHTML);
        }
        var links = document.getElementsByTagName('link');
        for (var i = 0; i < links.length; i++) {
            if (links[i].rel === 'stylesheet') {
                doc.write(links[i].outerHTML);
            }
        }
        
        doc.write('<style>@media print { @page { margin: 0; } body { margin: 0; padding: 10px; } body * { visibility: visible !important; color: #000 !important; border-color: #000 !important; background: transparent !important; } .pos-receipt-v2 { width: 100% !important; max-width: 80mm !important; margin: 0 auto; box-shadow: none !important; } .no-print { display: none !important; } }</style>');
        doc.write('</head><body>');
        doc.write(printContents);
        doc.write('</body></html>');
        doc.close();
        
        setTimeout(function() {
            iframe.contentWindow.focus();
            iframe.contentWindow.print();
            setTimeout(function() { document.body.removeChild(iframe); }, 1000);
        }, 500);
    }
    </script>
    <%/if%>
</div>

<style>
<%if $is_pdf|default:false%>
@page { margin: 5mm 5mm; }
body { margin: 0; padding: 0; }
<%/if%>
/* Modern Receipt Styling V2 */
.receipt-outer-wrap {
    perspective: 1000px;
}
.receipt-inner {
    max-width: 150mm;
    margin: 0 auto;
    border-radius: 16px;
    background: #fff;
    max-height: 80vh;
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: #7367f0 #f0f0f0;
}
.pos-receipt-v2 {
    width: 100%;
    max-width: 150mm;
    box-sizing: border-box;
    padding: 15px 10px;
    background: #fff;
    font-family: 'Outfit', 'Inter', sans-serif;
    color: #2b2b2b;
    margin: 0 auto;
}

/* Bootstrap fallbacks for Dompdf */
.text-center { text-align: center; }
.text-start { text-align: left; }
.text-end { text-align: right; }
.text-primary { color: #7367f0 !important; }
.fw-bold { font-weight: bold; }
.fw-bolder { font-weight: 900; }
.text-muted { color: #6c757d; }
.small { font-size: 0.875em; }
.my-3 { margin-top: 1rem; margin-bottom: 1rem; }
.mt-4 { margin-top: 1.5rem; }

/* Header */
.brand-logo {
    max-height: 55px;
    filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
}
.main-title {
    font-size: 1.6rem;
    font-weight: 800;
    letter-spacing: -0.5px;
    margin: 0;
    color: #111;
    text-transform: uppercase;
}
.sub-header {
    font-size: 0.8rem;
    color: #777;
    margin: 4px 0 0 0;
    font-weight: 500;
}
.contact-details {
    font-size: 0.7rem;
    color: #999;
}

/* Dividers */
<%if !$is_pdf|default:false%>
.ornamental-divider { display: flex; align-items: center; color: #ddd; margin: 15px 0; }
.ornamental-divider::before, .ornamental-divider::after { content: ""; flex: 1; border-bottom: 2px dashed #eee; }
.ornamental-divider span { margin: 0 10px; font-size: 1.2rem; }
<%else%>
.ornamental-divider { text-align: center; border-top: 2px dashed #eee; margin: 15px 0; position: relative; padding-top: 10px; }
<%/if%>
.straight-divider { border-bottom: 2px solid #f0f0f0; margin: 15px 0; }

/* Meta */
.transaction-meta { background: #fcfcfc; padding: 10px; border-radius: 8px; border: 1px solid #f5f5f5; }
<%if !$is_pdf|default:false%>
.meta-row { display: flex; justify-content: space-between; margin-bottom: 4px; border-bottom: 1px dotted #ececec; padding-bottom: 4px; }
.m-label { font-size: 0.65rem; color: #aaa; font-weight: 700; }
.m-value { font-size: 0.75rem; font-weight: 600; color: #444; }
<%else%>
.meta-row { display: table; width: 100%; margin-bottom: 4px; border-bottom: 1px dotted #ececec; padding-bottom: 4px; }
.m-label { display: table-cell; text-align: left; font-size: 0.65rem; color: #aaa; font-weight: 700; width: 40%; vertical-align: middle; }
.m-value { display: table-cell; text-align: right; font-size: 0.75rem; font-weight: 600; color: #444; width: 55%; vertical-align: middle; }
<%/if%>
.meta-row:last-child { border: 0; padding: 0; margin: 0; }
.highlight { color: #7367f0; }

/* Table */
.item-table { width: 100%; border-collapse: collapse; }
.item-table th { font-size: 0.65rem; color: #bbb; padding-bottom: 10px; border-bottom: 2px solid #f9f9f9; }
.item-row td { padding: 12px 0; border-bottom: 1px solid #f9f9f9; vertical-align: top; }
.p-name { font-weight: 700; font-size: 0.85rem; line-height: 1.2; color: #111; }
.p-rate { font-size: 0.75rem; }
.p-qty { font-size: 0.8rem; font-weight: 500; color: #666; }
.p-total { font-weight: 800; color: #111; font-size: 0.9rem; }

/* Summary */
<%if !$is_pdf|default:false%>
.summary-line { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
.breakdown-line { display: flex; justify-content: space-between; margin-bottom: 3px; font-size: 0.75rem; }
<%else%>
.summary-line { display: table; width: 100%; font-size: 0.8rem; margin-bottom: 6px; }
.summary-line > span:first-child { display: table-cell; text-align: left; vertical-align: middle; }
.summary-line > span:last-child { display: table-cell; text-align: right; font-weight: bold; vertical-align: middle; }
<%/if%>
<%if !$is_pdf|default:false%>
.net-payable-box { background: rgba(115, 103, 240, 0.05); }
.net-row { border: 2px solid rgba(115, 103, 240, 0.2); }
<%else%>
.net-payable-box { background-color: #e8e6fb; }
.net-row { border: 2px solid #ceccfc; }
<%/if%>
.net-label { font-weight: 800; font-size: 0.85rem; }
.net-value { font-size: 1.3rem; }

/* Stamp */
<%if !$is_pdf|default:false%>
.verification-stamp {
    display: inline-flex;
    align-items: center;
    padding: 6px 16px;
    border: 3px solid #28c76f;
    border-radius: 6px;
    color: #28c76f;
    transform: rotate(-3deg);
    font-weight: 900;
}
<%else%>
.verification-stamp {
    display: inline-block;
    padding: 8px 16px;
    border: 3px solid #28c76f;
    border-radius: 6px;
    color: #28c76f;
    font-weight: 900;
}
<%/if%>
.success-icon { font-size: 1.4rem; margin-right: 8px; }
.stamp-text { font-size: 1.1rem; letter-spacing: 1px; }

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
.barcode-id { font-size: 0.7rem; color: #888; margin-top: 5px; letter-spacing: 3px; }

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
