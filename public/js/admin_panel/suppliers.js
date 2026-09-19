$(document).ready(function () {
    supplierPage.init();

    $(document).on("click", ".delete_supplier", function () {
        var supplierId = $(this).data("id");
        Swal.fire({
            title: "Are you sure?",
            text: "This supplier will be moved to the trash!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, delete it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "delete_supplier",
                    type: "POST",
                    data: { supplier_id: supplierId },
                    dataType: "json",
                    success: function (response) {
                        if (response.success == 1) {
                            toaster("success", response.msg);
                            setTimeout(function () { location.reload(); }, 1000);
                        } else { toaster("error", response.msg); }
                    },
                    error: function () { toaster("error", "Something went wrong."); }
                });
            }
        });
    });
});

var supplierTable = '';
var supplier_file_name = "supplier_list";
var supplier_pdf_title = "Supplier List";

const supplierPage = {
    init: function () {
        this.dataTable();
        this.formInitiate();
        $(".select2").select2();
    },

    dataTable: function () {
        supplierTable = $("#suppliersTable").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            searching:   true,
            pagingType:  "full_numbers",
            pageLength:  15,
            lengthMenu:  [[10, 15, 25, 50, 100], [10, 15, 25, 50, 100]],

            buttons: [
                {
                    extend:    "excel",
                    className: "d-none",
                    filename:  supplier_file_name,
                    title:     "Supplier List",
                    exportOptions: { columns: [0, 1, 2, 3, 4] },
          customize: function (xlsx) {
            var sheet  = xlsx.xl.worksheets['sheet1.xml'];
            var styles = xlsx.xl['styles.xml'];

            var themeColor   = '5B5FC7';
            var themeLighter = '9B9ED8';
            var white        = 'FFFFFF';
            var borderColor  = 'C5C5D8';

            // FILLS
            var fillsEl = $('fills', styles);
            var fCount  = parseInt(fillsEl.attr('count'));
            fillsEl.append('<fill><patternFill patternType="solid"><fgColor rgb="' + themeLighter + '"/><bgColor indexed="64"/></patternFill></fill>');
            var titleFillId = fCount++;
            fillsEl.append('<fill><patternFill patternType="solid"><fgColor rgb="' + themeColor + '"/><bgColor indexed="64"/></patternFill></fill>');
            var headerFillId = fCount++;
            fillsEl.attr('count', fCount);

            // FONTS
            var fontsEl = $('fonts', styles);
            var ftCount = parseInt(fontsEl.attr('count'));
            fontsEl.append('<font><b/><sz val="13"/><color rgb="' + white + '"/><name val="Calibri"/></font>');
            var titleFontId = ftCount++;
            fontsEl.append('<font><b/><sz val="11"/><color rgb="' + white + '"/><name val="Calibri"/></font>');
            var headerFontId = ftCount++;
            fontsEl.attr('count', ftCount);

            // BORDERS
            var bordersEl = $('borders', styles);
            var bCount    = parseInt(bordersEl.attr('count'));
            var medBorder =
              '<border>' +
                '<left   style="medium"><color rgb="' + borderColor + '"/></left>'   +
                '<right  style="medium"><color rgb="' + borderColor + '"/></right>'  +
                '<top    style="medium"><color rgb="' + borderColor + '"/></top>'    +
                '<bottom style="medium"><color rgb="' + borderColor + '"/></bottom>' +
                '<diagonal/>' +
              '</border>';
            bordersEl.append(medBorder);
            var dataBorderId = bCount++;
            bordersEl.attr('count', bCount);

            // CELL XFS
            var cellXfsEl = $('cellXfs', styles);
            var xfCount   = parseInt(cellXfsEl.attr('count'));
            cellXfsEl.append('<xf numFmtId="0" fontId="' + titleFontId  + '" fillId="' + titleFillId  + '" borderId="' + dataBorderId + '" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>');
            var titleStyleId = xfCount++;
            cellXfsEl.append('<xf numFmtId="0" fontId="' + headerFontId + '" fillId="' + headerFillId + '" borderId="' + dataBorderId + '" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>');
            var headerStyleId = xfCount++;
            cellXfsEl.append('<xf numFmtId="0" fontId="0" fillId="0" borderId="' + dataBorderId + '" xfId="0" applyBorder="1" applyAlignment="1"><alignment vertical="center"/></xf>');
            var dataStyleId = xfCount++;
            cellXfsEl.attr('count', xfCount);

            // APPLY STYLES
            var rows = $('row', sheet);
            rows.eq(0).find('c').attr('s', titleStyleId);
            rows.eq(1).find('c').attr('s', headerStyleId);
            rows.each(function (i) { if (i >= 2) { $(this).find('c').attr('s', dataStyleId); } });

            // MERGE TITLE
            $('sheetData', sheet).after('<mergeCells count="1"><mergeCell ref="A1:E1"/></mergeCells>');

            // ROW HEIGHTS
            rows.eq(0).attr({ ht: '28', customHeight: '1' });
            rows.eq(1).attr({ ht: '20', customHeight: '1' });

            // COLUMN WIDTHS
            $('cols', sheet).remove();
            $('sheetData', sheet).before('<cols><col min="1" max="1" width="25" customWidth="1"/><col min="2" max="2" width="20" customWidth="1"/><col min="3" max="3" width="18" customWidth="1"/><col min="4" max="4" width="20" customWidth="1"/><col min="5" max="5" width="15" customWidth="1"/></cols>');
          }
                },
                {
                    extend:    "pdf",
                    className: "d-none",
                    filename:  supplier_file_name,
                    exportOptions: { columns: [0, 1, 2, 3, 4] },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];
                        if (doc.content[0]) {
                            doc.content[0].text      = supplier_pdf_title.toUpperCase();
                            doc.content[0].color     = '#5b5fc7';
                            doc.content[0].fontSize  = 20;
                            doc.content[0].bold      = true;
                            doc.content[0].alignment = 'center';
                            doc.content[0].margin    = [0, 0, 0, 5];
                        }
                        var now = new Date();
                        var dateStr = now.getDate() + ' ' + now.toLocaleString('default', { month: 'short' }) + ' ' + now.getFullYear();
                        doc.content.splice(1, 0, { text: 'Generated on: ' + dateStr, color: '#888888', fontSize: 10, alignment: 'center', margin: [0, 0, 0, 15] });
                        doc.content.splice(2, 0, { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 515, y2: 0, lineWidth: 2, lineColor: '#5b5fc7' }], margin: [0, 0, 0, 20] });
                        if (doc.content[3] && doc.content[3].table && doc.content[3].table.body) {
                            var tableBody = doc.content[3].table.body;
                            var colCount  = tableBody[0].length; var widths = [];
                            for (var j = 0; j < colCount; j++) { widths.push((100 / colCount) + '%'); }
                            doc.content[3].table.widths = widths;
                            var tableHeader = tableBody[0];
                            for (var i = 0; i < tableHeader.length; i++) {
                                tableHeader[i].fillColor = '#eef0f2'; tableHeader[i].color = '#333333';
                                tableHeader[i].bold = true; tableHeader[i].margin = [5, 5, 5, 5];
                                if (i === tableHeader.length - 1) { tableHeader[i].alignment = 'center'; }
                            }
                            for (var r = 1; r < tableBody.length; r++) {
                                var row = tableBody[r]; var statusColIdx = row.length - 1;
                                if (row[statusColIdx] && row[statusColIdx].text) {
                                    var statusText = row[statusColIdx].text.trim();
                                    row[statusColIdx] = { text: '   ' + statusText + '   ', color: statusText.toLowerCase() === 'inactive' ? '#842029' : '#0f5132', bold: true, alignment: 'center', margin: [0, 5, 0, 5] };
                                }
                                for (var c = 0; c < row.length; c++) {
                                    if (row[c]) { row[c].fillColor = '#ffffff'; }
                                    if (c !== statusColIdx && row[c] && row[c].text) { row[c].margin = [5, 5, 5, 5]; }
                                }
                            }
                            doc.content[3].layout = {
                                hLineWidth: function () { return 1; }, vLineWidth: function () { return 1; },
                                hLineColor: function () { return '#dee2e6'; }, vLineColor: function () { return '#dee2e6'; },
                                fillColor:  function () { return '#ffffff'; }
                            };
                        }
                    }
                }
            ],

            language: {
                processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
                emptyTable:   '<div class="cat-empty text-center">No suppliers found.</div>',
                zeroRecords:  '<div class="cat-empty text-center">No records match your search.</div>',
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
            }
        });

        $('#search-filter-input').on('keyup input', function () {
            supplierTable.search(this.value).draw();
        });

        $('#export-excel').on('click', function () { supplierTable.button('.buttons-excel').trigger(); });
        $('#export-pdf').on('click',   function () { supplierTable.button('.buttons-pdf').trigger();   });
    },

    formInitiate: function () {
        let that = this;

        $(document).on("input change", ".required-input", function () {
            var val = $(this).val();
            var name = $(this).attr("name");
            var type = $(this).attr("type");

            if (val !== "" && val !== null) {
                var isValid = true;
                if (name === 'email' || type === 'email') {
                    isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val);
                } else if (name === 'phone') {
                    isValid = /^[0-9]{10,15}$/.test(val.replace(/[\s\-\+\(\)]/g, ""));
                }
                if (isValid) {
                    $(this).removeClass("is-invalid");
                    $(this).closest(".form-group").find("label.error").remove();
                }
            }
        });

        $("#addSupplierForm, .update-supplier-form").submit(function (e) {
            e.preventDefault();
            var href = $(this).attr("action");
            var id   = $(this).attr("id");
            if (that.formValidate(id)) { return; }
            var formData = new FormData($(this)[0]);
            $.ajax({
                type: "POST", url: href, data: formData,
                processData: false, contentType: false, dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        toaster("success", response.msg);
                        setTimeout(function () { window.location.reload(); }, 1000);
                    } else { toaster("error", response.msg); }
                },
                error: function (error) { console.error("Error:", error); toaster("error", "An error occurred."); }
            });
        });
    },

    formValidate: function (form_id) {
        form_id = form_id || '';
        let flag = false;
        let $form = $("#" + form_id);
        $form.find(".form-group label.error").remove();
        $form.find(".is-invalid").removeClass("is-invalid");

        $form.find(".required-input").each(function () {
            var value = $(this).val();
            var name = $(this).attr("name");
            var type = $(this).attr("type");
            var label = $(this).closest(".form-group").find("label").text().replace("*", "").trim();

            if (value === '' || value === null) {
                flag = true;
                $(this).addClass("is-invalid");
                var action = $(this).is("select") ? "select" : "enter";
                $(this).closest(".form-group").append("<label class='error text-danger' style='font-size: 12px;'>Please " + action + " " + label.toLowerCase() + "</label>");
            } else if (name === 'email' || type === 'email') {
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    flag = true;
                    $(this).addClass("is-invalid");
                    $(this).closest(".form-group").append("<label class='error text-danger' style='font-size: 12px;'>Please enter a valid email address</label>");
                }
            } else if (name === 'phone') {
                var cleanPhone = value.replace(/[\s\-\+\(\)]/g, "");
                var phoneRegex = /^[0-9]{10,15}$/;
                if (!phoneRegex.test(cleanPhone)) {
                    flag = true;
                    $(this).addClass("is-invalid");
                    $(this).closest(".form-group").append("<label class='error text-danger' style='font-size: 12px;'>Please enter a valid 10-digit phone number</label>");
                }
            }
        });
        return flag;
    }
}
