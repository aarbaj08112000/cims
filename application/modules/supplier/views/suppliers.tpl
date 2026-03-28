<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Suppliers</em></a>
          </h1>
          <br>
          <span >Manage Suppliers</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
        <input type="text" id="search-filter-input" placeholder="Search Suppliers..." class="form-control search-filter-input me-2">
        <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addSupplier" title="Add Supplier">
           <i class="ti ti-plus"></i> Add Supplier
        </button>
      </div>

      <!-- Add Supplier Modal -->
      <div class="modal fade" id="addSupplier" tabindex="-1" role="dialog" aria-labelledby="addSupplierLabel" aria-hidden="true">
         <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="addSupplierLabel">Add New Supplier</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <form action="<%base_url('add_supplier')%>" method="POST" id="addSupplierForm" class="custom-form">
               <div class="modal-body">
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <div class="form-group">
                        <label for="supplier_name">Supplier Name<span class="text-danger">*</span></label>
                        <input type="text" name="supplier_name" placeholder="Enter Supplier Name" class="form-control required-input">
                      </div>
                    </div>
                    <div class="col-md-6 mb-3">
                      <div class="form-group">
                        <label for="contact_person">Contact Person</label>
                        <input type="text" name="contact_person" placeholder="Enter Contact Person" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" name="email" placeholder="Enter Email" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6 mb-3">
                      <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" name="phone" placeholder="Enter Phone Number" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <div class="form-group">
                        <label for="gst_number">GST Number</label>
                        <input type="text" name="gst_number" placeholder="Enter GST Number" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6 mb-3">
                      <div class="form-group">
                        <label for="status">Status</label>
                        <select name="status" class="form-control select2">
                          <option value="Active">Active</option>
                          <option value="Inactive">Inactive</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="address">Address</label>
                    <textarea name="address" placeholder="Enter Address" class="form-control" rows="3"></textarea>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Save Supplier</button>
               </div>
               </form>
            </div>
         </div>
      </div>



      <div class="card p-0 mt-0 w-100">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" id="suppliersTable">
            <thead>
               <tr>
                  <th>Supplier Name</th>
                  <th>Contact Person</th>
                  <th>Phone</th>
                  <th>GST Number</th>
                  <th>Status</th>
                  <th>Action</th>
               </tr>
            </thead>
            <tbody>
            <%if ($suppliers) %>
              <%assign var='i' value= 1 %>
              <%foreach from=$suppliers item=val %>
               <tr>
                  <td><%$val['supplier_name'] %></td>
                  <td><%$val['contact_person']|default:'N/A' %></td>
                  <td><%$val['phone']|default:'N/A' %></td>
                  <td><%$val['gst_number']|default:'N/A' %></td>
                  <td>
                    <span class="badge <%if $val['status'] == 'Active' %>bg-label-success<%else %>bg-label-danger<%/if %>">
                      <%$val['status'] %>
                    </span>
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <a href="javascript:void(0)" class="me-2" data-bs-toggle="modal" data-bs-target="#editSupplier<%$i %>" title="Edit">
                        <i class="ti ti-edit text-primary"></i>
                      </a>
                      <a href="javascript:void(0)" class="delete_supplier" data-id="<%$val['supplier_id']%>" title="Delete">
                        <i class="ti ti-trash text-danger"></i>
                      </a>
                    </div>
                    
                    <!-- Edit Supplier Modal -->
                    <div class="modal fade" id="editSupplier<%$i %>" tabindex="-1" role="dialog" aria-hidden="true">
                      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title">Update Supplier</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <form action="<%base_url('update_supplier')%>" method="POST" id="editSupplierForm<%$i %>" class="update-supplier-form custom-form">
                            <input type="hidden" name="supplier_id" value="<%$val['supplier_id']%>">
                            <div class="modal-body text-wrap">
                              <div class="row">
                                <div class="col-md-6 mb-3">
                                  <div class="form-group text-start">
                                    <label>Supplier Name<span class="text-danger">*</span></label>
                                    <input type="text" name="supplier_name" class="form-control required-input" value="<%$val['supplier_name'] %>">
                                  </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                  <div class="form-group text-start">
                                    <label>Contact Person</label>
                                    <input type="text" name="contact_person" class="form-control" value="<%$val['contact_person'] %>">
                                  </div>
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-md-6 mb-3">
                                  <div class="form-group text-start">
                                    <label>Email</label>
                                    <input type="email" name="email" class="form-control" value="<%$val['email'] %>">
                                  </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                  <div class="form-group text-start">
                                    <label>Phone</label>
                                    <input type="text" name="phone" class="form-control" value="<%$val['phone'] %>">
                                  </div>
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-md-6 mb-3">
                                  <div class="form-group text-start">
                                    <label>GST Number</label>
                                    <input type="text" name="gst_number" class="form-control" value="<%$val['gst_number'] %>">
                                  </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                  <div class="form-group text-start">
                                    <label>Status</label>
                                    <select name="status" class="form-control select2">
                                      <option value="Active" <%if $val['status'] == 'Active' %>selected<%/if%>>Active</option>
                                      <option value="Inactive" <%if $val['status'] == 'Inactive' %>selected<%/if%>>Inactive</option>
                                    </select>
                                  </div>
                                </div>
                              </div>
                              <div class="form-group text-start">
                                <label>Address</label>
                                <textarea name="address" class="form-control" rows="3"><%$val['address'] %></textarea>
                              </div>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                              <button type="submit" class="btn btn-primary">Update Supplier</button>
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

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/suppliers.js"></script>
