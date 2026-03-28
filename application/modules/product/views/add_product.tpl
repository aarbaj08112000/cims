
    <!-- Include jQuery UI for Autocomplete -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- Include Tokenfield JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-tokenfield/dist/bootstrap-tokenfield.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

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
          <span ><%if isset($products) %>Update Product<%else%>Add Product<%/if%></span>
        </div>
      </nav>
        <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
         <a href="<%base_url('product')%>"  class="btn btn-seconday" title="Back To College/School Master Listing">
            <i class="ti ti-arrow-left"></i>
        </a>
        </div>
      <div class="dt-top-btn d-grid gap-2 d-md-flex justify-content-md-end mb-5">
        <%* <button class="btn btn-seconday" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv"></i></button>
        <button class="btn btn-seconday" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf"></i></button>
        <button class="btn btn-seconday filter-icon" type="button"><i class="ti ti-filter" ></i></i></button>
        <button class="btn btn-seconday" type="button"><i class="ti ti-refresh reset-filter"></i></button> *%>
        
       <!-- <button type="button" class="btn btn-seconday" data-bs-toggle="modal" data-bs-target="#addPromo" title="Add process">
       <i class="ti ti-plus"></i>
        </button> -->
       

      </div>
     

      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
        <div class="p-3">
          <form id="product_form" class="container mt-4" action="javascript:void(0)" method="POST" enctype="multipart/form-data">
           <div class="row">
           <!-- Row 1 -->
            <%if isset($products)%>
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
                <select name="category_id" class="form-control required-input form-select">
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
                 <select name="brand_id" class="form-control required-input form-select">
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
              <label class="form-label">Price (Selling) <span class="text-danger">*</span></label>
              <input type="text" step="0.01" name="price" class="form-control required-input onlyNumericInput" placeholder="Enter Selling Price" value="<%if isset($products) %><%$products[0].price%><%/if%>">
            </div>
            
            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Purchase Price</label>
              <input type="text" step="0.01" name="purchase_price" class="form-control onlyNumericInput" placeholder="Enter Purchase Price" value="<%if isset($products) %><%$products[0].purchase_price%><%/if%>">
            </div>

            <div class="mb-3 col-md-4 col-12">
              <label class="form-label">Tax Rate (%)</label>
              <input type="text" step="0.01" name="tax_rate" class="form-control onlyNumericInput" placeholder="e.g. 5, 12, 18" value="<%if isset($products) %><%$products[0].tax_rate%><%/if%>">
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
               <select name="unit" class="form-control form-select">
                   <option value="Piece" <%if isset($products) && $products[0].unit == 'Piece'%>selected<%/if%>>Piece</option>
                   <option value="Meter" <%if isset($products) && $products[0].unit == 'Meter'%>selected<%/if%>>Meter</option>
                   <option value="Kg" <%if isset($products) && $products[0].unit == 'Kg'%>selected<%/if%>>Kg</option>
                   <option value="Box" <%if isset($products) && $products[0].unit == 'Box'%>selected<%/if%>>Box</option>
               </select>
            </div>

             <!-- Row 5 -->
            <div class="mb-3 col-md-4 col-12">
               <label class="form-label">Size</label>
               <input type="text" name="size" class="form-control" placeholder="e.g. S, M, L, XL" value="<%if isset($products) %><%$products[0].size%><%/if%>">
            </div>

             <div class="mb-3 col-md-4 col-12">
               <label class="form-label">Color</label>
               <input type="text" name="color" class="form-control" placeholder="e.g. Red, Blue" value="<%if isset($products) %><%$products[0].color%><%/if%>">
            </div>

             <div class="mb-3 col-md-4 col-12">
               <label class="form-label">Material</label>
               <input type="text" name="material" class="form-control" placeholder="e.g. Cotton, Silk" value="<%if isset($products) %><%$products[0].material%><%/if%>">
            </div>


            <div class="mb-3 col-12">
              <label class="form-label">Description <span class="text-danger">*</span></label>
              <textarea name="description" class="form-control required-input" rows="4" placeholder="Enter Product Description"><%if isset($products[0].description)%><%$products[0].description %><%/if %></textarea>
            </div>

            <div class="mb-3 col-md-6 col-12">
              <label class="form-label">Product Image <span class="text-danger">*</span></label>
              <input type="file" name="image" class="form-control required-input" >
               <input type="hidden" class="form-control required-input" id="product_image" name="product_image" value="<%if isset($products) %><%$products[0].image%><%/if%>">
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
    </style>
    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>
      <link rel="stylesheet" href="<%$base_url%>public/plugin/editor/editor.css">
    <!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="<%$base_url%>public/plugin/editor/editor.js"></script>
   
    <script src="<%$base_url%>public/js/admin_panel/add_product.js"></script>
