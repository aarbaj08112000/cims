$(document).ready(function () {
    purchaseReport.init();
});

var purchaseReportTable = '';
var report_file_name = "purchase_report_" + new Date().toISOString().slice(0, 10);
var report_pdf_title = "Purchase Report";

const purchaseReport = {
    init: function () {
        this.dataTable();
    },

    dataTable: function () {
        purchaseReportTable = $('#purchaseReportTable').DataTable({
            serverSide: true,
            processing: true,
            ajax: {
                url: base_url + "reports/get_purchase_report_datatables",
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
                    if (json.grand_total) $('#grand-total-footer').text(json.grand_total);
                    if (json.total_entries !== undefined) $('#kpi-total-entries').text(json.total_entries);
                    if (json.total_cash !== undefined) $('#kpi-total-cash').text('₹' + json.total_cash);
                    if (json.total_upi !== undefined) $('#kpi-total-upi').text('₹' + json.total_upi);
                    if (json.total_card !== undefined) $('#kpi-total-card').text('₹' + json.total_card);
                }
            },
            
            // Match exactly with Category & Stock Valuation UI layout
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
                emptyTable:   '<div class="cat-empty">No purchase records found.</div>',
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
                purchaseReportTable.search(val).draw();
            }, 350);
        });

        // --- Filter Form Submission ---
        $('#filter-form').on('submit', function (e) {
            e.preventDefault();
            purchaseReportTable.draw(); // This will trigger AJAX request and update table + KPIs
        });

        // --- Custom Export Buttons Integration ---
        // Note: Make sure the HTML buttons don't have hardcoded onclick functions for export if using this,
        // or just let them be handled by the HTML onclick if preferred.
        // We'll override the HTML onclick by unbinding or just leaving it.
        // It's cleaner to remove the onclick="" in the TPL and use these listeners.
        $('#export-csv').removeAttr('onclick').off('click').on('click', function () {
            purchaseReportTable.button('.buttons-csv').trigger();
        });

        $('#export-pdf').removeAttr('onclick').off('click').on('click', function () {
            purchaseReportTable.button('.buttons-pdf').trigger();
        });
    }
};
