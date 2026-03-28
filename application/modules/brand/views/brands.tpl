
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Brands</em></a>
          </h1>
          <br>
          <span >Brands</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
        <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
        <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addBrand" title="Add Brand">
       <i class="ti ti-plus"></i>
        </button>
      </div>

      <div class="modal fade" id="addBrand" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog  modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Add Brand</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <form action="<%base_url('add_brand')%>" method="POST" enctype="multipart/form-data" id="addBrandForm" class="addBrandForm custom-form">
               <div class="modal-body">
                  <div class="form-group">
                  	<label for="brand_name">Brand Name<span class="text-danger">*</span></label> <br>
                  	<input  type="text" name="brand_name" placeholder="Enter Brand Name" class="form-control required-input" value="" >
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



      <div class="card p-0 mt-0 w-100">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" border-color="#e1e1e1" id="brandsTable">
              <thead>
                 <tr>
                    <th>Brand Name</th>
                    <th>Status</th>
                    <th>Action</th>
                 </tr>
              </thead>
              <tbody>
              <%if ($brands) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$brands item=val %>
                     <tr>
                        <td><%$val['brand_name'] %></td>
                        <td style="font-weight: bold; <%if $val['status'] == 'Active' %>color: green;<%else %>color: red;<%/if %>">
                            <%$val['status'] %>
                        </td>
                        <td>
                        	<a type="button" class="" data-bs-toggle="modal" data-bs-target="#updateBrand<%$i %>" title="Edit">
					       		<i class="ti ti-edit edit-part" ></i>
					        </a>
                            <span class="delete_data" title="Delete Record" data-id="<%$val['brand_id']%>"><i class="ti ti-trash"></i></span>
                        	
                        	<div class="modal fade" id="updateBrand<%$i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						         <div class="modal-dialog  modal-dialog-centered" role="document">
						            <div class="modal-content">
						               <div class="modal-header">
						                  <h5 class="modal-title" id="exampleModalLabel">Update Brand</h5>
						                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						               </div>
						               <form action="<%base_url('update_brands')%>" method="POST" enctype="multipart/form-data" id="update_brands<%$i %>" class="update_brands update_brands<%$i %> custom-form">
						               	<input type="hidden" name="brand_id" value="<%$val['brand_id']%>">
						               <div class="modal-body">
						                  <div class="form-group">
						                  	<label for="brand_name">Brand Name<span class="text-danger">*</span></label> <br>
						                  	<input  type="text" name="brand_name" placeholder="Enter Brand Name" class="form-control required-input" value="<%$val['brand_name'] %>" >
						                  </div>
										   <div class="form-group">
						                  		<label for="status">Status<span class="text-danger">*</span></label> <br>
						                  	 	<select name="status" class="form-control select2 required-input" id="update_status<%$i %>">
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
      </div>
      <div class="content-backdrop fade"></div>
    </div>

    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>
    <script src="<%$base_url%>public/js/admin_panel/brands.js"></script>
