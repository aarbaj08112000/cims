<link rel="stylesheet" href="<%base_url()%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-activity"></i>
        </div>
        <div>
          <h1 class="cat-page-title">User Activity Log</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevrons-right"></i>
            <span>User Management</span>
            <i class="ti ti-chevrons-right"></i>
            <span>Activity Log</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search Logs..." />
        </div>
        <button type="button" id="export-excel" class="cat-btn cat-btn-outline" title="Export Excel">
          <i class="ti ti-file-spreadsheet"></i> Export Excel
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
      </div>
    </div>

    <!-- Table Card -->
    <div class="cat-table-card">
      <div class="table-responsive"><table class="table table-hover mb-0 w-100" id="activity_logs_table">
        <thead>
          <tr>
            <th width="5%">ID</th>
            <th width="15%">Date &amp; Time</th>
            <th width="15%">User</th>
            <th width="15%">Module</th>
            <th width="35%">Action &amp; Description</th>
            <th width="15%">IP Address</th>
          </tr>
        </thead>
        <tbody>
          <!-- Datatables populated -->
        </tbody>
      </table></div>
     </div>
  </div>

  <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>;
  </script>
  <script src="<%base_url()%>public/js/admin_panel/activity_logs.js?v=1789814160"></script>
</div>