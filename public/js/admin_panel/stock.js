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
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4, 5, 6]
                    },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];
                        
                        if (doc.content[0]) {
                            doc.content[0].text = "CURRENT STOCK INVENTORY REPORT";
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
                            
                            // 7 cols: Product, Category, Brand, Current Stock, Alert Qty, Unit, Status
                            doc.content[3].table.widths = ["22%", "15%", "13%", "12%", "10%", "10%", "18%"];
                            
                            var tableHeader = tableBody[0];
                            for (var i = 0; i < tableHeader.length; i++) {
                                tableHeader[i].fillColor = '#eef0f2';
                                tableHeader[i].color = '#333333';
                                tableHeader[i].bold = true;
                                tableHeader[i].margin = [5, 5, 5, 5];
                                if (i === tableHeader.length - 1) {
                                    tableHeader[i].alignment = 'center';
                                }
                            }

                            for (var r = 1; r < tableBody.length; r++) {
                                var row = tableBody[r];
                                var statusColIdx = row.length - 1; // Status is last col
                                
                                if (row[statusColIdx] && row[statusColIdx].text) {
                                    var statusText = row[statusColIdx].text.trim();
                                    var textColor = '#0f5132'; 
                                    if (statusText.toLowerCase() === 'inactive') {
                                        textColor = '#842029'; 
                                    }
                                    row[statusColIdx] = {
                                        text: '   ' + statusText + '   ',
                                        color: textColor,
                                        bold: true,
                                        alignment: 'center',
                                        margin: [0, 5, 0, 5],
                                        fillColor: '#ffffff'
                                    };
                                }
                                
                                for (var c = 0; c < row.length; c++) {
                                    if (row[c]) {
                                        row[c].fillColor = '#ffffff';
                                    }
                                    if (c !== statusColIdx && row[c] && row[c].text) {
                                        row[c].margin = [5, 5, 5, 5];
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
