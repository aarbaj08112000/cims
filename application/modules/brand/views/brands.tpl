<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-tag"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Brands</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url()%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Brands</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search brands..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-spreadsheet"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary" data-bs-toggle="modal" data-bs-target="#addBrand" title="Add Brand">
          <i class="ti ti-plus"></i> Add Brand
        </button>
      </div>
    </div>

    <!-- Add Brand Modal -->
    <div class="modal fade" id="addBrand" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Add Brand</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="<%base_url('add_brand')%>" method="POST" enctype="multipart/form-data" id="addBrandForm" class="addBrandForm custom-form">
            <div class="modal-body">
              <div class="form-group mb-3">
                <label for="brand_name">Brand Name<span class="text-danger">*</span></label>
                <input type="text" name="brand_name" placeholder="Enter Brand Name" class="form-control required-input" value="">
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
      <table id="brandsTable" class="table table-hover mb-0 w-100">
        <thead>
          <tr>
            <th class="cat-col-num" width="50">#</th>
            <th>Brand Name</th>
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
  <script src="<%$base_url%>public/js/admin_panel/brands.js"></script>
</div>
