<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Purchase Bill - <%$purchase['bill_no']%></title>
    <style>
        body {
            font-family: 'Helvetica', sans-serif;
            color: #1f2937;
            background-color: #fff;
            margin: 0;
            padding: 30px;
            font-size: 14px;
        }

        .text-primary { color: #1254ff; }
        .text-end { text-align: right; }
        .text-center { text-align: center; }
        .text-muted { color: #6b7280; }
        .text-dark { color: #1f2937; }
        .fw-bold { font-weight: 700; }
        .text-success { color: #10b981; }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        .header-table td {
            vertical-align: top;
        }

        .company-logo {
            height: 60px;
        }

        .company-name {
            font-size: 20px;
            color: #1254ff;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .invoice-title {
            font-size: 32px;
            font-weight: bold;
            color: #111827;
            text-align: right;
        }

        .sub-header {
            margin-top: 20px;
            margin-bottom: 20px;
            border-top: 1px solid #f3f4f6;
            padding-top: 20px;
        }

        .label {
            font-size: 10px;
            font-weight: bold;
            color: #6b7280;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .value {
            font-size: 15px;
            font-weight: bold;
        }

        .party-box {
            background-color: #f9fafb;
            padding: 15px;
            margin-bottom: 20px;
        }

        .invoice-table {
            width: 100%;
            margin-bottom: 20px;
            border: 1px solid #f3f4f6;
        }

        .invoice-table th {
            background-color: #1254ff;
            color: #fff;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            padding: 10px;
            text-align: left;
        }
        
        .invoice-table th.text-end { text-align: right; }
        .invoice-table th.text-center { text-align: center; }

        .invoice-table td {
            padding: 15px 10px;
            font-size: 14px;
            border-bottom: 1px solid #f3f4f6;
        }

        .remarks-box {
            background-color: #f9fafb;
            padding: 15px;
            margin-bottom: 30px;
        }

        .summary-box {
            background-color: #f9fafb;
            padding: 15px;
        }

        .grand-total-label {
            font-size: 18px;
            font-weight: bold;
            color: #1254ff;
        }

        .grand-total-val {
            font-size: 24px;
            font-weight: bold;
            color: #1254ff;
            text-align: right;
        }

        .signature-table {
            margin-top: 50px;
            width: 100%;
        }

        .signature-line {
            border-bottom: 1px solid #6b7280;
            margin-bottom: 5px;
            height: 40px;
        }
    </style>
</head>
<body>

    <table class="header-table">
        <tr>
            <td width="60%">
                <table style="width: 100%;">
                    <tr>
                        <td width="80" style="vertical-align: middle;">
                            <%if $logo_base64 != ''%>
                                <img src="<%$logo_base64%>" alt="Company Logo" style="max-height: 80px; max-width: 100px;">
                            <%/if%>
                        </td>
                        <td style="vertical-align: middle;">
                            <div class="company-name"><%$company_name|default:'Your Company'%></div>
                            <div class="text-muted"><%$company_address|default:''%></div>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="40%" style="text-align: right; vertical-align: top;">
                <div class="invoice-title" style="font-size: 32px; font-weight: bold; color: #111827;">PURCHASE BILL</div>
            </td>
        </tr>
    </table>
    <br>
    <table class="sub-header">
        <tr>
            <td width="33%" style="padding:10px;">
                <div class="label">BILL DETAILS</div>
                <div class="value text-primary">#<%$purchase['bill_no']%></div>
            </td>
            <td width="33%" class="text-center" style="padding:10px;">
                <div class="label">DATE</div>
                <div class="value"><%$purchase['purchase_date']|date_format:'%d/%m/%Y'%></div>
            </td>
            <td width="33%" class="text-end" style="padding:10px;">
                <div class="label">COMPANY GST</div>
                <div class="value"><%$company_gst|default:'Not Provided'%></div>
            </td>
        </tr>
    </table>

    <div class="party-box">
        <div class="label text-primary">SUPPLIER INFO</div>
        <div class="value"><%$purchase['supplier_name']%></div>
        <%if $purchase['phone']|default:'' != ''%>
            <div style="font-size: 13px; color: #6b7280; margin-top: 3px;"><%$purchase['phone']%></div>
        <%/if%>
        <%if $purchase['email']|default:'' != ''%>
            <div style="font-size: 13px; color: #6b7280; margin-top: 3px;"><%$purchase['email']%></div>
        <%/if%>
        <%if $purchase['gst_number']|default:'' != ''%>
            <div style="font-size: 13px; color: #6b7280; margin-top: 3px;">GST: <%$purchase['gst_number']%></div>
        <%/if%>
    </div>

    <table class="invoice-table">
        <thead>
            <tr>
                <th width="8%">SN</th>
                <th width="35%">DESCRIPTION</th>
                <th class="text-center" width="15%">QTY</th>
                <th class="text-end" width="20%">PRICE</th>
                <th class="text-end" width="22%">AMOUNT</th>
            </tr>
        </thead>
        <tbody>
            <%assign var="sn" value=1%>
            <%assign var="totalQty" value=0%>
            <%foreach from=$items item=item%>
            <tr>
                <td class="text-muted"><%$sn|string_format:"%02d"%></td>
                <td>
                    <div class="fw-bold"><%$item['product_name']%></div>
                    <%if $item['product_code']%><div style="font-size: 11px; color: #6b7280; margin-top: 4px;">Code: <%$item['product_code']%></div><%/if%>
                </td>
                <td class="text-center"><%$item['qty']%></td>
                <td class="text-end">₹<%$item['purchase_price']|number_format:2%></td>
                <td class="text-end fw-bold text-primary">₹<%$item['total_amount']|number_format:2%></td>
            </tr>
            <%assign var="sn" value=$sn+1%>
            <%assign var="totalQty" value=$totalQty+$item['qty']%>
            <%/foreach%>
        </tbody>
    </table>

    <div class="remarks-box">
        <div class="label">REMARKS</div>
        <p style="margin: 0;">Purchase order verified and processed.</p>
    </div>

    <table>
        <tr>
            <td width="48%" style="vertical-align: top;">
                <div style="border: 1px solid #f3f4f6; padding: 15px; margin-bottom: 15px;">
                    <div class="label text-primary">PURCHASE SUMMARY</div>
                    <div style="margin-bottom: 5px;"><span class="text-muted" style="display:inline-block; width:100px;">Total Items:</span> <strong><%$items|@count%></strong></div>
                    <div><span class="text-muted" style="display:inline-block; width:100px;">Total Quantity:</span> <strong><%$totalQty%></strong></div>
                </div>
            </td>
            <td width="4%"></td>
            <td width="48%" style="vertical-align: top;">
                <div class="summary-box">
                    <table style="width: 100%; border-bottom: 1px dashed #d1d5db; margin-bottom: 10px; padding-bottom: 10px;">
                        <tr >
                            <td class="text-muted fw-bold"></td>
                        </tr>
                    </table>
                    
                    <table style="width: 100%; margin-top: 0px;">
                        <tr>
                            <td class="grand-total-label">Grand Total</td>
                            <td class="grand-total-val">₹<%$purchase['total_amount']|number_format:2%></td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <table class="signature-table">
        <tr>
            <td width="40%" class="text-center">
                <div class="signature-line"></div>
                <div style="font-size: 11px; color: #6b7280;">Supplier Signature</div>
            </td>
            <td width="20%"></td>
            <td width="40%" class="text-center">
                <div class="signature-line"></div>
                <div style="font-size: 11px; color: #6b7280;">Authorized Signatory</div>
            </td>
        </tr>
    </table>

</body>
</html>
