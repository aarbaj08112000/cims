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
        .name {
            font-weight: bold;
            font-size: 11px;
            margin-bottom: 2px;
            color: #000;
        }
        .meta {
            font-size: 9px;
            margin-bottom: 4px;
            padding-bottom: 4px;
            border-bottom: 1px solid #ccc;
            color: #1a4b77; /* Subtle blue to match reference */
        }
        .bcode-td {
            margin-top: 4px;
        }
        .bcode-img {
            max-width: 100%;
            height: 95px;
            object-fit: contain;
        }
        .bcode-txt {
            font-size: 10px;
            font-weight: bold;
            margin-top: 3px;
            color: #1a4b77; /* Subtle blue to match reference */
        }
    </style>
</head>
<body>
    <%foreach from=$labels item=label name=lbl%>
        <div class="label-container" <%if not $smarty.foreach.lbl.last%>style="page-break-after: always;"<%/if%>>
            <div class="label-box">
                <div class="name"><%$label['name']%></div>
                <div class="meta">
                    Size: <%$label['size']|default:'N/A'%> | Code: <%$label['product_code']|default:'N/A'%><br>
                    <span style="font-size: 11px; font-weight: bold; color: #000;">Price: <%$label['price']|default:'0'%></span>
                </div>
                <div class="bcode-td">
                    <%if $label['barcode_base64'] != ''%>
                        <img class="bcode-img" src="<%$label['barcode_base64']%>">
                    <%/if%>
                </div>
                <div class="bcode-txt"><%$label['line_bar_code']%></div>
            </div>
        </div>
    <%/foreach%>
</body>
</html>
