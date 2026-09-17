<div class="modal-header border-bottom-0 py-4 rounded-top" style="background: linear-gradient(135deg, var(--bs-primary) 0%, #2b3252 100%);">
    <div class="d-flex align-items-center gap-3">
        <div class="bg-white rounded-circle d-flex align-items-center justify-content-center shadow-sm" style="width: 42px; height: 42px;">
            <i class="ti ti-history text-primary fs-4"></i>
        </div>
        <div>
            <h5 class="modal-title mb-0 text-white fw-bold">Stock Ledger</h5>
            <small class="text-white-50"><%$product['name']%> (<%$product['product_code']%>)</small>
        </div>
    </div>
    <button type="button" class="btn-close btn-close-white m-0" data-bs-dismiss="modal" aria-label="Close" style="position: absolute; right: 1.5rem; top: 1.5rem; background-color: rgba(255,255,255,0.1); border-radius: 50%; padding: 0.5rem; opacity: 1; box-shadow: none;"></button>
</div>
<div class="modal-body p-0">
    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
        <table class="table table-hover mb-0">
            <thead class="table-light sticky-top">
                <tr>
                    <th class="ps-4">Date & Time</th>
                    <th class="text-center">Previous</th>
                    <th class="text-center">Adjustment</th>
                    <th class="text-center">New Qty</th>
                    <th>Remarks</th>
                    <th class="pe-4">By</th>
                </tr>
            </thead>
            <tbody>
                <%if $ledger%>
                    <%foreach from=$ledger item=row%>
                    <tr>
                        <td class="ps-4"><span class="fw-medium text-dark"><%$row['added_date']|getDefaultDateTime%></span></td>
                        <td class="text-center"><span class="badge bg-label-secondary fs-6"><%$row['previous_qty']%></span></td>
                        <td class="text-center">
                            <%if $row['qty'] > 0%>
                                <span class="badge bg-label-success px-2 py-1"><i class="ti ti-arrow-up"></i> +<%$row['qty']%></span>
                            <%else%>
                                <span class="badge bg-label-danger px-2 py-1"><i class="ti ti-arrow-down"></i> <%$row['qty']%></span>
                            <%/if%>
                        </td>
                        <td class="text-center fw-bold text-dark fs-6"><%$row['new_qty']%></td>
                        <td><small class="text-muted"><%$row['remarks']|default:'-'%></small></td>
                        <td class="pe-4">
                            <div class="d-flex align-items-center gap-2">
                                <div style="width:24px;height:24px;border-radius:50%;background:#e0e0e0;color:#555;display:flex;align-items:center;justify-content:center;font-size:.7rem;font-weight:700;">
                                    <%$row['added_by_name']|truncate:1:'':true|default:'S'%>
                                </div>
                                <span class="text-dark small fw-medium"><%$row['added_by_name']|default:'System'%></span>
                            </div>
                        </td>
                    </tr>
                    <%/foreach%>
                <%else%>
                    <tr>
                        <td colspan="6" class="text-center py-5 text-muted">
                            <i class="ti ti-history display-4 d-block mb-3 opacity-25"></i>
                            No stock movement history found.
                        </td>
                    </tr>
                <%/if%>
            </tbody>
        </table>
    </div>
</div>
<div class="modal-footer bg-light border-top-0 py-3 rounded-bottom">
    <button type="button" class="btn btn-label-secondary px-4 fw-medium" data-bs-dismiss="modal">Close</button>
</div>
