<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">


    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing">
            <i class="ti ti-chevrons-right"></i>
            <em>Categories</em></a>
        </h1>
        <br>
        <span>Categories</span>
      </div>
    </nav>

    <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
      <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
      <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addCategoriesModal" title="Add category">
        <i class="ti ti-plus"></i>
      </button>
    </div>

    <!-- Add Category Modal -->
    <div class="modal fade" id="addCategoriesModal" tabindex="-1" role="dialog" aria-labelledby="addCategoriesModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="addCategoriesModalLabel">Add Category</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="<%base_url('add_categories')%>" method="POST" enctype="multipart/form-data" id="addCategoriesForm" class="addCategories custom-form">
            <div class="modal-body">
              <div class="form-group mb-3">
                <label for="category_name">Category Name<span class="text-danger">*</span></label>
                <input type="text" name="category_name" id="category_name" placeholder="Enter Category Name" class="form-control required-input">
              </div>

              <div class="form-group mb-3" style="display: none;">
                <label for="parent_category_id">Parent Category</label>
                <select name="parent_category_id" class="form-control select2" id="parent_category_id">
                  <option value="0" selected>Select Parent Category</option>
                  <%foreach from=$categories item=val %>
                    <option value="<%$val['category_id'] %>"><%$val['category_name'] %></option>
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



    <div class="card p-0 mt-2 w-100">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" border-color="#e1e1e1" id="categoriesTable">
          <thead>
            <tr>
              <th>Category Name</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <%if ($categories) %>
              <%assign var='i' value= 1 %>
              <%foreach from=$categories item=val %>
                <tr>
                  <td><%$val['category_name'] %></td>
                  <td style="font-weight: bold; <%if $val['status'] == 'Active' %>color: green;<%else %>color: red;<%/if %>">
                    <%$val['status'] %>
                  </td>
                  <td>
                    <a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateCategoryModal<%$i %>" title="Edit">
                      <i class="ti ti-edit edit-part"></i>
                    </a>
                    <span class="delete_data" title="Delete Record" data-id="<%$val['category_id']%>">
                      <i class="ti ti-trash"></i>
                    </span>

                    <!-- Update Category Modal -->
                    <div class="modal fade" id="updateCategoryModal<%$i %>" tabindex="-1" role="dialog" aria-labelledby="updateCategoryModalLabel<%$i %>" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="updateCategoryModalLabel<%$i %>">Update Category</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <form action="<%base_url('update_categories')%>" method="POST" enctype="multipart/form-data" id="updateCategoryForm<%$i %>" class="update_categories custom-form">
                            <input type="hidden" name="category_id" value="<%$val['category_id']%>">
                            <div class="modal-body">
                              <div class="form-group mb-3">
                                <label for="category_name_<%$i %>">Category Name<span class="text-danger">*</span></label>
                                <input type="text" name="category_name" id="category_name_<%$i %>" placeholder="Enter Category Name" class="form-control required-input" value="<%$val['category_name'] %>">
                              </div>

                              <div class="form-group mb-3" style="display: none;">
                                <label for="parent_category_id_<%$i %>">Parent Category</label>
                                <select name="parent_category_id" class="form-control select2" id="parent_category_id_<%$i %>">
                                  <option value="0" selected>Select Parent Category</option>
                                  <%foreach from=$categories item=p_val %>
                                    <option value="<%$p_val['category_id'] %>" <%if $p_val['category_id'] eq $val['parent_category_id']%>selected<%/if%>>
                                      <%$p_val['category_name'] %>
                                    </option>
                                  <%/foreach%>
                                </select>
                              </div>

                              <div class="form-group mb-3">
                                <label for="status_<%$i %>">Status<span class="text-danger">*</span></label>
                                <select name="status" class="form-control select2 required-input" id="status_<%$i %>">
                                  <option value="Active" <%if $val['status'] eq 'Active'%>selected<%/if%>>Active</option>
                                  <option value="Inactive" <%if $val['status'] eq 'Inactive'%>selected<%/if%>>Inactive</option>
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
                  </td>
                </tr>
                <%assign var='i' value=$i+1 %>
              <%/foreach%>
            <%/if%>
          </tbody>
        </table>
    </div>
  </div>

  <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
  </script>

  <script src="<%$base_url%>public/js/admin_panel/categories.js"></script>
</div>
