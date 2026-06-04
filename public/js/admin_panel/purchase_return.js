$(document).ready(function () {
    purchaseReturnPage.init();
});

var returnListTable = '';
const purchaseReturnPage = {
    init: function () {
        this.initSelect2();
        this.bindEvents();
        this.dataTable();
    },
    initSelect2: function (selector = ".select2") {
        $(selector).select2({
            width: '100%'
        });
    },
    dataTable: function () {
        returnListTable = $("#returnListTable").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: "purchase_return_history",
                    exportOptions: { columns: [0, 1, 2, 3, 4, 5] }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: "purchase_return_history",
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = "Purchase Return History";
                        doc.content[1].table.widths = ["15%", "15%", "25%", "15%", "15%", "15%"];
                    },
                    exportOptions: { columns: [0, 1, 2, 3, 4, 5] }
                },
            ],
            searching: true,
            order: [[5, "desc"]], // Sort by Added Date
            pagingType: "full_numbers",
            language: {
                processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
                emptyTable:   '<div class="cat-empty">No returns found.</div>',
                zeroRecords:  '<div class="cat-empty">No records match your search.</div>',
                info:         'Showing _START_ to _END_ of _TOTAL_ entries',
                infoEmpty:    'Showing 0 to 0 of 0 entries',
                infoFiltered: '(filtered from _MAX_ total)',
                lengthMenu:   'Show _MENU_ entries',
                paginate: {
                    first:    '<i class="ti ti-chevrons-left"></i>',
                    last:     '<i class="ti ti-chevrons-right"></i>',
                    next:     '<i class="ti ti-chevron-right"></i>',
                    previous: '<i class="ti ti-chevron-left"></i>'
                }
            }
        });

        $('#search-filter-input').on('keyup input', function () {
            returnListTable.search(this.value).draw();
        });

        $('#export-csv').on('click', function () {
            returnListTable.button('.buttons-csv').trigger();
        });

        $('#export-pdf').on('click', function () {
            returnListTable.button('.buttons-pdf').trigger();
        });
    },
    bindEvents: function () {
        let that = this;

        // Load Items for selection
        $("#purchase_id").change(function () {
            let purchaseId = $(this).val();
            if (purchaseId) {
                $.ajax({
                    url: "get_purchase_items_for_return",
                    type: "POST",
                    data: { purchase_id: purchaseId },
                    dataType: "json",
                    success: function (response) {
                        if (response.success == 1) {
                            that.renderReturnItems(response.items);
                            if (response.purchase) {
                                let supplier = response.purchase.supplier_name || 'Walk-in';
                                $("#billSupplier").text(supplier);
                                $("#billDate").text(response.purchase.purchase_date);
                                $("#billAmount").text("₹" + parseFloat(response.purchase.grand_total).toFixed(2));
                                $("#billItems").text(response.items.length);
                                $("#billInfoPanel").fadeIn(300);
                            }
                        } else {
                            $("#returnItemBody").html('<tr><td colspan="7" class="text-center text-danger">' + response.msg + '</td></tr>');
                            that.calculateGrandTotal();
                            $("#billInfoPanel").hide();
                        }
                    }
                });
            } else {
                $("#returnItemBody").html(`
                    <tr class="empty-state-row">
                        <td colspan="7">
                            <div class="empty-state">
                                <div class="empty-state-icon"><i class="ti ti-receipt-off"></i></div>
                                <span class="empty-state-text">No items to display</span>
                                <span class="empty-state-sub">Select an original purchase bill above to load returnable items</span>
                            </div>
                        </td>
                    </tr>
                `);
                that.calculateGrandTotal();
                $("#billInfoPanel").hide();
            }
        });

        // Calculation on Qty Change
        $(document).on("input", ".return-qty-input", function () {
            let row = $(this).closest("tr");
            let available = parseFloat(row.find(".available-qty").text());
            let current = parseFloat($(this).val()) || 0;

            if (current > available) {
                toaster("error", "Cannot return more than available qty (" + available + ")");
                $(this).val(available);
                current = available;
            }

            let price = parseFloat(row.find(".price-text").val()) || 0;
            let total = current * price;
            row.find(".row-total-input").val(total.toFixed(2));
            that.calculateGrandTotal();
        });

        // Form Submit
        $("#purchaseReturnForm").submit(function (e) {
            e.preventDefault();
            let form = $(this);

            let hasQty = false;
            $(".return-qty-input").each(function () {
                if (parseFloat($(this).val()) > 0) hasQty = true;
            });

            if (!hasQty) {
                toaster("error", "Please enter return quantity for at least one item.");
                return;
            }

            let formData = new FormData(form[0]);
            $.ajax({
                type: "POST",
                url: form.attr("action"),
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        toaster("success", response.msg);
                        setTimeout(function () {
                            window.location.href = "purchase_return_list";
                        }, 1500);
                    } else {
                        toaster("error", response.msg);
                    }
                }
            });
        });

        // View Detail Modal
        $(document).on("click", ".view-return-details", function () {
            let returnId = $(this).data("id");
            $("#return-modal-content").html('<div class="p-5 text-center"><div class="spinner-border text-primary"></div></div>');
            $("#returnDetailModal").modal("show");

            $.ajax({
                url: "return_details_ajax",
                type: "POST",
                data: { return_id: returnId },
                dataType: "json",
                success: function (response) {
                    $("#return-modal-content").html(response.html);
                }
            });
        });
    },
    renderReturnItems: function (items) {
        let html = '';
        items.forEach(item => {
            let alreadyReturned = item.qty - item.available_qty;
            html += `<tr>
                <td>
                    <strong>${item.product_name}</strong><br>
                    <small class="text-muted">${item.product_code}</small>
                    <input type="hidden" name="product_id[]" value="${item.product_id}">
                </td>
                <td class="text-center">${item.qty}</td>
                <td class="text-center">${alreadyReturned}</td>
                <td class="text-center available-qty font-weight-bold text-primary">${item.available_qty}</td>
                <td>
                    <input type="number" name="return_qty[]" class="form-control return-qty-input text-center" min="0" max="${item.available_qty}" value="0">
                </td>
                <td class="text-end">
                    ₹${parseFloat(item.purchase_price).toFixed(2)}
                    <input type="hidden" name="price[]" class="price-text" value="${item.purchase_price}">
                </td>
                <td class="text-end">
                    <input type="text" name="total[]" class="form-control row-total-input text-end bg-light fw-bold" readonly value="0.00">
                </td>
            </tr>`;
        });
        
        if (items.length === 0) {
            html = `<tr class="empty-state-row">
                        <td colspan="7">
                            <div class="empty-state">
                                <div class="empty-state-icon"><i class="ti ti-alert-circle text-danger"></i></div>
                                <span class="empty-state-text text-danger">All items have been fully returned for this bill.</span>
                            </div>
                        </td>
                    </tr>`;
        }
        
        $("#returnItemBody").html(html);
        
        // Update stats
        $("#totalItemsCount").text(items.length);
        $("#returningCount").text('0');
        
        this.calculateGrandTotal();
    },
    calculateGrandTotal: function () {
        let grandTotal = 0;
        let returningCount = 0;
        
        $(".row-total-input").each(function () {
            grandTotal += parseFloat($(this).val()) || 0;
        });
        
        $(".return-qty-input").each(function () {
            let val = parseFloat($(this).val()) || 0;
            if (val > 0) returningCount++;
        });
        
        $("#grand_total_display").text("₹" + grandTotal.toFixed(2));
        $("#total_return_amount").val(grandTotal.toFixed(2));
        $("#returningCount").text(returningCount);
    }
}
