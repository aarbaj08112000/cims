<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-category-2"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Categories</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Categories</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search categories..." />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-spreadsheet"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <button type="button" class="cat-btn cat-btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoriesModal" title="Add Category">
          <i class="ti ti-plus"></i> Add Category
        </button>
      </div>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="addCategoriesModal" tabindex="-1" role="dialog"
      aria-labelledby="addCategoriesModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addCategoriesModalLabel">Add Category</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="<%base_url('add_categories')%>" method="POST" enctype="multipart/form-data"
            id="addCategoriesForm" class="addCategories custom-form">
            <div class="modal-body">
              <div class="form-group mb-3">
                <label for="category_name">Category Name<span class="text-danger">*</span></label>
                <input type="text" name="category_name" id="category_name" placeholder="Enter Category Name"
                  class="form-control required-input">
              </div>
              <div class="form-group mb-3" style="display: none;">
                <label for="parent_category_id">Parent Category</label>
                <select name="parent_category_id" class="form-control select2" id="parent_category_id">
                  <option value="0" selected>Select Parent Category</option>
                  <%foreach from=$categories item=val %>
                    <option value="<%$val['category_id'] %>">
                      <%$val['category_name'] %>
                    </option>
                  <%/foreach%>
                </select>
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
      <table id="categoriesTable" class="table table-hover mb-0 w-100">
        <thead>
          <tr>
            <th>Category Name</th>
            <th>Status</th>
            <th class="text-center">Action</th>
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
  <script src="<%$base_url%>public/js/admin_panel/categories.js"></script>
</div>