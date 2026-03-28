<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
           Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Sales</em></a>
          </h1>
          <br>
          <span >Sales History</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
        <input type="text" id="search-filter-input" placeholder="Search Sales..." class="form-control search-filter-input me-2">
        <a href="<%base_url('create_sale')%>" class="btn btn-seconday" title="Create Sales Bill">
           <i class="ti ti-plus"></i> Create Sales Bill
        </a>
      </div>



      <div class="card p-0 mt-0 w-100">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" id="salesListTable">
            <thead>
               <tr>
                  <th>Invoice No</th>
                  <th>Customer</th>
                  <th>Sales Date</th>
                  <th>Total Amount</th>
                  <th>Payment Mode</th>
                  <th>Added Date</th>
                  <th>Action</th>
               </tr>
            </thead>
            <tbody>
            <%if ($sales) %>
              <%foreach from=$sales item=val %>
               <tr>
                  <td><%$val['bill_no'] %></td>
                  <td><%$val['customer_phone_number']|default:'Walk-in'%></td>
                  <td><%$val['sales_date']|date_format:'%d-%m-%Y' %></td>
                  <td><strong>₹<%$val['total_amount']|number_format:2 %></strong></td>
                  <td><span class="badge bg-label-info"><%$val['payment_mode'] %></span></td>
                  <td><%$val['added_date']|date_format:'%d-%m-%Y %H:%M' %></td>
                  <td>
                    <div class="d-flex align-items-center">
                      <a href="javascript:void(0)" class="me-2 view-sale-details" data-id="<%$val['sales_id']%>" title="View Details">
                        <i class="ti ti-eye text-info"></i>
                      </a>
                    </div>
                  </td>
               </tr>
              <%/foreach%>
            <%/if%>
            </tbody>
          </table>
      </div>
  </div>
</div>

<!-- Sales Detail Modal -->
<div class="modal fade" id="salesDetailModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content" id="modal-content-area">
      <!-- AJAX content will load here -->
    </div>
  </div>
</div>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/sales_list.js"></script>
