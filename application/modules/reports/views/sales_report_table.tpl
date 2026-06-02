<table class="table table-striped table-hover" id="salesReportTable" style="width: 100%">
    <thead>
        <tr>
            <th>Bill No</th>
            <th>Date</th>
            <th class="text-center">Customer Phone</th>
            <th class="text-center">Payment Mode</th>
            <th class="text-end">Total Amount</th>
        </tr>
    </thead>
    <tbody>
        <%if $sales%>
            <%assign var="total_val" value=0%>
            <%foreach from=$sales item=row%>
                <tr>
                    <td><span class="text-primary fw-bold"><%$row['bill_no']%></span></td>
                    <td>
                        <span class="d-inline-flex align-items-center text-dark">
                            <i class="ti ti-calendar-event me-2 text-muted fs-5"></i>
                            <%$row['sales_date']|date_format:'%d-%m-%Y'%>
                        </span>
                    </td>
                    <td class="text-center">
                        <span class="d-inline-flex align-items-center justify-content-center text-dark">
                            <i class="ti ti-phone me-2 text-muted fs-5"></i>
                            <%$row['customer_phone_number']|default:'-'%>
                        </span>
                    </td>
                    <td class="text-center">
                        <span class="badge bg-label-info d-inline-flex align-items-center justify-content-center">
                            <i class="ti ti-credit-card me-1"></i>
                            <%$row['payment_mode']%>
                        </span>
                    </td>
                    <td class="text-end fw-bold text-success"><%$row['total_amount']|number_format:2%></td>
                </tr>
                <%assign var="total_val" value=$total_val + $row['total_amount']%>
            <%/foreach%>
        <%/if%>
    </tbody>
    <%if $sales%>
    <tfoot>
        <tr class="table-primary border-top-2">
            <th colspan="4" class="text-end h5 mb-0 py-3">GRAND TOTAL:</th>
            <th class="text-end h5 mb-0 py-3 text-primary"><%$total_val|number_format:2%></th>
        </tr>
    </tfoot>
    <%/if%>
</table>
