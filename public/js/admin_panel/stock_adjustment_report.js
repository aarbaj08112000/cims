$(document).ready(function () {
    if ($.fn.daterangepicker) {
        var fromDate = $('#adj-from-date').val();
        var toDate = $('#adj-to-date').val();
        $('#date_range_picker').daterangepicker({
            autoUpdateInput: false,
            open: 'left',
            dropdownParent: $('#filterOffcanvas'),
            startDate: fromDate ? moment(fromDate, 'YYYY-MM-DD') : moment().startOf('month'),
            endDate: toDate ? moment(toDate, 'YYYY-MM-DD') : moment().endOf('month'),
            maxDate: moment(),
            locale: {
                format: 'YYYY-MM-DD',
                cancelLabel: 'Clear'
            }
        });
        if (fromDate && toDate) {
            $('#date_range_picker').val(fromDate + ' ~ ' + toDate);
        }
        $('#date_range_picker').on('apply.daterangepicker', function(eve, picker) {
            $(this).val(picker.startDate.format('YYYY-MM-DD') + ' ~ ' + picker.endDate.format('YYYY-MM-DD'));
            $('#adj-from-date').val(picker.startDate.format('YYYY-MM-DD'));
            $('#adj-to-date').val(picker.endDate.format('YYYY-MM-DD'));
        });
        $('#date_range_picker').on('cancel.daterangepicker', function(eve, picker) {
            $(this).val('');
            $('#adj-from-date, #adj-to-date, #date_range_picker').val('');
        });
    }

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
    $(document).on('click', '#btn-export-excel', function () {
        if (window.adjTable) window.adjTable.button('.buttons-excel').trigger();
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
                extend: 'excel',
                className: 'd-none',
                filename: 'Stock_Adjustment_Report',
                title: 'Stock Adjustment Report',
                exportOptions: {
                    columns: [1, 2, 3, 4, 5, 6, 7],
                    format: {
                        body: function (data, row, column, node) {
                            if (column === 6) {
                                var tmp = document.createElement('div');
                                tmp.innerHTML = data;
                                var text = (tmp.textContent || tmp.innerText || '').trim();
                                var parts = text.split(/\s+/).filter(function(t) { return t.length > 1; });
                                return parts.join(' ') || text;
                            }
                            return data.replace ? data.replace(/<[^>]*>?/gm, '').trim() : data;
                        }
                    }
                },
          customize: function (xlsx) {
            var sheet  = xlsx.xl.worksheets['sheet1.xml'];
            var styles = xlsx.xl['styles.xml'];

            var themeColor   = '5B5FC7';
            var themeLighter = '9B9ED8';
            var white        = 'FFFFFF';
            var borderColor  = 'C5C5D8';

            var fillsEl = $('fills', styles);
            var fCount  = parseInt(fillsEl.attr('count'));
            fillsEl.append('<fill><patternFill patternType="solid"><fgColor rgb="' + themeLighter + '"/><bgColor indexed="64"/></patternFill></fill>');
            var titleFillId = fCount++;
            fillsEl.append('<fill><patternFill patternType="solid"><fgColor rgb="' + themeColor + '"/><bgColor indexed="64"/></patternFill></fill>');
            var headerFillId = fCount++;
            fillsEl.attr('count', fCount);

            var fontsEl = $('fonts', styles);
            var ftCount = parseInt(fontsEl.attr('count'));
            fontsEl.append('<font><b/><sz val="13"/><color rgb="' + white + '"/><name val="Calibri"/></font>');
            var titleFontId = ftCount++;
            fontsEl.append('<font><b/><sz val="11"/><color rgb="' + white + '"/><name val="Calibri"/></font>');
            var headerFontId = ftCount++;
            fontsEl.attr('count', ftCount);

            var bordersEl = $('borders', styles);
            var bCount    = parseInt(bordersEl.attr('count'));
            var medBorder = '<border><left style="medium"><color rgb="' + borderColor + '"/></left><right style="medium"><color rgb="' + borderColor + '"/></right><top style="medium"><color rgb="' + borderColor + '"/></top><bottom style="medium"><color rgb="' + borderColor + '"/></bottom><diagonal/></border>';
            bordersEl.append(medBorder);
            var dataBorderId = bCount++;
            bordersEl.attr('count', bCount);

            var cellXfsEl = $('cellXfs', styles);
            var xfCount   = parseInt(cellXfsEl.attr('count'));
            cellXfsEl.append('<xf numFmtId="0" fontId="' + titleFontId  + '" fillId="' + titleFillId  + '" borderId="' + dataBorderId + '" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>');
            var titleStyleId = xfCount++;
            cellXfsEl.append('<xf numFmtId="0" fontId="' + headerFontId + '" fillId="' + headerFillId + '" borderId="' + dataBorderId + '" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>');
            var headerStyleId = xfCount++;
            cellXfsEl.append('<xf numFmtId="0" fontId="0" fillId="0" borderId="' + dataBorderId + '" xfId="0" applyBorder="1" applyAlignment="1"><alignment vertical="center"/></xf>');
            var dataStyleId = xfCount++;
            cellXfsEl.attr('count', xfCount);

            var rows = $('row', sheet);
            rows.eq(0).find('c').attr('s', titleStyleId);
            rows.eq(1).find('c').attr('s', headerStyleId);
            rows.each(function (i) { if (i >= 2) { $(this).find('c').attr('s', dataStyleId); } });

            $('sheetData', sheet).after('<mergeCells count="1"><mergeCell ref="A1:G1"/></mergeCells>');
            rows.eq(0).attr({ ht: '28', customHeight: '1' });
            rows.eq(1).attr({ ht: '20', customHeight: '1' });

            $('cols', sheet).remove();
            $('sheetData', sheet).before('<cols><col min="1" max="1" width="15" customWidth="1"/><col min="2" max="2" width="25" customWidth="1"/><col min="3" max="3" width="10" customWidth="1"/><col min="4" max="4" width="10" customWidth="1"/><col min="5" max="5" width="10" customWidth="1"/><col min="6" max="6" width="20" customWidth="1"/><col min="7" max="7" width="15" customWidth="1"/></cols>');
          }
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


$(document).on('click', '#btn-reset-filter', function() {
    $('#adj-from-date, #adj-to-date, #adj-search').val('');
    $('#btn-apply-filter').trigger('click');
});

$(document).on('click', '#btn-apply-filter', function() {
    var el = document.getElementById('filterOffcanvas');
    if (el && window.bootstrap) {
        var instance = bootstrap.Offcanvas.getInstance(el) || new bootstrap.Offcanvas(el);
        instance.hide();
    }
});