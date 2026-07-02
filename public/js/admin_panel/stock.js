$(document).ready(function () {
    if ($("#stockListTable").length) {
        stockPage.init();
    }
});

const stockPage = {
    init: function () {
        this.initSelect2();
        this.dataTable();
        this.bindEvents();
    },
    initSelect2: function (selector = ".select2") {
        $(selector).select2();
    },
    bindEvents: function () {
        let that = this;

        // View Ledger
        $(document).on("click", ".view-stock-ledger", function () {
            let product_id = $(this).data("id");
            $.ajax({
                type: "POST",
                url: base_url + "stock_ledger_ajax",
                data: { product_id: product_id },
                dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        $("#stock-ledger-content").html(response.html);
                        $("#stockLedgerModal").modal("show");
                    }
                }
            });
        });

        // Adjust Stock from row
        $(document).on("click", ".adjust-stock-btn", function () {
            let product_id = $(this).data("id");
            $("#adjustment_product_id").val(product_id).trigger("change");
            $("#manualAdjustmentModal").modal("show");
        });

        // Show current/old stock when product is selected
        $("#adjustment_product_id").on("change", function () {
            let selectedOption = $(this).find("option:selected");
            if (selectedOption.val()) {
                let stock = selectedOption.data("stock");
                $("#current_stock_val").text(stock);
                $("#current_stock_display").slideDown(200);
            } else {
                $("#current_stock_display").slideUp(200);
            }
        });

        // Manual Adjustment Form Submit
        $("#stockAdjustmentForm").submit(function (e) {
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
                        $("#manualAdjustmentModal").modal("hide");
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        toaster("error", response.msg);
                    }
                }
            });
        });
    },
    dataTable: function () {
        var stockListTable = $("#stockListTable").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: "stock_report",
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6]
                    }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: "stock_report",
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = "Current Stock Inventory Report";
                    },
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6]
                    }
                },
            ],
            searching: true,
            order: [[3, "asc"]], // Sort by Current Stock (Lowest first)
            pagingType: "full_numbers",
            language: {
                processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
                emptyTable:   '<div class="cat-empty">No stock records found.</div>',
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
            },
        });

        $('#search-filter-input').on('keyup input', function () {
            stockListTable.search(this.value).draw();
        });

        $('#export-csv').on('click', function () {
            stockListTable.button('.buttons-csv').trigger();
        });

        $('#export-pdf').on('click', function () {
            stockListTable.button('.buttons-pdf').trigger();
        });
    },
}
