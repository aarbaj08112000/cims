
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Customer</em></a>
          </h1>
          <br>
          <span >Customer Listing</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
        <a href="add_customer" ><button type="button" class="btn btn-seconday"  title="Add Customer">
        <i class="ti ti-plus"></i></button></a>
      </div>
      
      


      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" border-color="#e1e1e1" id="customerListTable">
              <thead>
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Image</th>
                    <th>Customer Number</th>
                    <th>Name</th>
                    <th>Email </th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Action</th>
                 </tr>
              </thead>
              <tbody>
                 <%if ($customer) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$customer item=u %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                       
                        <td>
                           <%if file_exists("public/uploads/customer/<%$u.customer_id%>/profile/<%$u.profile_photo%>") && $u.profile_photo != ""%>
                              <img src="public/uploads/customer/<%$u.customer_id%>/profile/<%$u.profile_photo%>" 
                                  alt="Profile" 
                                  style="max-width: 75px; height: auto;">
                          <%else%>
                              <img src="public/uploads/no_profile_image.png" 
                                  alt="No Profile" 
                                  style="max-width: 75px; height: auto;">
                          <%/if%>

                        </td>

                        <td><%$u['customer_number'] %></td>
                        <td><%$u['full_name'] %></td>
                        <td><%$u['email'] %></td>
                        <td><%$u['mobile_number'] %></td>
                        
                        <td style="font-weight: bold; 
                        <%if $u['status'] == 'Active' %>color: green;<%else %>color: red;<%/if %>">
                        <%$u['status'] %>
                    </td>
                        <td class="text-center">
                        <span class="delete_data" title="Delete Record" data-id="<%$u['customer_id']%>"><i class="ti ti-trash"></i>
                        </span>
                       
                        	<a href="update_customer/<%$u['customer_id']%>" title="Edit">
                            <i class="ti ti-edit edit-part" ></i>
                          </a>
                        	<a href="customer_detail/<%$u['customer_id']%>" title="Edit">
                           <i class="ti ti-eye view-part"></i>
                          </a>
                          <br>
                          <a href="customer_invoice/<%$u['customer_id']%>" title="Invoice" >
                            <i class="ti ti-file-invoice" style="color: #e09718;"></i> 
                          </a>

                          <a href="javascript:void(0);" class="view-products-payment" 
                            data-id="<%$u['customer_id']%>" 
                            title="Take Payment / View Products">
                            <i class="ti ti-wallet text-primary"></i>
                          </a>

                      
                        </td>
                     </tr>
                  <%assign var='i' value=$i+1 %>
                  <%/foreach%>
                  <%/if%>
              </tbody>
           </table>

           <!-- Modal Structure -->
          <div class="modal fade" id="productPaymentModal" tabindex="-1" aria-labelledby="productPaymentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="productPaymentModalLabel"> Product | Payment | Invoice</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body position-relative">
                 <div id="modelAlertBox" style="  z-index: 1055;" class="alert model-error d-none position-absolute top-5 start-0 end-0 mx-3 mt-3 z-3" role="alert">
                  
                </div>
                 <div id="modalContentArea">
                  <!-- Your dynamic content (form, etc.) -->
                </div>
                </div>
              </div>
            </div>
          </div>

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

    <script src="<%$base_url%>public/js/admin_panel/add_customer.js"></script>
