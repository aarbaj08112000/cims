<div class="modal-header bg-primary py-3">
    <h5 class="modal-title text-white">Stock Ledger: <%$product['name']%> (<%$product['product_code']%>)</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body p-0">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>Date</th>
                    <th class="text-center">Previous</th>
                    <th class="text-center">Adjustment</th>
                    <th class="text-center">New Qty</th>
                    <th>Remarks</th>
                    <th>By</th>
                </tr>
            </thead>
            <tbody>
                <%if $ledger%>
                    <%foreach from=$ledger item=row%>
                    <tr>
                        <td><%$row['added_date']|date_format:'%d-%m-%Y %H:%M'%></td>
                        <td class="text-center"><%$row['previous_qty']%></td>
                        <td class="text-center">
                            <span class="badge <%if $row['qty'] > 0%>bg-label-success<%else%>bg-label-danger<%/if%>">
                                <%if $row['qty'] > 0%>+<%/if%><%$row['qty']%>
                            </span>
                        </td>
                        <td class="text-center fw-bold"><%$row['new_qty']%></td>
                        <td><small><%$row['remarks']|default:'-'%></small></td>
                        <td><%$row['added_by_name']|default:'System'%></td>
                    </tr>
                    <%/foreach%>
                <%else%>
                    <tr>
                        <td colspan="6" class="text-center py-4 text-muted">No stock movement history found.</td>
                    </tr>
                <%/if%>
            </tbody>
        </table>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">Close</button>
</div>
