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
        $(selector).select2();
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
                            $("#returnItemsCard").show();
                            $("#noItemsMsg").hide();
                        } else {
                            $("#returnItemsCard").hide();
                            $("#noItemsMsg").show().text(response.msg);
                        }
                    }
                });
            } else {
                $("#returnItemsCard").hide();
                $("#noItemsMsg").hide();
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
            html += `<tr>
                <td>
                    <strong>${item.product_name}</strong><br>
                    <small class="text-muted">${item.product_code}</small>
                    <input type="hidden" name="product_id[]" value="${item.product_id}">
                </td>
                <td>${item.qty}</td>
                <td class="available-qty font-weight-bold text-success">${item.available_qty}</td>
                <td>
                    <input type="number" name="return_qty[]" class="form-control return-qty-input" min="0" max="${item.available_qty}" value="0">
                </td>
                <td>
                    ₹${item.purchase_price}
                    <input type="hidden" name="price[]" class="price-text" value="${item.purchase_price}">
                </td>
                <td>
                    <input type="number" name="total[]" class="form-control row-total-input" readonly value="0">
                </td>
            </tr>`;
        });
        $("#returnItemBody").html(html);
        this.calculateGrandTotal();
    },
    calculateGrandTotal: function () {
        let grandTotal = 0;
        $(".row-total-input").each(function () {
            grandTotal += parseFloat($(this).val()) || 0;
        });
        $("#grand_total").val(grandTotal.toFixed(2));
    }
}
