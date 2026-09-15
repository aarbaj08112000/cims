<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-ruler-measure"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Unit Master</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Unit Master</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search units..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-spreadsheet"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary" data-bs-toggle="modal" data-bs-target="#addUnit" title="Add Unit">
          <i class="ti ti-plus"></i> Add Unit
        </button>
      </div>
    </div>

    <!-- Add Unit Modal -->
    <div class="modal fade" id="addUnit" tabindex="-1" role="dialog" aria-labelledby="addUnitLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addUnitLabel">Add Unit</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="<%base_url('add_unit')%>" method="POST" enctype="multipart/form-data" id="addUnitForm" class="addUnitForm custom-form">
            <div class="modal-body">
              <div class="form-group mb-3">
                <label for="unit_name">Unit Name<span class="text-danger">*</span></label>
                <input type="text" name="unit_name" placeholder="e.g. Piece, Kg, Litre" class="form-control required-input" value="">
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Save changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Table Card -->
    <div class="cat-table-card">
      <table id="unitsTable" class="table table-hover mb-0 w-100">
        <thead>
          <tr>
            <th>Unit Name</th>
            <th class="text-left">Unit Code</th>
            <th width="140">Status</th>
            <th width="160" class="text-center">Action</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>

  </div>

  <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
  </script>
  <script src="<%$base_url%>public/js/admin_panel/unit_master.js"></script>
</div>
