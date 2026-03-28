<table class="table table-striped table-hover" id="purchaseReportTable">
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
                    <td><span class="text-primary fw-bold"><%$row['bill_no']%></span></td>
                    <td><i class="ti ti-calendar-event me-1 text-muted"></i><%$row['purchase_date']|date_format:'%d-%m-%Y'%></td>
                    <td><span class="fw-medium"><%$row['supplier_name']|default:'N/A'%></span></td>
                    <td><span class="badge bg-label-warning"><i class="ti ti-credit-card me-1"></i><%$row['payment_mode']%></span></td>
                    <td class="text-end fw-bold text-danger"><%$row['total_amount']|number_format:2%></td>
                </tr>
                <%assign var="total_val" value=$total_val + $row['total_amount']%>
            <%/foreach%>
        <%/if%>
    </tbody>
    <%if $purchases%>
    <tfoot>
        <tr class="table-warning border-top-2">
            <th colspan="4" class="text-end h5 mb-0 py-3 text-dark">GRAND TOTAL:</th>
            <th class="text-end h5 mb-0 py-3 text-danger"><%$total_val|number_format:2%></th>
        </tr>
    </tfoot>
    <%/if%>
</table>
