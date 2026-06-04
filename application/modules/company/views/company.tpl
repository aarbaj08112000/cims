<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-building"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Company</h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Company Listing</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Filter Search" />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <a href="add_company" class="cat-btn cat-btn-primary text-white" title="Add Company">
          <i class="ti ti-plus"></i> Add Company
        </a>
      </div>
    </div>

    <!-- Main content -->
    <div class="cat-table-card">
      <table class="table table-hover mb-0 w-100" id="companyListTable">
        <thead class="bg-light">
           <tr>
              <th class="cat-col-num">#</th>
              <th>Image</th>
              <th>Company Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>GST Number</th>
              <th>Status</th>
              <th class="text-center">Action</th>
           </tr>
        </thead>
              <tbody>
                 <%if ($company) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$company item=u %>
                     <tr>
                        <td class="text-center cat-row-num"><span class="cat-row-num"><%$i %></span></td>
                        <td>
                           <img src="public/uploads/company/<%$u['company_id']%>/logo/<%$u['company_logo']%>" onerror="this.src='public/assets/images/no_image.jpg';" alt="" style="max-width: 75px; height: auto;">
                        </td>
                        <td><%$u['company_name'] %></td>
                        <td><%$u['email'] %></td>
                        <td><%$u['phone'] %></td>
                        <td><%$u['gst_number'] %></td>
                        <td class="cat-col-status">
                          <%if $u['status'] == 'Active' %>
                            <span class="cat-badge cat-badge-active">Active</span>
                          <%else %>
                            <span class="cat-badge cat-badge-inactive">Inactive</span>
                          <%/if %>
                        </td>
                        <td class="text-center cat-col-action">
                          <div class="d-flex align-items-center justify-content-center">
                              <a href="update_company/<%$u['company_id']%>" class="me-2" title="Edit">
                                <i class="ti ti-edit text-primary"></i>
                              </a>
                              <a href="javascript:void(0)" class="delete_data" title="Delete Record" data-id="<%$u['company_id']%>">
                                <i class="ti ti-trash text-danger"></i>
                              </a>
                          </div>
                        </td>
                     </tr>
                  <%assign var='i' value=$i+1 %>
                  <%/foreach%>
                  <%/if%>
              </tbody>
           </table>
          </div>
        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->


      <div class="content-backdrop fade"></div>
    </div>


    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <script src="<%$base_url%>public/js/admin_panel/company.js"></script>
