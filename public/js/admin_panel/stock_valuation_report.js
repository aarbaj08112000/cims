$(document).ready(function () {
    stockValuationReport.init();
});

var stockValuationTable = '';
var report_file_name = "stock_valuation_report_" + new Date().toISOString().slice(0, 10);
var report_pdf_title = "Stock Valuation Report";

const stockValuationReport = {
    init: function () {
        this.dataTable();
    },

    dataTable: function () {
        stockValuationTable = $('#stockValuationTable').DataTable({
            order: [[0, 'asc']],
            pagingType: "full_numbers",
            pageLength: 25,
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            autoWidth: false,
            
            // Match exactly with Category & Brand pages UI layout
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',

            buttons: [
                {
                    extend: 'csv',
                    className: 'd-none', // Hidden, triggered by custom external button
                    filename: report_file_name,
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'pdf',
                    className: 'd-none', // Hidden, triggered by custom external button
                    filename: report_file_name,
                    title: report_pdf_title,
                    exportOptions: {
                        columns: ':visible'
                    },
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.styles.tableHeader.fillColor = '#f8f7fa';
                        doc.styles.tableHeader.color = '#333333';
                    }
                }
            ],

            language: {
                emptyTable:   '<div class="cat-empty">No stock valuation records found.</div>',
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
                stockValuationTable.search(val).draw();
            }, 350);
        });

        // --- Custom Export Buttons Integration ---
        $('#export-csv').on('click', function () {
            stockValuationTable.button('.buttons-csv').trigger();
        });

        $('#export-pdf').on('click', function () {
            stockValuationTable.button('.buttons-pdf').trigger();
        });
    }
};
