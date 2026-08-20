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
        table.main-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 15px;
        }
        td.label {
            width: 33.33%;
            border: 1px dashed #666;
            padding: 10px;
            vertical-align: top;
        }
        td.empty {
            border: none;
        }
        table.inner-table {
            width: 100%;
            border-collapse: collapse;
        }
        .name {
            font-weight: bold;
            font-size: 16px;
            text-align: center;
            padding-bottom: 5px;
        }
        .meta {
            font-size: 12px;
            color: #333;
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }
        .bcode-td {
            text-align: center;
            padding-top: 10px;
        }
        .bcode-img {
            width: 160px;
            height: 50px;
        }
        .bcode-txt {
            font-size: 14px;
            letter-spacing: 1px;
            font-weight: bold;
            text-align: center;
            padding-top: 5px;
        }
    </style>
</head>
<body>
    <table class="main-table">
        <%assign var="col" value=0%>
        <%foreach from=$labels item=label%>
            <%if $col == 0%><tr><%/if%>
            <td class="label">
                <table class="inner-table">
                    <tr>
                        <td class="name"><%$label['name']%></td>
                    </tr>
                    <tr>
                        <td class="meta">Size: <%$label['size']|default:'N/A'%> &nbsp;|&nbsp; Code: <%$label['product_code']|default:'N/A'%></td>
                    </tr>
                    <tr>
                        <td class="bcode-td">
                            <%if $label['barcode_base64'] != ''%>
                                <img class="bcode-img" src="<%$label['barcode_base64']%>">
                            <%/if%>
                        </td>
                    </tr>
                    <tr>
                        <td class="bcode-txt"><%$label['line_bar_code']%></td>
                    </tr>
                </table>
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
