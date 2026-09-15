<table class="table table-striped table-hover" id="purchaseReportTable" style="width: 100%">
    <thead>
        <tr>
            <th>Bill No</th>
            <th>Date</th>
            <th>Supplier</th>
            <th>Payment Mode</th>
            <th class="text-end">Total Amount</th>
        </tr>
    </thead>
    <tbody>
        <%if $purchases%>
            <%foreach from=$purchases item=row%>
                <tr>
                    <td><%$row['bill_no']%></td>
                    <td><%$row['purchase_date']|date_format:'%d-%m-%Y'%></td>
                    <td><%$row['supplier_name']|default:'N/A'%></td>
                    <td>Cash</td>
                    <td class="text-end"><%$row['total_amount']|number_format:2%></td>
                </tr>
            <%/foreach%>
        <%/if%>
    </tbody>
</table>
