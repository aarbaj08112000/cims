$(document).ready(function () {
    salesReport.init();
});

var salesReportTable = '';
var report_file_name = "sales_report_" + new Date().toISOString().slice(0, 10);
var report_pdf_title = "Sales Report";

const salesReport = {
    init: function () {
        this.dataTable();
    },

    dataTable: function () {
        salesReportTable = $('#salesReportTable').DataTable({
            serverSide: true,
            processing: true,
            ajax: {
                url: base_url + "reports/get_sales_report_datatables",
                type: "POST",
                data: function(d) {
                    d.from_date = $('input[name="from_date"]').val();
                    d.to_date = $('input[name="to_date"]').val();
                }
            },
            order: [[0, 'desc']], // Order by Date descending
            pagingType: "full_numbers",
            pageLength: 25,
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            autoWidth: false,
            
            columnDefs: [
                { targets: 4, className: 'text-end fw-bold' }
            ],

            drawCallback: function(settings) {
                var api = this.api();
                var json = api.ajax.json();
                if (json) {
                    if (json.total_entries !== undefined) $('#kpi-total-entries').text(json.total_entries);
                    if (json.total_cash !== undefined) $('#kpi-total-cash').text('₹' + json.total_cash);
                    if (json.total_upi !== undefined) $('#kpi-total-upi').text('₹' + json.total_upi);
                    if (json.total_card !== undefined) $('#kpi-total-card').text('₹' + json.total_card);
                    if (json.grand_total !== undefined) $('#kpi-total-amount').text('₹' + json.grand_total);
                }
            },

            // Match exactly with Category & Purchase Report UI layout
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',

            buttons: [
                {
                    extend: 'excel',
                    className: 'd-none',
                    filename: report_file_name,
                    title: report_pdf_title,
                    exportOptions: {
                        columns: ':visible'
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

            $('sheetData', sheet).after('<mergeCells count="1"><mergeCell ref="A1:E1"/></mergeCells>');
            rows.eq(0).attr({ ht: '28', customHeight: '1' });
            rows.eq(1).attr({ ht: '20', customHeight: '1' });

            $('cols', sheet).remove();
            $('sheetData', sheet).before('<cols><col min="1" max="1" width="15" customWidth="1"/><col min="2" max="2" width="25" customWidth="1"/><col min="3" max="3" width="20" customWidth="1"/><col min="4" max="4" width="15" customWidth="1"/><col min="5" max="5" width="20" customWidth="1"/></cols>');
          }
                },
                {
                    extend: 'pdf',
                    className: 'd-none',
                    filename: report_file_name,
                    title: report_pdf_title,
                    exportOptions: {
                        columns: ':visible'
                    },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];

                        if (doc.content[0]) {
                            doc.content[0].text = report_pdf_title.toUpperCase();
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
                            var widths = [];
                            for (var j = 0; j < colCount; j++) { widths.push((100 / colCount) + '%'); }
                            doc.content[3].table.widths = widths;

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

            language: {
                emptyTable: '<div class="text-center py-5"><i class="ti ti-report-off d-block" style="font-size:2.5rem;color:#cbd5e1;"></i><p class="fw-semibold text-muted mt-2 mb-1">No Sales Records Found</p><small class="text-muted">Try adjusting your date filters.</small></div>',
                zeroRecords: '<div class="text-center py-5"><i class="ti ti-search-off d-block" style="font-size:2.5rem;color:#cbd5e1;"></i><p class="fw-semibold text-muted mt-2 mb-1">No Records Match</p><small class="text-muted">Try a different search term.</small></div>',
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

            initComplete: function () {
                this.api().columns.adjust();
            }
        });

        // --- Custom Debounced Search ---
        var searchTimer;
        $('#search-filter-input').on('keyup input', function () {
            var val = this.value;
            clearTimeout(searchTimer);
            searchTimer = setTimeout(function () {
                salesReportTable.search(val).draw();
            }, 350);
        });

        // --- Filter Form Submission ---
        $('#filter-form').on('submit', function (e) {
            e.preventDefault();
            salesReportTable.draw(); // This will trigger AJAX request and update table + KPIs
        });

        // --- Custom Export Buttons Integration ---
        $('#export-excel').removeAttr('onclick').off('click').on('click', function () {
            salesReportTable.button('.buttons-excel').trigger();
        });

        $('#export-pdf').removeAttr('onclick').off('click').on('click', function () {
            salesReportTable.button('.buttons-pdf').trigger();
        });
    }
};

