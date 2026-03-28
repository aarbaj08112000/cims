
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
            <em >Company</em></a>
          </h1>
          <br>
          <span ><%if isset($company) %>Update Company<%else%>Add Company<%/if%></span>
        </div>
      </nav>
        <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
         <a href="<%base_url('company')%>"  class="btn btn-seconday" title="Company Listing">
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
          
  <form class="container mt-4" action="javascript:void(0)" method="POST" enctype="multipart/form-data" id="company_form">
  <div class="row">
    <div class="col-md-6">
      <label class="form-label">Company Name <span class="text-danger">*</span></label>
      <input type="text" name="company_name" class="form-control" required placeholder="Enter company name" value="<%if isset($company) %><%$company.company_name%><%/if%>">
    </div>
    <div class="col-md-6">
      <label class="form-label">Company Code <span class="text-danger">*</span></label>
      <input type="text" name="company_code" value="<%if isset($company) %><%$company.company_code%><%/if%>" class="form-control"  required placeholder="Enter company code">
    </div>
    <div class="col-md-6">
      <label class="form-label">Company Logo <span class="text-danger">*</span></label>
      <input type="file" name="company_logo" class="form-control">
      <input type="hidden" name="hidden_company_logo" value="<%if isset($company) %><%$company.company_logo%><%/if%>">
    </div>
    <div class="col-md-6">
      <label class="form-label">Contact Person <span class="text-danger">*</span></label>
      <input type="text" name="contact_person" value="<%if isset($company) %><%$company.contact_person%><%/if%>" class="form-control" required placeholder="Enter contact person name">
    </div>
    <div class="col-md-6">
      <label class="form-label">Email <span class="text-danger">*</span></label>
      <input type="email" name="email" value="<%if isset($company) %><%$company.email%><%/if%>" class="form-control" required placeholder="Enter email address">
    </div>
    <div class="col-md-6">
      <label class="form-label">Phone <span class="text-danger">*</span></label>
      <input type="tel" name="phone" value="<%if isset($company) %><%$company.phone%><%/if%>" class="form-control" required placeholder="Enter phone number">
    </div>
    <div class="col-md-12">
      <label class="form-label">Address <span class="text-danger">*</span></label>
      <textarea name="address"  class="form-control" rows="2" required placeholder="Enter address"><%if isset($company) %><%$company.address%><%/if%></textarea>
    </div>
    <div class="col-md-4">
      <label class="form-label">City <span class="text-danger">*</span></label>
      <input type="text" name="city" value="<%if isset($company) %><%$company.city%><%/if%>" class="form-control" required placeholder="Enter city">
    </div>
    <div class="col-md-4">
      <label class="form-label">State <span class="text-danger">*</span></label>
      <input type="text" name="state" value="<%if isset($company) %><%$company.state%><%/if%>" class="form-control" required placeholder="Enter state">
    </div>
    <div class="col-md-2">
      <label class="form-label">Pincode <span class="text-danger">*</span></label>
      <input type="text" name="pincode" value="<%if isset($company) %><%$company.pincode%><%/if%>" class="form-control" required placeholder="Enter pincode">
    </div>
    <div class="col-md-2">
      <label class="form-label">Country <span class="text-danger">*</span></label>
      <input type="text" name="country" value="<%if isset($company) %><%$company.country%><%/if%>" class="form-control" required placeholder="Enter country">
    </div>
    <div class="col-md-6">
      <label class="form-label">GST Number <span class="text-danger">*</span></label>
      <input type="text" name="gst_number" value="<%if isset($company) %><%$company.gst_number%><%/if%>" class="form-control" required placeholder="Enter GST number">
    </div>
    <div class="col-md-6">
      <label class="form-label">GST Certificate <span class="text-danger">*</span></label>
      <input type="file" name="gst_certificate" class="form-control">
      <input type="hidden" name="hidden_gst_certificate" value="<%if isset($company) %><%$company.gst_certificate%><%/if%>">
    </div>
    <div class="col-md-6">
      <label class="form-label">PAN Number <span class="text-danger">*</span></label>
      <input type="text" name="pan_number" value="<%if isset($company) %><%$company.pan_number%><%/if%>" class="form-control" required placeholder="Enter PAN number">
    </div>
    <div class="col-md-6">
      <label class="form-label">PAN Card Image <span class="text-danger">*</span></label>
      <input type="file" name="pan_card_img"  class="form-control">
      <input type="hidden" name="hidden_pan_card_img" value="<%if isset($company) %><%$company.pan_card_img%><%/if%>">
    </div>

  </div>

  <div class="mt-4">
   <input type="hidden"  id="mode"  value="<%if isset($company)%>Update<%else%>Add<%/if%>">
    <input type="hidden"  id="company_id" name="company_id" value="<%if isset($company) %><%$company.company_id%><%/if%>">
    <button type="submit" class="btn btn-primary">Save</button>
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
   
    <script src="<%$base_url%>public/js/admin_panel/company.js"></script>
