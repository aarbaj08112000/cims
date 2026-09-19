$(document).ready(function () {
  categoryPage.init();

  $(document).on("click", ".delete_data", function () {
    var categoryId = $(this).data("id");
    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "Yes, delete it!"
    }).then((result) => {
      if (result.isConfirmed) {
        $.ajax({
          url: "delete_category",
          type: "POST",
          data: { category_id: categoryId },
          dataType: "json",
          success: function (response) {
            if (response.success == 1) {
              Swal.fire("Deleted!", response.msg, "success");
              location.reload();
            } else {
              Swal.fire("Error!", response.msg, "error");
            }
          },
          error: function () {
            Swal.fire("Error!", "Something went wrong.", "error");
          }
        });
      }
    });
  });
});

var categoryTable = '';
var category_file_name = "category_list";
var category_pdf_title = "Category List";

// Custom export action to fetch ALL data before exporting
function newExportAction(e, dt, button, config) {
  var self = this;
  var oldStart = dt.settings()[0]._iDisplayStart;
  dt.one('preXhr', function (e, s, data) {
    data.start  = 0;
    data.length = -1;
    dt.one('preDraw', function (e, settings) {
      if (button[0].className.indexOf('buttons-excel') >= 0) {
        $.fn.dataTable.ext.buttons.excelHtml5.action.call(self, e, dt, button, config);
      } else if (button[0].className.indexOf('buttons-pdf') >= 0) {
        $.fn.dataTable.ext.buttons.pdfHtml5.action.call(self, e, dt, button, config);
      }
      dt.one('preXhr', function (e, s, data) {
        settings._iDisplayStart = oldStart;
        data.start = oldStart;
      });
      setTimeout(dt.ajax.reload, 0);
      return false;
    });
  });
  dt.ajax.reload();
}

