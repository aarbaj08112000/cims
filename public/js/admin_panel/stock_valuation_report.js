$(document).ready(function () {
    stockValuationReport.init();
});

const stockValuationReport = {
    init: function () {
        this.dataTable();
    },
    dataTable: function () {
        var table = $('#stockValuationTable').DataTable({
            order: [[0, 'asc']],
            pageLength: 25,
            // Buttons are handled via dt-top-btn for visual consistency,
            // but we can also use DataTables built-in buttons if preferred.
            // Since the user asked specifically to move "btn from table card and add that btn on right tops",
            // I will use standardized manual buttons in the TPL.
        });

        $('#search-filter-input').on('keyup', function () {
            table.search(this.value).draw();
        });
    }
};


