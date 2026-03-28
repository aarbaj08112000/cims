<div id="menu_overlay" class="menu_overlay home-page-boxes <%if $sitemap%>open site-map-contain<%/if%>">
   <div class="new_sitemap_items">
      <div class="headingfix">
         <div class="heading" id="top_heading_fix">
            <div class="d-flex align-items-center justify-content-between px-4 pt-4">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm me-3">
                        <span class="avatar-initial rounded bg-label-secondary"><i class="ti ti-layout-grid ti-md text-dark"></i></span>
                    </div>
                    <div>
                        <h4 class="text-dark fw-bolder mb-0">Admin Quick Menu</h4>
                    </div>
                </div>
                <div class="quick-menu-close-btn" style="cursor: pointer;">
                    <i class="ti ti-x ti-md text-muted hover-danger"></i>
                </div>
            </div>
         </div>
      </div>
      
      <div id="scrollable_content" class="scrollable-content mt-2">
         <div class="sitemap-blocks pad-calc-container px-4 pb-5">
            <div class="row g-4">
               <!-- Dashboards -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-dashboards h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-smart-home text-info me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">Dashboards</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="dashboard" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-chart-bar me-2 ti-xs"></i> Main Analytics
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- Product Catalog -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-products h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-package text-primary me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">Product Catalog</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="product" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-cube me-2 ti-xs"></i> Manage Products
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="category" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-grid-dots me-2 ti-xs"></i> Categories
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="brand" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-award me-2 ti-xs"></i> Brands
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- Orders & Sales -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-sales h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-shopping-cart text-success me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">Orders & Sales</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="sales_list" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-list me-2 ti-xs"></i> Sales List
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="create_sale" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-plus me-2 ti-xs"></i> Create Sale
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="sales_return" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-arrow-back-up me-2 ti-xs"></i> Sales Return
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- Customer Management -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-customers h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-user-circle text-primary me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">Customer Management</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="customer" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-users me-2 ti-xs"></i> Customer List
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- Procurement -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-procurement h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-truck-delivery text-warning me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">Procurement</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="purchase_list" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-list me-2 ti-xs"></i> Purchase List
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="create_purchase" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-plus me-2 ti-xs"></i> Create Purchase
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="supplier" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-building-store me-2 ti-xs"></i> Suppliers
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- Stock Management -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-stock h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-box text-danger me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">Stock & Inventory</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="stock" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-stack me-2 ti-xs"></i> Stock Management
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="purchase_return" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-arrow-back-up me-2 ti-xs"></i> Purchase Return
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- Reports & Marketing -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-reports h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-report text-secondary me-2 ti-sm" style="color: #6366f1 !important;"></i>
                            <h6 class="mb-0 fw-bold">Reports & Analytics</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="reports" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-chart-infographic me-2 ti-xs"></i> All Reports
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

               <!-- System Settings -->
               <div class="col-md-4 col-lg-3">
                  <div class="quick-menu-card card-settings h-100 border rounded-3 overflow-hidden">
                     <div class="card-header-accent"></div>
                     <div class="card-header border-bottom p-3">
                         <div class="d-flex align-items-center">
                            <i class="ti ti-settings text-secondary me-2 ti-sm"></i>
                            <h6 class="mb-0 fw-bold">System Settings</h6>
                         </div>
                     </div>
                     <div class="card-body p-0">
                        <ul class="list-unstyled mb-0">
                           <li>
                              <a hijacked="yes" href="user_list" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-user me-2 ti-xs"></i> User Management
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="group_master" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-shield-lock me-2 ti-xs"></i> Group Master
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="company" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-building me-2 ti-xs"></i> Company Details
                              </a>
                           </li>
                           <li>
                              <a hijacked="yes" href="settings" class="quick-link-item d-flex align-items-center border-bottom text-muted">
                                 <i class="ti ti-adjustments me-2 ti-xs"></i> Application Settings
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>

            </div>
         </div>
      </div>
   </div>
</div>

<style>
#menu_overlay.menu_overlay {
    background: rgba(248, 249, 250, 0.98);
    z-index: 1000;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: fixed;
    top: 64px;
    height: calc(100vh - 64px);
    width: 100%;
    overflow: hidden;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    pointer-events: none; /* Disable mouse interaction when hidden */
}

#menu_overlay.open {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
    pointer-events: auto; /* Re-enable mouse interaction when visible */
}

