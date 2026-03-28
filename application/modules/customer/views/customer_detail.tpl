
    <!-- Include jQuery UI for Autocomplete -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include Tokenfield JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-tokenfield/dist/bootstrap-tokenfield.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

<style>
.tox .tox-notification--warning{
  display: none !important;
}
.tox-notifications-container{
  display: none !important;
}
.img-data{
  width: 75px;
  height: 75px;
  border-radius: 5px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}
label {
    font-size: 14px !important;
    font-weight:600 !important;
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
          <span >Customer Details</span>
        </div>
      </nav>
        <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
         <a href="<%base_url('customer')%>"  class="btn btn-seconday" title="Customer">
            <i class="ti ti-arrow-left"></i>
        </a>
        </div>
      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <%* <button class="btn btn-seconday" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv"></i></button>
        <button class="btn btn-seconday" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf"></i></button>
        <button class="btn btn-seconday filter-icon" type="button"><i class="ti ti-filter" ></i></i></button>
        <button class="btn btn-seconday" type="button"><i class="ti ti-refresh reset-filter"></i></button> *%>
        
       <!-- <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addPromo" title="Add process">
       <i class="ti ti-plus"></i>
        </button> -->
       

      </div>
     

      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
       <div class="p-3 container">
      <h4 class="mb-3">1. Basic Information</h4>
        <div class="row">
          <div class="col-md-3 mb-3">
            <label class="form-label fw-bold">Full Name</label>
            <div>
              <%if isset($customer) && !empty($customer[0].full_name) %>
                <%$customer[0].full_name%>
              <%else%>
                <span class="text-muted">-</span>
              <%/if%>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <label class="form-label fw-bold">Mobile Number</label>
            <div>
              <%if isset($customer) && !empty($customer[0].mobile_number) %>
                <%$customer[0].mobile_number%>
              <%else%>
                <span class="text-muted">-</span>
              <%/if%>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <label class="form-label fw-bold">Alternate Contact Number</label>
            <div>
              <%if isset($customer) && !empty($customer[0].alternate_contact) %>
                <%$customer[0].alternate_contact%>
              <%else%>
                <span class="text-muted">-</span>
              <%/if%>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <label class="form-label fw-bold">Email Address</label>
            <div>
              <%if isset($customer) && !empty($customer[0].email) %>
                <%$customer[0].email%>
              <%else%>
                <span class="text-muted">-</span>
              <%/if%>
            </div>
          </div>
          <div class="col-md-3">
            <label class="form-label">Customer Profile Photo</label><br>
          <%if isset($customer) && !empty($customer[0].profile_photo) %>
                <img class="img-data" src="public/uploads/customer/<%$customer[0].customer_id%>/profile/<%$customer[0].profile_photo%>" alt="Profile Photo" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; padding: 5px;">
              <%else%>
                <span class="text-muted">No image available</span>
              <%/if%>
          </div>
          <div class="col-md-3 mb-3">
            <label class="form-label fw-bold">Date of Birth</label>
            <div>
              <%if isset($customer) && !empty($customer[0].dob) %>
                <%$customer[0].dob%>
              <%else%>
                <span class="text-muted">-</span>
              <%/if%>
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <label class="form-label fw-bold">Gender</label>
            <div>
              <%if isset($customer) && !empty($customer[0].gender) %>
                <%$customer[0].gender%>
              <%else%>
                <span class="text-muted">-</span>
              <%/if%>
            </div>
          </div>
          
        </div>
<hr>
      <h4 class="my-4">2. Address Information</h4>
<div class="row">
  <div class="col-md-6 mb-3">
    <label class="form-label fw-bold">Address Line 1</label>
    <div>
      <%if isset($customer) && !empty($customer[0].address1) %>
        <%$customer[0].address1%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-6 mb-3">
    <label class="form-label fw-bold">Address Line 2</label>
    <div>
      <%if isset($customer) && !empty($customer[0].address2) %>
        <%$customer[0].address2%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-4 mb-3">
    <label class="form-label fw-bold">City</label>
    <div>
      <%if isset($customer) && !empty($customer[0].city) %>
        <%$customer[0].city%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-4 mb-3">
    <label class="form-label fw-bold">State</label>
    <div>
      <%if isset($customer) && !empty($customer[0].state) %>
        <%$customer[0].state%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-2 mb-3">
    <label class="form-label fw-bold">Pincode</label>
    <div>
      <%if isset($customer) && !empty($customer[0].pincode) %>
        <%$customer[0].pincode%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-2 mb-3">
    <label class="form-label fw-bold">Country</label>
    <div>
      <%if isset($customer) && !empty($customer[0].country) %>
        <%$customer[0].country%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
</div>
<hr>
<h4 class="my-4">3. Identity Documents</h4>
<div class="row">
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">PAN Card Number</label>
    <div>
      <%if isset($customer) && !empty($customer[0].pan_number) %>
        <%$customer[0].pan_number%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">PAN Card Image</label>
    <div>
      <%if isset($customer) && !empty($customer[0].pan_image) %>
        <img class="img-data" src="public/uploads/customer/<%$customer[0].customer_id%>/pan/<%$customer[0].pan_image%>" alt="PAN Card Image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; padding: 5px;">
      <%else%>
        <span class="text-muted">No image available</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Aadhar Card Number</label>
    <div>
      <%if isset($customer) && !empty($customer[0].aadhar_number) %>
        <%$customer[0].aadhar_number%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Aadhar Card Image</label>
    <div>
      <%if isset($customer) && !empty($customer[0].aadhar_image) %>
        <img class="img-data" src="public/uploads/customer/<%$customer[0].customer_id%>/aadhar/<%$customer[0].aadhar_image%>" alt="Aadhar Card Image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; padding: 5px;">
      <%else%>
        <span class="text-muted">No image available</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">GST Number</label>
    <div>
      <%if isset($customer) && !empty($customer[0].gst_number) %>
        <%$customer[0].gst_number%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">GST Certificate</label>
    <div>
      <%if isset($customer) && !empty($customer[0].gst_certificate) %>
        <img class="img-data" src="public/uploads/customer/<%$customer[0].customer_id%>/gst/<%$customer[0].gst_certificate%>" alt="GST Certificate" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; padding: 5px;">
      <%else%>
        <span class="text-muted">No image available</span>
      <%/if%>
    </div>
  </div>
</div>
<hr>
<h4 class="my-4">4. Business Details</h4>
<div class="row">
  <div class="col-md-4 mb-3">
    <label class="form-label fw-bold">Company Name</label>
    <div>
      <%if isset($customer) && !empty($customer[0].company_name) %>
        <%$customer[0].company_name%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Business Type</label>
    <div>
      <%if isset($customer) && !empty($customer[0].business_type) %>
        <%$customer[0].business_type%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Contact Person</label>
    <div>
      <%if isset($customer) && !empty($customer[0].business_contact) %>
        <%$customer[0].business_contact%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  
  <div class="col-md-2 mb-3">
    <label class="form-label fw-bold">GST Registered?</label>
    <div>
      <%if isset($customer) && !empty($customer[0].gst_registered) %>
        <%$customer[0].gst_registered%>
      <%else%>
        <span class="text-muted">No</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Business PAN</label>
    <div>
      <%if isset($customer) && !empty($customer[0].business_pan) %>
        <%$customer[0].business_pan%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-3 mb-3">
    <label class="form-label fw-bold">Business Email</label>
    <div>
      <%if isset($customer) && !empty($customer[0].business_email) %>
        <%$customer[0].business_email%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
  <div class="col-md-6 mb-3">
    <label class="form-label fw-bold">Business Address</label>
    <div>
      <%if isset($customer) && !empty($customer[0].business_address) %>
        <%$customer[0].business_address%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </div>
  </div>
</div>
<hr>
<h4 class="my-4">5. Payment Details</h4>
<div class="row">
  <div class="col-md-12 mb-3">
    <label class="form-label fw-bold">Payment Notes</label>
      <p>      
      <%if isset($customer) && !empty(trim($customer[0].payment_notes)) %>
        <%$customer[0].payment_notes%>
      <%else%>
        <span class="text-muted">-</span>
      <%/if%>
    </p>
  </div>
</div>
<hr>
<h4 class="my-4">6. Product Details</h4>

<%if isset($c_product) && count($c_product) > 0%>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th class="text-center">Product</th>
        <th class="text-center">Product Price (₹)</th>
        <th class="text-center">Quantity</th>
        <th class="text-center">Total Price (₹)</th>
        <th class="text-center"> Handover Qty</th>
        <th class="text-center">Remaining Quantity</th>
        <th class="text-center">Status</th>
      </tr>
    </thead>
    <tbody>
      <%foreach $c_product as $cp%>
        <tr>
          <td>
          <%$cp['product_name'] %>
          </td>
          <td class="text-center"><%number_format(floatval($cp['price']), 2) %></td>
          <td class="text-center"><%intval($cp['qty']) %></td>
          <td class="text-center"><%number_format(floatval($cp['price']) * intval($cp['qty']), 2) %></td>
          <td class="text-center"><%intval($cp['handover_qty']) %></td>
          <td class="text-center"><%intval($cp['qty']) - intval($cp['handover_qty']) %></td>
          <td class="text-center">
          <%if intval($cp['handover_qty']) == 0 %>
            <span class="text-secondary">Not Handover</span>
          <%elseif intval($cp['handover_qty']) < intval($cp['qty']) %>
            <span class="text-warning">Partial Handover</span>
          <%else %>
            <span class="text-success">Handover</span>
          <%/if %>
        </td>

        </tr>

      <%/foreach%>
    </tbody>
  </table>
<%else%>
  <p class="text-muted">No products added.</p>
<%/if%>


<%$grand_total = 0 %>
<%$gst_percentage = 0 %>
<%$gst_type = 'No' %>
<%$gst_price = 0 %>

<%foreach $c_product as $cp %>
  <%$grand_total = $grand_total + (floatval($cp['price']) * intval($cp['qty'])) %>
<%/foreach%>

<%if isset($customer[0]['gst_percentage']) %>
  <%$gst_percentage = floatval($customer[0]['gst_percentage']) %>
<%/if%>

<%if isset($customer[0]['gst_type']) %>
  <%$gst_type = $customer[0]['gst_type'] %>
<%/if%>

<%if $gst_type == 'Yes' %>
  <%$gst_price = ($grand_total * $gst_percentage) / 100 %>
<%else%>
  <%$gst_price = 0 %>
<%/if%>

<%$final_total = $grand_total + $gst_price %>


<div class="row mt-2">
  <div class="col-md-2">
    <label class="form-label">Grand Total Price</label>
    <p class="form-control-plaintext">₹ <%number_format($grand_total, 2)%></p>
  </div>
  <div class="col-md-2">
    <label class="form-label">GST Type</label>
    <p class="form-control-plaintext"><%$gst_type%></p>
  </div>
  <div class="col-md-2">
    <label class="form-label">GST Percentage</label>
    <p class="form-control-plaintext"><%$gst_percentage%>%</p>
  </div>
  <div class="col-md-2">
    <label class="form-label">GST Price</label>
    <p class="form-control-plaintext">₹ <%number_format($gst_price, 2)%></p>
  </div>
  <div class="col-md-2">
    <label class="form-label fw-bold">Final Total (Incl. GST)</label>
    <p class="form-control-plaintext text-success fw-bold">₹ <%number_format($final_total, 2)%></p>
  </div>
</div>




<hr>
<h4 class="my-4">7. Additional Details</h4>
<div class="row">
  
  <div class="col-md-3">
    <label class="form-label">Customer Type</label>
    <p><%if isset($customer) && $customer[0].customer_type%><%$customer[0].customer_type%><%else%>-<%/if%></p>
  </div>
  <div class="col-md-3">
    <label class="form-label">Company</label>
    <p>
   
      <%$company_id%>
    </p>
  </div>
  <div class="col-md-6 mt-3">
    <label class="form-label">Customer Notes</label>
    <p><%if isset($customer) && $customer[0].notes%><%nl2br($customer[0].notes)%><%else%>-<%/if%></p>
  </div>
</div>




      </div>
      </div>
      <!-- /.col -->
    

      
    </div>

    
    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>
      <link rel="stylesheet" href="<%$base_url%>public/plugin/editor/editor.css">
    <!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="<%$base_url%>public/plugin/editor/editor.js"></script>
   
    <script src="<%$base_url%>public/js/admin_panel/add_customer.js"></script>