const categoryPage = {
  init: function () {
    this.dataTable();
    this.formInitiate();
    $(".select2").select2();
  },

  dataTable: function () {
    categoryTable = $("#categoriesTable").DataTable({
      processing:  true,
      serverSide:  true,
      searching:   true,
      pagingType:  "full_numbers",
      pageLength:  15,
      lengthMenu:  [[10, 15, 25, 50, 100], [10, 15, 25, 50, 100]],
      autoWidth:   false,
      dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',

      buttons: [
        {
          extend:   'excel',
          className: 'd-none',
          filename: category_file_name,
          title:    'Category List',       // Row 1 title
          action:   newExportAction,
          exportOptions: { columns: [0, 1, 2] },

          customize: function (xlsx) {
            var sheet  = xlsx.xl.worksheets['sheet1.xml'];
            var styles = xlsx.xl['styles.xml'];

            // ── Theme palette ────────────────────────────────────────────
            var themeColor   = '5B5FC7';   // main indigo
            var themeLighter = '9B9ED8';   // lighter shade for title row
            var white        = 'FFFFFF';
            var borderColor  = 'C5C5D8';   // subtle border

            // ── 1. FILLS ─────────────────────────────────────────────────
            var fillsEl = $('fills', styles);
            var fCount  = parseInt(fillsEl.attr('count'));

            fillsEl.append(
              '<fill><patternFill patternType="solid">' +
                '<fgColor rgb="' + themeLighter + '"/>' +
                '<bgColor indexed="64"/>' +
              '</patternFill></fill>'
            );
            var titleFillId = fCount++;

            fillsEl.append(
              '<fill><patternFill patternType="solid">' +
                '<fgColor rgb="' + themeColor + '"/>' +
                '<bgColor indexed="64"/>' +
              '</patternFill></fill>'
            );
            var headerFillId = fCount++;

            fillsEl.attr('count', fCount);

            // ── 2. FONTS ─────────────────────────────────────────────────
            var fontsEl = $('fonts', styles);
            var ftCount = parseInt(fontsEl.attr('count'));

            // Bold white 13pt – title
            fontsEl.append(
              '<font><b/><sz val="13"/>' +
                '<color rgb="' + white + '"/>' +
                '<name val="Calibri"/>' +
              '</font>'
            );
            var titleFontId = ftCount++;

            // Bold white 11pt – column headers
            fontsEl.append(
              '<font><b/><sz val="11"/>' +
                '<color rgb="' + white + '"/>' +
                '<name val="Calibri"/>' +
              '</font>'
            );
            var headerFontId = ftCount++;

            fontsEl.attr('count', ftCount);

            // ── 3. BORDERS ───────────────────────────────────────────────
            var bordersEl = $('borders', styles);
            var bCount    = parseInt(bordersEl.attr('count'));

            var thinBorder =
              '<border>' +
                '<left   style="medium"><color rgb="' + borderColor + '"/></left>'   +
                '<right  style="medium"><color rgb="' + borderColor + '"/></right>'  +
                '<top    style="medium"><color rgb="' + borderColor + '"/></top>'    +
                '<bottom style="medium"><color rgb="' + borderColor + '"/></bottom>' +
                '<diagonal/>' +
              '</border>';

            bordersEl.append(thinBorder);
            var dataBorderId = bCount++;

            bordersEl.attr('count', bCount);

            // ── 4. CELL XFS (style records) ──────────────────────────────
            var cellXfsEl = $('cellXfs', styles);
            var xfCount   = parseInt(cellXfsEl.attr('count'));

            // Title style  – lighter fill + bold white font + centered + border
            cellXfsEl.append(
              '<xf numFmtId="0"' +
                ' fontId="'   + titleFontId   + '"' +
                ' fillId="'   + titleFillId   + '"' +
                ' borderId="' + dataBorderId  + '"' +
                ' xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1">' +
                '<alignment horizontal="center" vertical="center"/>' +
              '</xf>'
            );
            var titleStyleId = xfCount++;

            // Header style – theme fill + bold white font + centered + border
            cellXfsEl.append(
              '<xf numFmtId="0"' +
                ' fontId="'   + headerFontId  + '"' +
                ' fillId="'   + headerFillId  + '"' +
                ' borderId="' + dataBorderId  + '"' +
                ' xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1">' +
                '<alignment horizontal="center" vertical="center"/>' +
              '</xf>'
            );
            var headerStyleId = xfCount++;

            // Data style – no fill, thin border
            cellXfsEl.append(
              '<xf numFmtId="0" fontId="0" fillId="0"' +
                ' borderId="' + dataBorderId + '"' +
                ' xfId="0" applyBorder="1" applyAlignment="1">' +
                '<alignment vertical="center"/>' +
              '</xf>'
            );
            var dataStyleId = xfCount++;

            cellXfsEl.attr('count', xfCount);

            // ── 5. APPLY STYLES TO ROWS ──────────────────────────────────
            var rows = $('row', sheet);

            rows.eq(0).find('c').attr('s', titleStyleId);   // Title row
            rows.eq(1).find('c').attr('s', headerStyleId);  // Header row
            rows.each(function (i) {
              if (i >= 2) {
                $(this).find('c').attr('s', dataStyleId);   // Data rows
              }
            });

            // ── 6. MERGE TITLE CELLS A1:C1 ───────────────────────────────
            $('sheetData', sheet).after(
              '<mergeCells count="1"><mergeCell ref="A1:C1"/></mergeCells>'
            );

            // ── 7. ROW HEIGHTS ───────────────────────────────────────────
            rows.eq(0).attr({ ht: '28', customHeight: '1' });  // Title
            rows.eq(1).attr({ ht: '20', customHeight: '1' });  // Headers

            // ── 8. COLUMN WIDTHS ─────────────────────────────────────────
            $('cols', sheet).remove();
            $('sheetData', sheet).before(
              '<cols>' +
                '<col min="1" max="1" width="30" customWidth="1"/>' +
                '<col min="2" max="2" width="22" customWidth="1"/>' +
                '<col min="3" max="3" width="15" customWidth="1"/>' +
              '</cols>'
            );
          }
        },

        {
          extend:    'pdf',
          className: 'd-none',
          filename:  category_file_name,
          title:     category_pdf_title,
          action:    newExportAction,
          exportOptions: { columns: [0, 1, 2] },
          customize: function (doc) {
            if (doc.content[0] && doc.content[0].text) {
              doc.content[0].color     = '#5b5fc7';
              doc.content[0].fontSize  = 20;
              doc.content[0].bold      = true;
              doc.content[0].alignment = 'center';
              doc.content[0].margin    = [0, 0, 0, 5];
            }
            var now     = new Date();
            var dateStr = now.getDate() + ' ' + now.toLocaleString('default', { month: 'short' }) + ' ' + now.getFullYear();
            doc.content.splice(1, 0, { text: 'Generated on: ' + dateStr, color: '#888888', fontSize: 10, alignment: 'center', margin: [0, 0, 0, 15] });
            doc.content.splice(2, 0, { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 515, y2: 0, lineWidth: 2, lineColor: '#5b5fc7' }], margin: [0, 0, 0, 20] });
            if (doc.content[3] && doc.content[3].table && doc.content[3].table.body) {
              var tableBody = doc.content[3].table.body;
              var colCount  = tableBody[0].length;
              var widths    = [];
              for (var j = 0; j < colCount; j++) { widths.push((100 / colCount) + '%'); }
              doc.content[3].table.widths = widths;
              var tableHeader = tableBody[0];
              for (var i = 0; i < tableHeader.length; i++) {
                tableHeader[i].fillColor = '#eef0f2';
                tableHeader[i].color     = '#333333';
                tableHeader[i].bold      = true;
                tableHeader[i].margin    = [5, 5, 5, 5];
                if (i === tableHeader.length - 1) { tableHeader[i].alignment = 'center'; }
              }
              for (var r = 1; r < tableBody.length; r++) {
                var row          = tableBody[r];
                var statusColIdx = row.length - 1;
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
                hLineWidth: function () { return 1; },
                vLineWidth: function () { return 1; },
                hLineColor: function () { return '#dee2e6'; },
                vLineColor: function () { return '#dee2e6'; },
                fillColor:  function () { return '#ffffff'; }
              };
            }
          }
        }
      ],

      ajax: { url: base_url + "get_categories_ajax", type: "POST" },

      columns: [
        { data: 0, className: "cat-col-name text-left" },
        { data: 1, className: "text-left" },
        {
          data: 2,
          width: "140px",
          className: "cat-col-status",
          render: function (data) {
            var tmp  = document.createElement('div');
            tmp.innerHTML = data;
            var text = (tmp.textContent || tmp.innerText || '').trim();
            if (text.toLowerCase() === 'active') {
              return '<span class="cat-badge cat-badge-active"><span class="cat-badge-dot"></span>Active</span>';
            }
            return '<span class="cat-badge cat-badge-inactive"><span class="cat-badge-dot"></span>Inactive</span>';
          }
        },
        { data: 3, width: "160px", className: "text-center cat-col-action", orderable: false, searchable: false }
      ],

      language: {
        processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
        emptyTable:   '<div class="cat-empty text-center">No categories found.</div>',
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
      },

      searching:      true,
      autoWidth:      true,
      scrollX:        true,
      scrollY:        true,
      scrollCollapse: true,
      lengthChange:   true,

      drawCallback: function () {
        $(".select2").select2();
        categoryPage.formInitiate();
      },
      initComplete: function () {
        this.api().columns.adjust();
      }
    });

    // Debounced search
    var searchTimer;
    $('#search-filter-input').on('keyup input', function () {
      var val = this.value;
      clearTimeout(searchTimer);
      searchTimer = setTimeout(function () { categoryTable.search(val).draw(); }, 350);
    });

    // Export buttons
    $('#export-excel').on('click', function () { categoryTable.button('.buttons-excel').trigger(); });
    $('#export-pdf').on('click',   function () { categoryTable.button('.buttons-pdf').trigger();   });
  },

  formInitiate: function () {
    var that = this;
    $(".addCategories,.update_categories").off('submit').submit(function (e) {
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
          } else {
            toaster("error", response.msg);
          }
        },
        error: function (err) { console.error("Error:", err); }
      });
    });
  },

  formValidate: function (form_id) {
    form_id = form_id || '';
    var flag = false;
    $("#" + form_id + " .required-input").each(function () {
      if ($(this).val() === '') {
        flag = true;
        var label = $(this).parents(".form-group").find("label").contents()
          .filter(function () { return this.nodeType === 3; }).text().trim();
        if ($(this).parents(".form-group").find("label.error").length === 0) {
          var start = ($(this).prop("localName") === "select") ? "Please select " : "Please enter ";
          label = label.toLowerCase().replace("enter", "").replace("select", "");
          var msg = start + label.replace(/[^\w\s*]/gi, '');
          $(this).parents(".form-group").append("<label class='error'>" + msg + "</label>");
        }
      }
    });
    return flag;
  }
};
