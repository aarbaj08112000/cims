<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Barcode Print</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            color: #000;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td.label {
            width: 33.3%;
            border: 1px dashed #666;
            padding: 15px;
            text-align: center;
            vertical-align: top;
        }
        td.empty {
            border: none;
        }
        .name {
            font-weight: bold;
            font-size: 15px;
            margin-bottom: 5px;
        }
        .meta {
            font-size: 12px;
            color: #333;
            margin-bottom: 8px;
        }
        .divider {
            border-top: 1px solid #ccc;
            margin-bottom: 8px;
        }
        .bcode-img {
            width: 160px;
            height: 50px;
        }
        .bcode-txt {
            font-size: 13px;
            letter-spacing: 2px;
            font-weight: bold;
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <table>
        <%assign var="col" value=0%>
        <%foreach from=$labels item=label%>
            <%if $col == 0%><tr><%/if%>
            <td class="label">
                <div class="name"><%$label['name']%></div>
                <div class="meta">Size: <%$label['size']|default:'N/A'%> &nbsp;|&nbsp; Code: <%$label['product_code']|default:'N/A'%></div>
                <div class="divider"></div>
                <%if $label['barcode_base64'] != ''%>
                    <div><img class="bcode-img" src="<%$label['barcode_base64']%>"></div>
                <%/if%>
                <div class="bcode-txt"><%$label['line_bar_code']%></div>
            </td>
            <%assign var="col" value=$col+1%>
            <%if $col == 3%></tr><%assign var="col" value=0%><%/if%>
        <%/foreach%>
        <%if $col == 1%>
            <td class="empty"></td><td class="empty"></td></tr>
        <%elseif $col == 2%>
            <td class="empty"></td></tr>
        <%/if%>
    </table>
</body>
</html>
