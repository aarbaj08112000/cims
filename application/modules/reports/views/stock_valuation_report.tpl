<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-chart-bar"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Stock Valuation Report</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url()%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Reports</span>
            <i class="ti ti-chevron-right"></i>
            <span>Stock Valuation Report</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search report..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-spreadsheet"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary" onclick="location.reload()" title="Refresh">
          <i class="ti ti-refresh"></i> Refresh
        </button>
      </div>
    </div>

    <!-- Table Card -->
    <div class="cat-table-card">
        <table class="table table-hover mb-0 w-100" id="stockValuationTable">
          <thead>
            <tr>
              <th style="width: 150px; white-space: nowrap;">Product Code</th>
              <th>Product Name</th>
              <th>Category</th>
              <th>Brand</th>
              <th class="text-center">Current Qty</th>
              <th>Purchase Price</th>
              <th>Total Value</th>
            </tr>
          </thead>
          <tbody>
            <%assign var="grand_total" value=0%>
            <%foreach from=$stock item=item%>
            <%assign var="item_value" value=$item.qty*$item.purchase_price%>
            <tr>
              <td style="white-space: nowrap;"><%$item.product_code%></td>
              <td class="cat-col-name"><%$item.product_name%></td>
              <td><%$item.category_name|default:'-'%></td>
              <td><%$item.brand_name|default:'-'%></td>
              <td class="text-center"><span class="cat-badge cat-badge-active"><%$item.qty%></span></td>
              <td><%$item.purchase_price|number_format:2%></td>
              <td class="fw-bold"><%$item_value|number_format:2%></td>
            </tr>
            <%assign var="grand_total" value=$grand_total+$item_value%>
            <%/foreach%>
          </tbody>
          <tfoot>
            <tr>
              <th style="border-top: 1px solid var(--cat-border);"></th>
              <th style="border-top: 1px solid var(--cat-border);"></th>
              <th style="border-top: 1px solid var(--cat-border);"></th>
              <th style="border-top: 1px solid var(--cat-border);"></th>
              <th style="border-top: 1px solid var(--cat-border);"></th>
              <th class="text-end" style="border-top: 1px solid var(--cat-border);">Total Inventory Value:</th>
              <th class="text-primary" style="font-size: 1.1rem; color: #c0392b !important; border-top: 1px solid var(--cat-border);"><%$grand_total|number_format:2%></th>
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
/* Custom Footer Styling specifically for Stock Valuation Report */
#stockValuationTable tfoot th {
  background-color: var(--cat-gray-50) !important;
  font-family: var(--cat-font);
  font-weight: 600;
  padding: 16px !important;
}
</style>
