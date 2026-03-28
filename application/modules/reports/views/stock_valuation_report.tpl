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
        <span>Stock Valuation Report</span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
      <input type="text" id="search-filter-input" placeholder="Search Report..." class="form-control search-filter-input me-2">
       <button class="btn btn-success me-2" onclick="exportTableToCSV('stockValuationTable', 'stock_valuation_report.csv')">
        <i class="ti ti-file-type-csv me-1"></i> Export CSV
      </button>
      <button class="btn btn-danger" onclick="exportTableToPDF()">
        <i class="ti ti-file-type-pdf me-1"></i> Export PDF
      </button>
    </div>

    <div class="card p-0 mt-0 w-100">
        <table class="table table-hover table-striped text-nowrap" id="stockValuationTable" width="100%">
          <thead>
            <tr>
              <th>Product Code</th>
              <th>Product Name</th>
              <th>Category</th>
              <th>Brand</th>
              <th>Current Qty</th>
              <th>Purchase Price</th>
              <th>Total Value</th>
            </tr>
          </thead>
          <tbody class="table-border-bottom-0">
            <%assign var="grand_total" value=0%>
            <%foreach from=$stock item=item%>
            <%assign var="item_value" value=$item.qty*$item.purchase_price%>
            <tr>
              <td><%$item.product_code%></td>
              <td><%$item.product_name%></td>
              <td><%$item.category_name|default:'-'%></td>
              <td><%$item.brand_name|default:'-'%></td>
              <td class="text-center"><%$item.qty%></td>
              <td><%$settings.company_currency.value|default:'$'%><%$item.purchase_price|number_format:2%></td>
              <td class="fw-bold"><%$settings.company_currency.value|default:'$'%><%$item_value|number_format:2%></td>
            </tr>
            <%assign var="grand_total" value=$grand_total+$item_value%>
            <%/foreach%>
          </tbody>
          <tfoot>
            <tr>
              <th colspan="6" class="text-end">Total Inventory Value:</th>
              <th class="text-primary"><%$settings.company_currency.value|default:'$'%><%$grand_total|number_format:2%></th>
            </tr>
          </tfoot>
        </table>
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/stock_valuation_report.js"></script>

<style>
/* Sticky Header for this specific table */
#stockValuationTable thead th {
  position: -webkit-sticky;
  position: sticky;
  top: 62px !important; /* Align with navbar */
  z-index: 110;
  background-color: #f8f7fa !important;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08) !important;
}

/* Sticky Footer (Total Row) with slim, professional look */
#stockValuationTable tfoot tr {
  position: -webkit-sticky;
  position: sticky;
  bottom: 0px;
  z-index: 105;
}

#stockValuationTable tfoot th {
  background-color: #fef2f2 !important; /* Very subtle light pink */
  color: #c0392b !important; /* Professional dark red */
  box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.08) !important;
  background-clip: padding-box;
  padding: 0.875rem 1rem !important; /* Matching header padding */
  border-top: 1px solid #f8d7da !important;
  font-weight: 700 !important;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

#stockValuationTable tfoot th.text-primary {
  color: #c0392b !important;
  font-size: 1.1rem;
}

/* Ensure report card doesn't force a large gap between data and footer */
.content-wrapper:has(#stockValuationTable) .card .dataTables_wrapper {
    max-height: none !important;
    display: block !important;
}

.content-wrapper:has(#stockValuationTable) .card .dt-scroll-body-wrapper {
    flex: none !important;
    max-height: calc(100vh - 280px) !important;
    overflow-y: auto !important;
}

@media print {
  .btn, .dt-top-btn, .sidebar, .navbar, .breadcrumb { display: none !important; }
  .card { border: none !important; box-shadow: none !important; }
  .content-wrapper { padding: 0 !important; margin: 0 !important; }
}
</style>
