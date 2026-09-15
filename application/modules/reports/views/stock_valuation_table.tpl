<table class="table table-striped table-hover" id="stockReportTable" style="width: 100%">
    <thead>
        <tr>
            <th>Product</th>
            <th>Category</th>
            <th>Current Qty</th>
            <th class="text-end">Avg Purchase Price</th>
            <th class="text-end">Total Valuation</th>
        </tr>
    </thead>
    <tbody>
        <%if $stock%>
            <%$low_stock_threshold = 10%> <!-- Example threshold -->
            <%foreach from=$stock item=row%>
                <tr>
                    <td>
                        <%$row['name']%>
                        <span class="text-muted">(<%$row['product_code']%>)</span>
                    </td>
                    <td><%$row['category_name']|default:'N/A'%></td>
                    <td><%$row['qty']%> <%$row['unit']%></td>
                    <td class="text-end"><%$row['purchase_price']|number_format:2%></td>
                    <td class="text-end"><%$row['valuation']|number_format:2%></td>
                </tr>
            <%/foreach%>
        <%/if%>
    </tbody>
</table>
