<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Attribute Export</title>
    <link rel="stylesheet" href="<%$base_url%>public/css/pdf_export.css" />
</head>
<body>
    <div class="pdf-container">
        <div class="pdf-header">
            <h1 class="pdf-title">Attribute Report</h1>
            <div class="pdf-date">Generated on: <%$smarty.now|date_format:"%d %b %Y"%></div>
        </div>
        <table class="pdf-table">
            <thead>
                <tr>
                    <th width="8%">#</th>
                    <th width="42%">Attribute Name</th>
                    <th width="22%">Attribute Code</th>
                    <th width="28%" class="text-center">Status</th>
                </tr>
            </thead>
            <tbody>
                <%assign var="counter" value=1%>
                <%foreach from=$attributes item=item%>
                <tr>
                    <td><%$counter++%></td>
                    <td><%$item.attribute_name%></td>
                    <td><%$item.attribute_code|default:"-"%></td>
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
