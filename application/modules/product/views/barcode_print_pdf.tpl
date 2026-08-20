<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Barcode Print</title>
    <style>
        @page {
            margin: 20px;
        }
        body {
            font-family: 'Helvetica', 'Arial', sans-serif;
            background: #fff;
            padding: 0;
            margin: 0;
            color: #000;
        }
        table.label-grid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 15px;
            table-layout: fixed;
        }
        td.label-cell {
            width: 33.33%;
            vertical-align: top;
        }
        .sticker-label {
            border: 1px dashed #666;
            padding: 15px;
            background: #fff;
            text-align: center;
        }
        .label-product-name {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 6px;
        }
        .label-meta {
            font-size: 14px;
            color: #333;
            margin-bottom: 4px;
        }
        .divider {
            border-top: 1px solid #ccc;
            margin: 10px 0;
        }
        .barcode-section {
            text-align: center;
            margin-top: 10px;
        }
        .barcode-section img {
            width: 90%;
            height: 60px;
        }
        .barcode-num {
            font-size: 14px;
            letter-spacing: 1px;
            font-weight: bold;
            margin-top: 6px;
        }
        td.empty-cell {
            width: 33.33%;
        }
    </style>
</head>
<body>
    <table class="label-grid">
        <%assign var="col" value=0%>
        <%foreach from=$labels item=label%>
            <%if $col == 0%><tr><%/if%>
            <td class="label-cell">
                <div class="sticker-label">
                    <div class="label-product-name"><%$label['name']%></div>
                    <div class="label-meta">Size: <%$label['size']|default:'N/A'%> &nbsp; | &nbsp; Code: <%$label['product_code']|default:'N/A'%></div>
                    <div class="divider"></div>
                    <div class="barcode-section">
                        <%if $label['barcode_base64'] != ''%>
                            <img src="<%$label['barcode_base64']%>">
                        <%/if%>
                        <div class="barcode-num"><%$label['line_bar_code']%></div>
                    </div>
                </div>
            </td>
            <%assign var="col" value=$col+1%>
            <%if $col == 3%></tr><%assign var="col" value=0%><%/if%>
        <%/foreach%>
        <%if $col == 1%>
            <td class="empty-cell"></td><td class="empty-cell"></td></tr>
        <%elseif $col == 2%>
            <td class="empty-cell"></td></tr>
        <%/if%>
    </table>
</body>
</html>
