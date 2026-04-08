<div class="container-xxl flex-grow-1 container-p-y">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary py-4">
            <h3 class="mb-0 text-white"><i class="ti ti-books me-2"></i>CIMS System Documentation Guide</h3>
            <p class="text-white opacity-75 mb-0 mt-2">Comprehensive operational manual for Cloud Inventory & POS Management</p>
        </div>
        <div class="card-body p-5">
            <div class="row">
                <!-- Sidebar Navigation for jumping to sections -->
                <div class="col-lg-3 border-end d-none d-lg-block">
                    <div class="sticky-top" style="top: 20px;">
                        <h6 class="text-uppercase text-muted font-weight-bold mb-3">Menu Structure</h6>
                        <nav id="docs-nav" class="nav flex-column gap-2">
                            <a class="nav-link p-2 bg-light rounded text-primary" href="documentation#dashboard">1. Dashboard</a>
                            <a class="nav-link p-2" href="documentation#product">2. Product Management</a>
                            <a class="nav-link p-2" href="documentation#supplier">3. Supplier Management</a>
                            <a class="nav-link p-2" href="documentation#customer">4. Customer Management</a>
                            <a class="nav-link p-2" href="documentation#purchase">5. Purchase Management</a>
                            <a class="nav-link p-2" href="documentation#sales">6. Sales Management</a>
                            <a class="nav-link p-2" href="documentation#pos">7. POS Billing</a>
                            <a class="nav-link p-2" href="documentation#stock">8. Stock Management</a>
                            <a class="nav-link p-2" href="documentation#reports">9. Reports</a>
                            <a class="nav-link p-2" href="documentation#users">10. User Management</a>
                            <a class="nav-link p-2" href="documentation#company">11. Company Details</a>
                            <a class="nav-link p-2" href="documentation#settings">12. Settings</a>
                        </nav>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="col-lg-9 ps-lg-5">
                    
                    <!-- Intro -->
                    <div class="alert alert-info d-flex align-items-center mb-5" role="alert">
                        <i class="ti ti-info-circle me-3 fs-3"></i>
                        <div>
                            This guide is synchronized with your main sidebar navigation to help you find information quickly. Use the left menu to jump to specific module details.
                        </div>
                    </div>

                    <!-- Dashboard Section -->
                    <section id="dashboard" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">1. Dashboard</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Bird's-eye view of your business performance.</p>
                            <ul>
                                <li><strong>Overview Stats:</strong> Real-time display of Total Sales, Orders, and Items.</li>
                                <li><strong>Sales Trends:</strong> Visual charts showing daily and monthly revenue growth.</li>
                                <li><strong>Quick Actions:</strong> Instant shortcuts to frequent tasks like POS and Stock updates.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Product Management Section -->
                    <section id="product" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">2. Product Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Master database for SKU data, pricing, and categories.</p>
                            <div class="card bg-light border-0 mb-4">
                                <div class="card-body">
                                    <h6 class="fw-bold">Sub-modules:</h6>
                                    <ul class="mb-0">
                                        <li><strong>Category:</strong> Organize products into logical groups.</li>
                                        <li><strong>Brand:</strong> Manage manufacturer/brand labels.</li>
                                        <li><strong>Product List:</strong> Full management of price, SKU, and barcode data.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Supplier Management Section -->
                    <section id="supplier" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">3. Supplier Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Managing vendor relationships and procurement contacts.</p>
                            <ul>
                                <li><strong>Vendor Registry:</strong> Store supplier names, addresses, and tax IDs.</li>
                                <li><strong>Supplier Performance:</strong> Track which vendors fulfill your stock needs.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Customer Management Section -->
                    <section id="customer" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">4. Customer Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> CRM to track shopper interaction and history.</p>
                            <ul>
                                <li><strong>Customer Profiles:</strong> Record mobile numbers and purchase preferences.</li>
                                <li><strong>Anonymous Checkout:</strong> Support for 'Walk-in' customers without registration.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Purchase Management Section -->
                    <section id="purchase" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">5. Purchase Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Handling stock intake and vendor returns.</p>
                            <ul>
                                <li><strong>Create Purchase:</strong> Generate purchase orders to add stock to the system.</li>
                                <li><strong>Purchase List:</strong> Audit trail of all inventory received.</li>
                                <li><strong>Purchase Return:</strong> Manage defective or returned items back to suppliers.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Sales Management Section -->
                    <section id="sales" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">6. Sales Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Full cycle management of standard customer orders.</p>
                            <ul>
                                <li><strong>Create Sale:</strong> Manual order creation interface.</li>
                                <li><strong>Sales List:</strong> Historical record of all transactions.</li>
                                <li><strong>Sales Return:</strong> Handling customer refunds and restokes.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- POS Billing Section -->
                    <section id="pos" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">7. POS Billing</h2>
                        <div class="mb-4">
                            <p><strong>Purpose:</strong> High-speed retail checkout with scanning support.</p>
                            <div class="alert alert-success d-flex align-items-center mb-3">
                                <i class="ti ti-check me-2"></i>
                                <strong>Tip:</strong> The POS system automatically recalculates tax and change on every scan.
                            </div>
                            <ul>
                                <li><strong>Barcode Logic:</strong> Scans increment quantity instantly.</li>
                                <li><strong>Receipt Generation:</strong> Professional 80mm thermal receipt output.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Stock Management Section -->
                    <section id="stock" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">8. Stock Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Real-time inventory monitoring and audit.</p>
                            <ul>
                                <li><strong>Stock Ledger:</strong> Inbound/Outbound history for every unit.</li>
                                <li><strong>Alerts:</strong> Notification for items falling below safety levels.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Reports Section -->
                    <section id="reports" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">9. Reports</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Business intelligence and tax audits.</p>
                            <table class="table table-sm table-bordered mb-4">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Report Type</th>
                                        <th>Utility</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr><td>Sales Report</td><td>Profit/Revenue analysis.</td></tr>
                                    <tr><td>Stock Valuation</td><td>Asset value of current inventory.</td></tr>
                                    <tr><td>Purchase Report</td><td>Expense tracking per vendor.</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </section>

                    <!-- User Management Section -->
                    <section id="users" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">10. User Management</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Secure access and permissions management.</p>
                            <ul>
                                <li><strong>User List:</strong> Create accounts for staff and administrators.</li>
                                <li><strong>Group Master:</strong> Define roles and module permissions (RBAC).</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Company Details Section -->
                    <section id="company" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">11. Company Details</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Profile setup for your business identity.</p>
                            <ul>
                                <li><strong>Contact Info:</strong> Address, Phone, and Email for receipts.</li>
                                <li><strong>Logo Branding:</strong> Upload logo for Dashboards and Invoices.</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Settings Section -->
                    <section id="settings" class="mb-5 py-3">
                        <h2 class="h4 border-bottom pb-2 mb-4 text-primary">12. Settings</h2>
                        <div class="mb-3">
                            <p><strong>Purpose:</strong> Core system configuration and tax logic.</p>
                            <ul>
                                <li><strong>Tax Configuration:</strong> Set global tax rates (e.g., GST 2.5%).</li>
                                <li><strong>System Rules:</strong> Configure default behaviors for the POS.</li>
                            </ul>
                        </div>
                    </section>

                    <div class="border-top pt-4 mt-5">
                        <p class="text-muted small mb-0">© 2026 CIMS Support. All rights reserved.</p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<style>
#docs-nav .nav-link {
    color: #697a8d;
    font-size: 0.9rem;
    padding: 8px 12px !important;
    transition: all 0.2s;
}
#docs-nav .nav-link:hover {
    background: #f8f9fa;
    color: #7367f0;
    padding-left: 18px !important;
}
section h2 {
    letter-spacing: -0.5px;
    font-weight: 700;
}
section p {
    color: #566a7f;
    line-height: 1.6;
}
</style>
