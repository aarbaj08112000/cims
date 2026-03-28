
<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">
        <nav aria-label="breadcrumb">
            <div class="sub-header-left pull-left breadcrumb">
                <h1>
                    Home
                    <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Company Details">
                        <i class="ti ti-chevrons-right"></i>
                        <em>Company</em></a>
                </h1>
                <br>
                <span>Details</span>
            </div>
        </nav>

        <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
            <a href="edit_company/<%$company['company_id']%>" class="btn btn-primary" title="Edit Company">
                <i class="ti ti-edit me-1"></i> Edit Company
            </a>
        </div>

        <div class="row">
            <!-- Company Overview -->
            <div class="col-xl-4 col-lg-5 col-md-5">
                <div class="card mb-4 mt-4">
                    <div class="card-body">
                        <div class="user-avatar-section">
                            <div class="d-flex align-items-center flex-column">
                                <img class="img-fluid rounded mb-3 pt-1 mt-4" 
                                     src="public/uploads/company/<%$company['company_logo']%>" 
                                     height="100" width="100" 
                                     alt="Company Logo"
                                     onerror="this.src='public/assets/images/no_image.jpg';">
                                <div class="user-info text-center">
                                    <h4 class="mb-2"><%$company['company_name']%></h4>
                                    <span class="badge bg-label-secondary mt-1"><%$company['company_code']%></span>
                                </div>
                            </div>
                        </div>
                        <p class="mt-4 small text-uppercase text-muted">Details</p>
                        <div class="info-container">
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <span class="fw-medium me-1">Email:</span>
                                    <span><%$company['email']%></span>
                                </li>
                                <li class="mb-2">
                                    <span class="fw-medium me-1">Phone:</span>
                                    <span><%$company['phone']%></span>
                                </li>
                                <li class="mb-2">
                                    <span class="fw-medium me-1">Status:</span>
                                    <span class="badge bg-label-success"><%$company['status']%></span>
                                </li>
                                <li class="mb-2">
                                    <span class="fw-medium me-1">GST NO:</span>
                                    <span><%$company['gst_number']%></span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Company Info & Documents -->
            <div class="col-xl-8 col-lg-7 col-md-7">
                <div class="card mb-4 mt-4">
                    <h5 class="card-header"><i class="ti ti-info-circle me-1"></i> Company Information</h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-6 mb-3">
                                <label class="text-muted mb-1">Contact Person</label>
                                <p class="fw-medium"><%$company['contact_person']%></p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <label class="text-muted mb-1">PAN Number</label>
                                <p class="fw-medium"><%$company['pan_number']%></p>
                            </div>
                            <div class="col-12 mb-3">
                                <label class="text-muted mb-1">Address</label>
                                <p class="fw-medium"><%$company['address']%>, <%$company['city']%>, <%$company['state']%> - <%$company['pincode']%>, <%$company['country']%></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <h5 class="card-header"><i class="ti ti-file-text me-1"></i> Documents</h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-6 text-center">
                                <div class="border rounded p-3 mb-2">
                                    <p class="mb-2 small fw-medium">GST Certificate</p>
                                    <a href="public/uploads/company/<%$company['gst_certificate']%>" target="_blank">
                                        <i class="ti ti-file-description fs-1 mb-2 text-primary"></i><br>
                                        View Certificate
                                    </a>
                                </div>
                            </div>
                            <div class="col-sm-6 text-center">
                                <div class="border rounded p-3 mb-2">
                                    <p class="mb-2 small fw-medium">PAN Card Image</p>
                                    <a href="public/uploads/company/<%$company['pan_card_img']%>" target="_blank">
                                        <i class="ti ti-id fs-1 mb-2 text-primary"></i><br>
                                        View PAN Card
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
