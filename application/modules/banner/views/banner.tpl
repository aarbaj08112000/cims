<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-photo"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Banner</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Banner</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search banners..." />
        </div>
        <button type="button" class="cat-btn cat-btn-primary" data-bs-toggle="modal" data-bs-target="#addBanner" title="Add Banner">
          <i class="ti ti-plus"></i> Add Banner
        </button>
      </div>
    </div>

      <div class="modal fade" id="addBanner" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Add Banner</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

                  </button>
               </div>
               <form action="<%base_url('add_banner')%>" method="POST" enctype="multipart/form-data" id="add_banner" class="add_banner custom-form">
               <div class="modal-body">
                  <div class="form-group">
                  </div>
                  <div class="form-group">
                  	<label for="on click url">Banner Image<span class="text-danger">*</span></label> <br>
                  	<input  type="file" name="banner_image" placeholder="Enter banner image" class="form-control required-input" >
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
            <table class="table table-hover mb-0 w-100" id="banner">
              <thead class="bg-light">
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Banner Image </th>
                    <th>Status</th>
                    <th class="text-center">Action</th>
                 </tr>
              </thead>
              <tbody>
              <%if ($banner) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$banner item=val %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                        <td><img src="<%base_url()%>public/uploads/banner/<%$val['banner_image'] %>" atr="<%$val['banner_image'] %>" width="250" height="auto" class="rounded">
                        </td>
                        
                        <td class="cat-col-status">
                           <%if $val['status'] == 'Active' %>
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
                          <span class="delete_data cursor-pointer text-danger" title="Delete Record" data-id="<%$val['banners_id']%>"><i class="ti ti-trash"></i>
                          </span>
                          </div>
                          
                        	<div class="modal fade" id="updateGroup<%$i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						         <div class="modal-dialog  modal-dialog-centered text-start" role="document">
						            <div class="modal-content">
						               <div class="modal-header">
						                  <h5 class="modal-title" id="exampleModalLabel">Update Banner</h5>
						                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

						                  </button>
						               </div>
						               <form action="<%base_url('update_banner')%>" method="POST" enctype="multipart/form-data" id="update_banner<%$i %>" class="update_banner update_banner<%$i %> custom-form">
						               	<input type="hidden" name="banners_id" value="<%$val['banners_id']%>">
						               <div class="modal-body">
                                          <div class="form-group">
                                          <label for="on click url">banner Image</label> <br>
                                          <input  type="file" name="banner_image" placeholder="Enter banner image" class="form-control ">
                                          <input  type="hidden" name="hidden_banner_image" placeholder="Enter banner image" class="form-control" value="<%$val['banner_image'] %>">
                                      </div>
                                      
										   <div class="form-group">
						                  		<label for="on click url">Status</label> <br>
						                  	 	<select name="status" class="form-control select2 " id="status">
								                	<option value="Active" <%if $val['status'] eq 'Active'%>selected<%/if%>>Active</option>
								                	<option value="Inactive" <%if $val['status'] eq 'Inactive'%>selected<%/if%>>Inactive</option>
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

    <script src="<%$base_url%>public/js/admin_panel/banner.js"></script>
