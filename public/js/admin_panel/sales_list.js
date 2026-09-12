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
                        columns: [0, 1, 2, 3, 4, 5, 6]
                    }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: sales_file_name,
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6]
                    },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];
                        
                        if (doc.content[0]) {
                            doc.content[0].text = sales_pdf_title.toUpperCase();
                            doc.content[0].color = '#5b5fc7';
                            doc.content[0].fontSize = 20;
                            doc.content[0].bold = true;
                            doc.content[0].alignment = 'center';
                            doc.content[0].margin = [0, 0, 0, 5];
                        }

                        var now = new Date();
                        var dateStr = now.getDate() + ' ' + now.toLocaleString('default', { month: 'short' }) + ' ' + now.getFullYear();
                        
                        doc.content.splice(1, 0, {
                            text: 'Generated on: ' + dateStr,
                            color: '#888888',
                            fontSize: 10,
                            alignment: 'center',
                            margin: [0, 0, 0, 15]
                        });
                        
                        doc.content.splice(2, 0, {
                            canvas: [
                                {
                                    type: 'line',
                                    x1: 0, y1: 0,
                                    x2: 515, y2: 0,
                                    lineWidth: 2,
                                    lineColor: '#5b5fc7'
                                }
                            ],
                            margin: [0, 0, 0, 20]
                        });

                        if (doc.content[3] && doc.content[3].table && doc.content[3].table.body) {
                            var tableBody = doc.content[3].table.body;
                            
                            doc.content[3].table.widths = ["14%", "22%", "13%", "12%", "9%", "15%", "15%"];
                            
                            var tableHeader = tableBody[0];
                            for (var i = 0; i < tableHeader.length; i++) {
                                tableHeader[i].fillColor = '#eef0f2';
                                tableHeader[i].color = '#333333';
                                tableHeader[i].bold = true;
                                tableHeader[i].margin = [5, 5, 5, 5];
                            }

                            for (var r = 1; r < tableBody.length; r++) {
                                var row = tableBody[r];
                                for (var c = 0; c < row.length; c++) {
                                    if (row[c]) {
                                        row[c].fillColor = '#ffffff';
                                        if (row[c].text) {
                                            row[c].margin = [5, 5, 5, 5];
                                        }
                                    }
                                }
                            }
                            
                            doc.content[3].layout = {
                                hLineWidth: function (i, node) { return 1; },
                                vLineWidth: function (i, node) { return 1; },
                                hLineColor: function (i, node) { return '#dee2e6'; },
                                vLineColor: function (i, node) { return '#dee2e6'; },
                                fillColor: function (rowIndex, node, columnIndex) {
                                    return '#ffffff';
                                }
                            };
                        }
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