#scrollable_content {
    height: calc(100vh - 140px);
    overflow-y: auto;
    padding-top: 20px;
}

/* Glass Cards with Hover Effects */
.quick-menu-card {
    background: rgba(255, 255, 255, 0.9);
    border: 1px solid rgba(255, 255, 255, 0.4) !important;
    border-radius: 1.25rem !important;
    box-shadow: 0 4px 16px rgba(31, 38, 135, 0.05) !important;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    position: relative;
}

.quick-menu-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 15px 45px rgba(31, 38, 135, 0.15) !important;
    background: rgba(255, 255, 255, 1);
    will-change: transform;
}

/* Category Accent Gradients */
.card-header-accent {
    height: 4px;
    width: 100%;
    position: absolute;
    top: 0;
    left: 0;
}

.card-dashboards .card-header-accent { background: linear-gradient(90deg, #48cae4, #0077b6); }
.card-products .card-header-accent { background: linear-gradient(90deg, #a594f9, #6247aa); }
.card-sales .card-header-accent { background: linear-gradient(90deg, #4ade80, #16a34a); }
.card-customers .card-header-accent { background: linear-gradient(90deg, #1e88e5, #1565c0); }
.card-procurement .card-header-accent { background: linear-gradient(90deg, #fb923c, #ea580c); }
.card-stock .card-header-accent { background: linear-gradient(90deg, #fb7185, #e11d48); }
.card-reports .card-header-accent { background: linear-gradient(90deg, #818cf8, #4f46e5); }
.card-settings .card-header-accent { background: linear-gradient(90deg, #4b5563, #1f2937); }

.quick-menu-card .card-header {
    background: transparent;
    padding: 1.25rem !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.04) !important;
}

.quick-menu-card .card-header h6 {
    font-size: 1rem;
    letter-spacing: -0.01em;
    color: #2f2b3d;
}

/* Enhanced Link Items */
.quick-link-item {
    padding: 12px 20px;
    font-size: 0.9rem;
    text-decoration: none;
    transition: all 0.25s ease;
    border-bottom: 1px solid rgba(0, 0, 0, 0.03) !important;
    display: flex;
    align-items: center;
    color: #5d596c !important;
    font-weight: 500;
}

.quick-link-item:hover {
    background-color: rgba(115, 103, 240, 0.05);
    color: #7367f0 !important;
    padding-left: 28px;
}

.quick-link-item i {
    font-size: 1.1rem;
    margin-right: 12px;
    transition: transform 0.2s ease;
}

.quick-link-item:hover i {
    transform: scale(1.2);
    color: #7367f0 !important;
}

.avatar-initial.bg-label-primary {
    background-color: #f0efff !important;
    color: #7367f0 !important;
}

.hover-danger:hover {
    color: #ea5455 !important;
    transform: rotate(90deg);
    transition: all 0.3s ease;
}

/* Animation for cards appearing */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

#menu_overlay.open .quick-menu-card {
    animation: fadeInUp 0.5s ease backwards;
}

#menu_overlay.open .col-md-4:nth-child(1) .quick-menu-card { animation-delay: 0.1s; }
#menu_overlay.open .col-md-4:nth-child(2) .quick-menu-card { animation-delay: 0.15s; }
#menu_overlay.open .col-md-4:nth-child(3) .quick-menu-card { animation-delay: 0.2s; }
#menu_overlay.open .col-md-4:nth-child(4) .quick-menu-card { animation-delay: 0.25s; }
#menu_overlay.open .col-md-4:nth-child(5) .quick-menu-card { animation-delay: 0.3s; }
#menu_overlay.open .col-md-4:nth-child(6) .quick-menu-card { animation-delay: 0.35s; }
#menu_overlay.open .col-md-4:nth-child(7) .quick-menu-card { animation-delay: 0.4s; }
#menu_overlay.open .col-md-4:nth-child(8) .quick-menu-card { animation-delay: 0.45s; }

@media (max-width: 1199.98px) {
    #menu_overlay.menu_overlay {
        left: 0;
        width: 100%;
        top: 64px;
        height: calc(100vh - 64px);
    }
}
</style>

<script>
$(document).ready(function() {
    $('.quick-menu-close-btn').on('click', function() {
        $('.quick-menu-bar').trigger('click');
    });
});
</script>