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
            dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"rt><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
            buttons: [
                {
                    extend: "csv",
                    text: '<i class="ti ti-file-type-csv"></i>',
                    titleAttr: "Download CSV",
                    filename: "stock_report"
                },
                {
                    extend: "pdf",
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    titleAttr: "Download Pdf",
                    filename: "stock_report",
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = "Current Stock Inventory Report";
                    },
                },
            ],
            searching: true,
            order: [[3, "asc"]], // Sort by Current Stock (Lowest first)
            pagingType: "full_numbers",
        });

        $('#search-filter-input').on('keyup', function () {
            stockListTable.search(this.value).draw();
        });


    },
}
