<table class="table table-striped table-hover" id="stockReportTable">
    <thead>
        <tr>
            <th>Product</th>
            <th>Category</th>
            <th class="text-center">Current Qty</th>
            <th class="text-end">Avg Purchase Price</th>
            <th class="text-end">Total Valuation</th>
        </tr>
    </thead>
    <tbody>
        <%if $stock%>
            <%assign var="total_val" value=0%>
            <%$low_stock_threshold = 10%> <!-- Example threshold -->
            <%foreach from=$stock item=row%>
                <tr>
                    <td>
                        <span class="d-block fw-bold text-primary"><%$row['name']%></span>
                        <small class="text-muted"><%$row['product_code']%></small>
                    </td>
                    <td><span class="badge bg-label-secondary"><%$row['category_name']|default:'N/A'%></span></td>
                    <td class="text-center">
                        <%if $row['qty'] <= $row['alert_qty']%>
                            <span class="badge bg-label-danger"><i class="ti ti-alert-triangle me-1"></i><%$row['qty']%> <%$row['unit']%></span>
                        <%else%>
                            <span class="badge bg-label-success"><%$row['qty']%> <%$row['unit']%></span>
                        <%/if%>
                    </td>
                    <td class="text-end fw-medium"><%$row['purchase_price']|number_format:2%></td>
                    <td class="text-end fw-bold text-primary"><%$row['valuation']|number_format:2%></td>
                </tr>
                <%assign var="total_val" value=$total_val + $row['valuation']%>
            <%/foreach%>
        <%/if%>
    </tbody>
    <%if $stock%>
    <tfoot>
        <tr class="table-success border-top-2">
            <th colspan="4" class="text-end h5 mb-0 py-3 text-dark">TOTAL INVENTORY VALUE:</th>
            <th class="text-end h5 mb-0 py-3 text-success"><%$total_val|number_format:2%></th>
        </tr>
    </tfoot>
    <%/if%>
</table>
