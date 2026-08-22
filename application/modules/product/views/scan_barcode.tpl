<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
    .scanner-container {
        max-width: 600px;
        margin: 20px auto;
        background: #fff;
        padding: 0;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        overflow: hidden;
    }
    .scanner-header {
        background: linear-gradient(135deg, var(--cat-primary), #4318FF);
        color: white;
        padding: 20px;
        text-align: center;
    }
    .scanner-header h5 {
        margin: 0;
        color: white;
        font-weight: 600;
        font-size: 1.1rem;
    }
    .scanner-body {
        padding: 20px;
    }
    #reader {
        width: 100%;
        border: none !important;
        border-radius: 8px;
        overflow: hidden;
    }
    #reader video {
        border-radius: 8px;
        object-fit: cover;
    }
    /* html5-qrcode overrides */
    #reader__scan_region {
        background: #f8f9fa;
        border-radius: 8px;
    }
    #reader__dashboard_section_csr button {
        background: var(--cat-primary);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        transition: background 0.3s;
    }
    #reader__dashboard_section_csr button:hover {
        background: #4318FF;
    }
    
    .product-details-card {
        display: none;
        margin-top: 20px;
        padding: 25px;
        border: 1px solid #eee;
        border-radius: 12px;
        background: #fafafa;
        animation: fadeIn 0.4s ease-out;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .product-img-wrapper {
        background: #fff;
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #eaeaea;
        margin-bottom: 15px;
        text-align: center;
    }
    .product-img {
        max-width: 100%;
        max-height: 180px;
        object-fit: contain;
    }
    .product-info-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .product-info-list li {
        padding: 8px 0;
        border-bottom: 1px dashed #eee;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
    }
    .product-info-list li:last-child {
        border-bottom: none;
    }
    .product-info-list .info-label {
        font-weight: 600;
        color: #555;
        flex: 0 0 40%;
        font-size: 0.9rem;
    }
    .product-info-list .info-value {
        flex: 1;
        text-align: right;
        font-size: 0.9rem;
        color: #222;
        word-break: break-word;
    }
    .scan-btn-resume {
        display: none;
        margin-top: 20px;
        width: 100%;
        padding: 12px;
        font-size: 1rem;
        border-radius: 8px;
    }
    
    @media (max-width: 768px) {
        .cat-page-header {
            flex-direction: column;
            align-items: flex-start;
        }
        .cat-page-header-right {
            margin-top: 15px;
            width: 100%;
            justify-content: flex-end;
        }
        .scanner-container {
            margin: 10px;
            border-radius: 10px;
        }
        .scanner-body {
            padding: 15px;
        }
    }
</style>
<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y">
        <!-- Page Header -->
        <div class="cat-page-header">
            <div class="cat-page-header-left">
                <div class="cat-page-icon"><i class="ti ti-barcode"></i></div>
                <div>
                    <h1 class="cat-page-title">Scan Barcode</h1>
                    <nav class="cat-breadcrumb">
                        <a href="<%base_url('dashboard')%>">Home</a>
                        <i class="ti ti-chevron-right"></i>
                        <a href="<%base_url('product')%>">Products</a>
                        <i class="ti ti-chevron-right"></i>
                        <span>Scan Barcode</span>
                    </nav>
                </div>
            </div>
            <div class="cat-page-header-right">
                <a href="<%base_url('product')%>" class="cat-btn cat-btn-outline" title="Back to Products">
                    <i class="ti ti-arrow-left"></i> Back
                </a>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="scanner-container">
                    <div class="scanner-header">
                        <h5><i class="ti ti-scan me-2"></i> Position Barcode in Frame</h5>
                    </div>
                    <div class="scanner-body">
                        <div id="reader"></div>
                        
                        <div id="product-details" class="product-details-card">
                            <h4 class="mb-4 text-primary text-center">Product Found</h4>
                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="product-img-wrapper">
                                        <img id="p_image" src="" alt="Product Image" class="product-img" onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';">
                                    </div>
                                    <div class="text-center mb-3 mb-sm-0">
                                        <span class="badge bg-label-primary px-3 py-2" id="p_code"></span>
                                    </div>
                                </div>
                                <div class="col-sm-7">
                                    <ul class="product-info-list">
                                        <li><span class="info-label">Name:</span> <span class="info-value fw-bold" id="p_name"></span></li>
                                        <li><span class="info-label">Category:</span> <span class="info-value" id="p_category"></span></li>
                                        <li><span class="info-label">Brand:</span> <span class="info-value" id="p_brand"></span></li>
                                        <li><span class="info-label">Price:</span> <span class="info-value text-success fw-bold fs-5" id="p_price"></span></li>
                                        <li><span class="info-label">Stock:</span> <span class="info-value" id="p_stock_container"><span id="p_stock"></span> <span id="p_unit" class="text-muted small"></span></span></li>
                                        <li><span class="info-label">Description:</span> <span class="info-value text-muted" id="p_desc"></span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="text-center mt-4">
                                <a id="p_link" href="#" class="btn btn-outline-primary w-100">View Full Details <i class="ti ti-arrow-right ms-1"></i></a>
                            </div>
                        </div>

                        <button type="button" id="resume-scan" class="btn btn-primary scan-btn-resume">
                            <i class="ti ti-scan me-1"></i> Scan Another Item
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
<script>
    var base_url = '<%$base_url%>';
    let html5QrcodeScanner;

    function onScanSuccess(decodedText, decodedResult) {
        if(html5QrcodeScanner) {
            html5QrcodeScanner.pause(true);
        }

        if(typeof toaster !== 'undefined'){
            toaster("info", "Barcode scanned. Fetching details...");
        }

        $.ajax({
            url: base_url + "product/get_product_by_barcode",
            type: "POST",
            data: { barcode: decodedText },
            dataType: "json",
            success: function (res) {
                if (res.success) {
                    if(typeof toaster !== 'undefined') toaster("success", res.msg);
                    
                    let p = res.data;
                    
                    $('#p_name').text(p.name || '-');
                    $('#p_code').text(p.product_code || '-');
                    $('#p_category').text(p.category_name || '-');
                    $('#p_brand').text(p.brand_name || '-');
                    $('#p_price').text(p.price ? "₹ " + p.price : '-');
                    $('#p_stock').text(p.qty || '0');
                    $('#p_unit').text(p.unit || '');
                    
                    let desc = p.description || '-';
                    if (desc.length > 60) desc = desc.substring(0, 60) + '...';
                    $('#p_desc').text(desc);
                    
                    if(p.image){
                        $('#p_image').attr('src', base_url + 'public/uploads/product/product_image/' + p.product_id + '/' + p.image);
                    } else {
                        $('#p_image').attr('src', base_url + 'public/assets/images/no_image.jpg');
                    }

                    $('#p_link').attr('href', base_url + 'product/product_details/' + p.product_id);

                    // Hide scanner, show details
                    $('#reader').slideUp(300);
                    $('#product-details').slideDown(300);
                    $('#resume-scan').fadeIn(300);

                } else {
                    if(typeof toaster !== 'undefined') toaster("error", res.msg);
                    else alert(res.msg); 
                    
                    $('#resume-scan').fadeIn(300);
                }
            },
            error: function () {
                if(typeof toaster !== 'undefined') toaster("error", "Server Error while fetching details.");
                $('#resume-scan').fadeIn(300);
            }
        });
    }

    function onScanFailure(error) {
        // Handle scan failure silently to keep the scanner running smoothly
    }

    $(document).ready(function() {
        // Make qrbox responsive to screen size
        function getQrBoxSize(viewfinderWidth, viewfinderHeight) {
            let minEdgePercentage = 0.9; // 90% for maximum scanning area
            let minEdgeSize = Math.min(viewfinderWidth, viewfinderHeight);
            let qrboxSize = Math.floor(minEdgeSize * minEdgePercentage);
            
            // QR Codes require a square box for optimal scanning.
            return {
                width: qrboxSize,
                height: qrboxSize
            };
        }

        html5QrcodeScanner = new Html5QrcodeScanner(
            "reader",
            { 
                fps: 20, 
                qrbox: getQrBoxSize,
                showTorchButtonIfSupported: true,
                // Removing useBarCodeDetectorIfSupported as it can sometimes fail for 1D barcodes on mobile browsers
                // Removing aspectRatio to let the camera use its natural resolution without cropping
                videoConstraints: {
                    facingMode: "environment",
                    // Request higher resolution specifically for 1D barcodes (they need clarity)
                    width: { min: 640, ideal: 1920, max: 1920 },
                    height: { min: 480, ideal: 1080, max: 1080 }
                }
            },
            false
        );
        html5QrcodeScanner.render(onScanSuccess, onScanFailure);

        $('#resume-scan').on('click', function(){
            $('#product-details').slideUp(200);
            $(this).hide();
            $('#reader').slideDown(300, function() {
                if(html5QrcodeScanner){
                    html5QrcodeScanner.resume();
                }
            });
        });
    });
</script>
