
   

    <style>
        .product-image-container {
            background-color: #f8f9fa;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .product-image-container:hover img {
            transform: scale(1.02);
            transition: transform 0.3s ease;
        }
        .review-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease-in-out;
            border: 1px solid #eee;
        }
        .review-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .feature-box {
            background-color: #fff;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            height: 100%;
            transition: all 0.3s;
        }
        .feature-box:hover {
            border-color: #bfaee3; /* Using a violet-ish tint from admin theme */
            box-shadow: 0 0 10px rgba(115, 103, 240, 0.1);
        }
    </style>
    <div class="content-wrapper">
      <!-- Content -->
      <div class="container-xxl flex-grow-1 container-p-y">
        
        <!-- Breadcrumb & Back Action -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <nav aria-label="breadcrumb">
              <div class="sub-header-left pull-left breadcrumb">
                <h1>
                  Home
                  <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Back to Issue Request Listing" >
                    <i class="ti ti-chevrons-right" ></i>
                    <em >Product Details</em></a>
                  </h1>
                  <br>
                  <span >Product Details</span>
                </div>
              </nav>
            <a href="<%base_url('product')%>" class="btn btn-outline-secondary btn-sm">
                <i class="ti ti-arrow-left me-1"></i> Back to List
            </a>
        </div>

        <!-- Main Product Card -->
        <div class="card border-0 shadow-lg overflow-hidden" style="border-radius: 16px;">
            <div class="card-body p-0">
                <div class="row g-0">
                    
                    <!-- Left Column: Single Product Image -->
                    <div class="col-lg-6 bg-light p-4 p-md-5 d-flex align-items-center justify-content-center">
                        <div class="product-image-container bg-white shadow-sm p-3 rounded-3" style="max-width: 100%; width: 100%;">
                            <%if $products[0]['image']%>
                                <img id="mainImage" src="public/uploads/product/product_image/<%$products[0]['product_id']%>/<%$products[0]['image']%>" 
                                     onerror="this.src='public/assets/images/no_image.jpg';"
                                     class="img-fluid rounded" 
                                     alt="<%$products[0]['name']%>" 
                                     style="max-height: 500px; width: 100%; object-fit: contain;">
                            <%else%>
                                <img id="mainImage" src="public/assets/images/no_image.jpg" 
                                     class="img-fluid rounded" 
                                     alt="No Image Available" 
                                     style="max-height: 500px; width: 100%; object-fit: contain;">
                            <%/if%>
                        </div>
                    </div>

                    <!-- Right Column: Product Info -->
                    <div class="col-lg-6 p-4 p-md-5 bg-white">
                        <div class="mb-2">
                             <span class="badge bg-label-primary rounded-pill px-3"><%$products[0]['category_name']%></span>
                             <span class="text-muted ms-2 small">Brand: <strong><%$products[0]['brand_name']%></strong></span>
                        </div>
                        
                        <h1 class="fw-bold text-dark display-6 mb-3"><%$products[0]['name']%></h1>
                        
                        <div class="d-flex align-items-center mb-4">
                            <h2 class="text-primary fw-bold mb-0 me-3">₹<%$products[0]['price']|number_format:2%></h2>
                            <%if $products[0]['qty'] > 0%>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success px-3">In Stock (<%$products[0]['qty']%>)</span>
                            <%else%>
                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger px-3">Out of Stock</span>
                            <%/if%>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-4">
                                <div class="feature-box">
                                    <i class="ti ti-ruler-2 text-primary mb-2 fs-4"></i>
                                    <div class="text-muted small">Size</div>
                                    <div class="fw-bold"><%$products[0]['size']|default:'-'%></div>
                                </div>
                            </div>
                            <div class="col-4">
                                 <div class="feature-box">
                                    <i class="ti ti-palette text-warning mb-2 fs-4"></i>
                                    <div class="text-muted small">Color</div>
                                    <div class="fw-bold"><%$products[0]['color']|default:'-'%></div>
                                </div>
                            </div>
                             <div class="col-4">
                                 <div class="feature-box">
                                    <i class="ti ti-shirt text-info mb-2 fs-4"></i>
                                    <div class="text-muted small">Material</div>
                                    <div class="fw-bold"><%$products[0]['material']|default:'-'%></div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <h5 class="fw-bold border-bottom pb-2 mb-3">Product Description</h5>
                            <p class="text-muted" style="line-height: 1.7;">
                                <%$products[0]['description']|nl2br|default:'No description available.'%>
                            </p>
                        </div>
                        
                        <div class="bg-light rounded p-3 mb-4">
                            <div class="row text-muted small">
                                 <div class="col-md-4 mb-2 mb-md-0"><strong>SKU:</strong> <br><span class="text-dark"><%$products[0]['product_code']%></span></div>
                                 <div class="col-md-4 mb-2 mb-md-0"><strong>HSN Code:</strong> <br><span class="text-dark"><%$products[0]['hsn_code']%></span></div>
                                 <div class="col-md-4"><strong>Tax Rate:</strong> <br><span class="text-dark"><%$products[0]['tax_rate']%>%</span></div>
                            </div>
                            <%if $products[0]['line_bar_code']%>
                            <div class="row mt-3 pt-3 border-top">
                                <div class="col-12">
                                    <small class="text-muted d-block mb-1"><strong>Barcode:</strong></small>
                                    <img src="public/uploads/product/bar_code/<%$products[0]['product_id']%>/<%$products[0]['line_bar_code']%>.png" 
                                         onerror="this.src='public/assets/images/no_image.jpg';"
                                         alt="<%$products[0]['line_bar_code']%>" 
                                         class="img-fluid" 
                                         style="height: 60px; max-width: 100%; object-fit: contain;">
                                </div>
                            </div>
                            <%/if%>
                        </div>

                       
                    </div>
                </div>
            </div>
        </div>

        
        
      </div>
      <!-- / Content -->
      <div class="content-backdrop fade"></div>
    </div>
    
    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
