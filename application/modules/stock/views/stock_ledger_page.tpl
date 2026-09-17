<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header mb-3">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-history"></i></div>
        <div>
          <h1 class="cat-page-title">Stock Ledger</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%$base_url%>stock">Stock Management</a>
            <i class="ti ti-chevron-right"></i>
            <span><%$product['name']|default:'N/A'%></span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%$base_url%>stock" class="cat-btn cat-btn-outline" title="Back to Stock">
          <i class="ti ti-arrow-left"></i> Back to Stock
        </a>
      </div>
    </div>

    <!-- Product Info Card (gradient header) -->
    <div class="card border-0 shadow-sm mb-4 overflow-hidden">
      <div style="background: #5b5fc7; min-height: 130px; position: relative;">
        <!-- Decorative circles -->
        <div style="position:absolute;top:-30px;right:-30px;width:200px;height:200px;border-radius:50%;background:rgba(255,255,255,0.05);"></div>
        <div style="position:absolute;bottom:-50px;right:80px;width:150px;height:150px;border-radius:50%;background:rgba(255,255,255,0.04);"></div>
        <div class="d-flex align-items-center gap-4 p-4" style="position:relative; z-index:1;">
          <!-- Product Image -->
          <div class="flex-shrink-0">
            <%if $product['image']%>
              <img src="<%$base_url%>public/uploads/product/product_image/<%$product['product_id']%>/<%$product['image']%>"
                   alt="<%$product['name']%>"
                   class="rounded-3 shadow"
                   style="width: 90px; height: 90px; object-fit: cover; border: 3px solid rgba(255,255,255,0.25); background: white;">
            <%else%>
              <div class="rounded-3 shadow d-flex align-items-center justify-content-center"
                   style="width: 90px; height: 90px; background: rgba(255,255,255,0.15); border: 3px solid rgba(255,255,255,0.25);">
                <i class="ti ti-photo text-white" style="font-size: 2.5rem; opacity: 0.6;"></i>
              </div>
            <%/if%>
          </div>
          <!-- Product Info -->
          <div class="flex-grow-1 min-w-0">
            <h4 class="mb-1 text-white fw-bold" style="font-size: 1.3rem;"><%$product['name']%></h4>
            <div class="d-flex align-items-center gap-2 flex-wrap">
              <span class="badge bg-white text-primary fw-semibold px-2 py-1" style="font-size: 0.78rem; letter-spacing: 0.5px;">
                <i class="ti ti-barcode me-1"></i><%$product['product_code']%>
              </span>
              <%if $product['category_name']%>
              <span class="badge text-white fw-normal px-2 py-1" style="background: rgba(255,255,255,0.15); font-size: 0.78rem;">
                <i class="ti ti-tag me-1"></i><%$product['category_name']%>
              </span>
              <%/if%>
              <%if $product['brand_name']%>
              <span class="badge text-white fw-normal px-2 py-1" style="background: rgba(255,255,255,0.15); font-size: 0.78rem;">
                <i class="ti ti-building-store me-1"></i><%$product['brand_name']%>
              </span>
              <%/if%>
            </div>
          </div>
          <!-- Stock Summary -->
          <div class="flex-shrink-0 text-end d-none d-md-block">
            <div class="rounded-3 px-4 py-3 text-center" style="min-width: 110px; background: rgba(255,255,255,0.12); border: 1px solid rgba(255,255,255,0.25); backdrop-filter: blur(8px);">
              <div class="fw-semibold mb-1 text-uppercase text-white-50" style="font-size: 0.7rem; letter-spacing: 0.5px;">Total Moves</div>
              <div class="fw-bold text-white" style="font-size: 1.8rem; line-height: 1;"><%count($ledger)%></div>
              <div class="text-white-50" style="font-size: 0.72rem;">entries</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Ledger Table -->
    <div class="cat-table-card">
      <div class="table-responsive">
        <table class="table table-hover mb-0 w-100">
          <thead class="table-light">
            <tr>
              <th class="ps-4">Date &amp; Time</th>
              <th class="text-center">Previous</th>
              <th class="text-center">Adjustment</th>
              <th class="text-center">New Qty</th>
              <th>Remarks</th>
              <th class="pe-4">By</th>
            </tr>
          </thead>
          <tbody>
            <%if $ledger%>
              <%foreach from=$ledger item=row%>
              <tr>
                <td class="ps-4">
                  <span class="fw-medium text-dark"><%$row['added_date']|getDefaultDateTime%></span>
                </td>
                <td class="text-center">
                  <span class="badge bg-label-secondary fs-6"><%$row['previous_qty']%></span>
                </td>
                <td class="text-center">
                  <%if $row['qty'] > 0%>
                    <span class="badge bg-label-success px-2 py-1">
                      <i class="ti ti-arrow-up"></i> +<%$row['qty']%>
                    </span>
                  <%else%>
                    <span class="badge bg-label-danger px-2 py-1">
                      <i class="ti ti-arrow-down"></i> <%$row['qty']%>
                    </span>
                  <%/if%>
                </td>
                <td class="text-center fw-bold text-dark fs-6"><%$row['new_qty']%></td>
                <td><small class="text-muted"><%$row['remarks']|default:'-'%></small></td>
                <td class="pe-4">
                  <div class="d-flex align-items-center gap-2">
                    <div style="width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#4f46e5,#7c3aed);color:white;display:flex;align-items:center;justify-content:center;font-size:.75rem;font-weight:700;">
                      <%$row['added_by_name']|truncate:1:'':true|default:'S'%>
                    </div>
                    <span class="text-dark small fw-medium"><%$row['added_by_name']|default:'System'%></span>
                  </div>
                </td>
              </tr>
              <%/foreach%>
            <%else%>
              <tr>
                <td colspan="6" class="text-center py-5 text-muted">
                  <i class="ti ti-history d-block mb-3" style="font-size: 3rem; opacity: 0.2;"></i>
                  No stock movement history found.
                </td>
              </tr>
            <%/if%>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>
