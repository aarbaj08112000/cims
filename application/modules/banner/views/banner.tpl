
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Banner</em></a>
          </h1>
          <br>
          <span >Banner</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
        <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addBanner" title="Add Banner">
       <i class="ti ti-plus"></i>
        </button>
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
      <div class="card p-0 mt-4 w-100">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" border-color="#e1e1e1" id="banner">
              <thead>
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Banner Image </th>
                    <th>Status</th>
                    <th>Action</th>
                 </tr>
              </thead>
              <tbody>
              <%if ($banner) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$banner item=val %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                        <td><img src="<%base_url()%>public/uploads/banner/<%$val['banner_image'] %>" atr="<%$val['banner_image'] %>" width="250" height="auto">
                        </td>
                        
                        <td style="font-weight: bold; 
                            <%if $val['status'] == 'Active' %>color: green;<%else %>color: red;<%/if %>">
                            <%$val['status'] %>
                        </td>
                        <td>
                          
                        	<a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateGroup<%$i %>" title="Edit">
                            <i class="ti ti-edit edit-part" ></i>
                          </a>
                          <span class="delete_data" title="Delete Record" data-id="<%$val['banners_id']%>"><i class="ti ti-trash"></i>
                          </span>
                          
                        	<div class="modal fade" id="updateGroup<%$i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						         <div class="modal-dialog  modal-dialog-centered " role="document">
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
        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->


      <div class="content-backdrop fade"></div>
    </div>


    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <script src="<%$base_url%>public/js/admin_panel/banner.js">"></script>
