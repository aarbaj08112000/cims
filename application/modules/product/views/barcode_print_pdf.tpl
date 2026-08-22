<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Barcode Print</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #000;
        }
        table.main-table {
            border-collapse: collapse;
        }
        td.label-td {
            padding: 3px;
            vertical-align: top;
        }
        .label-box {
            border: 1px dashed #666;
            padding: 5px;
            text-align: center;
        }
        table.inner-table {
            border-collapse: collapse;
        }
        .name {
            font-weight: bold;
            font-size: 11px;
            text-align: center;
            padding-bottom: 2px;
        }
        .meta {
            font-size: 9px;
            color: #333;
            text-align: center;
            padding-bottom: 5px;
            border-bottom: 1px solid #ccc;
        }
        .bcode-td {
            text-align: center;
            padding-top: 5px;
        }
        .qr-code {
            margin-top: 3px;
        }
        .bcode-txt {
            font-size: 9px;
            font-weight: bold;
            text-align: center;
            padding-top: 3px;
        }
    </style>
</head>
<body>
    <table class="main-table">
        <%assign var="col" value=0%>
        <%foreach from=$labels item=label%>
            <%if $col == 0%><tr><%/if%>
            <td class="label-td" >
                <div class="label-box" style="height:150px;">
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
                                    <img class="bcode-img <%$label['barcode_class']|default:'bar-code'%>" src="<%$label['barcode_base64']%>">
                                <%/if%>
                            </td>
                        </tr>
                        <tr>
                            <td class="bcode-txt"><%$label['line_bar_code']%></td>
                        </tr>
                    </table>
                </div>
            </td>
            <%assign var="col" value=$col+1%>
            <%if $col == 5%></tr><%assign var="col" value=0%><%/if%>
        <%/foreach%>
        
        <%if $col > 0%>
            <%while $col < 5%>
                <td class="label-td"></td>
                <%assign var="col" value=$col+1%>
            <%/while%>
            </tr>
        <%/if%>
    </table>
</body>
</html>
