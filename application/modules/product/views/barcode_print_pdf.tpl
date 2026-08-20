<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Barcode Print</title>
    <style>
        body {
            font-family: 'Helvetica', 'Arial', sans-serif;
            background: #fff;
            padding: 15px;
            margin: 0;
            color: #000;
        }
        table.label-grid {
            width: 100%;
            border-collapse: collapse;
        }
        td.label-cell {
            width: 33.3%;
            padding: 10px;
            vertical-align: top;
        }
        .sticker-label {
            border: 1px dashed #666;
            padding: 15px;
            text-align: center;
        }
        .label-product-name {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 5px;
        }
        .label-meta {
            font-size: 12px;
            color: #333;
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
        }
        .barcode-section {
            margin-top: 10px;
        }
        .barcode-section img {
            width: 170px;
            height: 50px;
        }
        .barcode-num {
            font-size: 13px;
            letter-spacing: 2px;
            font-weight: bold;
            margin-top: 5px;
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
                    <div class="label-meta">Size: <%$label['size']|default:'N/A'%> &nbsp;|&nbsp; Code: <%$label['product_code']|default:'N/A'%></div>
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
            <td class="label-cell"></td><td class="label-cell"></td></tr>
        <%elseif $col == 2%>
            <td class="label-cell"></td></tr>
        <%/if%>
    </table>
</body>
</html>
