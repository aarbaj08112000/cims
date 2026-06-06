<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-users"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Group Master</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>User Management</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search groups..." />
        </div>
        <button type="button" class="cat-btn cat-btn-primary" data-bs-toggle="modal" data-bs-target="#addPromo" title="Add Group">
          <i class="ti ti-plus"></i> Add Group
        </button>
      </div>
    </div>

      <div class="modal fade" id="addPromo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Add Group</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

                  </button>
               </div>
               <form action="<%base_url('user/user/addGroupMaster')%>" method="POST" enctype="multipart/form-data" id="add_group" class="add_group custom-form">
               <div class="modal-body">
                  <div class="form-group">
                  </div>
                  <div class="form-group">
                  	<label for="on click url">Group Name<span class="text-danger">*</span></label> <br>
                  	<input  type="text" name="group_name" placeholder="Enter Group Name" class="form-control required-input" value="" >
                  </div>
                  <div class="form-group">
                  	<label for="on click url">Group Code<span class="text-danger">*</span></label> <br>
                  	<input  type="text" name="group_code" id="group_code" placeholder="Enter Group Code" class="form-control required-input" value="" >
                  </div>

				   <div class="form-group">
                  		<label for="on click url">Status<span class="text-danger">*</span></label> <br>
                  	 	<select name="status" class="form-control select2 required-input" id="status">
		                	<option value="Active">Active</option>
		                	<option value="Inactive">Inactive</option>
		             	</select>
                  	</div>
               </div>
               <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
               <button type="submit" class="btn btn-primary">Save changes</button>
               </form>
               </div>
            </div>
         </div>
      </div>


      <!-- Main content -->
      <div class="cat-table-card w-100">
            <table class="table table-hover mb-0 w-100" id="process">
              <thead class="bg-light">
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Group Name</th>
                    <th>Group Code</th>
                    <th>Status</th>
                    <th class="text-center">Action</th>
                 </tr>
              </thead>
              <tbody>
                 <%if ($groups) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$groups item=u %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                        <td><a href="<%base_url('group_menu')%>?id=<%$u['group_master_id']%>" class="text-primary fw-medium"><%$u['group_name'] %></a></td>
                        <td><%$u['group_code'] %></td>
                        <td class="cat-col-status">
                           <%if $u['status'] == 'Active' %>
                              <span class="cat-badge cat-badge-active"><span class="cat-badge-dot"></span>Active</span>
                           <%else %>
                              <span class="cat-badge cat-badge-inactive"><span class="cat-badge-dot"></span>Inactive</span>
                           <%/if %>
                        </td>
                        <td class="text-center cat-col-action">
                          <div class="d-flex align-items-center justify-content-center">
                        	<a type="button" class="me-2" data-bs-toggle="modal" data-bs-target="#updateGroup<%$i %>" title="Edit">
					       		<i class="ti ti-edit text-primary" ></i>
					        </a>
                          </div>
                        	<div class="modal fade" id="updateGroup<%$i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						         <div class="modal-dialog  modal-dialog-centered text-start" role="document">
						            <div class="modal-content">
						               <div class="modal-header">
						                  <h5 class="modal-title" id="exampleModalLabel">Update Group</h5>
						                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

						                  </button>
						               </div>
						               <form action="<%base_url('user/user/updateGroupMaster')%>" method="POST" enctype="multipart/form-data" id="update_group<%$i %>" class="update_group update_group<%$i %> custom-form">
						               	<input type="hidden" name="group_master_id" value="<%$u['group_master_id']%>">
						               <div class="modal-body">
						                  <div class="form-group">
						                  </div>
						                  <div class="form-group">
						                  	<label for="on click url">Group Name<span class="text-danger">*</span></label> <br>
						                  	<input  type="text" name="group_name" placeholder="Enter Group Name" class="form-control required-input" value="<%$u['group_name'] %>" >
						                  </div>
						                  <div class="form-group">
						                  	<label for="on click url">Group Code<span class="text-danger">*</span></label> <br>
						                  	<input  type="text" name="group_code" id="group_code" placeholder="Enter Group Code" class="form-control required-input" value="<%$u['group_code'] %>" disabled>
						                  </div>

										   <div class="form-group">
						                  		<label for="on click url">Status<span class="text-danger">*</span></label> <br>
						                  	 	<select name="status" class="form-control select2 required-input" id="status">
								                	<option value="Active" <%if $u['status'] eq 'Active'%>selected<%/if%>>Active</option>
								                	<option value="Inactive" <%if $u['status'] eq 'Inactive'%>selected<%/if%>>Inactive</option>
								             	</select>
						                  	</div>
						               </div>
						               <div class="modal-footer">
						               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						               <button type="submit" class="btn btn-primary">Save changes</button>
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
      <!-- /.col -->


      <div class="content-backdrop fade"></div>
    </div>


    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <script src="<%$base_url%>public/js/admin/group_master.js"></script>
