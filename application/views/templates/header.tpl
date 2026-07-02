      
<!DOCTYPE html>
<html
   lang="en"
   class="light-style layout-menu-fixed layout-menu-collapsed  layout-navbar-fixed "
   dir="ltr"
   data-theme="theme-default"
   data-assets-path="<%$base_url%>public/assets/"
   data-template="vertical-menu-template-free"
   >
   <head>
      <meta charset="utf-8" />
      <meta
         name="viewport"
         content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
         />
      <title><%$config['company_name']%></title>
      <meta name="description" content="" />
      <base href="<%base_url()%>">
      <!-- Favicon -->
      <link rel="icon" type="image/x-icon" href="<%base_url()%><%$config['company_fav_icon']%>" />
      <!-- Fonts -->
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
      <link
         href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
         rel="stylesheet"
         />
       <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
      <!-- Icons. Uncomment required icon fonts -->
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/fonts/boxicons.css" />

      <!-- lineawesome --->
      <link rel="stylesheet" href="<%$base_url%>public/css/line-awesome/1.3.0/css/line-awesome.css">
      <link rel="stylesheet" href="<%$base_url%>public/css/line-awesome/1.3.0/css/line-awesome.min.css">

      <!-- lineawesome --->

      <!-- tabler css -->
      <link rel="stylesheet" href="<%$base_url%>public/css/plugin/tabler_css/tabler_icons.css">
      <!-- Core CSS -->
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/css/core.css" class="template-customizer-core-css" />
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
      <link rel="stylesheet" href="<%$base_url%>public/assets/css/theme.css" />
      <!-- Vendors CSS -->
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/libs/apex-charts/apex-charts.css" />
      <link rel="stylesheet" href="<%$base_url%>public/css/common.css" />
      <link rel="stylesheet" href="<%$base_url%>public/css/admin_modern.css" />
      <!-- Page CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
      <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/data_table/searchPanes.dataTables.min.css">
      <!-- Helpers -->
      <!-- <script src="<%$base_url%>public/assets/vendor/js/helpers.js"></script> -->
      <script src="<%$base_url%>public/assets/js/config.js"></script>
      <script src="<%$base_url%>public/assets/vendor/js/bootstrap.js"></script>
      <script src="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
      <script src="<%$base_url%>public/js/admin/plugin/jquery.min.js"></script>
      <script src="<%$base_url%>public/js/admin/plugin/jquery.validate.js"></script>
      <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/pdfmake.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/vfs_fonts.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
      <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/fixedcolumns/3.3.3/js/dataTables.fixedColumns.min.js"></script>
      <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
      <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/fixedcolumns/3.3.3/css/fixedColumns.dataTables.min.css">
      <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/data_table/datatable.css">
      <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/datatable-standard.css">
      <script src="<%$base_url%>public/js/admin_panel/global_datatable_setup.js"></script>
      <!-- select2 -->
      <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
      <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
      <!-- toastr -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
      <!-- date picker  -->
      <!-- <script src="https://cdn.jsdelivr.net/npm/moment/min/moment.min.js"></script>
         <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
         <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"> -->
      <script type="text/javascript" src="<%base_url()%>public/plugin/datepicker/moment.min.js"></script>
      <script type="text/javascript" src="<%base_url()%>public/plugin/datepicker/daterangepicker.min.js"></script>
      <link rel="stylesheet" type="text/css" href="<%base_url()%>public/plugin/datepicker/daterangepicker.css" />
      <script type="text/javascript">
         var theme_color = "#ea1c31";
      </script>
    <!-- toaster -->
      <link rel="stylesheet" href="public/css/toaster/custom_toaster.css" />
      <link rel="stylesheet" href="public/css/fontawesome/font_awesome.css">
     <!-- toaster -->
     <script type="text/javascript">
        var default_page_view_type = <%json_decode($config['default_page_view_type'])|@json_encode%>;
     </script>
     <script type="text/javascript" src="<%base_url()%>public/js/admin/grid_structure.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
