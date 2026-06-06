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
          <h1 class="cat-page-title">Customer Listing</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Customer</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Search customers..." />
        </div>
        <!-- Export buttons can be integrated later, if their JS is adapted; keeping the add button for now -->
        <a href="add_customer" class="cat-btn cat-btn-primary" title="Add Customer">
          <i class="ti ti-plus"></i> Add Customer
        </a>
      </div>
    </div>

    <!-- Main content -->
    <div class="cat-table-card w-100">
      <table class="table table-hover mb-0 w-100" id="customerListTable">
        <thead class="bg-light">
           <tr>
              <th class="text-center" style="width: 80px;">Image</th>
              <th>Customer Number</th>
              <th>Name</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Status</th>
              <th class="text-center" style="width: 140px;">Action</th>
           </tr>
        </thead>
        <tbody>
           <%if ($customer) %>
                <%assign var='i' value= 1 %>
                <%foreach from=$customer item=u %>
               <tr>
                  <td class="text-center">
                     <%if file_exists("public/uploads/customer/<%$u.customer_id%>/profile/<%$u.profile_photo%>") && $u.profile_photo != ""%>
                        <img src="public/uploads/customer/<%$u.customer_id%>/profile/<%$u.profile_photo%>" 
                            alt="Profile" 
                            style="width: 50px; height: 50px; object-fit: contain; border-radius: 8px;">
                     <%else%>
                        <img src="public/uploads/no_profile_image.png" 
                            alt="No Profile" 
                            style="width: 50px; height: 50px; object-fit: contain; border-radius: 8px;">
                     <%/if%>
                  </td>

                  <td><%$u['customer_number'] %></td>
                  <td><%$u['full_name'] %></td>
                  <td><%$u['email'] %></td>
                  <td><%$u['mobile_number'] %></td>
                  
                  <td class="cat-col-status">
                      <%if $u['status'] == 'Active' %>
                        <span class="cat-badge cat-badge-active"><span class="cat-badge-dot"></span>Active</span>
                      <%else %>
                        <span class="cat-badge cat-badge-inactive"><span class="cat-badge-dot"></span>Inactive</span>
                      <%/if %>
                  </td>

                  <td class="text-center cat-col-action">
                    <div class="dropdown">
                        <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                            <i class="ti ti-dots-vertical" style="font-size: 1.25rem;"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="customer_detail/<%$u['customer_id']%>" title="View Detail">
                                <i class="ti ti-eye me-1"></i> View Detail
                            </a>
                            <a class="dropdown-item" href="update_customer/<%$u['customer_id']%>" title="Edit">
                                <i class="ti ti-edit me-1"></i> Edit
                            </a>
                            <a class="dropdown-item" href="customer_invoice/<%$u['customer_id']%>" title="Invoice">
                                <i class="ti ti-file-invoice me-1"></i> Invoice
                            </a>
                            <a class="dropdown-item view-products-payment" href="javascript:void(0);" data-id="<%$u['customer_id']%>" title="Take Payment">
                                <i class="ti ti-wallet me-1"></i> Take Payment
                            </a>
                            <a class="dropdown-item delete_data text-danger" href="javascript:void(0);" data-id="<%$u['customer_id']%>" title="Delete">
                                <i class="ti ti-trash me-1"></i> Delete
                            </a>
                        </div>
                    </div>
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
           <div id="modelAlertBox" style="z-index: 1055;" class="alert model-error d-none position-absolute top-5 start-0 end-0 mx-3 mt-3 z-3" role="alert">
            
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

<div class="content-backdrop fade"></div>

<script type="text/javascript">
var base_url = <%$base_url|@json_encode%>
</script>

<script src="<%$base_url%>public/js/admin_panel/add_customer.js"></script>

