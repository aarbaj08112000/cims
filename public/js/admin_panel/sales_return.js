$(document).ready(function () {
    if ($("#returnListTable").length) {
        salesReturnPage.initList();
    }
    if ($("#salesReturnForm").length) {
        salesReturnPage.initCreate();
    }
});

var returnListTable = '';
var return_file_name = "sales_return_history";
var return_pdf_title = "Sales Return History Report";

const salesReturnPage = {
    initList: function () {
        this.dataTable();
        this.bindListEvents();
    },
    initCreate: function () {
        this.initSelect2();
        this.bindCreateEvents();
    },
    initSelect2: function (selector = ".select2") {
        $(selector).select2();
    },
    bindListEvents: function () {
        let that = this;
        $(document).on("click", ".view-return-details", function () {
            let return_id = $(this).data("id");
            $.ajax({
                type: "POST",
                url: base_url + "return_details_ajax",
                data: { return_id: return_id },
                dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        $("#return-modal-content").html(response.html);
                        $("#returnDetailModal").modal("show");
                    }
                }
            });
        });
    },
    bindCreateEvents: function () {
        let that = this;

        // Change Bill - Load Items
        $("#sales_id").on("change", function () {
            let sales_id = $(this).val();
            if (sales_id) {
                $.ajax({
                    type: "POST",
                    url: base_url + "get_sale_items_for_return",
                    data: { sales_id: sales_id },
                    dataType: "json",
                    success: function (response) {
                        if (response.success == 1) {
                            that.renderReturnItems(response.items);
                        } else {
                            $("#returnItemsTable tbody").html('<tr><td colspan="7" class="text-center text-danger">' + response.msg + '</td></tr>');
                            that.calculateGrandTotal();
                        }
                    }
                });
            } else {
                $("#returnItemsTable tbody").html('<tr><td colspan="7" class="text-center text-muted">Select an original bill to load items.</td></tr>');
                that.calculateGrandTotal();
            }
        });

        // Quantity Change
        $(document).on("input", ".return-qty", function () {
            let row = $(this).closest("tr");
            let qty = parseFloat($(this).val()) || 0;
            let available = parseFloat(row.find(".available-qty").text()) || 0;

            if (qty > available) {
                toaster("warning", "Return quantity cannot exceed available quantity!");
                $(this).val(available);
                qty = available;
            }

            let price = parseFloat(row.find(".price-text").val()) || 0;
            let total = qty * price;
            row.find(".row-total").val(total.toFixed(2));
            that.calculateGrandTotal();
        });

        // Form Submit
        $("#salesReturnForm").submit(function (e) {
            e.preventDefault();
            let form = $(this);
            let invalid = false;

            $(".required-input").each(function () {
                if ($(this).val() == "") {
                    $(this).addClass("is-invalid");
                    invalid = true;
                } else {
                    $(this).removeClass("is-invalid");
                }
            });

            if (invalid) {
                toaster("error", "Please fill all required fields.");
                return;
            }

            let totalItems = 0;
            $(".return-qty").each(function () {
                totalItems += parseFloat($(this).val()) || 0;
            });

            if (totalItems <= 0) {
                toaster("error", "Please specify return quantity for at least one item.");
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
                            window.location.href = base_url + "sales_return_list";
                        }, 1500);
                    } else {
                        toaster("error", response.msg);
                    }
                }
            });
        });
    },
    renderReturnItems: function (items) {
        let html = "";
        items.forEach(function (item) {
            html += `<tr>
                <td>
                    <strong>${item.product_name}</strong><br>
                    <small class="text-muted">${item.product_code}</small>
                    <input type="hidden" name="product_id[]" value="${item.product_id}">
                </td>
                <td>${item.qty}</td>
                <td>${item.qty - item.available_qty}</td>
                <td class="available-qty fw-bold">${item.available_qty}</td>
                <td>
                    <input type="number" name="return_qty[]" class="form-control return-qty" min="0" max="${item.available_qty}" value="0">
                </td>
                <td>
                    ₹${parseFloat(item.sale_price).toFixed(2)}
                    <input type="hidden" name="price[]" class="price-text" value="${item.sale_price}">
                </td>
                <td>
                    <input type="text" name="total[]" class="form-control row-total" value="0.00" readonly>
                </td>
            </tr>`;
        });
        $("#returnItemsTable tbody").html(html);
        this.calculateGrandTotal();
    },
    calculateGrandTotal: function () {
        let grandTotal = 0;
        $(".row-total").each(function () {
            grandTotal += parseFloat($(this).val()) || 0;
        });
        $("#grand_total_display").text("₹" + grandTotal.toFixed(2));
        $("#total_return_amount").val(grandTotal.toFixed(2));
    },
    dataTable: function () {
        returnListTable = $("#returnListTable").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: return_file_name,
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4]
                    }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: return_file_name,
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = return_pdf_title;
                        doc.content[1].table.widths = ["15%", "20%", "30%", "20%", "15%"];
                    },
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4]
                    }
                },
            ],
            searching: true,
            order: [[3, "desc"]], // Sort by Date
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
}
