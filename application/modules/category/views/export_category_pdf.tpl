<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Category Export</title>
    <link rel="stylesheet" href="<%%>public/css/pdf_export.css" />
</head>
<body>
    <div class="pdf-container">
        <div class="pdf-header">
            <h1 class="pdf-title">Category Report</h1>
            <div class="pdf-date">Generated on: <%.now|date_format:"%d %b %Y, %I:%M %p"%></div>
        </div>

        <table class="pdf-table">
            <thead>
                <tr>
                    <th width="10%">#</th>
                    <th width="70%">Category Name</th>
                    <th width="20%" class="text-center">Status</th>
                </tr>
            </thead>
            <tbody>
                <%assign var="counter" value=1%>
                <%foreach from= item=item%>
                <tr>
                    <td><%++%></td>
                    <td><%.category_name%></td>
                    <td class="text-center">
                        <%if .status == 'Active'%>
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
