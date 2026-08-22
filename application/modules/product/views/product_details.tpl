<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<link rel="stylesheet" href="<%$base_url%>public/css/product_details.css" />
<div class="content-wrapper p-4">
  <div class="cat-page-header">
    <div class="cat-page-header-left">
      <div class="cat-page-icon"><i class="ti ti-box"></i></div>
      <div>
        <h1 class="cat-page-title">Product Details</h1>
        <nav class="cat-breadcrumb">
          <a href="<%$base_url%>">Home</a>
          <i class="ti ti-chevron-right"></i>
          <a href="<%$base_url%>product">Products</a>
          <i class="ti ti-chevron-right"></i>
          <span>Details</span>
        </nav>
      </div>
    </div>
    <a href="<%$base_url%>product" class="cat-btn cat-btn-outline cat-btn-sm">
      <i class="ti ti-arrow-left me-1"></i> Back to List
    </a>
  </div>

  <div class="cat-table-card">
    <div class="card border-0 shadow-lg overflow-hidden" style="border-radius: 16px;">
      <div class="card-body p-0">
        <div class="row g-0">
          <!-- Image Column -->
          <div class="col-lg-6 bg-light p-4 d-flex align-items-center justify-content-center">
            <div class="product-image-container bg-white shadow-sm p-3 rounded-3" style="max-width:100%; width:100%;">
              <%if $products[0]['image']%>
                <img id="mainImage" src="public/uploads/product/product_image/<%$products[0]['product_id']%>/<%$products[0]['image']%>" onerror="this.src='public/assets/images/no_image.jpg';" class="img-fluid rounded" alt="<%$products[0]['name']%>" style="max-height:500px; width:100%; object-fit:contain;" />
              <%else%>
                <img id="mainImage" src="public/assets/images/no_image.jpg" class="img-fluid rounded" alt="No Image Available" style="max-height:500px; width:100%; object-fit:contain;" />
              <%/if%>
            </div>
          </div>
          <!-- Info Column -->
          <div class="col-lg-6 p-4 bg-white">
            <div class="mb-2">
              <span class="cat-badge cat-badge-primary rounded-pill px-3"><%$products[0]['category_name']%></span>
              <span class="text-muted ms-2 small">Brand: <strong><%$products[0]['brand_name']%></strong></span>
            </div>
            <h1 class="fw-bold text-dark display-6 mb-3"><%$products[0]['name']%></h1>
            <div class="d-flex align-items-center mb-4">
              <h2 class="text-primary fw-bold mb-0 me-3">₹<%$products[0]['price']|default:0|number_format:2%></h2>
              <%if $products[0]['qty'] > 0%>
                <span class="cat-badge cat-badge-success">In Stock (<%$products[0]['qty']%>)</span>
              <%else%>
                <span class="cat-badge cat-badge-danger">Out of Stock</span>
              <%/if%>
            </div>
            <div class="row g-3 mb-4">
              <div class="col-4"><div class="feature-box"><i class="ti ti-ruler-2 text-primary mb-2 fs-4"></i><div class="text-muted small">Size</div><div class="fw-bold"><%$products[0]['size']|default:'-'%></div></div></div>
              <div class="col-4"><div class="feature-box"><i class="ti ti-palette text-warning mb-2 fs-4"></i><div class="text-muted small">Color</div><div class="fw-bold"><%$products[0]['color']|default:'-'%></div></div></div>
              <div class="col-4"><div class="feature-box"><i class="ti ti-shirt text-info mb-2 fs-4"></i><div class="text-muted small">Material</div><div class="fw-bold"><%$products[0]['material']|default:'-'%></div></div></div>
            </div>
            <h5 class="fw-bold border-bottom pb-2 mb-3">Product Description</h5>
            <p class="text-muted" style="line-height:1.7;">
              <%$products[0]['description']|nl2br|default:'No description available.'%>
            </p>
            <div class="bg-light rounded p-3 mb-4">
              <div class="row text-muted small">
                <div class="col-md-4 mb-2 mb-md-0"><strong>SKU:</strong><br><span class="text-dark"><%$products[0]['product_code']%></span></div>
                <div class="col-md-4 mb-2 mb-md-0"><strong>HSN Code:</strong><br><span class="text-dark"><%$products[0]['hsn_code']%></span></div>
                <div class="col-md-4"><strong>Tax Rate:</strong><br><span class="text-dark"><%$products[0]['tax_rate']%>%</span></div>
              </div>
              <%if $products[0]['line_bar_code']%>
                <div class="row mt-3 pt-3 border-top">
                  <div class="col-12"><small class="text-muted d-block mb-1"><strong>Barcode:</strong></small>
                    <img src="public/uploads/product/bar_code/<%$products[0]['product_id']%>/<%$products[0]['line_bar_code']%>.png" onerror="this.src='public/assets/images/no_image.jpg';" alt="<%$products[0]['line_bar_code']%>" class="img-fluid" style="height:60px; max-width:100%; object-fit:contain;" />
                  </div>
                </div>
              <%/if%>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
