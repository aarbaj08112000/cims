$(document).ready(function () {
    salesListPage.init();
});

var salesListTable = '';
var sales_file_name = "sales_history";
var sales_pdf_title = "Sales History Report";

const salesListPage = {
    init: function () {
        this.dataTable();
    },
    dataTable: function () {
        salesListTable = $("#salesListTable").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: sales_file_name,
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5]
                    }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: sales_file_name,
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = sales_pdf_title;
                        doc.content[1].table.widths = ["15%", "25%", "15%", "15%", "10%", "20%"];
                    },
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5]
                    }
                },
            ],
            searching: true,
            order: [[5, "desc"]], // Sort by Added Date
            pagingType: "full_numbers",
            language: {
                processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
                emptyTable:   '<div class="cat-empty">No sales found.</div>',
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
            salesListTable.search(this.value).draw();
        });

        $('#export-csv').on('click', function () {
            salesListTable.button('.buttons-csv').trigger();
        });

        $('#export-pdf').on('click', function () {
            salesListTable.button('.buttons-pdf').trigger();
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
