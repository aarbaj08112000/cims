<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Barcode Print</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Helvetica', 'Arial', sans-serif;
            background: #fff;
            padding: 10px;
        }
        table.label-grid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 6px;
        }
        td.label-cell {
            width: 33.33%;
            vertical-align: top;
        }
        .sticker-label {
            border: 1px dashed #999;
            padding: 8px;
            background: #fff;
        }
        .label-product-name {
            font-weight: bold;
            font-size: 11px;
            margin-bottom: 3px;
        }
        .label-meta {
            font-size: 10px;
            color: #555;
            margin-bottom: 2px;
        }
        hr.divider {
            border: none;
            border-top: 0px solid #ddd;
            margin: 5px 0;
        }
        .barcode-section {
            text-align: center;
        }
        .barcode-num {
            font-size: 9px;
            letter-spacing: 1px;
            font-weight: bold;
            text-align: center;
            margin-top: 2px;
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
                    <div class="label-meta">Size: <%$label['size']|default:'N/A'%></div>
                    <div class="label-meta">Code: <%$label['product_code']|default:'N/A'%></div>
                    <hr class="divider">
                    <div class="barcode-section">
                        <%if $label['barcode_base64'] != ''%>
                            <img src="<%$label['barcode_base64']%>" width="155" height="50">
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
