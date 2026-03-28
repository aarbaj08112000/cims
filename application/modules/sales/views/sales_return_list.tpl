<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link">
            <i class="ti ti-chevrons-right"></i>
            <em>Sales Return</em>
          </a>
        </h1>
        <br>
        <span>Return History</span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
      <input type="text" id="search-filter-input" placeholder="Search Returns..." class="form-control search-filter-input me-2">
      <button class="btn btn-success me-2" onclick="exportTableToCSV('returnListTable', 'sales_return_history.csv')">
        <i class="ti ti-file-type-csv me-1"></i> Export CSV
      </button>
      <button class="btn btn-danger me-2" onclick="exportTableToPDF()">
        <i class="ti ti-file-type-pdf me-1"></i> Export PDF
      </button>
      <a href="<%base_url('create_sales_return')%>" class="btn btn-seconday" title="Initiate Return">
        <i class="ti ti-plus me-2"></i> Initiate Return
      </a>
    </div>

    <div class="card p-0 mt-0 w-100">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" id="returnListTable">
          <thead>
            <tr>
              <th>Return No</th>
              <th>Original Bill</th>
              <th>Customer</th>
              <th>Date</th>
              <th>Amount</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody class="table-border-bottom-0">
            <%foreach from=$returns item=return%>
            <tr>
              <td><strong>#<%$return.return_no%></strong></td>
              <td>#<%$return.original_bill_no%></td>
              <td><%$return.customer_name|default:'Walk-in'%></td>
              <td><%$return.return_date|date_format:"%d %b %Y"%></td>
              <td><%$settings.company_currency.value|default:'$'%><%$return.total_return_amount|number_format:2%></td>
              <td>
                <div class="d-flex align-items-center">
                  <a href="javascript:void(0)" class="me-2 view-return-details" data-id="<%$return.return_id%>" title="View Details">
                    <i class="ti ti-eye text-info"></i>
                  </a>
                </div>
              </td>
            </tr>
            <%/foreach%>
          </tbody>
        </table>
    </div>
  </div>
</div>

<!-- Return Detail Modal -->
<div class="modal fade" id="returnDetailModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content" id="return-modal-content">
      <!-- AJAX content loaded here -->
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales_return.js"></script>