div:where(.swal2-icon) .swal2-icon-content {
   font-size: 45px;
}
</style>

   </head>
   <body>
      <!-- Layout wrapper -->
      <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container outer-div-box">
      <!-- Menu -->
      <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme ">
         <div class="app-brand demo justify-content-center" style="height: 75px; border-bottom: 1px solid rgba(165,163,174,0.08);">
            <a href="dashboard" class="app-brand-link">
               <img src="<%base_url()%><%$config['company_logo']%>" alt="Logo" style="max-height: 45px; width: auto; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));">
            </a>
            <i class="ti ti-x fs-3 close-vertical-btn d-block d-xl-block toggle-sidebar-btn" id="close-vertical-btn" title="Close" style="cursor: pointer;"></i>
         </div>
         <div class="menu-inner-shadow"></div>
          <ul class="menu-inner py-1">
             <%assign var="current_uri" value=$smarty.server.REQUEST_URI%>
             <!-- Dashboard -->
             <li class="menu-item <%if strpos($current_uri, 'dashboard') !== false%>active<%/if%>">
                <a href="dashboard" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-home-circle"></i>
                   <div data-i18n="Dashboard">Dashboard</div>
                </a>
             </li>

             <!-- Master Management -->
             <li class="menu-item <%if stripos($current_uri, 'category') !== false || stripos($current_uri, 'brand') !== false || stripos($current_uri, 'product') !== false%>active open<%/if%>">
                <a href="javascript:void(0);" class="menu-link menu-toggle">
                   <i class="menu-icon tf-icons bx bx-data"></i>
                   <div data-i18n="Master Management">Master Management</div>
                </a>
                <ul class="menu-sub">
                   <li class="menu-item <%if stripos($current_uri, 'category') !== false%>active<%/if%>">
                      <a href="category" class="menu-link">
                         <i class="menu-icon tf-icons bx bx-grid-alt hide"></i>
                         <div data-i18n="Category">Category</div>
                      </a>
                   </li>
                   <li class="menu-item <%if stripos($current_uri, 'brand') !== false%>active<%/if%>">
                      <a href="brand" class="menu-link">
                         <i class="menu-icon tf-icons bx bx-award hide"></i>
                         <div data-i18n="Brand">Brand</div>
                      </a>
                   </li>
                   <li class="menu-item <%if stripos($current_uri, 'product') !== false%>active<%/if%>">
                      <a href="product" class="menu-link">
                         <i class="menu-icon tf-icons bx bx-cube hide"></i>
                         <div data-i18n="Product">Product</div>
                      </a>
                   </li>
                </ul>
             </li>

             <!-- Supplier Management -->
             <li class="menu-item <%if strpos($current_uri, 'supplier') !== false%>active<%/if%>">
                <a href="supplier" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-store-alt"></i>
                   <div data-i18n="Supplier Management">Supplier Management</div>
                </a>
             </li>

             <%*
             <!-- Customer Management -->
             <li class="menu-item <%if strpos($current_uri, 'customer') !== false%>active<%/if%>">
                <a href="customer" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-user-pin"></i>
                   <div data-i18n="Customer Management">Customer Management</div>
                </a>
             </li>
             *%>

             <!-- Purchase Management -->
             <li class="menu-item <%if strpos($current_uri, 'purchase') !== false%>active open<%/if%>">
                <a href="javascript:void(0);" class="menu-link menu-toggle">
                   <i class="menu-icon tf-icons bx bx-cart-alt"></i>
                   <div data-i18n="Purchase Management">Purchase Management</div>
                </a>
                <ul class="menu-sub">
                   <li class="menu-item <%if strpos($current_uri, 'create_purchase') !== false%>active<%/if%>">
                      <a href="create_purchase" class="menu-link">
                         <div data-i18n="Create Purchase">Create Purchase</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'purchase_list') !== false%>active<%/if%>">
                      <a href="purchase_list" class="menu-link">
                         <div data-i18n="Purchase List">Purchase List</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'purchase_return') !== false%>active<%/if%>">
                      <a href="purchase_return" class="menu-link">
                         <div data-i18n="Purchase Return">Purchase Return</div>
                      </a>
                   </li>
                </ul>
             </li>

             <!-- Sales Management -->
             <li class="menu-item <%if strpos($current_uri, 'sales') !== false%>active open<%/if%>">
                <a href="javascript:void(0);" class="menu-link menu-toggle">
                   <i class="menu-icon tf-icons bx bx-trending-up"></i>
                   <div data-i18n="Sales Management">Sales Management</div>
                </a>
                <ul class="menu-sub">
                   <li class="menu-item <%if strpos($current_uri, 'create_sale') !== false%>active<%/if%>">
                      <a href="create_sale" class="menu-link">
                         <div data-i18n="Create Sale">Create Sale</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'sales_list') !== false%>active<%/if%>">
                      <a href="sales_list" class="menu-link">
                         <div data-i18n="Sales List">Sales List</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'sales_return') !== false%>active<%/if%>">
                      <a href="sales_return" class="menu-link">
                         <div data-i18n="Sales Return">Sales Return</div>
                      </a>
                   </li>
                </ul>
             </li>
             
             <!-- POS Billing -->
             <li class="menu-item <%if strpos($current_uri, 'pos') !== false%>active<%/if%>">
                <a href="pos" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-calculator"></i>
                   <div data-i18n="POS Billing">POS Billing</div>
                </a>
             </li>

             <!-- Stock Management -->
             <li class="menu-item <%if strpos($current_uri, 'stock') !== false%>active<%/if%>">
                <a href="stock" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-package"></i>
                   <div data-i18n="Stock Management">Stock Management</div>
                </a>
             </li>

             <!-- Reports -->
             <li class="menu-item <%if strpos($current_uri, 'reports') !== false || strpos($current_uri, 'sales_report') !== false || strpos($current_uri, 'purchase_report') !== false || strpos($current_uri, 'stock_valuation_report') !== false || strpos($current_uri, 'stock_adjustment_report') !== false%>active open<%/if%>">
                <a href="javascript:void(0);" class="menu-link menu-toggle">
                   <i class="menu-icon tf-icons bx bx-bar-chart-alt-2"></i>
                   <div data-i18n="Reports">Reports</div>
                </a>
                <ul class="menu-sub">
                   <li class="menu-item <%if $current_uri == 'reports'%>active<%/if%>">
                      <a href="reports" class="menu-link">
                         <div data-i18n="Quick Report">Quick Report</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'sales_report') !== false%>active<%/if%>">
                      <a href="sales_report" class="menu-link">
                         <div data-i18n="Sales Report">Sales Report</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'purchase_report') !== false%>active<%/if%>">
                      <a href="purchase_report" class="menu-link">
                         <div data-i18n="Purchase Report">Purchase Report</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'stock_valuation_report') !== false%>active<%/if%>">
                       <a href="stock_valuation_report" class="menu-link">
                          <div data-i18n="Stock Valuation Report">Stock Valuation Report</div>
                       </a>
                    </li>
                    <li class="menu-item <%if strpos($current_uri, 'stock_adjustment_report') !== false%>active<%/if%>">
                       <a href="stock_adjustment_report" class="menu-link">
                          <div data-i18n="Stock Adjustment Report">Stock Adjustment Report</div>
                       </a>
                    </li>
                 </ul>
             </li>

             <!-- User Management -->
             <li class="menu-item <%if strpos($current_uri, 'user_list') !== false || strpos($current_uri, 'group_master') !== false%>active open<%/if%>">
                <a href="javascript:void(0);" class="menu-link menu-toggle">
                   <i class="menu-icon tf-icons bx bx-user-circle"></i>
                   <div data-i18n="User Management">User Management</div>
                </a>
                <ul class="menu-sub">
                   <li class="menu-item <%if strpos($current_uri, 'user_list') !== false%>active<%/if%>">
                      <a href="user_list" class="menu-link">
                         <div data-i18n="User">User</div>
                      </a>
                   </li>
                   <li class="menu-item <%if strpos($current_uri, 'group_master') !== false%>active<%/if%>">
                      <a href="group_master" class="menu-link">
                         <div data-i18n="Group Master">Group Master</div>
                      </a>
                   </li>
                </ul>
             </li>

             <!-- Company -->
             <li class="menu-item <%if strpos($current_uri, 'company') !== false%>active<%/if%>">
                <a href="company" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-buildings"></i>
                   <div data-i18n="Company">Company</div>
                </a>
             </li>

             <!-- Settings -->
             <li class="menu-item <%if strpos($current_uri, 'settings') !== false%>active<%/if%>">
                <a href="settings" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-cog"></i>
                   <div data-i18n="Settings">Settings</div>
                </a>
             </li>

             <!-- System Documentation -->
             <li class="menu-item <%if strpos($current_uri, 'documentation') !== false%>active<%/if%>">
                <a href="documentation" class="menu-link">
                   <i class="menu-icon tf-icons bx bx-help-circle"></i>
                   <div data-i18n="System Guide">System Guide</div>
                </a>
             </li>
          </ul>

      </aside>
      <div class="main-wrap main-wrap--white main-loader-box" style="display: none;">
         <div class="loader-div"></div>
      </div>
      <!-- / Menu -->
      <!-- Layout container -->
      <div class="layout-page">
      <!-- Navbar -->
      <!-- / Navbar -->

      <nav class="navbar navbar-expand-lg bg-navbar-theme navbar-classic">
         <div class="container-fluid">
            <a href="dashboard" class="app-brand-link navbar-brand">
            <span class="app-brand-logo demo">
            <img src="<%base_url()%><%$config['company_logo']%>" alt="" width="150" title="<%$config['company_name']%>">
            </span>
            <!-- <span class="stat-cards-info__num fw-bolder ms-2 pt-1">AROM</span> -->
            </a>

            <!-- for horizontal menu bar  -->

            <%if $config['menu_type'] eq 'horizontal'%>
            <p class="horizontal-line-header" style="
    border-left: 1px solid gray;
    padding: 0px;
    margin: 0px;
    height: 38px;
    padding-right: 4px;
