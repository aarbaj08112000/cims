
    <!-- Include jQuery UI for Autocomplete -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include Tokenfield JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-tokenfield/dist/bootstrap-tokenfield.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.8.3/tinymce.min.js" referrerpolicy="origin"></script>

<style>
.tox .tox-notification--warning{
  display: none !important;
}
.tox-notifications-container{
  display: none !important;
}
#imagePreview img{
  padding: 2px;
  border-radius: 5px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}
</style>
<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<div class="content-wrapper">
  <!-- Content -->
  <div class="container-xxl flex-grow-1 container-p-y">

    <!-- Page Header -->
    <div class="cat-page-header">
      <div class="cat-page-header-left">
        <div class="cat-page-icon"><i class="ti ti-box"></i></div>
        <div>
          <h1 class="cat-page-title"><%if isset($products) && count($products) > 0%>Update Product<%else%>Add Product<%/if%></h1>
          <nav class="cat-breadcrumb">
            <a href="<%$base_url%>">Home</a>
            <i class="ti ti-chevron-right"></i>
            <span>Product</span>
            <i class="ti ti-chevron-right"></i>
            <span><%if isset($products) && count($products) > 0%>Update Product<%else%>Add Product<%/if%></span>
          </nav>
        </div>
      </div>
      <div class="cat-page-header-right">
        <a href="<%base_url('product')%>" class="cat-btn cat-btn-outline" title="Back to Product List">
          <i class="ti ti-arrow-left"></i> Back
        </a>
      </div>
    </div>

    <!-- Main content -->
    <div class="card bg-white border-0 shadow-sm mb-4 w-100">
      <div class="card-body p-4">
        <form id="product_form" action="javascript:void(0)" method="POST" enctype="multipart/form-data">

          <!-- ── Product Information Card ── -->
          <div class="card shadow-sm rounded-3 mb-4" style="border:1px solid #e3e6f0;">
            <div class="card-body p-4">
              <div class="d-flex align-items-center mb-4 pb-3 border-bottom">
                <div class="rounded-2 d-flex align-items-center justify-content-center me-3" style="width:38px;height:38px;background:linear-gradient(135deg,#7367f0,#9e95f5);">
                  <i class="ti ti-info-square text-white" style="font-size:18px;"></i>
                </div>
                <div>
                  <h6 class="mb-0 fw-bold" style="color:#3d3d3d;">Product Information</h6>
                  <p class="text-muted small mb-0">Fill in the core product details below</p>
                </div>
              </div>

              <div class="row">
              <!-- Row 1 -->
            <%if isset($products) && count($products) > 0%>
            <div class="mb-3 col-md-4 col-12">
               <label class="form-label">Product Code <span class="text-danger">*</span></label>
               <input type="text" name="product_code" class="form-control" placeholder="Auto Generated" value="<%$products[0].product_code%>" readonly>
            </div>
             <div class="mb-3 col-md-4 col-12">
               <label class="form-label">Line Bar Code</label>
               <input type="text" name="line_bar_code" class="form-control" placeholder="Scan/Enter Barcode" value="<%$products[0].line_bar_code%>" readonly>
            </div>
            <%/if%>
            
            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Product Name <span class="text-danger">*</span></label>
              <input type="text" name="name" class="form-control required-input" placeholder="Enter Product Name" value="<%if isset($products) %><%$products[0].name%><%/if%>">
            </div>

            <!-- Row 2 -->
            <div class="mb-3 col-md-4 col-12">
                <label class="form-label">Category <span class="text-danger">*</span></label>
                <select name="category_id" class="form-control required-input form-select select2">
                    <option value="">Select Category</option>
                    <%if isset($categories)%>
                        <%foreach from=$categories item=c%>
                            <option value="<%$c.category_id%>" <%if isset($products) && $products[0].category_id == $c.category_id%>selected<%/if%>><%$c.category_name%></option>
                        <%/foreach%>
                    <%/if%>
                </select>
            </div>

            <div class="mb-3 col-md-4 col-12">
                <label class="form-label">Brand <span class="text-danger">*</span></label>
                 <select name="brand_id" class="form-control required-input form-select select2">
                    <option value="">Select Brand</option>
                    <%if isset($brands)%>
                        <%foreach from=$brands item=b%>
                            <option value="<%$b.brand_id%>" <%if isset($products) && $products[0].brand_id == $b.brand_id%>selected<%/if%>><%$b.brand_name%></option>
                        <%/foreach%>
                    <%/if%>
                </select>
            </div>

            <div class="mb-3 col-md-4 col-12">
               <label class="form-label">HSN Code</label>
               <input type="text" name="hsn_code" class="form-control" placeholder="Enter HSN Code" value="<%if isset($products) %><%$products[0].hsn_code%><%/if%>">
            </div>

             <!-- Row 3 -->
            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Actual Price (Selling) <span class="text-danger">*</span></label>
              <div class="input-group">
                <select name="selling_currency_id" class="form-select" style="max-width: 80px;">
                  <%foreach from=$currencies item=c%>
                    <option value="<%$c.currency_id%>" <%if isset($products) && $products[0].selling_currency_id == $c.currency_id%>selected<%/if%>><%$c.currency_symbol%></option>
                  <%/foreach%>
                </select>
                <input type="text" step="0.01" name="actual_price" id="actual_price" class="form-control required-input onlyNumericInput" placeholder="Enter Actual Selling Price" value="<%if isset($products) %><%$products[0].actual_price%><%/if%>">
              </div>
            </div>

            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Discount (%)</label>
              <input type="text" step="0.01" name="discount" id="discount" class="form-control onlyNumericInput" placeholder="Enter Discount Percentage" value="<%if isset($products) %><%$products[0].discount%><%/if%>">
            </div>

            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Price (Selling) <span class="text-danger">*</span></label>
              <input type="text" step="0.01" name="price" id="price" class="form-control required-input onlyNumericInput" placeholder="Auto Calculated" value="<%if isset($products) %><%$products[0].price%><%/if%>" readonly tabindex="-1" style="background-color: #e9ecef; pointer-events: none;">
            </div>
            
            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Purchase Price</label>
              <div class="input-group">
                <select name="purchase_currency_id" class="form-select" style="max-width: 80px;">
                  <%foreach from=$currencies item=c%>
                    <option value="<%$c.currency_id%>" <%if isset($products) && $products[0].purchase_currency_id == $c.currency_id%>selected<%/if%>><%$c.currency_symbol%></option>
                  <%/foreach%>
                </select>
                <input type="text" step="0.01" name="purchase_price" class="form-control onlyNumericInput" placeholder="Enter Purchase Price" value="<%if isset($products) %><%$products[0].purchase_price%><%/if%>">
              </div>
            </div>

            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Tax Rate (%)</label>
              <input type="text" step="0.01" name="tax_rate" class="form-control onlyNumericInput" placeholder="e.g. 5, 12, 18" value="<%if isset($products) %><%$products[0].tax_rate%><%else%><%$settings['pos_tax_percentage']['value']|default:'0'%><%/if%>" >
            </div>

             <!-- Row 4 -->
            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Current Qty <span class="text-danger">*</span></label>
              <input type="text" name="qty" class="form-control required-input onlyNumericInput" placeholder="Enter Quantity" value="<%if isset($products) %><%$products[0].qty%><%/if%>">
            </div>

            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Alert Qty</label>
              <input type="text" name="alert_qty" class="form-control onlyNumericInput" placeholder="Low Stock Alert" value="<%if isset($products) %><%$products[0].alert_qty%><%/if%>">
            </div>

            <div class="mb-3 col-md-4 col-12">
               <label class="form-label">Unit</label>
               <select name="unit" class="form-control form-select select2">
                   <option value="">Select Unit</option>
                   <%if isset($units) && $units|@count > 0%>
                       <%foreach from=$units item=unit_val%>
                           <option value="<%$unit_val.unit_name%>" <%if isset($products) && $products[0].unit == $unit_val.unit_name%>selected<%/if%>><%$unit_val.unit_name%></option>
                       <%/foreach%>
                   <%/if%>
               </select>
            </div>

              <div class="mb-3 col-12">
                <label class="form-label">Description <span class="text-danger">*</span></label>
                <textarea name="description" class="form-control required-input" rows="4" placeholder="Enter Product Description"><%if isset($products[0].description)%><%$products[0].description %><%/if %></textarea>
              </div>

            </div><!-- /.row -->
            </div><!-- /.card-body (Product Information) -->
          </div><!-- /.card (Product Information) -->

            <!-- Attributes Section -->
            <div class="col-12 mb-4">
                <div class="card shadow-sm rounded-3" style="border: 1px solid #e3e6f0;">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h6 class="mb-1 fw-bold" style="color:#7367f0;"><i class="ti ti-adjustments-horizontal me-2"></i>Product Attributes</h6>
                                <p class="text-muted small mb-0">Specify custom details like Memory, Storage, Material, etc.</p>
                            </div>
                            <button type="button" class="btn btn-sm fw-semibold" id="add_attribute_btn"
                                style="background:linear-gradient(135deg,#7367f0,#9e95f5); color:#fff; border:none; border-radius:8px; padding:7px 18px; box-shadow:0 3px 10px rgba(115,103,240,.35);">
                                <i class="ti ti-plus me-1"></i> Add Row
                            </button>
                        </div>

                        <!-- Header labels -->
                        <div class="row mb-2 px-1 d-none d-md-flex">
                            <div class="col-md-5"><span class="small fw-semibold text-muted text-uppercase" style="letter-spacing:.5px;">Name</span></div>
                            <div class="col-md-6"><span class="small fw-semibold text-muted text-uppercase" style="letter-spacing:.5px;">Value</span></div>
                            <div class="col-md-1"></div>
                        </div>

                        <div id="attributes_container">
                            <%if isset($product_attrs) && $product_attrs|@count > 0%>
                                <%foreach from=$product_attrs item=attr%>
                                <div class="attribute-row d-flex align-items-center gap-3 mb-3 p-3 rounded-3" style="background:#f8f8ff; border:1px solid #ebe9fe;">
                                    <div class="flex-fill">
                                        <select name="attr_name[]" class="form-select attr-name-select select2" style="border-color:#ddd;">
                                            <option value="">Select Attribute</option>
                                            <%if isset($master_attributes)%>
                                                <%foreach from=$master_attributes item=ma%>
                                                    <option value="<%$ma.attribute_name%>" <%if $attr.attr_name == $ma.attribute_name%>selected<%/if%>><%$ma.attribute_name%></option>
                                                <%/foreach%>
                                            <%/if%>
                                        </select>
                                    </div>
                                    <div class="flex-fill">
                                        <input type="text" name="attr_value[]" class="form-control " placeholder="e.g. 16GB, 256GB" value="<%$attr.attr_value%>" style="border-color:#ddd;">
                                    </div>
                                    <div class="flex-shrink-0">
                                        <button type="button" class="remove-attr-btn d-flex align-items-center justify-content-center" title="Remove row"
                                            style="width:34px;height:34px;border-radius:8px;border:1px solid #ffcdd2;background:#fff5f5;color:#ea5455;cursor:pointer;transition:all .2s;">
                                            <i class="ti ti-trash" style="font-size:16px;"></i>
                                        </button>
                                    </div>
                                </div>
                                <%/foreach%>
                            <%else%>
                                <div class="attribute-row d-flex align-items-center gap-3 mb-3 p-3 rounded-3" style="background:#f8f8ff; border:1px solid #ebe9fe;">
                                    <div class="flex-fill">
                                        <select name="attr_name[]" class="form-select attr-name-select select2" style="border-color:#ddd;">
                                            <option value="">Select Attribute</option>
                                            <%if isset($master_attributes)%>
                                                <%foreach from=$master_attributes item=ma%>
                                                    <option value="<%$ma.attribute_name%>"><%$ma.attribute_name%></option>
                                                <%/foreach%>
                                            <%/if%>
                                        </select>
                                    </div>
                                    <div class="flex-fill">
                                        <input type="text" name="attr_value[]" class="form-control " placeholder="e.g. 16GB, 256GB" style="border-color:#ddd;">
                                    </div>
                                    <div class="flex-shrink-0">
                                        <button type="button" class="remove-attr-btn d-flex align-items-center justify-content-center" title="Remove row"
                                            style="width:34px;height:34px;border-radius:8px;border:1px solid #ffcdd2;background:#fff5f5;color:#ea5455;cursor:pointer;transition:all .2s;">
                                            <i class="ti ti-trash" style="font-size:16px;"></i>
                                        </button>
                                    </div>
                                </div>
                            <%/if%>
                        </div>
                    </div>
                </div>
            </div>

           

            <div class="col-12 mb-4">
              <div class="card shadow-sm rounded-3" style="border:1px solid #e3e6f0;">
                <div class="card-body p-4">
                  <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                      <h6 class="mb-1 fw-bold" style="color:#7367f0;"><i class="ti ti-photo-plus me-2"></i>Product Images</h6>
                      <p class="text-muted small mb-0">First image is the <strong>Primary Image</strong>. Click <span style="color:#ea5455;">×</span> to remove an image before saving.</p>
                    </div>
                    <label for="multiImageInput" class="btn btn-sm fw-semibold mb-0" style="background:linear-gradient(135deg,#7367f0,#9e95f5);color:#fff;border:none;border-radius:8px;padding:7px 18px;box-shadow:0 3px 10px rgba(115,103,240,.35);cursor:pointer;">
                      <i class="ti ti-upload me-1"></i> Browse Images
                    </label>
                  </div>

                  <!-- Custom styled file input (hidden, triggered by label) -->
                  <input type="file" name="multi_images[]" id="multiImageInput" class="d-none" accept="image/*" multiple>
                  
                  <!-- Drop-zone visual cue when no images yet -->
                  <div id="imageDropHint" class="text-center py-4 rounded-3 mb-3" style="border:2px dashed #d0cfff; background:#f8f8ff; display:none !important;">
                    <i class="ti ti-photo-off" style="font-size:36px; color:#c0bcff;"></i>
                    <p class="text-muted small mt-2 mb-0">No images selected yet. Click "Browse Images" above.</p>
                  </div>

                  <!-- Preview container -->
                  <div id="multiImagePreviewContainer" class="d-flex flex-wrap gap-3">
                    <%if isset($products)%>
                      <%if $products[0].image != ""%>
                      <div class="img-preview-card position-relative existing-image-preview" data-is-primary="1" data-image-name="<%$products[0].image%>">
                          <img src="<%$base_url%>public/uploads/product/product_image/<%$products[0].product_id%>/<%$products[0].image%>" 
                               onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';"
                               class="img-thumb">
                          <span class="primary-badge">⭐ Primary</span>
                          <button type="button" class="img-remove-btn remove-existing-btn" title="Remove">×</button>
                      </div>
                      <%/if%>
                      
                      <%if isset($product_images) && $product_images|@count > 0%>
                        <%foreach from=$product_images item=img%>
                        <div class="img-preview-card position-relative existing-image-preview" data-is-primary="0" data-image-id="<%$img.image_id%>" data-image-name="<%$img.image%>">
                            <img src="<%$base_url%>public/uploads/product/product_image/<%$products[0].product_id%>/gallery/<%$img.image%>" 
                                 onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';"
                                 class="img-thumb">
                            <span class="primary-badge d-none">⭐ Primary</span>
                            <button type="button" class="img-remove-btn remove-existing-btn" title="Remove">×</button>
                        </div>
                        <%/foreach%>
                      <%/if%>
                    <%/if%>
                  </div>
                  
                  <div id="removedExistingImagesContainer"></div>
                </div>
              </div>
            </div>

            <div class="mb-3 col-12">
              <input type="hidden"  id="mode"  value="<%if isset($products)%>Update<%else%>Add<%/if%>">
              <input type="hidden"  id="product_id" name="product_id" value="<%if isset($products) %><%$products[0].product_id%><%/if%>">
              <button type="submit" class="btn btn-primary">Submit</button>
            </div>
          </div>
        </form>


        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->
    

      <div class="content-backdrop fade"></div>
    </div>

    <style type="text/css">
      input.required-check:checked {
          border-color: #0d6efd !important;
          background-color: #fc0d0d !important;
      }
      .required-check{
          position: absolute;
          top: -13px;
          right: -7px;
          width: 22px;
          height: 22px;
      }

      /* ── Attribute row hover ── */
      .attribute-row { transition: box-shadow .2s; }
      .attribute-row:hover { box-shadow: 0 2px 12px rgba(115,103,240,.15); }
      .remove-attr-btn:hover { background:#ea5455 !important; color:#fff !important; border-color:#ea5455 !important; }

      /* ── Image preview cards ── */
      .img-preview-card {
        position: relative;
        width: 130px;
        height: 130px;
        border-radius: 12px;
        overflow: visible;
        box-shadow: 0 2px 10px rgba(0,0,0,.1);
        transition: transform .2s, box-shadow .2s;
        display: inline-block;
      }
      .img-preview-card:hover { transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,0,0,.15); }
      .img-thumb {
        width: 130px;
        height: 130px;
        object-fit: cover;
        border-radius: 12px;
        border: 2px solid #e3e6f0;
        display: block;
      }
      .img-preview-card[data-is-primary="1"] .img-thumb,
      .img-preview-card.is-primary .img-thumb {
        border-color: #7367f0;
        box-shadow: 0 0 0 3px rgba(115,103,240,.2);
      }
      .primary-badge {
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        background: linear-gradient(135deg,#7367f0,#9e95f5);
        color: #fff;
        font-size: 0.65rem;
        font-weight: 700;
        padding: 2px 10px;
        border-radius: 20px;
        white-space: nowrap;
        box-shadow: 0 2px 6px rgba(115,103,240,.4);
      }
      .img-remove-btn {
        position: absolute;
        top: -8px;
        right: -8px;
        width: 22px;
        height: 22px;
        min-width: 22px;
        min-height: 22px;
        background: #ea5455;
        color: #fff;
        border: 2px solid #fff;
        border-radius: 50% !important;
        font-size: 14px;
        line-height: 22px;
        padding: 0;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 2px 6px rgba(234,84,85,.45);
        transition: background .2s, transform .2s;
        z-index: 10;
        overflow: hidden;
      }
      .img-remove-btn:hover { background: #c0392b; transform: scale(1.15); }

      /* ── Section card unified border ── */
      .section-card { border: 1px solid #e3e6f0; border-radius: 12px; }
    </style>
    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>;
    var master_attributes = <%if isset($master_attributes)%><%$master_attributes|@json_encode%><%else%>[]<%/if%>;
    </script>
      <link rel="stylesheet" href="<%$base_url%>public/plugin/editor/editor.css">
    <!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="<%$base_url%>public/plugin/editor/editor.js"></script>
   
    <script src="<%$base_url%>public/js/admin_panel/add_product.js?v=1789815629"></script>
