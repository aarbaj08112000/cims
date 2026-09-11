<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Export</title>
    <link rel="stylesheet" href="<%$base_url%>public/css/pdf_export.css" />
</head>
<body>
    <div class="pdf-container">
        <div class="pdf-header">
            <h1 class="pdf-title">Product Report</h1>
            <div class="pdf-date">Generated on: <%$smarty.now|date_format:"%d %b %Y"%></div>
        </div>
        <table class="pdf-table">
            <thead>
                <tr>
                    <th width="5%">#</th>
                    <th width="12%">Code</th>
                    <th width="30%">Product Name</th>
                    <th width="18%">Category</th>
                    <th width="15%">Brand</th>
                    <th width="10%" class="text-right">Purchase Price</th>
                    <th width="10%" class="text-center">Status</th>
                </tr>
            </thead>
            <tbody>
                <%assign var="counter" value=1%>
                <%foreach from=$products item=item%>
                <tr>
                    <td><%$counter++%></td>
                    <td><%$item.product_code%></td>
                    <td><%$item.product_name%></td>
                    <td><%$item.category_name|default:"-"%></td>
                    <td><%$item.brand_name|default:"-"%></td>
                    <td class="text-right"><%$item.purchase_price|number_format:2%></td>
                    <td class="text-center">
                        <%if $item.status == "Active"%>
                            <span class="badge badge-success">Active</span>
                        <%else%>
                            <span class="badge badge-danger">Inactive</span>
                        <%/if%>
                    </td>
                </tr>
                <%/foreach%>
            </tbody>
        </table>
    </div>
</body>
</html>