">&nbsp;</p>
            <button class="navbar-toggler collapsed " id="toggle-horizontal-menu-bar" type="button" style="display:block; " title="Menu">
            <span class="ti ti-menu-2 h3"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
               <ul class="navbar-nav">
               </ul>
            </div>
            <%/if%>
           

            <!-- vertical menu bar -->
            <%if $config['menu_type'] eq 'vertical'%>
            <button class="navbar-toggler top-sidebar-toggle-btn d-block d-xl-block toggle-sidebar-btn" type="button" aria-label="Toggle navigation" style="border: none; background: transparent; padding: 0.25rem 0;">
               <i class="ti ti-menu-2 text-primary" style="font-size: 1.5rem;"></i>
            </button>
            <%/if%>
            <%if !(strpos($smarty.server.PATH_INFO, "/sitemap") !== false) %>
            <i class="ti ti-category quick-menu-bar login-nav-block-mobile" title="Quick Menu"></i>
            <%/if%>

            <div class="navbar-right-wrap ms-2 d-flex align-items-center nav-top-wrap navbar-nav">
               <div class="header_userprofile_blk me-2">
                  <img src="public/assets/images/user.png" width="38" height="38" onerror="imageLoadingError(this,'top-profile-image', 'S')" >
               </div>
               <div class="profile-info">
                  <span class="profile-name"><%$session_data['user_name']%></span>
                  <em class="text-muted" style="font-size: 11px; display: block; margin-top: -4px;"><%$session_data['role']%></em>
               </div>
               <ul class="navbar-right-wrap ms-auto d-flex nav-top-wrap navbar-nav">
                  <li class="ms-2 dropdown">
                     <a class="dropdownUser inactive" id="dropdownUser" aria-expanded="false">
                        <i class="las la-angle-down"></i>
                     </a>
                     <div data-bs-popper="static" class="dropdown-menu dropdown-menu-end  dropdown-menu dropdown-menu-end dropdownUserNav" aria-labelledby="dropdownUser" id="dropdownUserNav">
                        <div data-rr-ui-dropdown-item="" class=" ">
                           <ul class="top-menu ps-0">
                              <li class="top-child-menu">
                                    <a href="javascript:void(0);" title="Reset Password" class="top-menu-link" data-bs-toggle="modal" data-bs-target="#headerForgotPasswordModal">
                                        <span class="las la-user"></span>Reset Password
                                    </a>
                              </li>
                              <li class="top-child-menu">
                                    <a hijacked="yes" href="<%base_url('logout')%>" title="" class="top-menu-link">
                                        <span class="las la-sign-in-alt"></span>Sign Out
                                    </a>
                              </li>

                           </ul>
                           <!-- <div class="lh-1 ">
                              <h5 class="mb-1">  <%$session_data['user_name']%></h5>
                              <a class="text-inherit fs-6" href="javascript:void(0)"><%$session_data['user_email']%></a>
                              <h6 class="mt-2">(<%$session_data['clientUnitName']%>)</h6>
                           </div>
                           <div class=" dropdown-divider mt-3 mb-2"></div> -->
                        </div>
                        <!-- <a data-rr-ui-dropdown-item="" class="dropdown-item" role="button" tabindex="0" href="<%base_url('logout')%>"><i class="ti ti-power me-2" ti></i>Sign Out</a> -->
                     </div>
                  </li>
               </ul>
            </div>
            <%if $config['menu_type'] eq 'vertical'%>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
               <ul class="navbar-nav">
                  <!-- <li class="nav-item">
                     <a class="nav-link active" aria-current="page" href="http://localhost/extra_work/erp_converted/dashboard">Dashboard</a>
                  </li> -->
                  <!-- <li class="nav-item">
                     <a class="nav-link" href="http://localhost/extra_work/erp_converted/home_2">Charts</a>
                     </li> -->
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkPurchase" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     User Management
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkPurchaseSubmenu">
                        <li>
                           <a href="<%$base_url%>user_list" class="dropdown-item">User</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>group_master" class="dropdown-item">Group Master</a>
                        </li>
                        
                     </ul>
                  </li>
                  <!-- <li class="nav-item">
                     <a href="http://localhost/extra_work/erp_converted/logout" class="nav-link">Logout</a>
                     </li> -->
               </ul>
            </div>
            <%/if%>

            <%if !(strpos($smarty.server.PATH_INFO, "/sitemap") !== false) %>
            <div class="menu_show ms-3" >
               <i class="ti ti-category quick-menu-bar login-nav-block ms-2" title="Quick Menu"></i>
            </div>
            <%/if%>
         </div>
      </nav>
      <!-- Forgot Password Modal -->
<div class="modal fade" id="headerForgotPasswordModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg">
      <div class="modal-header border-bottom-0 pb-0">
        <h5 class="modal-title fw-bold" style="color: var(--primary-color);">Reset Password</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body pt-3">
        <p class="text-muted small mb-4">Enter your email and we'll send you instructions to reset your password.</p>
        <form id="headerFormResetPassword" action="javascript:void(0)" method="POST">
          <div class="form-group mb-3">
            <label class="form-label small fw-bold text-uppercase">Email Address</label>
            <div class="input-group-modern border rounded">
              <i class="ti ti-mail" style="color: var(--primary-color);"></i>
              <input type="email" name="username" id="header_forgot_email" class="form-control border-0 bg-transparent ms-4" placeholder="Enter your email" required style="padding-left: 20px;">
            </div>
            <div class="error-msg text-danger small mt-1" id="header_forgot_emailErr"></div>
          </div>
          <div class="mt-4">
            <button type="submit" class="btn btn-primary w-100 py-2 fw-bold" id="headerResetBtn">Send Reset Link</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="public/js/header_forgot_password.js"></script>
      <!-- Content wrapper -->
      <div class="content-wrapper">
      <!-- Content -->