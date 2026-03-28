<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm border-0 overflow-hidden">
                <div class="card-header bg-primary-gradient p-4">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-lg me-3">
                            <span class="avatar-initial rounded bg-white-transparent"><i class="ti ti-settings ti-md text-white"></i></span>
                        </div>
                        <div>
                            <h4 class="text-white mb-0">System Settings</h4>
                            <p class="text-white opacity-75 mb-0">Configure your application-wide preferences and branding</p>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="nav-align-left">
                        <ul class="nav nav-tabs border-0 bg-light-gray" role="tablist" style="width: 250px;">
                            <li class="nav-item">
                                <button type="button" class="nav-link active py-3 border-0 rounded-0" role="tab" data-bs-toggle="tab" data-bs-target="#navs-general" aria-controls="navs-general" aria-selected="true">
                                    <i class="ti ti-building ti-sm me-2"></i> General Branding
                                </button>
                            </li>
                            <li class="nav-item">
                                <button type="button" class="nav-link py-3 border-0 rounded-0" role="tab" data-bs-toggle="tab" data-bs-target="#navs-security" aria-controls="navs-security" aria-selected="false">
                                    <i class="ti ti-shield-lock ti-sm me-2"></i> Security & Access
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content border-0 shadow-none p-4">
                            <!-- General Branding Tab -->
                            <div class="tab-pane fade show active" id="navs-general" role="tabpanel">
                                <form id="settingsFormGeneral" enctype="multipart/form-data">
                                    <h5 class="mb-4 d-flex align-items-center"><i class="ti ti-palette me-2 text-primary"></i> Brand Identity</h5>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Company Name</label>
                                            <div class="input-group input-group-merge">
                                                <span class="input-group-text"><i class="ti ti-building"></i></span>
                                                <input type="text" name="company_name" class="form-control" value="<%$settings['company_name']['value']|default:''%>" placeholder="Enter company name">
                                            </div>
                                            <small class="text-muted"><%$settings['company_name']['description']%></small>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Company Logo</label>
                                            <div class="d-flex align-items-center mt-2">
                                                <div class="flex-shrink-0 me-3">
                                                    <img src="<%$base_url%><%$settings['company_logo']['value']|default:'public/assets/img/avatars/1.png'%>" alt="Logo" class="rounded border p-1" height="80" id="logoPreview">
                                                </div>
                                                <div class="flex-grow-1">
                                                    <input class="form-control" type="file" id="company_logo" name="company_logo" onchange="previewImage(this, 'logoPreview')">
                                                    <small class="text-muted mt-1 d-block"><%$settings['company_logo']['description']%> (Recommended: 250x80px PNG)</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Favicon</label>
                                            <div class="d-flex align-items-center mt-2">
                                                <div class="flex-shrink-0 me-3">
                                                    <img src="<%$base_url%><%$settings['company_fav_icon']['value']|default:'public/assets/img/favicon/favicon.ico'%>" alt="Favicon" class="rounded border p-1" height="32" width="32" id="faviconPreview">
                                                </div>
                                                <div class="flex-grow-1">
                                                    <input class="form-control form-control-sm" type="file" id="company_fav_icon" name="company_fav_icon" onchange="previewImage(this, 'faviconPreview')">
                                                    <small class="text-muted mt-1 d-block"><%$settings['company_fav_icon']['description']%> (Recommended: 32x32px ICO/PNG)</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <hr class="my-4">
                                    <div class="d-flex justify-content-end">
                                        <button type="submit" class="btn btn-primary d-flex align-items-center">
                                            <i class="ti ti-device-floppy me-2"></i> Save Changes
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- Security Tab -->
                            <div class="tab-pane fade" id="navs-security" role="tabpanel">
                                <form id="settingsFormSecurity">
                                    <h5 class="mb-4 d-flex align-items-center"><i class="ti ti-lock-access me-2 text-danger"></i> Authentication Security</h5>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Login Attempts Limit</label>
                                            <div class="input-group input-group-merge" style="max-width: 200px;">
                                                <span class="input-group-text"><i class="ti ti-hand-stop"></i></span>
                                                <input type="number" name="login_attempt" class="form-control" value="<%$settings['login_attempt']['value']|default:'5'%>" min="1" max="10">
                                            </div>
                                            <small class="text-muted"><%$settings['login_attempt']['description']%> (Recommended: 3-5)</small>
                                        </div>
                                    </div>

                                    <hr class="my-4">
                                    <div class="d-flex justify-content-end">
                                        <button type="submit" class="btn btn-primary d-flex align-items-center">
                                            <i class="ti ti-device-floppy me-2"></i> Save Security Settings
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.bg-primary-gradient { background: linear-gradient(135deg, #7367f0 0%, #9e95f5 100%); }
.bg-white-transparent { background-color: rgba(255, 255, 255, 0.2); }
.bg-light-gray { background-color: #f8f9fa; }

.nav-tabs .nav-link {
    text-align: left;
    color: #5d596c;
    font-weight: 500;
}
.nav-tabs .nav-link.active {
    background-color: #fff !important;
    color: #7367f0 !important;
    border-right: 3px solid #7367f0 !important;
}
.nav-tabs .nav-link:hover:not(.active) {
    background-color: #f1f0f2;
}

.tab-content {
    min-height: 400px;
}

.card-header.bg-primary-gradient {
    border-bottom: 0;
}

.avatar-lg {
    width: 48px;
    height: 48px;
}
</style>

<script>
function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById(previewId).src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}
</script>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/settings.js"></script>
