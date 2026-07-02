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
                exportOptions: { columns: [0, 1, 2, 3, 4, 5, 6, 7] }
            },
            {
                extend: 'pdf',
                className: 'd-none',
                filename: 'Stock_Adjustment_Report',
                title: 'Stock Adjustment Report',
                customize: function (doc) {
                    doc.pageMargins = [15, 15, 15, 15];
                    doc.styles.tableHeader.fillColor = '#5b5fc7';
                    doc.styles.tableHeader.color = '#ffffff';
                },
                exportOptions: { columns: [0, 1, 2, 3, 4, 5, 6, 7] }
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
