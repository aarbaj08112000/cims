<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
/* Custom modern details styling */
.details-card {
    border: none;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.05);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.details-card:hover {
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
}
.details-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    border-bottom: 1px solid #f1f1f4;
    padding: 1.5rem;
    border-radius: 12px 12px 0 0;
}
.details-body {
    padding: 1.5rem;
}
.company-logo-wrapper {
    width: 130px;
    height: 130px;
    border-radius: 50%;
    padding: 5px;
    background: #fff;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}
.company-logo-wrapper img {
    max-width: 100%;
    max-height: 100%;
    border-radius: 50%;
    object-fit: cover;
}
.info-label {
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #a1a5b7;
    margin-bottom: 5px;
    display: block;
    font-weight: 600;
}
.info-value {
    font-size: 1.05rem;
    color: #3f4254;
    font-weight: 500;
    display: flex;
    align-items: center;
}
.info-value i {
    color: #7239ea;
    margin-right: 10px;
    font-size: 1.3rem;
}
.doc-card {
    border: 1px solid #e4e6ef;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
    background: #fff;
    transition: all 0.3s;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.doc-card:hover {
    border-color: #7239ea;
    background: #fcfbfe;
    transform: translateY(-3px);
}
.doc-icon {
    font-size: 3.5rem;
    color: #7239ea;
    margin-bottom: 15px;
}
.doc-title {
    font-weight: 600;
    color: #3f4254;
    margin-bottom: 15px;
}
.doc-preview-img {
    max-width: 100%;
    height: 140px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 15px;
    border: 1px solid #eee;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}
</style>

<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">
        
        <!-- Page Header -->
        <div class="cat-page-header mb-4">
            <div class="cat-page-header-left">
                <div class="cat-page-icon">
                    <i class="ti ti-building"></i>
                </div>
                <div>
                    <h1 class="cat-page-title">Company Details</h1>
                    <nav class="cat-breadcrumb">
                        <a href="<%$base_url%>">Home</a>
                        <i class="ti ti-chevron-right"></i>
                        <a href="<%$base_url%>company">Company</a>
                        <i class="ti ti-chevron-right"></i>
                        <span>Details</span>
                    </nav>
                </div>
            </div>
            <div class="cat-page-header-right">
                <a href="edit_company/<%$company['company_id']%>" class="cat-btn cat-btn-primary text-white" title="Edit Company">
                    <i class="ti ti-edit"></i> Edit Company
                </a>
            </div>
        </div>

        <div class="row">
            <!-- Left Sidebar - Profile Overview -->
            <div class="col-xl-4 col-lg-5 col-md-5 mb-4">
                <div class="card details-card h-100">
                    <div class="details-header text-center pt-5 pb-4">
                        <div class="company-logo-wrapper mb-4">
                            <img src="public/uploads/company/<%$company['company_logo']%>" 
                                 onerror="this.src='public/assets/images/no_image.jpg';" 
                                 alt="Company Logo">
                        </div>
                        <h3 class="mb-2 fw-bold text-dark"><%$company['company_name']%></h3>
                        <span class="badge bg-label-primary mb-3 px-3 py-2 fs-6"><i class="ti ti-hash me-1"></i><%$company['company_code']%></span>
                        <div>
                            <%if $company['status'] == 'Active' %>
                                <span class="cat-badge cat-badge-active px-3 py-2 fs-6">Active</span>
                            <%else %>
                                <span class="cat-badge cat-badge-inactive px-3 py-2 fs-6">Inactive</span>
                            <%/if %>
                        </div>
                    </div>
                    <div class="details-body">
                        <h6 class="text-uppercase text-muted fw-bold mb-4" style="letter-spacing: 1px; font-size: 0.8rem;"><i class="ti ti-id-badge me-2"></i> Contact Overview</h6>
                        
                        <div class="mb-4">
                            <span class="info-label">Email Address</span>
                            <div class="info-value"><i class="ti ti-mail"></i> <%$company['email']%></div>
                        </div>
                        <div class="mb-4">
                            <span class="info-label">Phone Number</span>
                            <div class="info-value"><i class="ti ti-phone"></i> <%$company['phone']%></div>
                        </div>
                        <div class="mb-0">
                            <span class="info-label">GST Number</span>
                            <div class="info-value"><i class="ti ti-file-invoice"></i> <%$company['gst_number']%></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column - Detailed Info & Documents -->
            <div class="col-xl-8 col-lg-7 col-md-7">
                
                <!-- Company Information -->
                <div class="card details-card mb-4">
                    <div class="details-header">
                        <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-info-square-rounded fs-3 me-2 text-primary"></i> Company Information</h5>
                    </div>
                    <div class="details-body">
                        <div class="row g-4">
                            <div class="col-sm-6">
                                <div class="p-3 border rounded bg-light-subtle h-100 transition-hover">
                                    <span class="info-label">Contact Person</span>
                                    <div class="info-value"><i class="ti ti-user-circle"></i> <%$company['contact_person']%></div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="p-3 border rounded bg-light-subtle h-100 transition-hover">
                                    <span class="info-label">PAN Number</span>
                                    <div class="info-value"><i class="ti ti-id"></i> <%$company['pan_number']%></div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="p-3 border rounded bg-light-subtle transition-hover">
                                    <span class="info-label">Full Address</span>
                                    <div class="info-value align-items-start">
                                        <i class="ti ti-map-pin mt-1"></i> 
                                        <span>
                                            <%$company['address']%><br>
                                            <%$company['city']%>, <%$company['state']%> - <%$company['pincode']%><br>
                                            <%$company['country']%>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documents Section -->
                <div class="card details-card mb-4">
                    <div class="details-header">
                        <h5 class="mb-0 fw-bold d-flex align-items-center text-dark"><i class="ti ti-files fs-3 me-2 text-primary"></i> Essential Documents</h5>
                    </div>
                    <div class="details-body">
                        <div class="row g-4">
                            
                            <!-- GST Certificate -->
                            <div class="col-sm-6">
                                <div class="doc-card">
                                    <div>
                                        <%if $company['gst_certificate']%>
                                            <%assign var="gst_ext" value=$company['gst_certificate']|pathinfo:$smarty.const.PATHINFO_EXTENSION|strtolower%>
                                            <%if $gst_ext == 'jpg' || $gst_ext == 'jpeg' || $gst_ext == 'png' || $gst_ext == 'webp'%>
                                                <img src="public/uploads/company/<%$company['gst_certificate']%>" class="doc-preview-img" alt="GST Certificate" onerror="this.style.display='none'">
                                            <%else%>
                                                <i class="ti ti-file-certificate doc-icon"></i>
                                            <%/if%>
                                        <%else%>
                                            <i class="ti ti-file-certificate doc-icon text-muted"></i>
                                        <%/if%>
                                        <h6 class="doc-title">GST Certificate</h6>
                                    </div>
                                    
                                    <%if $company['gst_certificate']%>
                                        <a href="public/uploads/company/<%$company['gst_certificate']%>" target="_blank" class="btn btn-primary w-100">
                                            <i class="ti ti-eye me-1"></i> View Document
                                        </a>
                                    <%else%>
                                        <button class="btn btn-outline-secondary w-100" disabled>Not Uploaded</button>
                                    <%/if%>
                                </div>
                            </div>

                            <!-- PAN Card -->
                            <div class="col-sm-6">
                                <div class="doc-card">
                                    <div>
                                        <%if $company['pan_card_img']%>
                                            <%assign var="pan_ext" value=$company['pan_card_img']|pathinfo:$smarty.const.PATHINFO_EXTENSION|strtolower%>
                                            <%if $pan_ext == 'jpg' || $pan_ext == 'jpeg' || $pan_ext == 'png' || $pan_ext == 'webp'%>
                                                <img src="public/uploads/company/<%$company['pan_card_img']%>" class="doc-preview-img" alt="PAN Card" onerror="this.style.display='none'">
                                            <%else%>
                                                <i class="ti ti-id doc-icon"></i>
                                            <%/if%>
                                        <%else%>
                                            <i class="ti ti-id doc-icon text-muted"></i>
                                        <%/if%>
                                        <h6 class="doc-title">PAN Card</h6>
                                    </div>
                                    
                                    <%if $company['pan_card_img']%>
                                        <a href="public/uploads/company/<%$company['pan_card_img']%>" target="_blank" class="btn btn-primary w-100">
                                            <i class="ti ti-eye me-1"></i> View Document
                                        </a>
                                    <%else%>
                                        <button class="btn btn-outline-secondary w-100" disabled>Not Uploaded</button>
                                    <%/if%>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
