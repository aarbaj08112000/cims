<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-receipt"></i></div>
        <div>
          <h1 class="cat-page-title">Purchase Report</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Reports</span>
            <i class="ti ti-chevron-right"></i>
            <span>Purchase Report</span>
          </nav>
        </div>
      </div>
      <form method="POST" action="<%$base_url%>purchase_report" class="cat-page-header-right m-0" id="filter-form" style="display: flex; gap: 8px; align-items: center; flex-wrap: wrap;">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search report..." />
        </div>
        
        <div class="d-flex align-items-center gap-2">
            <input type="date" name="from_date" class="form-control form-control-sm" value="<%$from_date%>" required style="width: auto; height: 38px;" title="From Date" />
            <span class="text-muted">to</span>
            <input type="date" name="to_date" class="form-control form-control-sm" value="<%$to_date%>" required style="width: auto; height: 38px;" title="To Date" />
            <button type="submit" class="cat-btn cat-btn-primary" style="padding: 0 12px;">Filter</button>
        </div>

        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary" onclick="window.location.href='<%$base_url%>purchase_report'" title="Refresh">
          <i class="ti ti-refresh"></i> Refresh
        </button>
      </form>
    </div>

    <!-- Purchase Report Table -->
    <div class="cat-table-card">
      <table class="table table-hover mb-0 w-100" id="purchaseReportTable">
        <thead>
          <tr>
            <th style="white-space: nowrap;">Sr No</th>
            <th>Date</th>
            <th>Supplier Name</th>
            <th>Contact</th>
            <th>Payment Mode</th>
            <th class="text-end">Total Amount</th>
          </tr>
        </thead>
        <tbody>
          <%assign var="grand_total" value=0%>
          <%assign var="sr_no" value=1%>
          <%foreach from=$purchases item=purchase%>
          <tr>
            <td style="white-space: nowrap;"><%$sr_no++%></td>
            <td style="white-space: nowrap;"><%$purchase.purchase_date|date_format:"%d %b %Y"%></td>
            <td><%$purchase.supplier_name|default:'-'%></td>
            <td><%$purchase.contact_number|default:'-'%></td>
            <td><%$purchase.payment_mode|default:'Cash'%></td>
            <td class="text-end fw-bold"><%$purchase.total_amount|number_format:2%></td>
          </tr>
          <%assign var="grand_total" value=$grand_total+$purchase.total_amount%>
          <%/foreach%>
        </tbody>
        <tfoot>
          <tr>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th style="border-top: 1px solid var(--cat-border);"></th>
            <th class="text-end" style="border-top: 1px solid var(--cat-border);">Grand Total:</th>
            <th class="text-primary text-end" style="font-size: 1.1rem; color: #c0392b !important; border-top: 1px solid var(--cat-border);"><%$grand_total|number_format:2%></th>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/purchase_report.js"></script>
<style>
  #purchaseReportTable tfoot th {
    background-color: var(--cat-gray-50) !important;
    font-family: var(--cat-font);
    font-weight: 600;
    padding: 16px !important;
  }
  @media print {
    .cat-btn, .cat-search-box, .cat-page-header-right, form, .sidebar, .navbar, .cat-breadcrumb { display: none !important; }
    .cat-table-card { border: none !important; box-shadow: none !important; }
    .content-wrapper { padding: 0 !important; margin: 0 !important; }
  }
</style>
