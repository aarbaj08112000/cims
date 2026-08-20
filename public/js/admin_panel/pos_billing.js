$(document).ready(function () {
    // 1. Auto-focus scanner input
    $('#barcode_scan').focus();
    
    // Get current bill number from DOM
    var current_bill_no = $('#bill_no_display').text();

    // 2. Barcode Scan Event (Manual Input)
    $('#barcode_scan').on('keypress', function (e) {
        if (e.which === 13) { // Enter key
            var barcode = $(this).val();
            if (barcode) {
                addProductByBarcode(barcode);
                $(this).val('');
            }
        }
    });

    // 2.1 Mobile Camera Barcode Scanner
    var html5QrcodeScanner = null;
    $('#start_mobile_scan').on('click', function() {
        var $btn = $(this);
        var $container = $('#qr-reader');
        
        // If already scanning, stop it
        if (html5QrcodeScanner) {
            html5QrcodeScanner.clear().then(() => {
                $container.hide();
                $btn.html('<i class="ti ti-camera"></i>').removeClass('btn-danger').addClass('btn-outline-primary');
                html5QrcodeScanner = null;
            });
            return;
        }
        
        // Initialize and start scanner
        $container.show();
        $btn.html('<i class="ti ti-square-x"></i>').removeClass('btn-outline-primary').addClass('btn-danger');
        
        html5QrcodeScanner = new Html5QrcodeScanner(
            "qr-reader", 
            { fps: 10, qrbox: {width: 250, height: 150} },
            /* verbose= */ false
        );
        
        html5QrcodeScanner.render(function(decodedText, decodedResult) {
            // Success Callback
            if (decodedText) {
                // Play a beep sound or visual cue if desired
                $('#barcode_scan').val(decodedText);
                addProductByBarcode(decodedText);
                
                // Pause scanning briefly to prevent multiple scans of same code
                html5QrcodeScanner.pause(true);
                setTimeout(() => {
                    if (html5QrcodeScanner) html5QrcodeScanner.resume();
                    $('#barcode_scan').val('');
                }, 1500);
            }
        }, function(errorMessage) {
            // Error Callback - ignore to avoid console spam during seeking
        });
    });

    // 3. Manual Product Search (Autocomplete)
    $("#product_search").autocomplete({
        source: base_url + "pos_product_search",
        minLength: 1,
        select: function (event, ui) {
            addProductToTable(ui.item.product);
            $(this).val('');
            return false;
        }
    });

    // 4. Quantity Change Event
    $(document).on('input', '.qty-input', function () {
        var row = $(this).closest('tr');
        updateRowTotal(row);
        calculateFinalTotal();
    });

    // 5. Remove Item Event
    $(document).on('click', '.remove-item-btn', function () {
        $(this).closest('tr').remove();
        if ($('#pos_items_body tr[data-product-id]').length === 0) {
            $('#pos_items_body').append('<tr id="empty_state_row"><td colspan="5" class="text-center py-5 text-muted"><div class="py-4"><i class="ti ti-shopping-cart-x ti-xl mb-2 d-block opacity-25"></i>Scan barcode or search products to add items</div></td></tr>');
        }
        calculateFinalTotal();
    });

    // 6. Discount & Received Amount Change Event
    $('#discount_input').on('input', function () {
        calculateFinalTotal();
    });

    $('#received_amount_input').on('input', function () {
        if ($(this).val() === '') {
            $(this).data('manual', false);
        } else {
            $(this).data('manual', true);
        }
        calculateFinalTotal();
    });

    // 7. Pay & Complete Order (Save)
    $('#save_pos_bill_btn').on('click', function () {
        savePOSBill();
    });

    // 8. Keyboard Shortcut (F2 to save)
    $(document).on('keydown', function (e) {
        if (e.key === "F2") {
            e.preventDefault();
            savePOSBill();
        }
    });

    // Helper: Add product by barcode via AJAX
    function addProductByBarcode(barcode) {
        $.ajax({
            url: base_url + "pos_get_product",
            type: "POST",
            data: { barcode: barcode },
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    addProductToTable(response.product);
                } else {
                    toaster('error', response.msg);
                }
            }
        });
    }

    // Helper: Add product object to the billing table
    function addProductToTable(product) {
        // Remove empty state message if exists
        $('#empty_state_row').remove();
        if ($('#pos_items_body tr[data-product-id]').length === 0) {
            $('#pos_items_body').empty(); // Extra safety
        }

        // Check if product already exists in the table
        var existingRow = $(`#pos_items_body tr[data-product-id="${product.product_id}"]`);
        if (existingRow.length > 0) {
            var qtyInput = existingRow.find('.qty-input');
            var currentQty = parseInt(qtyInput.val());
            qtyInput.val(currentQty + 1);
            updateRowTotal(existingRow);
        } else {
            // Add new row
            var rowHtml = `
                <tr data-product-id="${product.product_id}">
                    <td data-label="Product">
                        <div class="fw-bold">${product.name}</div>
                        <small class="text-muted">${product.product_code}</small>
                        <input type="hidden" name="product_id[]" value="${product.product_id}">
                    </td>
                    <td data-label="Price" class="text-center">
                        ₹${parseFloat(product.price).toFixed(2)}
                        <input type="hidden" name="price[]" class="row-price" value="${product.price}">
                    </td>
                    <td data-label="Qty" class="text-center">
                        <input type="number" name="qty[]" class="form-control qty-input mx-auto" value="1" min="1">
                    </td>
                    <td data-label="Total" class="text-end fw-bold row-total-display">
                        ₹${parseFloat(product.price).toFixed(2)}
                        <input type="hidden" name="total[]" class="row-total-val" value="${product.price}">
                    </td>
                    <td data-label="Action" class="text-center">
                        <button type="button" class="btn btn-label-danger btn-sm remove-item-btn">
                            <i class="ti ti-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
            $('#pos_items_body').append(rowHtml);
            toaster('success', 'Product added: ' + product.name);
        }
        calculateFinalTotal();
    }

    // Helper: Update a single row total
    function updateRowTotal(row) {
        var price = parseFloat(row.find('.row-price').val()) || 0;
        var qty = parseInt(row.find('.qty-input').val()) || 0;
        var total = price * qty;
        row.find('.row-total-display').text('₹' + total.toFixed(2));
        row.find('.row-total-val').val(total.toFixed(2));
    }

    // Helper: Calculate Final Totals
    function calculateFinalTotal() {
        var subtotal = 0;
        var totalItems = 0;

        // Loop through each item row and calculate totals on the fly
        $('#pos_items_body tr[data-product-id]').each(function () {
            var rowPrice = parseFloat($(this).find('.row-price').val()) || 0;
            var rowQty = parseInt($(this).find('.qty-input').val()) || 0;
            
            var rowTotal = rowPrice * rowQty;
            subtotal += rowTotal;
            totalItems += rowQty;
            
            // Sync the row's total display and hidden value just in case
            $(this).find('.row-total-display').text('₹' + rowTotal.toFixed(2));
            $(this).find('.row-total-val').val(rowTotal.toFixed(2));
        });

        var discount = parseFloat($('#discount_input').val()) || 0;

        // Dynamic tax calculation from settings
        var taxEnabled = $('#pos_tax_enabled').val() === 'Yes';
        var taxPercentage = parseFloat($('#pos_tax_percentage').val()) || 0;
        var taxRate = taxEnabled ? (taxPercentage / 100) : 0;
        
        var taxAmount = subtotal * taxRate;
        var grandTotal = (subtotal + taxAmount) - discount;
        if (grandTotal < 0) grandTotal = 0;

        $('#total_items_count').text(totalItems);
        $('#subtotal_display').text('₹' + subtotal.toFixed(2));
        $('#tax_display').text('₹' + taxAmount.toFixed(2));
        $('#grand_total_display').text('₹' + grandTotal.toFixed(2));
        
        // Update label to reflect percentage
        if (taxEnabled) {
            $('#tax_label').text('Tax (' + taxPercentage + '%)');
        } else {
            $('#tax_label').text('Tax (0%)');
        }
        
        // Auto-calculate Received Amount
        var isManual = $('#received_amount_input').data('manual');
        if (!isManual) {
            $('#received_amount_input').val(grandTotal.toFixed(2));
        }
        
        var received = parseFloat($('#received_amount_input').val()) || 0;
        var change = received - grandTotal;
        if (change < 0) change = 0;
        $('#change_display').text('₹' + change.toFixed(2));
    }

    // Helper: AJAX Save POS Bill
    function savePOSBill() {
        if ($('#pos_items_body tr[data-product-id]').length === 0) {
            toaster('error', 'Please add at least one item to the bill.');
            return;
        }

        var customerName = $('#pos_customer_name').val().trim();
        if (customerName === '') {
            toaster('error', 'Customer Name is required.');
            $('#pos_customer_name').focus();
            return;
        }

        var formData = {
            customer_name: $('#pos_customer_name').val(),
            customer_mobile: $('#pos_customer_mobile').val(),
            bill_no: current_bill_no,
            payment_mode: $('input[name="payment_mode"]:checked').val(),
            product_id: $('input[name="product_id[]"]').map(function(){ return $(this).val(); }).get(),
            qty: $('input[name="qty[]"]').map(function(){ return $(this).val(); }).get(),
            price: $('input[name="price[]"]').map(function(){ return $(this).val(); }).get(),
            total: $('input[name="total[]"]').map(function(){ return $(this).val(); }).get(),
            subtotal: parseFloat($('#subtotal_display').text().replace('₹', '')),
            tax_amount: parseFloat($('#tax_display').text().replace('₹', '')),
            discount: parseFloat($('#discount_input').val()) || 0,
            grand_total: parseFloat($('#grand_total_display').text().replace('₹', '')),
            received_amount: parseFloat($('#received_amount_input').val()) || 0,
            change_amount: parseFloat($('#change_display').text().replace('₹', ''))
        };

        var btn = $('#save_pos_bill_btn');
        var btnHtml = btn.html();
        btn.html('<span class="spinner-border spinner-border-sm me-2"></span>Processing...').prop('disabled', true);

        $.ajax({
            url: base_url + "save_pos_bill",
            type: "POST",
            data: formData,
            dataType: "json",
            success: function (response) {
                btn.html(btnHtml).prop('disabled', false);
                if (response.success) {
                    toaster('success', response.msg);
                    // Fetch and show receipt popup
                    showReceiptPopup(response.sales_id);
                } else {
                    toaster('error', response.msg);
                }
            },
            error: function () {
                btn.html(btnHtml).prop('disabled', false);
                toaster('error', 'Something went wrong while saving.');
            }
        });
    }

    function showReceiptPopup(salesId) {
        $.ajax({
            url: base_url + "sales/Pos/get_bill_print_ajax",
            type: "POST",
            data: { 
                sales_id: salesId,
                received_amount: $('#received_amount_input').val(),
                change_amount: $('#change_display').text().replace('₹', '')
            },
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    $('#receipt_content').html(response.html);
                    $('#receiptModal').modal('show');
                }
            }
        });
    }

    // Reload page when receipt modal is closed
    $('#receiptModal').on('hidden.bs.modal', function () {
        location.reload();
    });
});
