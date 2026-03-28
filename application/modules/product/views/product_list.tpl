
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 

    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
        <h1>
          Home
          <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
            <i class="ti ti-chevrons-right" ></i>
            <em >Product</em></a>
          </h1>
          <br>
          <span >Product Listing</span>
        </div>
      </nav>

      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-3">
        <input type="text" id="search-filter-input" placeholder="Filter Search" class="form-control search-filter-input me-2">
        <a href="add_product" ><button type="button" class="btn btn-seconday"  title="Add Product">
        <i class="ti ti-plus"></i></button></a>
      </div>
      


      <!-- Main content -->
      <div class="card p-0 mt-0 w-100">
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped text-nowrap" border-color="#e1e1e1" id="product_list">
              <thead>
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Iamge</th>
                    <th>Barcode</th>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th class="text-center">Action</th>
                 </tr>
              </thead>
              <tbody>
                 <%if ($products) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$products item=u %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                       
                        <td>
                           <%if $u['image']%>
                               <img src="public/uploads/product/product_image/<%$u['product_id']%>/<%$u['image']%>" 
                                     onerror="this.src='public/assets/images/no_image.jpg';"
                                     alt="Product Image" style="max-width: 75px; height: auto;">
                           <%else%>
                               <img src="public/assets/images/no_image.jpg" alt="No Image" style="max-width: 75px; height: auto;">
                           <%/if%>
                        </td>

                        <td>
                           <%if $u['line_bar_code']%>
                               <img src="public/uploads/product/bar_code/<%$u['product_id']%>/<%$u['line_bar_code']%>.png" 
                                    onerror="this.src='public/assets/images/no_image.jpg';"
                                    alt="<%$u['line_bar_code']%>" style="max-width: 100px; height: auto;">
                               <br>
                               <small><%$u['line_bar_code']%></small>
                           <%else%>
                               -
                           <%/if%>
                        </td>

                        <td><%$u['name'] %></td>
                       <td title="<%$u['description']%>" style="max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                           <%$u['description']|truncate:80:"..."%>
                        </td>

                        <td><%$u['price'] %></td>
                        <td><%$u['qty'] %></td>
                        <td style="font-weight: bold; 
                        <%if $u['status'] == 'Active' %>color: green;<%else %>color: red;<%/if %>">
                        <%$u['status'] %>
                    </td>
                        <td class="text-center">
                            <div class="dropdown">
                                <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                    <i class="ti ti-dots-vertical" style="font-size: 1.25rem;"></i>
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="product_details/<%$u['product_id']%>">
                                        <i class="ti ti-eye me-1"></i> View Details
                                    </a>
                                    <a class="dropdown-item" href="update_product/<%$u['product_id']%>">
                                        <i class="ti ti-edit me-1"></i> Edit
                                    </a>
                                    <a class="dropdown-item update_stock" href="javascript:void(0);" data-id="<%$u['product_id']%>">
                                        <i class="ti ti-box me-1"></i> Update Stock
                                    </a>
                                    <a class="dropdown-item regenerate_barcode" href="javascript:void(0);" data-id="<%$u['product_id']%>">
                                        <i class="ti ti-reload me-1"></i> Regenerate Barcode
                                    </a>
                                    <a class="dropdown-item print_barcode" href="javascript:void(0);" data-id="<%$u['product_id']%>">
                                        <i class="ti ti-printer me-1"></i> Print
                                    </a>
                                    <a class="dropdown-item delete_data text-danger" href="javascript:void(0);" data-id="<%$u['product_id']%>">
                                        <i class="ti ti-trash me-1"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </td>
                     </tr>
                  <%assign var='i' value=$i+1 %>
                  <%/foreach%>
                  <%/if%>
              </tbody>
           </table>
        </div>
      </div>
      <!-- /.col -->


      <div class="content-backdrop fade"></div>
    </div>


    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <script src="<%$base_url%>public/js/admin_panel/product_list.js"></script>

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
                <button type="button" class="btn btn-success" id="print_labels_btn">
                    <i class="ti ti-printer me-1"></i> Print Labels
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
    height: 45px;
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
</style>
