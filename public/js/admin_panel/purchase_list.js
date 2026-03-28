$(document).ready(function () {
    purchaseListPage.init();
});

var purchaseListTable = '';
var purchase_file_name = "purchase_history";
var purchase_pdf_title = "Purchase History Report";

const purchaseListPage = {
    init: function () {
        this.dataTable();
    },
    dataTable: function () {
        purchaseListTable = $("#purchaseListTable").DataTable({
            dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"rt><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
            buttons: [
                {
                    extend: "csv",
                    text: '<i class="ti ti-file-type-csv"></i>',
                    titleAttr: "Download CSV",
                    filename: purchase_file_name
                },
                {
                    extend: "pdf",
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    titleAttr: "Download Pdf",
                    filename: purchase_file_name,
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = purchase_pdf_title;
                        doc.content[1].table.widths = ["15%", "25%", "15%", "15%", "10%", "20%"];
                    },
                },
            ],
            searching: true,
            order: [[5, "desc"]], // Sort by Added Date by default
            pagingType: "full_numbers",
        });

        $('#search-filter-input').on('keyup', function () {
            purchaseListTable.search(this.value).draw();
        });



        // Handle Detail Modal Trigger
        $(document).on("click", ".view-details", function () {
            let purchaseId = $(this).data("id");
            $("#modal-content-area").html('<div class="p-5 text-center"><div class="spinner-border text-primary" role="status"></div><p class="mt-2">Loading Details...</p></div>');
            $("#purchaseDetailModal").modal("show");

            $.ajax({
                url: "get_purchase_details_ajax",
                type: "POST",
                data: { purchase_id: purchaseId },
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
