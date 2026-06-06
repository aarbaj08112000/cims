$(document).ready(function () {
    if ($('#purchaseReportTable').length) {
        initReportTable('#purchaseReportTable', 'Purchase_Report');
    }
    if ($('#salesReportTable').length) {
        initReportTable('#salesReportTable', 'Sales_Report');
    }
});

function initReportTable(selector, filename) {
    var table = $(selector).DataTable({
        order: [[1, 'desc']],
        pageLength: 25
    });

    $('#search-filter-input').on('keyup', function () {
        table.search(this.value).draw();
    });
}


