
<%assign var='units' value=[] %>
<%assign var='groups_arr' value=[] %>
<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <!-- Page Header -->
   <div class="cat-page-header">
      <div class="cat-page-header-left">
         <div class="cat-page-icon">
            <i class="ti ti-users"></i>
         </div>
         <div>
            <h1 class="cat-page-title">User Management</h1>
            <nav class="cat-breadcrumb">
               <a href="<%base_url('dashboard')%>">Home</a>
               <i class="ti ti-chevron-right"></i>
               <span>User</span>
            </nav>
         </div>
      </div>
      <div class="cat-page-header-right">
         <div class="cat-search-box">
            <i class="ti ti-search"></i>
            <input type="text" id="search-filter-input" placeholder="Filter Search" />
         </div>
         <button type="button" class="cat-btn cat-btn-primary" id="btn-add-user">
            <i class="ti ti-plus"></i> Add User
         </button>
         <div class="dropdown grid-drop-down">
             <button class="cat-btn cat-btn-primary" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" title="Export">
               <i class=" la-list-ul ti ti-arrow-down-from-arc" ></i>
             </button>
             <ul class="dropdown-menu p-0 mt-1 export-drop-down" aria-labelledby="dropdownMenuButton1" >
               <li class="csv"  id="downloadExcelBtn" title="Excel"><label class="hide">Excel</label> <i class="ti ti-file-spreadsheet" style="color: black"></i></li>
               <li class="pdf " id="downloadPDFBtn" title="PDF"><label class="hide">PDF</label><i class="ti ti-file-type-pdf" style="color: black"></i></li>
             </ul>
         </div>
         <div class="dropdown grid-drop-down">
             <button class="cat-btn cat-btn-primary" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
               <i class=" la-list-ul ti ti-list-details" ></i>
             </button>
             <ul class="dropdown-menu p-0 mt-1 toggle-grid-btn" aria-labelledby="dropdownMenuButton2" >
               <li class="table active" data-value="Table"><label>Table</label> <i class="las la-stream" style="color: black"></i></li>
               <li class="grid " data-value="Grid"><label>Grid</label><i class="las la-border-all" style="color: black"></i></li>
             </ul>
         </div>
      </div>
   </div>

   <div class="content-wrapper" >
      <!-- Main content -->
      <section class="content">
         <div>
            <!-- Small boxes (Stat box) -->
            <div class="row">
               
               <div class="col-lg-12">
                                    <!-- User Form Offcanvas Sidebar -->
                  <div class="offcanvas offcanvas-end" tabindex="-1" id="userOffcanvas" aria-labelledby="userOffcanvasLabel">
                     <div class="offcanvas-header border-bottom">
                        <h5 id="userOffcanvasLabel" class="offcanvas-title">Add User</h5>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                     </div>
                     <form action="<%base_url('user/user/addUsersData') %>" method="POST" enctype="multipart/form-data" id="userForm">
                        <div class="offcanvas-body flex-grow-1">
                           <input type="hidden" name="user_id" id="user_id" value="">
                           <div class="form-group mb-3">
                              <label for="user_name">User Full Name<span class="text-danger">*</span></label>
                              <input required type="text" name="user_name" id="user_name" placeholder="Enter Full Name" class="form-control" value="" autocomplete="new-password">
                           </div>
                           <div class="form-group mb-3">
                              <label for="user_email">User Email<span class="text-danger">*</span></label>
                              <input required type="email" name="user_email" id="user_email" placeholder="Enter Email" class="form-control" value="" autocomplete="new-password">
                           </div>
                           <div class="form-group mb-3" id="password_container">
                              <label for="user_password">User Password<span class="text-danger">*</span></label>
                              <input required type="password" name="user_password" id="user_password" placeholder="Enter Password" class="form-control" value="" autocomplete="new-password">
                           </div>
                           <div class="form-group mb-3">
                              <label for="user_role">User Role<span class="text-danger">*</span></label>
                              <select name="user_role" id="user_role" class="form-control select2">
                                 <option value="">Select Role</option>
                                 <%foreach from=$groups item='group' %>
                                 <option value="<%$group['group_master_id']%>"><%$group['group_name']%></option>
                                 <%/foreach%>
                              </select>
                           </div>
                           <div class="form-group mb-3 unit-box d-none">
                              <label>Unit<span class="text-danger">*</span></label>
                              <div class="row">
                                 <%foreach from=$client item='client_val' %>
                                 <div class="col-4">
                                    <input type="checkbox" class="check-box " name="client[]" value="<%$client_val['id']%>">
                                    <label class="ms-1"><%$client_val['client_unit']%></label>
                                 </div>
                                 <%/foreach%>
                              </div>
                           </div>
                           <div class="form-group mb-3 d-none" id="status_container">
                              <label for="user_status" class="w-100">Status<span class="text-danger">*</span></label>
                              <select name="status" id="user_status" class="form-control">
                                 <option value="Active">Active</option>
                                 <option value="Inactive">Inactive</option>
                                 <option value="Block">Block</option>
                              </select>
                           </div>
                        </div>
                        <div class="offcanvas-footer border-top p-3 text-end">
                           <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                     </form>
                  </div>

                  <div class="cat-table-card w-100">
                     <!-- /.card-header -->
                     <div class="table-responsive text-nowrap">
                        <table id="erp_users" class="table table-striped w-100">
                           <thead>
                              <tr>
                                 <th>Full Name</th>
                                 <th>Email</th>
                                 <th>Password</th>
                                 <th>Role</th>
                                 <th>Status</th>
                                 <th>Action</th>
                              </tr>
                           </thead>
                           <tbody>
                              <%if (true) %>
                              <%assign var='i' value=1 %>
                              <%foreach from=$user_info item=u %>
                              <tr>
                                 <%assign var='units' value=explode(",",$u['unit_ids']|default:"")%>
                                 <%assign var='groups_arr' value=explode(",",$u['groups']|default:"")%>
                                 <td><%$u['user_name'] %></td>
                                 <td><%$u['user_email'] %></td>
                                 <td><%$u['user_password'] %></td>
                                 <td><%$u['group_name'] %></td>
                                 <td><%$u['status'] %></td>
                                 <td>
                                    <a href="javascript:void(0)" class="edit-user-btn" data-id="<%$u['id']%>" data-name="<%$u['user_name']%>" data-email="<%$u['user_email']%>" data-role="<%$u['user_role']%>" data-status="<%$u['status']%>"><i class="ti ti-edit"></i></a>

                                 </td>
                              </tr>
                              <%assign var='i' value=$i+1 %>
                              <%/foreach%>
                              <%/if%>
                           </tbody>
                        </table>
                     </div>
                     <!-- /.card-body -->
                  </div>
                  <!-- ./col -->
               </div>
            </div>
            <!-- /.row -->
             <!-- /.row (main row) -->
          </div>
          <!-- /.container-fluid -->
       </section>
       <!-- /.content -->
    </div>

   
   <div class="modal fade" id="accessGroups" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">Page Access</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
               </button>
            </div>
            <div class="modal-body">
               <div class="row">
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
</div>
<style type="text/css">
   input.check-box{
   width: 18px;
   height: 15px;
   cursor: pointer;
   }
   .menu-form-row {
   margin-top: 5px;
   padding-top: 5px;
   padding-bottom: 5px;
   width: 100%;
   position: relative;
   }
   .menu-form-row .form-label{
   float: left;
   width: 100% !important;
   }
   .menu-form-row .form-label lable{
   font-style: normal !important;
   display: block;
   margin-top: 3px;
   font-size: 17px;
   color: #919396;
   font-family: 'GilroySemibold', sans-serif !important;
   }
   .menu-form-row .form-right-div {
   margin: 10px 6px 10px 13px;
   float: left;
   width: 100% !important;
   }
   .menu-form-row .margin-equilize {
   float: left;
   width: 20%;
   }
   .menu-form-row .margin-equilize label{
   font-size: 17px;
   color: #000;
   margin: 0px 0px 2px 8px;
   }
   .menu-form-row .margin-equilize input{
   width: 17px;
   height: 15px;
   cursor: pointer;
   }
   #accessGroups .modal-body {
   padding: 0 20px 0 20px;
   max-height: 433px !important;
   overflow-y: scroll;
   overflow-x: clip;
   }
   .pointer-none{
   pointer-events: none;
   }
   .select2-container--default .select2-selection--multiple .select2-selection__choice {
   background-color: var(--bs-theme-light4-color) !important;
   }
</style>
<script type="text/javascript">
   var base_url = <%$base_url|@json_encode%>;
   var no_data_message = <%$no_data_message|@json_encode%>;
   var module_name = "User";
</script>
<script src="<%$base_url%>public/js/admin/user_list.js?v=11"></script>