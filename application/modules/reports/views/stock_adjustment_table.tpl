<%if $adjustments%>
<div class="table-responsive">
  <table class="table table-hover mb-0 w-100" id="adjReportTable">
    <thead>
      <tr>
        <th style="width:50px;">#</th>
        <th>Date &amp; Time</th>
        <th>Product</th>
        <th class="text-center">Old Stock</th>
        <th class="text-center">Change</th>
        <th class="text-center">New Stock</th>
        <th>Remarks</th>
        <th>Adjusted By</th>
      </tr>
    </thead>
    <tbody>
      <%assign var='idx' value=1%>
      <%foreach from=$adjustments item=row%>
      <tr>
        <td><span class="cat-row-num"><%$idx%></span></td>
        <td>
          <div class="fw-semibold text-dark" style="font-size:.88rem;"><%$row['added_date']|date_format:'%d %b %Y'%></div>
          <small class="text-muted"><%$row['added_date']|date_format:'%H:%M'%></small>
        </td>
        <td>
          <div class="fw-bold text-dark"><%$row['product_name']%></div>
          <small class="text-muted"><%$row['product_code']%></small>
        </td>
        <td class="text-center">
          <span class="badge bg-label-secondary fs-6"><%$row['previous_qty']%></span>
        </td>
        <td class="text-center">
          <%if $row['qty'] > 0%>
            <span class="adj-change-badge adj-add"><i class="ti ti-arrow-up"></i> +<%$row['qty']%></span>
          <%else%>
            <span class="adj-change-badge adj-reduce"><i class="ti ti-arrow-down"></i> <%$row['qty']%></span>
          <%/if%>
        </td>
        <td class="text-center">
          <span class="badge <%if $row['new_qty'] <= 0%>bg-label-danger<%elseif $row['new_qty'] < 10%>bg-label-warning<%else%>bg-label-success<%/if%> fs-6"><%$row['new_qty']%></span>
        </td>
        <td>
          <%if $row['remarks']%>
            <span class="text-muted" style="font-size:.85rem;"><%$row['remarks']%></span>
          <%else%>
            <span class="text-muted" style="font-size:.8rem;">—</span>
          <%/if%>
        </td>
        <td>
          <div class="d-flex align-items-center gap-2">
            <div style="width:30px;height:30px;border-radius:50%;background:#ededfa;color:#5b5fc7;display:flex;align-items:center;justify-content:center;font-size:.85rem;font-weight:700;flex-shrink:0;">
              <%$row['adjusted_by']|truncate:1:'':true%>
            </div>
            <span class="fw-medium text-dark" style="font-size:.88rem;"><%$row['adjusted_by']|default:'System'%></span>
          </div>
        </td>
      </tr>
      <%assign var='idx' value=$idx+1%>
      <%/foreach%>
    </tbody>
  </table>
</div>
<%else%>
<div class="text-center py-5 text-muted">
  <i class="ti ti-clipboard-off fs-1 d-block mb-2"></i>
  No stock adjustment records found for the selected period.
</div>
<%/if%>
