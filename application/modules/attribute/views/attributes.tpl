<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-adjustments"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Attributes</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Attributes</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search attributes..." />
        </div>
        <button type="button" id="export-excel" class="cat-btn cat-btn-outline" title="Export Excel">
          <i class="ti ti-file-spreadsheet"></i> Export Excel
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary" data-bs-toggle="modal" data-bs-target="#addAttribute" title="Add Attribute">
          <i class="ti ti-plus"></i> Add Attribute
        </button>
      </div>
    </div>

    <!-- Add Attribute Modal -->
    <div class="modal fade" id="addAttribute" tabindex="-1" role="dialog" aria-labelledby="addAttributeLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addAttributeLabel">Add Attribute</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="<%base_url('add_attribute')%>" method="POST" enctype="multipart/form-data" id="addAttributeForm" class="addAttributeForm custom-form">
            <div class="modal-body">
              <div class="form-group mb-3">
                <label for="attribute_name">Attribute Name<span class="text-danger">*</span></label>
                <input type="text" name="attribute_name" placeholder="Enter Attribute Name" class="form-control required-input" value="">
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
      <table id="attributesTable" class="table table-hover mb-0 w-100">
        <thead>
          <tr>
            <th>Attribute Name</th>
            <th>Attribute Code</th>
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
  <script src="<%$base_url%>public/js/admin_panel/attributes.js?v=4"></script>
</div>
