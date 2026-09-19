var activityLogsTable = '';
var activity_logs_file_name = "Activity_Logs_" + new Date().toISOString().slice(0, 10);
var activity_logs_pdf_title = "User Activity Logs";
// Custom export action to fetch ALL data before exporting
function newExportAction(e, dt, button, config) {
  var self = this;
  var oldStart = dt.settings()[0]._iDisplayStart;
  dt.one('preXhr', function (e, s, data) {
    data.start = 0;
    data.length = -1;
    dt.one('preDraw', function (e, settings) {
      if (button[0].className.indexOf('buttons-excel') >= 0) {
        if ($.fn.dataTable.ext.buttons.excelHtml5.available(dt, config)) {
          $.fn.dataTable.ext.buttons.excelHtml5.action.call(self, e, dt, button, config);
        } else {
          $.fn.dataTable.ext.buttons.excelFlash.action.call(self, e, dt, button, config);
        }
      } else if (button[0].className.indexOf('buttons-pdf') >= 0) {
        if ($.fn.dataTable.ext.buttons.pdfHtml5.available(dt, config)) {
          $.fn.dataTable.ext.buttons.pdfHtml5.action.call(self, e, dt, button, config);
        } else {
          $.fn.dataTable.ext.buttons.pdfFlash.action.call(self, e, dt, button, config);
        }
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

const activityLogsPage = {
  init: function () {
    this.dataTable();
  },
  dataTable: function () {
    activityLogsTable = $("#activity_logs_table").DataTable({
      processing: true,
      serverSide: true,
      searching: true,
      pagingType: "full_numbers",
      pageLength: 15,
      lengthMenu: [[10, 15, 25, 50, 100], [10, 15, 25, 50, 100]],
      autoWidth: false,
      dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',

      buttons: [
        {
          extend: 'excel',
          className: 'd-none',
          filename: activity_logs_file_name,
          title: 'User Activity Logs',
          action: newExportAction,
          exportOptions: { columns: [0, 1, 2, 3, 4, 5] }
        },
        {
          extend: 'pdf',
          className: 'd-none',
          filename: activity_logs_file_name,
          title: activity_logs_pdf_title,
          action: newExportAction,
          exportOptions: { columns: [0, 1, 2, 3, 4, 5] }
        }
      ],

      ajax: {
        url: base_url + "get_activity_logs_ajax",
        type: "POST"
      },

      order: [[0, "desc"]],

      columns: [
        { data: 0, className: "cat-col-name" },
        { data: 1 },
        { data: 2 },
        { data: 3 },
        { data: 4 },
        { data: 5 }
      ],

      language: {
        processing: '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
        emptyTable: '<div class="cat-empty text-center">No action logs found.</div>',
        zeroRecords: '<div class="cat-empty text-center">No matching records found.</div>',
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
      // scrollX: true,
      // scrollCollapse: true,
      lengthChange: true,

      drawCallback: function () {
        if ($.fn.select2) {
          $(".cat-dt-length select").select2({
            minimumResultsForSearch: Infinity,
            width: 'auto'
          });
        }
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
        activityLogsTable.search(val).draw();
      }, 350);
    });

    $('#export-excel').on('click', function () {
      activityLogsTable.button('.buttons-excel').trigger();
    });
    $('#export-pdf').on('click', function () {
      activityLogsTable.button('.buttons-pdf').trigger();
    });
  }
};

$(document).ready(function () {
  if ($("#activity_logs_table").length) {
    activityLogsPage.init();
  }
});
