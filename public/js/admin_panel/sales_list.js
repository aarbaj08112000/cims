$(document).ready(function () {
    salesListPage.init();
});

var salesListTable = '';

const salesListPage = {
    init: function () {
        this.dataTable();
    },
    dataTable: function () {
        salesListTable = $("#salesListTable").DataTable({
            dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"rt><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
            buttons: [
                {
                    extend: "csv",
                    text: '<i class="ti ti-file-type-csv"></i>',
                    titleAttr: "Download CSV",
                    filename: "sales_history"
                },
                {
                    extend: "pdf",
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    titleAttr: "Download Pdf",
                    filename: "sales_history",
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = "Sales History Report";
                    },
                },
            ],
            searching: true,
            order: [[5, "desc"]], // Sort by Added Date
            pagingType: "full_numbers",
        });

        $('#search-filter-input').on('keyup', function () {
            salesListTable.search(this.value).draw();
        });



        // Handle Detail Modal Trigger
        $(document).on("click", ".view-sale-details", function () {
            let salesId = $(this).data("id");
            $("#modal-content-area").html('<div class="p-5 text-center"><div class="spinner-border text-primary" role="status"></div><p class="mt-2">Loading Details...</p></div>');
            $("#salesDetailModal").modal("show");

            $.ajax({
                url: "sales_details_ajax",
                type: "POST",
                data: { sales_id: salesId },
                dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        $("#modal-content-area").html(response.html);
                    } else {
                        $("#modal-content-area").html('<div class="p-5 text-center text-danger">Failed to load details.</div>');
                    }
                },
                error: function () {
                    $("#modal-content-area").html('<div class="p-5 text-center text-danger">An error occurred.</div>');
                }
            });
        });
    }
}
