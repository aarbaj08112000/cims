<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link">
            <i class="ti ti-chevrons-right"></i>
            <em>Reports</em>
          </a>
        </h1>
        <br>
        <span>Purchase Report</span>
      </div>
    </nav>

    <!-- Filter Card -->
    <div class="card bg-white border-0 shadow-sm mb-4">
      <div class="card-body">
        <form method="GET" action="<%$base_url%>purchase_report" class="row g-3">
          <div class="col-md-4">
            <label class="form-label">From Date</label>
            <input type="date" name="from_date" class="form-control" value="<%$from_date%>" required>
          </div>
          <div class="col-md-4">
            <label class="form-label">To Date</label>
            <input type="date" name="to_date" class="form-control" value="<%$to_date%>" required>
          </div>
          <div class="col-md-4 d-flex align-items-end">
            <button type="submit" class="btn btn-primary me-2">Filter</button>
            <a href="<%$base_url%>purchase_report" class="btn btn-secondary">Reset</a>
          </div>
        </form>
      </div>
    </div>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
      <input type="text" id="search-filter-input" placeholder="Search Report..." class="form-control search-filter-input me-2">
      <button class="btn btn-success me-2" onclick="exportTableToCSV('purchaseReportTable', 'purchase_report.csv')">
        <i class="ti ti-file-type-csv me-1"></i> Export CSV
      </button>
      <button class="btn btn-danger" onclick="exportTableToPDF()">
        <i class="ti ti-file-type-pdf me-1"></i> Export PDF
      </button>
    </div>

    <!-- Purchase Report Card -->
    <div class="card bg-white border-0 shadow-sm">
      <div class="card-header bg-white border-bottom py-3">
        <h5 class="mb-0">Purchase History (<%$from_date|date_format:"%d %b %Y"%> to <%$to_date|date_format:"%d %b %Y"%>)</h5>
      </div>
      <div class="table-responsive text-nowrap p-3">
        <table class="table table-hover table-striped" id="purchaseReportTable" width="100%">
          <thead class="bg-light">
            <tr>
              <th>Purchase No</th>
              <th>Date</th>
              <th>Supplier Name</th>
              <th>Contact</th>
              <th>Payment Mode</th>
              <th>Total Amount</th>
            </tr>
          </thead>
          <tbody class="table-border-bottom-0">
            <%assign var="grand_total" value=0%>
            <%foreach from=$purchases item=purchase%>
            <tr>
              <td>#<%$purchase.purchase_no%></td>
              <td><%$purchase.purchase_date|date_format:"%d %b %Y"%></td>
              <td><%$purchase.supplier_name|default:'-'%></td>
              <td><%$purchase.contact_number|default:'-'%></td>
              <td><%$purchase.payment_mode|default:'Cash'%></td>
              <td class="fw-bold"><%$settings.company_currency.value|default:'$'%><%$purchase.total_amount|number_format:2%></td>
            </tr>
            <%assign var="grand_total" value=$grand_total+$purchase.total_amount%>
            <%/foreach%>
          </tbody>
          <tfoot class="bg-light">
            <tr>
              <th colspan="5" class="text-end">Grand Total:</th>
              <th class="text-primary"><%$settings.company_currency.value|default:'$'%><%$grand_total|number_format:2%></th>
            </tr>
          </tfoot>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/generic_reports.js"></script>

<style>
@media print {
  .btn, .dt-top-btn, form, .sidebar, .navbar, .breadcrumb { display: none !important; }
  .card { border: none !important; box-shadow: none !important; }
  .content-wrapper { padding: 0 !important; margin: 0 !important; }
}
</style>
