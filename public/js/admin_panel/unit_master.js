var unitTable;
var unit_file_name = 'Unit_Master_' + new Date().toISOString().slice(0, 10);
var unit_pdf_title = 'Unit Master Report';

function newExportAction(e, dt, button, config) {
  var self = this;
  var oldStart = dt.settings()[0]._iDisplayStart;
  dt.one('preXhr', function (e, s, data) {
    data.start = 0;
    data.length = -1;
    dt.one('preDraw', function (e, settings) {
      if (button[0].className.indexOf('buttons-csv') >= 0) {
        $.fn.dataTable.ext.buttons.csvHtml5.action.call(self, e, dt, button, config);
      } else if (button[0].className.indexOf('buttons-pdf') >= 0) {
        $.fn.dataTable.ext.buttons.pdfHtml5.action.call(self, e, dt, button, config);
      }
      dt.one('preXhr', function (e, s, data) { settings._iDisplayStart = oldStart; data.start = oldStart; });
      setTimeout(dt.ajax.reload, 0);
      return false;
    });
  });
  dt.ajax.reload();
}

var unitPage = {
  init: function () {
    this.dataTable();
  },

  dataTable: function () {
    unitTable = $("#unitsTable").DataTable({
      processing: true,
      serverSide: true,
      searching: true,
      pagingType: "full_numbers",
      pageLength: 15,
      lengthMenu: [[10, 15, 25, 50, 100], [10, 15, 25, 50, 100]],
      autoWidth: true,
      dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',

      buttons: [
        {
          extend: 'csv',
          className: 'd-none',
          filename: unit_file_name,
          action: newExportAction,
          exportOptions: { columns: [0, 1, 2] }
        },
        {
          extend: 'pdf',
          className: 'd-none',
          filename: unit_file_name,
          title: unit_pdf_title,
          action: newExportAction,
          exportOptions: { columns: [0, 1, 2] },
          customize: function (doc) {
            if (doc.content[0] && doc.content[0].text) {
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
                if (i === tableHeader.length - 1) {
                  tableHeader[i].alignment = 'center';
                }
              }

              for (var r = 1; r < tableBody.length; r++) {
                var row = tableBody[r];
                var statusColIdx = row.length - 1;
                if (row[statusColIdx] && row[statusColIdx].text) {
                  var statusText = row[statusColIdx].text.trim();
                  var bgColor = '#ffffff';
                  var textColor = '#0f5132';

                  if (statusText.toLowerCase() === 'inactive') {
                    bgColor = '#ffffff';
                    textColor = '#842029';
                  }

                  row[statusColIdx] = {
                    text: '   ' + statusText + '   ',
                    background: bgColor,
                    color: textColor,
                    bold: true,
                    alignment: 'center',
                    margin: [0, 5, 0, 5]
                  };
                }

                for (var c = 0; c < row.length; c++) {
                  if (row[c]) {
                    row[c].fillColor = '#ffffff';
                  }
                  if (c !== statusColIdx && row[c] && row[c].text) {
                    row[c].margin = [5, 5, 5, 5];
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

      ajax: {
        url: base_url + "get_units_ajax",
        type: "POST"
      },

      columns: [
        { data: 0, className: "cat-col-name" },
        { data: 1, className: "text-left" },
        {
          data: 2,
          width: "140px",
          className: "cat-col-status",
          render: function (data) {
            var tmp = document.createElement('div');
            tmp.innerHTML = data;
            var text = (tmp.textContent || tmp.innerText || '').trim();
            if (text.toLowerCase() === 'active') {
              return '<span class="cat-badge cat-badge-active"><span class="cat-badge-dot"></span>Active</span>';
            }
            return '<span class="cat-badge cat-badge-inactive"><span class="cat-badge-dot"></span>Inactive</span>';
          }
        },
        {
          data: 3,
          width: "160px",
          className: "text-center cat-col-action",
          orderable: false,
          searchable: false
        }
      ],

      language: {
        processing: '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
        emptyTable: '<div class="cat-empty text-center">No units found.</div>',
        zeroRecords: '<div class="cat-empty text-center">No records match your search.</div>',
        info: 'Showing _START_ to _END_ of _TOTAL_ entries',
        infoEmpty: 'Showing 0 to 0 of 0 entries',
        infoFiltered: '(filtered from _MAX_ total)',
        lengthMenu: 'Show _MENU_ entries',
        paginate: {
          first: '<i class="ti ti-chevrons-left"></i>',
          last: '<i class="ti ti-chevrons-right"></i>',
          next: '<i class="ti ti-chevron-right"></i>',
          previous: '<i class="ti ti-chevron-left"></i>'
        }
      },
      scrollX: true,
      scrollCollapse: true,
      lengthChange: true,

      drawCallback: function () {
        $(".select2").select2();
        unitPage.formInitiate();
      },

      initComplete: function () {
        this.api().columns.adjust();
      }
    });

    var searchTimer;
    $('#search-filter-input').on('keyup input', function () {
      var val = this.value;
      clearTimeout(searchTimer);
      searchTimer = setTimeout(function () {
        unitTable.search(val).draw();
      }, 350);
    });

    $('#export-csv').on('click', function () {
      unitTable.button('.buttons-csv').trigger();
    });
    $('#export-pdf').on('click', function () {
      unitTable.button('.buttons-pdf').trigger();
    });
  },

  formInitiate: function () {
    var that = this;
    $(".addUnitForm,.update_unit").off('submit').submit(function (e) {
      e.preventDefault();
      var href = $(this).attr("action");
      var id = $(this).attr("id");
      if (that.formValidate(id)) { return; }
      var formData = new FormData($(this)[0]);
      $.ajax({
        type: "POST",
        url: href,
        data: formData,
        processData: false,
        contentType: false,
        dataType: "json",
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

    $(document).off('click', '.delete_data').on('click', '.delete_data', function () {
      var id = $(this).data('id');
      if (!confirm('Are you sure you want to delete this unit?')) return;
      $.ajax({
        type: "POST",
        url: base_url + "delete_unit",
        data: { unit_id: id },
        dataType: "json",
        success: function (response) {
          if (response.success == 1) {
            toaster("success", response.msg);
            setTimeout(function () { unitTable.ajax.reload(); }, 800);
          } else {
            toaster("error", response.msg);
          }
        }
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

$(document).ready(function () {
  unitPage.init();
});
