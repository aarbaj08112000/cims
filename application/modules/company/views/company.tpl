
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Company</em></a>
          </h1>
          <br>
          <span >Company Listing</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
        <a href="add_company" ><button type="button" class="btn btn-seconday"  title="Add Company">
        <i class="ti ti-plus"></i></button></a>
      </div>
      


      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" border-color="#e1e1e1" id="companyListTable">
              <thead>
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Iamge</th>
                    <th>Company Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>GST Number </th>
                    <th>Status</th>
                    <th>Action</th>
                 </tr>
              </thead>
              <tbody>
                 <%if ($company) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$company item=u %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                       
                        <td>
                           <img src="public/uploads/company/<%$u['company_id']%>/logo/<%$u['company_logo']%>" alt="" style="max-width: 75px; height: auto;">
                        </td>

                        <td><%$u['company_name'] %></td>
                        <td><%$u['email'] %></td>
                        <td><%$u['phone'] %></td>
                        <td><%$u['gst_number'] %></td>
                        <td style="font-weight: bold; 
                        <%if $u['status'] == 'Active' %>color: green;<%else %>color: red;<%/if %>">
                        <%$u['status'] %>
                    </td>
                        <td>
                        <span class="delete_data" title="Delete Record" data-id="<%$u['company_id']%>"><i class="ti ti-trash"></i>
                        </span>
                       
                        	<a href="update_company/<%$u['company_id']%>" title="Edit">
					       		<i class="ti ti-edit edit-part" ></i>
					        </a>
                      
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
