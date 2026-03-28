<style>
#imageModal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-overlay {
  position: absolute;
  background: rgba(0, 0, 0, 0.7);
  width: 100%;
  height: 100%;
}

.modal-content {
  position: relative;
  background: #fff;
  width: 50%;
  max-height: 90%;
  padding: 25px;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
  text-align: center;
  z-index: 10000;
  overflow: auto; /* Scroll if content overflows */
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: start;
}

.modal-img {
  max-width: 40%;
  height: auto;
  border-radius: 8px;
  margin-top: 20px;
  display: block;
}

.modal-close {
  position: absolute;
  top: 8px;
  right: 14px;
  font-size: 28px;
  font-weight: bold;
  color: #333;
  cursor: pointer;
}

.modal-download {
  background-color: #28a745;
  color: white;
  padding: 10px 22px;
  border-radius: 5px;
  text-decoration: none;
  font-weight: bold;
  transition: background-color 0.3s ease;
  align-self: flex-start; /* Align to the left inside the flex container */
  margin-bottom: 10px;
}


.modal-download:hover {
  background-color: #218838;
}

</style>

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
          <span >Customer Invoice</span>
        </div>
      </nav>
      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
         <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
         <a href="<%base_url('customer')%>"  class="btn btn-seconday" title="Customer">
            <i class="ti ti-arrow-left"></i>
        </a>
        </div>

      


      <!-- Main content -->
      <div style="display: flex; gap: 20px;">
        <div>Customer Number: <strong> <td><%$customer[0]['customer_number'] %></td></strong></div>
        <div>Name: <strong> <td><%$customer[0]['full_name'] %></td></strong></div>
        <div>Email: <strong> <td><%$customer[0]['email'] %></td></strong></div>
        <div>Phone Number: <strong> <td><%$customer[0]['mobile_number'] %></td></strong></div>
    </div>

      <div class="card p-0 mt-4 w-100">
        <div class="">

          <div class="table-responsive text-nowrap">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped" style="border-collapse: collapse;" border-color="#e1e1e1" id="product_list">
              <thead>
                 <tr class="text-center">
                    <!-- <th>Sr No</th> -->
                    <th >Transaction Image</th>
                    <!-- <th>Customer Number</th>
                    <th>Name</th>
                    <th>Email </th>-->
                    <th>transaction Type</th> 
                    <th>Invoice Number</th>
                    <th>Invoice Date</th>
                    <th>Amount</th>
                    <th>Action</th>
                 </tr>
              </thead>
              <tbody>
                 <%if ($invoice) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$invoice item=u %>
                     <tr class="text-center">
                        <!-- <td><%$i %></td> -->
                       <td>
                        <%if file_exists("public/uploads/transaction_image/<%$u.customer_id%>/<%$u.transaction_image%>") && $u.transaction_image != ""%>
                          <img 
                            src="public/uploads/transaction_image/<%$u.customer_id%>/<%$u.transaction_image%>" 
                            alt="Transaction Image"
                            class="transaction-image"
                            data-customer-id="<%$u.customer_id%>" 
                            data-image-name="<%$u.transaction_image%>"
                            style="max-width: 75px; height: auto; cursor: pointer;">
                        <%else%>
                          <p>No transaction <br>Image</p>
                        <%/if%>
                      </td>

                       
                        <td><%$u['transaction_type'] %></td>
                        <td><%$u['invoice_name'] %></td>
                        <td><%$u['payment_date'] %></td>
                        <td><%$u['amount'] %></td>
                        
                        
                        <td class="text-center">
                      <a href="download_invoice/<%$u['customer_id']%>/<%$u['customer_payments_id']%>" 
                          class="download_invoice" 
                          title="Download Invoice">
                          <i class="ti ti-download"></i>
                        </a>


                        </span>
                       
                        	

                      
                        </td>
                     </tr>
                  <%assign var='i' value=$i+1 %>
                  <%/foreach%>
                  <%/if%>
              </tbody>
           </table>
          <div id="imageModal" style="display:none;">
            <div class="modal-overlay"></div>
            <div class="modal-content">
              <span id="closeImageModal" class="modal-close">&times;</span>
              <a id="downloadBtn" href="#" download class="modal-download">Download</a>
              <img id="popupImage" src="" alt="Transaction Image" class="modal-img">
              
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
<script>
  $(document).ready(function () {
    // Open modal
    $('.transaction-image').on('click', function () {
      var customerId = $(this).data('customer-id');
      var imageName = $(this).data('image-name');
      var imagePath = 'public/uploads/transaction_image/' + customerId + '/' + imageName;

      $('#popupImage').attr('src', imagePath);
      $('#downloadBtn').attr('href', imagePath);
      $('#imageModal').fadeIn();
    });

    // Close modal
    $('#closeImageModal, .modal-overlay').on('click', function () {
      $('#imageModal').fadeOut();
    });
  });
</script>

