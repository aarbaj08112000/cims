<table class="table table-striped table-hover" id="salesReportTable" style="width: 100%">
    <thead>
        <tr>
            <th>Bill No</th>
            <th>Date</th>
            <th>Customer Phone</th>
            <th>Payment Mode</th>
            <th class="text-end">Total Amount</th>
        </tr>
    </thead>
    <tbody>
        <%if $sales%>
            <%foreach from=$sales item=row%>
                <tr>
                    <td><%$row['bill_no']%></td>
                    <td><%$row['sales_date']|date_format:'%d-%m-%Y'%></td>
                    <td><%$row['customer_phone_number']|default:'-'%></td>
                    <td><%$row['payment_mode']%></td>
                    <td class="text-end"><%$row['total_amount']|number_format:2%></td>
                </tr>
            <%/foreach%>
        <%/if%>
    </tbody>
</table>
