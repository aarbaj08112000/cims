<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon">
          <i class="ti ti-history"></i>
        </div>
        <div>
          <h1 class="cat-page-title">Product Activity Log Report</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <a href="<%base_url('reports')%>">Reports</a>
            <i class="ti ti-chevron-right"></i>
            <span>Product Activity Logs</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <button id="btn-export-excel" class="cat-btn cat-btn-outline">
          <i class="ti ti-file-spreadsheet"></i> Export Excel
        </button>
        <button id="btn-export-pdf" class="cat-btn cat-btn-outline-red">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
      </div>
    </div>

    <!-- Summary Cards -->
    <div class="row g-3 mb-4" id="log-summary-cards">
      <div class="col-md-3">
        <div class="adj-summary-card">
          <div class="adj-summary-icon" style="background: #eef2ff; color: #6366f1;">
            <i class="ti ti-list-details"></i>
          </div>
          <div>
            <div class="text-muted fw-semibold" style="font-size: 0.78rem; text-transform: uppercase;">Total Logs</div>
            <div class="fs-4 fw-bold text-dark" id="stat-total-logs"><%$stats.total_logs|default:0%></div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="adj-summary-card">
          <div class="adj-summary-icon" style="background: #e8f8f0; color: #27ae60;">
            <i class="ti ti-box-seam"></i>
          </div>
          <div>
            <div class="text-muted fw-semibold" style="font-size: 0.78rem; text-transform: uppercase;">Created / Edited</div>
            <div class="fs-4 fw-bold text-dark" id="stat-created-edited"><%$stats.created_edited_count|default:0%></div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="adj-summary-card">
          <div class="adj-summary-icon" style="background: #fff7ed; color: #f97316;">
            <i class="ti ti-arrows-left-right"></i>
          </div>
          <div>
            <div class="text-muted fw-semibold" style="font-size: 0.78rem; text-transform: uppercase;">Stock Movements</div>
            <div class="fs-4 fw-bold text-dark" id="stat-stock-movements"><%$stats.stock_movements_count|default:0%></div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="adj-summary-card">
          <div class="adj-summary-icon" style="background: #fdecea; color: #e74c3c;">
            <i class="ti ti-trash"></i>
          </div>
          <div>
            <div class="text-muted fw-semibold" style="font-size: 0.78rem; text-transform: uppercase;">Deletions / Restores</div>
            <div class="fs-4 fw-bold text-dark" id="stat-deletions"><%$stats.deletions_count|default:0%></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Filter Card -->
    <div class="card border-0 shadow-sm mb-4" style="border-radius:12px;">
      <div class="card-body p-3">
        <form id="filterForm" class="row g-3 align-items-end">
          <div class="col-md-3">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Product</label>
            <select name="product_id" id="filter_product_id" class="form-select select2">
              <option value="">All Products</option>
              <%foreach from=$products item=sel_prod%>
                <option value="<%$sel_prod.id%>" <%if $product_id == $sel_prod.id%>selected<%/if%>>
                  <%$sel_prod.product_name%> (<%$sel_prod.product_code%>)
                </option>
              <%/foreach%>
            </select>
          </div>
          <div class="col-md-2">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">Action Type</label>
            <select name="action_type" id="filter_action_type" class="form-select select2">
              <option value="">All Actions</option>
              <option value="ADDED" <%if $action_type == "ADDED"%>selected<%/if%>>Product Added</option>
              <option value="EDITED" <%if $action_type == "EDITED"%>selected<%/if%>>Product Edited</option>
              <option value="STOCK_ADDED" <%if $action_type == "STOCK_ADDED"%>selected<%/if%>>Stock Added</option>
              <option value="STOCK_REMOVED" <%if $action_type == "STOCK_REMOVED"%>selected<%/if%>>Stock Removed</option>
              <option value="STOCK_ADJUSTED" <%if $action_type == "STOCK_ADJUSTED"%>selected<%/if%>>Stock Adjusted</option>
              <option value="SALE" <%if $action_type == "SALE"%>selected<%/if%>>Sale / Outflow</option>
              <option value="PURCHASE" <%if $action_type == "PURCHASE"%>selected<%/if%>>Purchase / Inflow</option>
              <option value="DELETED" <%if $action_type == "DELETED"%>selected<%/if%>>Deleted</option>
              <option value="RESTORED" <%if $action_type == "RESTORED"%>selected<%/if%>>Restored</option>
            </select>
          </div>
          <div class="col-md-2">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">User / Staff</label>
            <select name="created_by" id="filter_created_by" class="form-select select2">
              <option value="">All Staff</option>
              <%foreach from=$users item=sel_user%>
                <option value="<%$sel_user.id%>" <%if $created_by == $sel_user.id%>selected<%/if%>>
                  <%$sel_user.first_name%> <%$sel_user.last_name%>
                </option>
              <%/foreach%>
            </select>
          </div>
          <div class="col-md-2">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">From Date</label>
            <input type="date" name="from_date" id="filter_from_date" class="form-control" value="<%$from_date%>">
          </div>
          <div class="col-md-2">
            <label class="form-label fw-semibold text-muted" style="font-size:0.78rem; text-transform:uppercase; letter-spacing:.5px;">To Date</label>
            <input type="date" name="to_date" id="filter_to_date" class="form-control" value="<%$to_date%>">
          </div>
          <div class="col-md-1 d-flex gap-2">
            <button type="submit" id="btn-apply-filter" class="cat-btn cat-btn-primary w-100">
              <i class="ti ti-filter"></i> Filter
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Table -->
    <div class="cat-table-card">
      <div class="p-3 table-responsive">
        <table id="productLogTable" class="table table-hover align-middle w-100">
          <thead>
            <tr>
              <th style="width: 5%;">#</th>
              <th style="width: 15%;">Date &amp; Time</th>
              <th style="width: 20%;">Product</th>
              <th style="width: 12%;">Action</th>
              <th style="width: 18%;">Changes / Values</th>
              <th style="width: 8%;">Qty</th>
              <th style="width: 12%;">User</th>
              <th style="width: 10%;">Remarks</th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>

  <style>
.adj-change-badge {
  display: inline-flex; align-items: center; gap: 4px;
  padding: 3px 10px; border-radius: 20px; font-size: 0.78rem; font-weight: 600;
}
.adj-add    { background: #e8f8f0; color: #27ae60; }
.adj-reduce { background: #fdecea; color: #e74c3c; }
.adj-summary-card {
  background: #fff; border-radius: 12px; border: 1px solid #e2e6ef;
  padding: 1.2rem 1.5rem; box-shadow: 0 2px 16px rgba(91,95,199,.07);
  display: flex; align-items: center; gap: 1rem;
}
.adj-summary-icon {
  width: 50px; height: 50px; border-radius: 10px;
  display: flex; align-items: center; justify-content: center; font-size: 1.4rem; flex-shrink: 0;
}
</style>

<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin_panel/product_log_report.js?v=1"></script>
