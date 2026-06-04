<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    
    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-shopping-cart"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Sales History</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Sales History</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search Sales..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <a href="<%$base_url%>create_sale" class="cat-btn cat-btn-primary text-white" title="Create Sales Bill">
           <i class="ti ti-plus"></i> Create Sales Bill
        </a>
      </div>
    </div>

    <!-- Main Table -->
    <div class="cat-table-card">
      <table class="table table-hover mb-0 w-100" id="salesListTable">
        <thead class="bg-light">
           <tr>
              <th>Invoice No</th>
              <th>Customer</th>
              <th>Sales Date</th>
              <th>Total Amount</th>
              <th>Payment Mode</th>
              <th>Added Date</th>
              <th class="text-center">Action</th>
           </tr>
        </thead>
        <tbody>
        <%if ($sales) %>
          <%foreach from=$sales item=val %>
           <tr>
              <td class="fw-medium text-dark"><%$val['bill_no'] %></td>
              <td><%$val['customer_phone_number']|default:'Walk-in' %></td>
              <td><%$val['sales_date']|date_format:'%d-%m-%Y' %></td>
              <td class="fw-bold text-success"><%$val['total_amount']|number_format:2 %></td>
              <td class="cat-col-status">
                <%if $val['payment_mode'] == 'Cash' %>
                  <span class="cat-badge cat-badge-active"><%$val['payment_mode']%></span>
                <%else %>
                  <span class="cat-badge cat-badge-inactive"><%$val['payment_mode']%></span>
                <%/if %>
              </td>
              <td><%$val['added_date']|date_format:'%d-%m-%Y %H:%M' %></td>
              <td class="text-center cat-col-action">
                <div class="d-flex align-items-center justify-content-center">
                  <a href="javascript:void(0)" class="view-sale-details" data-id="<%$val['sales_id']%>" title="View Details">
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

<!-- Sales Detail Modal -->
<div class="modal fade" id="salesDetailModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content" id="modal-content-area">
      <!-- AJAX content will load here -->
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales_list.js"></script>
