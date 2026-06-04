
    <!-- Include jQuery UI for Autocomplete -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include Tokenfield JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-tokenfield/dist/bootstrap-tokenfield.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
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
.form-label {
    font-weight: 600;
    color: #4b4b5a;
    margin-bottom: 8px;
    font-size: 0.9rem;
}
.form-control {
    border-radius: 8px;
    border: 1px solid #e1e5eb;
    padding: 0.65rem 1rem;
    transition: all 0.2s;
}
.form-control:focus {
    border-color: #7239ea;
    box-shadow: 0 0 0 0.25rem rgba(114, 57, 234, 0.1);
}
.form-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.04);
    border: none;
    overflow: hidden;
}
.form-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    border-bottom: 1px solid #f1f1f4;
    padding: 1.5rem;
}
.form-body {
    padding: 2rem;
}
.field-icon {
    position: absolute;
    top: 12px;
    right: 15px;
    color: #a1a5b7;
    font-size: 1.2rem;
}
</style>

<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header mb-4">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-building"></i>
        </div>
        <div>
          <h1 class="cat-page-title"><%if isset($company) %>Update Company<%else%>Add Company<%/if%></h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>company">Company</a>
            <i class="ti ti-chevron-right"></i>
            <span><%if isset($company) %>Update Company<%else%>Add Company<%/if%></span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%base_url('company')%>" class="cat-btn cat-btn-outline" title="Back to Listing">
          <i class="ti ti-arrow-left"></i> Back
        </a>
      </div>
    </div>

    <!-- Main content -->
    <div class="form-card w-100">
      <div class="form-header">
        <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-forms fs-3 me-2 text-primary"></i> Company Details Form</h5>
      </div>
      <div class="form-body">
        <form action="javascript:void(0)" method="POST" enctype="multipart/form-data" id="company_form">
          <div class="row g-4">
            <div class="col-md-6">
              <label class="form-label">Company Name <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="text" name="company_name" class="form-control" required placeholder="Enter company name" value="<%if isset($company) %><%$company.company_name%><%/if%>">
                  <i class="ti ti-building field-icon"></i>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">Company Code <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="text" name="company_code" value="<%if isset($company) %><%$company.company_code%><%/if%>" class="form-control" required placeholder="Enter company code">
                  <i class="ti ti-hash field-icon"></i>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">Company Logo <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="file" name="company_logo" class="form-control">
                  <i class="ti ti-upload field-icon"></i>
              </div>
              <input type="hidden" name="hidden_company_logo" value="<%if isset($company) %><%$company.company_logo%><%/if%>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Contact Person <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="text" name="contact_person" value="<%if isset($company) %><%$company.contact_person%><%/if%>" class="form-control" required placeholder="Enter contact person name">
                  <i class="ti ti-user field-icon"></i>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">Email <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="email" name="email" value="<%if isset($company) %><%$company.email%><%/if%>" class="form-control" required placeholder="Enter email address">
                  <i class="ti ti-mail field-icon"></i>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">Phone <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="tel" name="phone" value="<%if isset($company) %><%$company.phone%><%/if%>" class="form-control" required placeholder="Enter phone number">
                  <i class="ti ti-phone field-icon"></i>
              </div>
            </div>
            <div class="col-md-12">
              <label class="form-label">Address <span class="text-danger">*</span></label>
              <textarea name="address" class="form-control" rows="2" required placeholder="Enter address"><%if isset($company) %><%$company.address%><%/if%></textarea>
            </div>
            <div class="col-md-4">
              <label class="form-label">City <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="text" name="city" value="<%if isset($company) %><%$company.city%><%/if%>" class="form-control" required placeholder="Enter city">
                  <i class="ti ti-map field-icon"></i>
              </div>
            </div>
            <div class="col-md-4">
              <label class="form-label">State <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="text" name="state" value="<%if isset($company) %><%$company.state%><%/if%>" class="form-control" required placeholder="Enter state">
                  <i class="ti ti-map field-icon"></i>
              </div>
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
              <div class="position-relative">
                  <input type="text" name="gst_number" value="<%if isset($company) %><%$company.gst_number%><%/if%>" class="form-control" required placeholder="Enter GST number">
                  <i class="ti ti-file-invoice field-icon"></i>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">GST Certificate <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="file" name="gst_certificate" class="form-control">
                  <i class="ti ti-upload field-icon"></i>
              </div>
              <input type="hidden" name="hidden_gst_certificate" value="<%if isset($company) %><%$company.gst_certificate%><%/if%>">
            </div>
            <div class="col-md-6">
              <label class="form-label">PAN Number <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="text" name="pan_number" value="<%if isset($company) %><%$company.pan_number%><%/if%>" class="form-control" required placeholder="Enter PAN number">
                  <i class="ti ti-id field-icon"></i>
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label">PAN Card Image <span class="text-danger">*</span></label>
              <div class="position-relative">
                  <input type="file" name="pan_card_img" class="form-control">
                  <i class="ti ti-upload field-icon"></i>
              </div>
              <input type="hidden" name="hidden_pan_card_img" value="<%if isset($company) %><%$company.pan_card_img%><%/if%>">
            </div>
          </div>

          <div class="mt-5 text-end">
            <input type="hidden" id="mode" value="<%if isset($company)%>Update<%else%>Add<%/if%>">
            <input type="hidden" id="company_id" name="company_id" value="<%if isset($company) %><%$company.company_id%><%/if%>">
            <a href="<%base_url('company')%>" class="btn btn-outline-secondary me-2 px-4 py-2">Cancel</a>
            <button type="submit" class="cat-btn cat-btn-primary px-5 py-2"><i class="ti ti-device-floppy me-2"></i> Save Company</button>
          </div>
        </form>
      </div>
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
