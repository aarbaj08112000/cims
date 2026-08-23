<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Barcode Thermal Print</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #000;
        }
        @page {
            margin: 2mm;
            margin-bottom: 0mm !important;
        }
        .label-container {
            page-break-inside: avoid;
        }
        .label-box {
            padding: 4px;
            border: 1px dashed #666;
            text-align: center;
        }
        .inner-table {
            width: 100%;
            border-collapse: collapse;
        }
        .name {
            font-weight: 500;
            font-size: 11px;
            text-align: center;
            padding-bottom: 2px;
            color: #000;
        }
        .meta {
            font-size: 9px;
            text-align: center;
            padding-bottom: 4px;
            border-bottom: 1px solid #ccc;
        }
        .bcode-td {
            text-align: center;
            padding-top: 4px;
        }
        .bcode-img {
            height: 75px;
            object-fit: contain;
            width: 100px;
        } 
        .bcode-txt {
            font-size: 10px;
            font-weight: 500;
            text-align: center;
            padding-top: 2px;
        }
    </style>
</head>
<body>
    <%foreach from=$labels item=label name=lbl%>
        <div class="label-container" <%if not $smarty.foreach.lbl.last%>style="page-break-after: always;"<%/if%>>
            <div class="label-box" style="height:140px;">
                <table class="inner-table">
                    <tr>
                        <td class="name"><%$label['name']%></td>
                    </tr>
                    <tr>
                        <td class="meta">
                            Size: <%$label['size']|default:'N/A'%> | Code: <%$label['product_code']|default:'N/A'%><br>
                            <span style="font-size: 11px; font-weight: 500; color: #000;">Price: <%$label['price']|default:'0'%></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="bcode-td" style="width:100px;">
                            <%if $label['barcode_base64'] != ''%>
                                <img class="bcode-img" style="width:100px;" src="<%$label['barcode_base64']%>">
                            <%/if%>
                        </td>
                    </tr>
                    <tr>
                        <td class="bcode-txt"><%$label['line_bar_code']%></td>
                    </tr>
                </table>
            </div>
        </div>
    <%/foreach%>
</body>
</html>
