$(document).ready(function () {
    loadAdjustmentReport();

    // Apply filter
    $('#btn-apply-filter').on('click', function () {
        loadAdjustmentReport();
    });

    // Enter key on search
    $('#adj-search').on('keyup', function () {
        if (window.adjTable) {
            window.adjTable.search($(this).val()).draw();
        }
    });

    // Export buttons — triggered after table is loaded
    $(document).on('click', '#btn-export-csv', function () {
        if (window.adjTable) window.adjTable.button('.buttons-csv').trigger();
    });
    $(document).on('click', '#btn-export-pdf', function () {
        if (window.adjTable) window.adjTable.button('.buttons-pdf').trigger();
    });
});

function loadAdjustmentReport() {
    var fromDate   = $('#adj-from-date').val();
    var toDate     = $('#adj-to-date').val();
    var productId  = $('#adj-product-id').val() || '';

    $('#adj-table-container').html('<div class="text-center py-5 text-muted"><i class="ti ti-loader-2 ti-spin fs-3"></i><br>Loading…</div>');

    $.ajax({
        type: 'POST',
        url: base_url + 'get_stock_adjustment_ajax',
        data: { from_date: fromDate, to_date: toDate, product_id: productId },
        dataType: 'json',
        success: function (response) {
            if (response.success == 1) {
                $('#adj-table-container').html(response.html);
                initAdjTable();
                buildSummaryCards();
            }
        },
        error: function () {
            $('#adj-table-container').html('<div class="text-center py-4 text-danger">Failed to load data. Please try again.</div>');
        }
    });
}

function initAdjTable() {
    if ($.fn.DataTable.isDataTable('#adjReportTable')) {
        $('#adjReportTable').DataTable().destroy();
    }
    window.adjTable = $('#adjReportTable').DataTable({
        dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
        buttons: [
            {
                extend: 'csv',
                className: 'd-none',
                filename: 'Stock_Adjustment_Report',
                exportOptions: { columns: [1, 2, 3, 4, 5, 6, 7] }
            },
            {
                extend: 'pdf',
                className: 'd-none',
                filename: 'Stock_Adjustment_Report',
                title: 'Stock Adjustment Report',
                exportOptions: {
                    columns: [1, 2, 3, 4, 5, 6, 7],
                    format: {
                        body: function (data, row, column, node) {
                            // column 6 = "Adjusted By" (7th exported col, 0-based index 6)
                            if (column === 6) {
                                var tmp = document.createElement('div');
                                tmp.innerHTML = data;
                                // Get all text nodes, filter out single-char initials
                                var text = (tmp.textContent || tmp.innerText || '').trim();
                                // The initial circle contains the first letter, followed by the full name
                                // Split by whitespace and filter out single-char tokens
                                var parts = text.split(/\s+/).filter(function(t) { return t.length > 1; });
                                return parts.join(' ') || text;
                            }
                            return data.replace ? data.replace(/<[^>]*>?/gm, '').trim() : data;
                        }
                    }
                },
                customize: function (doc) {
                    doc.pageMargins = [40, 40, 40, 40];

                    if (doc.content[0]) {
                        doc.content[0].text = doc.content[0].text ? doc.content[0].text.toUpperCase() : doc.content[0].text;
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

                        var colCount = tableBody[0].length;
                        if (colCount === 7) {
                            // Explicit widths: 0: Date, 1: Product, 2: Old Stock, 3: Change, 4: New Stock, 5: Remarks, 6: Adjusted By
                            doc.content[3].table.widths = ["15%", "25%", "10%", "10%", "10%", "18%", "12%"];
                        } else {
                            var widths = [];
                            for (var j = 0; j < colCount; j++) { widths.push((100 / colCount) + '%'); }
                            doc.content[3].table.widths = widths;
                        }

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
            }
        ],
        order: [[0, 'asc']],
        pagingType: 'full_numbers',
        language: {
            processing:  '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
            emptyTable:  '<div class="cat-empty">No adjustment records found.</div>',
            zeroRecords: '<div class="cat-empty">No records match your search.</div>',
            info:        'Showing _START_ to _END_ of _TOTAL_ entries',
            infoEmpty:   'Showing 0 to 0 of 0 entries',
            infoFiltered:'(filtered from _MAX_ total)',
            lengthMenu:  'Show _MENU_ entries',
            paginate: {
                first:    '<i class="ti ti-chevrons-left"></i>',
                last:     '<i class="ti ti-chevrons-right"></i>',
                next:     '<i class="ti ti-chevron-right"></i>',
                previous: '<i class="ti ti-chevron-left"></i>'
            }
        }
    });

    // Wire the custom search box
    $('#adj-search').on('keyup input', function () {
        window.adjTable.search(this.value).draw();
    });
}

function buildSummaryCards() {
    var table = window.adjTable;
    if (!table) return;

    var totalEntries = table.data().count();
    var totalAdded   = 0;
    var totalRemoved = 0;

    table.data().each(function (row) {
        // row[4] is "Change" column HTML — extract number
        var cell = $(row[4]);
        var num  = parseInt(cell.text().replace(/[^0-9\-]/g, ''));
        if (!isNaN(num)) {
            if (num > 0) totalAdded   += num;
            else          totalRemoved += Math.abs(num);
        }
    });

    var html = '' +
        '<div class="col-xl-4 col-md-6">' +
        '  <div class="adj-summary-card">' +
        '    <div class="adj-summary-icon" style="background:#ededfa;color:#5b5fc7;"><i class="ti ti-list-check fs-4"></i></div>' +
        '    <div><div style="font-size:.72rem;font-weight:600;color:#8490a7;text-transform:uppercase;letter-spacing:.5px;">Total Entries</div>' +
        '    <div style="font-size:1.5rem;font-weight:800;color:#1e293b;">' + totalEntries + '</div></div>' +
        '  </div>' +
        '</div>' +
        '<div class="col-xl-4 col-md-6">' +
        '  <div class="adj-summary-card">' +
        '    <div class="adj-summary-icon" style="background:#e8f8f0;color:#27ae60;"><i class="ti ti-arrow-up fs-4"></i></div>' +
        '    <div><div style="font-size:.72rem;font-weight:600;color:#8490a7;text-transform:uppercase;letter-spacing:.5px;">Total Added Qty</div>' +
        '    <div style="font-size:1.5rem;font-weight:800;color:#27ae60;">+' + totalAdded + '</div></div>' +
        '  </div>' +
        '</div>' +
        '<div class="col-xl-4 col-md-6">' +
        '  <div class="adj-summary-card">' +
        '    <div class="adj-summary-icon" style="background:#fdecea;color:#e74c3c;"><i class="ti ti-arrow-down fs-4"></i></div>' +
        '    <div><div style="font-size:.72rem;font-weight:600;color:#8490a7;text-transform:uppercase;letter-spacing:.5px;">Total Reduced Qty</div>' +
        '    <div style="font-size:1.5rem;font-weight:800;color:#e74c3c;">-' + totalRemoved + '</div></div>' +
        '  </div>' +
        '</div>';

    $('#adj-summary-cards').html(html);
}
