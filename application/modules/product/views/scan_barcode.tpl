<link rel="stylesheet" href="<%$base_url%>public/css/category_ui.css" />
<style>
    .scanner-container {
        max-width: 600px;
        margin: 0 auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    #reader {
        width: 100%;
        min-height: 300px;
    }
    .product-details-card {
        display: none;
        margin-top: 20px;
        padding: 20px;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        background: #fafafa;
    }
    .product-img {
        max-width: 150px;
        border-radius: 4px;
    }
    .scan-btn-resume {
        display: none;
        margin-top: 15px;
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

        <div class="row">
            <div class="col-md-12">
                <div class="scanner-container">
                    <h5 class="text-center mb-3">Position Barcode in the Camera Frame</h5>
                    <div id="reader"></div>
                    
                    <div id="product-details" class="product-details-card">
                        <h4 class="mb-3 text-primary">Product Details</h4>
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <img id="p_image" src="" alt="Product Image" class="product-img mb-2" onerror="this.src='<%$base_url%>public/assets/images/no_image.jpg';">
                                <br>
                                <strong><span id="p_code"></span></strong>
                            </div>
                            <div class="col-md-8">
                                <table class="table table-borderless table-sm">
                                    <tbody>
                                        <tr><th width="40%">Name:</th><td><span id="p_name"></span></td></tr>
                                        <tr><th>Category:</th><td><span id="p_category"></span></td></tr>
                                        <tr><th>Brand:</th><td><span id="p_brand"></span></td></tr>
                                        <tr><th>Price:</th><td><span id="p_price" class="text-success fw-bold"></span></td></tr>
                                        <tr><th>Stock:</th><td><span id="p_stock"></span> <span id="p_unit"></span></td></tr>
                                        <tr><th>Description:</th><td><span id="p_desc"></span></td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="text-center mt-3">
                            <a id="p_link" href="#" class="btn btn-sm btn-outline-primary">View Full Details</a>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="button" id="resume-scan" class="btn btn-primary scan-btn-resume">
                            <i class="ti ti-scan"></i> Scan Another Item
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
        // Stop scanning after successful scan
        if(html5QrcodeScanner) {
            html5QrcodeScanner.pause(true);
        }

        // Show loading state or toaster (assuming toaster is available in project)
        if(typeof toastr !== 'undefined'){
            toastr.info("Barcode scanned. Fetching details...");
        }

        // Fetch product details
        $.ajax({
            url: base_url + "product/get_product_by_barcode",
            type: "POST",
            data: { barcode: decodedText },
            dataType: "json",
            success: function (res) {
                if (res.success) {
                    if(typeof toastr !== 'undefined') toastr.success(res.msg);
                    
                    let p = res.data;
                    
                    // Update UI
                    $('#p_name').text(p.name || '-');
                    $('#p_code').text(p.product_code || '-');
                    $('#p_category').text(p.category_name || '-');
                    $('#p_brand').text(p.brand_name || '-');
                    $('#p_price').text(p.price ? "₹ " + p.price : '-');
                    $('#p_stock').text(p.qty || '0');
                    $('#p_unit').text(p.unit || '');
                    $('#p_desc').text(p.description || '-');
                    
                    if(p.image){
                        $('#p_image').attr('src', base_url + 'public/uploads/product/product_image/' + p.product_id + '/' + p.image);
                    } else {
                        $('#p_image').attr('src', base_url + 'public/assets/images/no_image.jpg');
                    }

                    $('#p_link').attr('href', base_url + 'product/product_details/' + p.product_id);

                    // Show details, show resume button
                    $('#product-details').slideDown();
                    $('#resume-scan').show();

                } else {
                    if(typeof toastr !== 'undefined') toastr.error(res.msg);
                    alert(res.msg); // Fallback
                    $('#resume-scan').show();
                }
            },
            error: function () {
                if(typeof toastr !== 'undefined') toastr.error("Server Error while fetching details.");
                $('#resume-scan').show();
            }
        });
    }

    function onScanFailure(error) {
        // handle scan failure, usually better to ignore and keep scanning
        // console.warn(`Code scan error = ${error}`);
    }

    $(document).ready(function() {
        // Initialize scanner
        html5QrcodeScanner = new Html5QrcodeScanner(
            "reader",
            { fps: 10, qrbox: {width: 250, height: 150} },
            /* verbose= */ false
        );
        html5QrcodeScanner.render(onScanSuccess, onScanFailure);

        $('#resume-scan').on('click', function(){
            $('#product-details').slideUp();
            $(this).hide();
            if(html5QrcodeScanner){
                html5QrcodeScanner.resume();
            }
        });
    });
</script>
