
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
#imagePreview img{
  padding: 2px;
  border-radius: 5px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}
input:disabled,
select:disabled,
textarea:disabled {
  background-color: #e9ecef; /* light grey */
  color: #6c757d;            /* muted text */
  border: 1px solid #ced4da;
  cursor: not-allowed;
}
input:read-only,
textarea:read-only,
select:disabled {
  background-color: #e9ecef;  /* light gray */
  color: #6c757d;             /* muted text color */
  border: 1px solid #ced4da;
  cursor: not-allowed;
}

input:read-only::placeholder,
textarea:read-only::placeholder {
  color: #adb5bd; /* lighter placeholder for readonly */
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
          <span ><%if isset($customer) %>Update Customer<%else%>Add Customer<%/if%></span>
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
        <div class="p-3">
          <form class="container mt-4 custom-form" action="javascript:void(0)" method="POST" enctype="multipart/form-data" id="customer_form">
          <h4 class="mb-3">1. Basic Information</h4>
          <div class="row">
            <div class="col-md-4">
              <label class="form-label">Full Name <span class="text-danger">*</span></label>
              <input type="text" name="full_name" value="<%if isset($customer) %><%$customer[0].full_name%><%/if%>" class="form-control required-input" placeholder="Enter Full Name">
            </div>
            <div class="col-md-4">
              <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
              <input type="tel" name="mobile_number" value="<%if isset($customer) %><%$customer[0].mobile_number%><%/if%>" class="form-control required-input" placeholder="Enter Mobile Number">
            </div>
            <div class="col-md-4">
              <label class="form-label">Alternate Contact Number</label>
              <input type="tel" name="alternate_contact" value="<%if isset($customer) %><%$customer[0].alternate_contact%><%/if%>"  class="form-control" placeholder="Enter Alternate Number">
            </div>
            <div class="col-md-4">
              <label class="form-label">Email Address<span class="text-danger">*</span></label>
              <input type="email" name="email" value="<%if isset($customer) %><%$customer[0].email%><%/if%>" class="form-control" placeholder="Enter Email Address">
            </div>
            <div class="col-md-4">
              <label class="form-label">Date of Birth<span class="text-danger">*</span></label>
              <input type="date" name="dob" value="<%if isset($customer) %><%$customer[0].dob%><%/if%>" class="form-control" placeholder="Select Date of Birth">
            </div>
            <div class="col-md-4">
              <label class="form-label">Gender<span class="text-danger">*</span></label>
              <select name="gender" class="form-control select2" placeholder="Select Gender">
                <option value="">Select Gender</option>
                <option value="Male" <%if isset($customer) && $customer[0].gender == 'Male'%>selected<%/if%>>Male</option>
                <option value="Female" <%if isset($customer) && $customer[0].gender == 'Female'%>selected<%/if%>>Female</option>
                <option value="Other" <%if isset($customer) && $customer[0].gender == 'Other'%>selected<%/if%>>Other</option>

              </select>
            </div>
          </div>

          <h4 class="my-4">2. Address Information</h4>
          <div class="row">
            <div class="col-md-6">
              <label class="form-label">Address Line 1 <span class="text-danger">*</span></label>
              <input type="text" name="address1" value="<%if isset($customer) %><%$customer[0].address1%><%/if%>" class="form-control required-input" placeholder="Enter Address Line 1">
            </div>
            <div class="col-md-6">
              <label class="form-label">Address Line 2</label>
              <input type="text" name="address2" value="<%if isset($customer) %><%$customer[0].address2%><%/if%>" class="form-control" placeholder="Enter Address Line 2">
            </div>
            <div class="col-md-4">
              <label class="form-label">City<span class="text-danger">*</span></label>
              <input type="text" name="city" value="<%if isset($customer) %><%$customer[0].city%><%/if%>" class="form-control" placeholder="Enter City">
            </div>
            <div class="col-md-4">
              <label class="form-label">State<span class="text-danger">*</span></label>
              <input type="text" name="state" value="<%if isset($customer) %><%$customer[0].state%><%/if%>" class="form-control" placeholder="Enter State">
            </div>
            <div class="col-md-2">
              <label class="form-label">Pincode<span class="text-danger">*</span></label>
              <input type="number" name="pincode" value="<%if isset($customer) %><%$customer[0].pincode%><%/if%>" class="form-control" placeholder="Enter Pincode">
            </div>
            <div class="col-md-2">
              <label class="form-label">Country<span class="text-danger">*</span></label>
              <input type="text" name="country" value="<%if isset($customer) %><%$customer[0].country%><%/if%>" class="form-control" placeholder="Enter Country">
            </div>
          </div>

          <h4 class="my-4">3. Identity Documents</h4>
          <div class="row">
            <div class="col-md-4">
              <label class="form-label">PAN Card Number<span class="text-danger">*</span></label>
              <input type="text" name="pan_number" value="<%if isset($customer) %><%$customer[0].pan_number%><%/if%>" class="form-control" placeholder="Enter PAN Card Number">
            </div>
            <div class="col-md-4">
              <label class="form-label">PAN Card Image<span class="text-danger">*</span></label>
              <input type="file" name="pan_image" class="form-control">
              <input type="hidden" class="form-control required-input" id="hidden_pan_image" name="hidden_pan_image" value="<%if isset($customer) %><%$customer[0].pan_image%><%/if%>">

            </div>
            <div class="col-md-4">
              <label class="form-label">Aadhar Card Number<span class="text-danger">*</span></label>
              <input type="text" name="aadhar_number" value="<%if isset($customer) %><%$customer[0].aadhar_number%><%/if%>" class="form-control" placeholder="Enter Aadhar Number">
            </div>
            <div class="col-md-4">
              <label class="form-label">Aadhar Card Image<span class="text-danger">*</span></label>
              <input type="file" name="aadhar_image"  class="form-control">
              <input type="hidden" class="form-control required-input" id="hidden_aadhar_image" name="hidden_aadhar_image" value="<%if isset($customer) %><%$customer[0].aadhar_image%><%/if%>">

            </div>
            <div class="col-md-4">
              <label class="form-label">GST Number</label>
              <input type="text" name="gst_number" value="<%if isset($customer) %><%$customer[0].gst_number%><%/if%>" class="form-control" placeholder="Enter GST Number">
            </div>
            <div class="col-md-4">
              <label class="form-label">GST Certificate</label>
              <input type="file" name="gst_certificate"  class="form-control">
              <input type="hidden" class="form-control required-input" id="hidden_gst_certificate" name="hidden_gst_certificate" value="<%if isset($customer) %><%$customer[0].gst_certificate%><%/if%>">

            </div>
          </div>

          <h4 class="my-4">4. Business Details (Optional)</h4>
          <div class="row">
            <div class="col-md-4">
              <label class="form-label">Company Name</label>
              <input type="text" name="company_name" value="<%if isset($customer) %><%$customer[0].company_name%><%/if%>" class="form-control" placeholder="Enter Company Name">
            </div>
            <div class="col-md-4">
              <label class="form-label">Business Type</label>
              <select name="business_type" class="form-control select2">
                <option value="">Select Business Type</option>
                <option value="Sole Proprietor" <%if isset($customer) && $customer[0].business_type == 'Sole Proprietor'%>selected<%/if%>>Sole Proprietor</option>
                <option value="Pvt Ltd" <%if isset($customer) && $customer[0].business_type == 'Pvt Ltd'%>selected<%/if%>>Pvt Ltd</option>
                <option value="Partnership" <%if isset($customer) && $customer[0].business_type == 'Partnership'%>selected<%/if%>>Partnership</option>

              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Contact Person</label>
              <input type="text" name="business_contact" value="<%if isset($customer) %><%$customer[0].business_contact%><%/if%>" class="form-control" placeholder="Enter Contact Person Name">
            </div>
            <div class="col-md-6">
              <label class="form-label">Business Address</label>
              <input type="text" name="business_address" value="<%if isset($customer) %><%$customer[0].business_address%><%/if%>" class="form-control" placeholder="Enter Business Address">
            </div>
            <div class="col-md-2">
              <label class="form-label">GST Registered?</label>
              <select name="gst_registered" class="form-control select2">
                <option value="No" <%if isset($customer) && $customer[0].gst_registered == 'No'%>selected<%/if%>>No</option>
                <option value="Yes" <%if isset($customer) && $customer[0].gst_registered == 'Yes'%>selected<%/if%>>Yes</option>

              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Business PAN</label>
              <input type="text" name="business_pan" value="<%if isset($customer) %><%$customer[0].business_pan%><%/if%>" class="form-control" placeholder="Enter Business PAN">
            </div>
            <div class="col-md-4">
              <label class="form-label">Business Email</label>
              <input type="email" name="business_email" value="<%if isset($customer) %><%$customer[0].business_email%><%/if%>" class="form-control" placeholder="Enter Business Email">
            </div>
          </div>

          <h4 class="my-4">5. Payment Details</h4>
          <div class="row">
            <div class="col-md-3 hide">
              <label class="form-label">Payment Mode</label>
              <select name="payment_mode" class="form-control select2">
                <option value="">Select Payment Mode</option>
                <option value="Cash">Cash</option>
                <option value="UPI">UPI</option>
                <option value="Bank Transfer">Bank Transfer</option>
                <option value="Cheque">Cheque</option>
                <option value="Credit">Credit</option>
              </select>
            </div>
            <div class="col-md-3 hide">
              <label class="form-label">Bank Name</label>
              <input type="text" name="bank_name" value="<%if isset($customer) %><%$customer[0].bank_name%><%/if%>" class="form-control" placeholder="Enter Bank Name">
            </div>
            <div class="col-md-3 hide">
              <label class="form-label">Account Holder Name</label>
              <input type="text" name="account_holder" value="<%if isset($customer) %><%$customer[0].account_holder%><%/if%>" class="form-control" placeholder="Enter Account Holder Name">
            </div>
            <div class="col-md-3 hide">
              <label class="form-label">Account Number</label>
              <input type="text" name="account_number" value="<%if isset($customer) %><%$customer[0].account_number%><%/if%>" class="form-control" placeholder="Enter Account Number">
            </div>
            <div class="col-md-3 hide">
              <label class="form-label">IFSC Code</label>
              <input type="text" name="ifsc" value="<%if isset($customer) %><%$customer[0].ifsc%><%/if%>" class="form-control" placeholder="Enter IFSC Code">
            </div>
            <div class="col-md-3 hide">
              <label class="form-label">UPI ID</label>
              <input type="text" name="upi_id" value="<%if isset($customer) %><%$customer[0].upi_id%><%/if%>" class="form-control" placeholder="Enter UPI ID">
            </div>
            <div class="col-md-3 hide">
              <label class="form-label">Payment Terms</label>
              <input type="text" name="payment_terms" value="<%if isset($customer) %><%$customer[0].payment_terms%><%/if%>" class="form-control" placeholder="e.g., Net 30">
            </div>
            <div class="col-md-12 ">
              <label class="form-label">Payment  Notes</label>
              <textarea name="payment_notes"  class="form-control" rows="3" placeholder="Enter Payment  Notes"><%if isset($customer) %><%$customer[0].payment_notes%><%/if%></textarea>
            </div>
          </div>

          <h4 class="my-4">6. Product Details</h4>
          
          <%if isset($c_product) && count($c_product) > 0%>
          <%foreach $c_product as $cp%>
            <div class="row product-row">
              <div class="col-md-4">
                <label class="form-label">Product <span class="text-danger">*</span></label>
                <select name="product_id[]" class="form-control required-input product-select">
                  <option value="">Select Product</option>
                  <%foreach $product as $p%>
                    <option value="<%$p['product_id']%>" data-price="<%$p['price']%>" <%if $p['product_id'] == $cp['product_id']%>selected<%/if%>>
                      <%$p['name']%> (₹ <%$p['price']%>)
                    </option>
                  <%/foreach%>
                </select>
              </div>

              <div class="col-md-3">
                <label class="form-label">Product Price <span class="text-danger">*</span></label>
                <input type="number" name="product_price[]" class="form-control required-input product-price" value="<%$cp['price']%>">
              </div>

              <div class="col-md-2">
                <label class="form-label">QTY <span class="text-danger">*</span></label>
                <input type="number" name="quantity[]" class="form-control required-input product-qty" value="<%$cp['qty']%>">
              </div>

              <div class="col-md-2">
                <label class="form-label">Total Price <span class="text-danger">*</span></label>
                <input type="number" name="total_price[]" class="form-control required-input product-total" value="<%floatval($cp['price']) * intval($cp['qty'])%>" readonly>
              </div>

              <div class="col-md-1 mt-4">
                <button type="button" class="btn btn-primary add-row">+</button>
              </div>
            </div>
          <%/foreach%>
        <%else%>
          <!-- Default blank row for add mode -->
          <div class="row product-row">
            <div class="col-md-4">
              <label class="form-label">Product <span class="text-danger">*</span></label>
              <select name="product_id[]" class="form-control required-input product-select">
                <option value="">Select Product</option>
                <%foreach $product as $p%>
                  <option value="<%$p['product_id']%>" data-price="<%$p['price']%>">
                    <%$p['name']%> (₹ <%$p['price']%>)
                  </option>
                <%/foreach%>
              </select>
            </div>

            <div class="col-md-3">
              <label class="form-label">Product Price <span class="text-danger">*</span></label>
              <input type="number" name="product_price[]" class="form-control required-input product-price" placeholder="Enter Product Price">
            </div>

            <div class="col-md-2">
              <label class="form-label">QTY <span class="text-danger">*</span></label>
              <input type="number" name="quantity[]" class="form-control required-input product-qty" placeholder="Enter quantity">
            </div>

            <div class="col-md-2">
              <label class="form-label">Total Price <span class="text-danger">*</span></label>
              <input type="number" name="total_price[]" class="form-control required-input product-total" readonly placeholder="Enter Total Price">
            </div>

            <div class="col-md-1 mt-4">
              <button type="button" class="btn btn-primary add-row">+</button>
            </div>
          </div>
        <%/if%>

          <div class="row">
             <div class="col-md-3">
              <label class="form-label">Grand Total Price</label>
              <input type="number" name="grand_total" readonly value="<%if isset($customer) %><%$customer[0].gst_percentage%><%/if%>" class="form-control" placeholder="Enter GST Percentage">
            </div>
            <div class="col-md-3">
              <label class="form-label">GST Type <span class="text-danger">*</span></label>
              <select name="gst_type" class="form-control required-input select2">
                <option value="">Select GST Option</option>
                <option value="No" <%if isset($customer) && $customer[0].gst_type == 'No'%>selected<%/if%>>No</option>
                <option value="Yes" <%if isset($customer) && $customer[0].gst_type == 'Yes'%>selected<%/if%>>Yes</option>

              </select>
            </div>
            <div class="col-md-3">
              <label class="form-label">GST Percentage</label>
              <input type="number" name="gst_percentage" value="<%if isset($customer) %><%$customer[0].gst_percentage%><%/if%>" class="form-control" placeholder="Enter GST Percentage">
            </div>
            <div class="col-md-3">
              <label class="form-label">GST Price</label>
              <input type="text" name="gst_total_price" readonly value="<%if isset($customer) %><%$customer[0].gst_percentage%><%/if%>" class="form-control" placeholder="Enter GST Percentage">
            </div>
           

          </div>
          <h4 class="my-4">7. Additional Details</h4>
          <div class="row">
            <div class="col-md-4">
              <label class="form-label">Customer Profile Photo</label>
              <input type="file" name="profile_photo" class="form-control">
              <input type="hidden" class="form-control required-input" id="hidden_profile_photo" name="hidden_profile_photo" value="<%if isset($customer) %><%$customer[0].profile_photo%><%/if%>">

            </div>
            <div class="col-md-4">
              <label class="form-label">Customer Type <span class="text-danger">*</span></label>
              <select name="customer_type" class="form-control required-input select2">
                <option value="">Select Customer Type</option>
                <option value="Individual" <%if isset($customer) && $customer[0].customer_type == 'Individual'%>selected<%/if%>>Individual</option>
                <option value="Business" <%if isset($customer) && $customer[0].customer_type == 'Business'%>selected<%/if%>>Business</option>
                <option value="Vendor" <%if isset($customer) && $customer[0].customer_type == 'Vendor'%>selected<%/if%>>Vendor</option>

              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Company <span class="text-danger">*</span></label>
              <select name="company_id" class="form-control required-input select2">
                <option value="">Select Company</option>
               <%foreach $company as $p%>
                 <option value="<%$p['company_id'] %>" <%if isset($customer) && $customer[0].company_id == $p['company_id']%>selected<%/if%>>
                  <%$p['company_name'] %> 
                </option>

                <%/foreach%>
              </select>
            </div>
           
            
            <div class="col-md-12">
              <label class="form-label">Customer Notes</label>
              <textarea name="notes" class="form-control" rows="3" placeholder="Additional Notes (if any)"><%if isset($customer) %><%$customer[0].notes%><%/if%></textarea>
            </div>
          </div>

          <div class="mt-4">
           <input type="hidden"  id="mode"  value="<%if isset($customer)%>Update<%else%>Add<%/if%>">
           <input type="hidden"  id="customer_id" name="customer_id" value="<%if isset($customer) %><%$customer[0].customer_id%><%/if%>">
            <button type="submit" class="btn btn-primary">Submit</button>
          </div>
          </form>
        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->
    

      <div class="content-backdrop fade"></div>
    </div>

    <style type="text/css">
      input.required-check:checked {
          border-color: #0d6efd !important;
          background-color: #fc0d0d !important;
      }
      .required-check{
          position: absolute;
          top: -13px;
          right: -7px;
          width: 22px;
          height: 22px;
      }
    </style>
    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>
      <link rel="stylesheet" href="<%$base_url%>public/plugin/editor/editor.css">
    <!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="<%$base_url%>public/plugin/editor/editor.js"></script>
   
    <script src="<%$base_url%>public/js/admin_panel/add_customer.js"></script>
