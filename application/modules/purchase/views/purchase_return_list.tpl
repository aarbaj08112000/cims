<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    
    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-receipt-refund"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Purchase Return History</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Return History</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search Returns..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <a href="<%base_url('create_purchase_return')%>" class="cat-btn cat-btn-primary text-white" title="Initiate Return">
           <i class="ti ti-plus"></i> Initiate Return
        </a>
      </div>
    </div>

    <!-- Main Table -->
    <div class="cat-table-card">
      <table class="table table-hover mb-0 w-100" id="returnListTable">
        <thead class="bg-light">
           <tr>
              <th>Return No</th>
              <th>Original Bill</th>
              <th>Supplier</th>
              <th>Return Date</th>
              <th>Total Return</th>
              <th>Added Date</th>
              <th class="text-center">Action</th>
           </tr>
        </thead>
        <tbody>
        <%if ($returns) %>
          <%foreach from=$returns item=val %>
           <tr>
              <td class="fw-medium text-dark"><%$val['return_no'] %></td>
              <td><%$val['original_bill_no'] %></td>
              <td><%$val['supplier_name'] %></td>
              <td><%$val['return_date']|date_format:'%d-%m-%Y' %></td>
              <td class="fw-bold text-danger">₹<%$val['total_return_amount']|number_format:2 %></td>
              <td><%$val['added_date']|date_format:'%d-%m-%Y %H:%M' %></td>
              <td class="text-center cat-col-action">
                <div class="d-flex align-items-center justify-content-center">
                  <a href="javascript:void(0)" class="view-return-details" data-id="<%$val['return_id']%>" title="View Details">
                    <i class="ti ti-eye text-primary"></i>
                  </a>
                </div>
              </td>
           </tr>
          <%/foreach%>
        <%/if%>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Return Detail Modal -->
<div class="modal fade" id="returnDetailModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content" id="return-modal-content">
      <!-- AJAX content -->
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/purchase_return.js"></script>
