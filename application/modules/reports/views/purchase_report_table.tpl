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
            <%assign var="total_val" value=0%>
            <%foreach from=$purchases item=row%>
                <tr>
                    <td><%$row['bill_no']%></td>
                    <td><%$row['purchase_date']|date_format:'%d-%m-%Y'%></td>
                    <td><%$row['supplier_name']|default:'N/A'%></td>
                    <td><%$row['payment_mode']%></td>
                    <td class="text-end"><%$row['total_amount']|number_format:2%></td>
                </tr>
                <%assign var="total_val" value=$total_val + $row['total_amount']%>
            <%/foreach%>
        <%/if%>
    </tbody>
    <%if $purchases%>
    <tfoot>
        <tr>
            <th colspan="4" class="text-end fw-bold">GRAND TOTAL:</th>
            <th class="text-end fw-bold"><%$total_val|number_format:2%></th>
        </tr>
    </tfoot>
    <%/if%>
</table>
