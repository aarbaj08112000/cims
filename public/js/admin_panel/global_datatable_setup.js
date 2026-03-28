/**
 * Global DataTables Default Configuration
 * Applied before any individual DataTable is initialized.
 * - Sticky header, fixed footer, scrollable body
 * - Standard footer: info LEFT | pagination + length RIGHT (inline)
 * - Full-numbers pagination with text navigation (First, Previous, Next, Last)
 * - Length menu: 10 / 25 / 50 / 100
 */
$(document).ready(function () {
    if (typeof $.fn.DataTable !== 'undefined') {
        $.extend($.fn.dataTable.defaults, {
            pagingType: "full_numbers",
            pageLength: 10,
            scrollY: false,
            bScrollCollapse: false,
            lengthMenu: [
                [10, 25, 50, 100],
                ['10', '25', '50', '100']
            ],
            dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"rt><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
            language: {
                search: "",
                searchPlaceholder: "Search...",
                lengthMenu: "_MENU_",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                infoEmpty: "Showing 0 to 0 of 0 entries",
                infoFiltered: "<span class='text-muted ms-1'>(filtered from _MAX_ total)</span>",
                paginate: {
                    first: 'First',
                    previous: 'Previous',
                    next: 'Next',
                    last: 'Last'
                },
                emptyTable: '<div class="dt-empty-state"><i class="ti ti-database-off"></i><span>No records found</span></div>',
                zeroRecords: '<div class="dt-empty-state"><i class="ti ti-search-off"></i><span>No matching records found</span></div>'
            }
        });
    }

    // After any DataTable initializes, clean up length label and apply Select2
    $(document).on('init.dt', function (e, settings) {
        var api = new $.fn.dataTable.Api(settings);
        var tableId = '#' + api.table().node().id;
        var $wrapper = $(tableId).closest('.dataTables_wrapper');

        // Helper: remove "Show" / "entries" text nodes from length label
        function cleanLengthLabel($w) {
            $w.find('.dataTables_length label').contents().filter(function () {
                return this.nodeType === 3; // text nodes only
            }).remove();
        }

        // Clean immediately
        cleanLengthLabel($wrapper);

        // Apply Select2 to length dropdown, then clean again
        setTimeout(function () {
            $wrapper.find('.dataTables_length select').select2({
                minimumResultsForSearch: Infinity,
                width: 'auto',
                dropdownParent: $wrapper.find('.dt-fixed-footer') // Ensure it opens within the footer
            });
            // Clean again after Select2 wraps the element
            cleanLengthLabel($wrapper);
        }, 200);
    });
});

/**
 * Global Export Helpers
 */
function exportTableToCSV(tableId, filename) {
    var csv = [];
    var rows = document.querySelectorAll("#" + tableId + " tr");

    for (var i = 0; i < rows.length; i++) {
        var row = [], cols = rows[i].querySelectorAll("td, th");
        for (var j = 0; j < cols.length; j++) {
            // Remove commas and clean text
            var text = cols[j].innerText.replace(/,/g, '').trim();
            row.push(text);
        }
        csv.push(row.join(","));
    }

    var csvFile = new Blob([csv.join("\n")], { type: "text/csv" });
    var downloadLink = document.createElement("a");
    downloadLink.download = filename;
    downloadLink.href = window.URL.createObjectURL(csvFile);
    downloadLink.style.display = "none";
    document.body.appendChild(downloadLink);
    downloadLink.click();
    document.body.removeChild(downloadLink);
}

function exportTableToPDF() {
    window.print();
}
