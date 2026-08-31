<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-box"></i></div>
        <div>
          <h1 class="cat-page-title">Products</h1>
          <nav class="cat-breadcrumb">
            <a href="<%base_url('dashboard')%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Products</span>
            <i class="ti ti-chevron-right"></i>
            <span>Product Listing</span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <div class="cat-search-box">
          <i class="ti ti-search"></i>
          <input type="text" id="search-filter-input" placeholder="Filter Search" />
        </div>
        <button type="button" id="export-csv" class="cat-btn cat-btn-outline" title="Export CSV">
          <i class="ti ti-file-type-csv"></i> Export CSV
        </button>
        <button type="button" id="export-pdf" class="cat-btn cat-btn-outline-red" title="Export PDF">
          <i class="ti ti-file-type-pdf"></i> Export PDF
        </button>
        <a href="<%$base_url%>product/scan_barcode" class="cat-btn cat-btn-outline" title="Scan Barcode">
          <i class="ti ti-barcode"></i> Scan
        </a>
        <a href="<%$base_url%>product/add_product" class="cat-btn cat-btn-primary text-white" title="Add Product">
          <i class="ti ti-plus"></i> Add Product
        </a>
      </div>
    </div>

    <!-- Main content -->
    <div class="cat-table-card">
      <div class="table-responsive text-nowrap">
      <table class="table table-hover mb-0 w-100" id="product_list">
        <thead class="bg-light">
          <tr>
                    <th class="text-center" style="width: 80px;">Image</th>
                    <th class="text-center">Barcode</th>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Sale Price</th>
                    <th>Purchase Price</th>
                    <th>Unit</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th class="text-center" style="width: 100px;">Action</th>
                 </tr>
              </thead>
              <tbody>
              </tbody>
           </table>
        </div>
      </div>
      </div>
      <!-- /.col -->


      <div class="content-backdrop fade"></div>
    </div>


    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <script src="<%$base_url%>public/js/admin_panel/product_list.js?v=<%time()%>"></script>

<!-- Print Barcode Modal -->
<div class="modal fade" id="printBarcodeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Barcode Label Preview</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3 align-items-end">
                    <div class="col-md-6">
                        <label class="form-label">Available Stock</label>
                        <input type="text" id="available_stock_display" class="form-control" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Number of Labels <span class="text-danger">*</span></label>
                        <input type="number" id="label_count" class="form-control" value="1" min="1">
                    </div>
                </div>
                <hr>
                <div id="barcode_preview_container" class="preview-scroll">
                    <!-- Labels will be generated here -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-info" id="print_labels_thermal_btn">
                    <i class="ti ti-printer me-1"></i> Print Thermal (48mm)
                </button>
                <button type="button" class="btn btn-success" id="print_labels_btn">
                    <i class="ti ti-printer me-1"></i> Print A4
                </button>
            </div>
        </div>
    </div>
</div>

<style>
.preview-scroll {
    max-height: 400px;
    overflow-y: auto;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    justify-content: center;
}

/* Sticker Label Design - Redesigned for Horizontal Layout */
.sticker-label {
    width: 300px; /* Adjusting for 3-col fit */
    height: 150px;
    background: white;
    border: 1px dashed #bbb;
    padding: 10px;
    display: flex;
    flex-direction: column;
    font-family: 'Poppins', sans-serif;
    color: #333;
    position: relative;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    margin-bottom: 10px;
}

.label-top-section {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
}

.label-info-section {
    width: 100%;
    display: flex;
    flex-direction: column;
}

.label-product-name {
    font-weight: 700;
    font-size: 13px;
    margin-bottom: 2px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.label-product-size {
    font-weight: 600;
    font-size: 11px;
    color: #444;
}

.label-product-desc {
    font-size: 11px;
    font-weight: 500;
    color: #444;
    margin-top: 3px;
}

.label-bottom-section {
    height: 40%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.horizontal-barcode {
    width: 100%;
    height: 70px;
    object-fit: contain;
}

.label-barcode-num {
    font-size: 10px;
    margin-top: 2px;
    letter-spacing: 2px;
    font-weight: 500;
}

@media print {
    @page {
        size: A4;
        margin: 2mm !important; /* Small margin to avoid printer unprintable areas */
    }
    html, body {
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        background: white !important;
        overflow: visible !important;
    }
    body * {
        visibility: hidden !important;
    }
    #barcode_preview_container, 
    #barcode_preview_container * {
        visibility: visible !important;
    }
    #barcode_preview_container {
        position: absolute !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        padding: 0 !important;
        margin: 0 !important;
        display: grid !important;
        grid-template-columns: repeat(3, 1fr) !important;
        gap: 0 !important;
        background: white !important;
        justify-content: stretch !important;
        box-sizing: border-box !important;
    }
    .sticker-label {
        width: 100% !important;
        height: 150px !important;
        border: 0.1mm solid #ddd !important;
        margin: 0 !important;
        padding: 10px !important;
        box-sizing: border-box !important;
        display: flex !important;
        flex-direction: column !important;
        page-break-inside: avoid !important;
        background: white !important;
    }
    .label-top-section {
        display: flex !important;
        justify-content: space-between !important;
        height: 60% !important;
    }
    .label-bottom-section {
        height: 40% !important;
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        justify-content: center !important;
    }
    .horizontal-barcode {
        width: 100% !important;
        height: 45px !important;
        object-fit: contain !important;
    }
}

/* User required Datatable scroll constraints */
.dataTables_wrapper .dataTables_scrollBody {
    min-height: 55vh;
    max-height: 59vh !important;
    overflow-y: auto;
}
.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody {
    height: auto !important; /* Allow min/max height bounds to control it completely */
}

/* 
  FIX: When scrollY is enabled, DataTables duplicates the header into dataTables_scrollHeadInner.
  demo.css aggressively overrides the padding to 15px 18px, making it larger than body columns,
  causing total desync in computed width. We revert it here to match category_ui.css
*/
.cat-table-card .dataTables_scrollHeadInner table.dataTable thead th, 
.cat-table-card .dataTables_scrollHeadInner table.dataTable thead td {
    padding: 13px 16px !important;
    border-bottom: 1.5px solid var(--cat-gray-200) !important;
}

.list-barcode-img:hover {
    transform: scale(2.5);
    z-index: 10;
    position: relative;
    background: white;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    border-radius: 4px;
    padding: 5px;
}

</style>
