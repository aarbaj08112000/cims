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

// Custom export action to fetch all data before exporting
function newExportAction(e, dt, button, config) {
  var self = this;
  var oldStart = dt.settings()[0]._iDisplayStart;
  dt.one('preXhr', function (e, s, data) {
    // Load all data from the server
    data.start = 0;
    data.length = -1;
    dt.one('preDraw', function (e, settings) {
      // Call the original action function
      if (button[0].className.indexOf('buttons-csv') >= 0) {
        $.fn.dataTable.ext.buttons.csvHtml5.action.call(self, e, dt, button, config);
      } else if (button[0].className.indexOf('buttons-pdf') >= 0) {
        $.fn.dataTable.ext.buttons.pdfHtml5.action.call(self, e, dt, button, config);
      }
      dt.one('preXhr', function (e, s, data) {
        // Revert settings to what they were before exporting
        settings._iDisplayStart = oldStart;
        data.start = oldStart;
      });
      // Reload the grid with original page
      setTimeout(dt.ajax.reload, 0);
      return false;
    });
  });
  // Requery the server with new export settings
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
          extend: 'csv',
          className: 'd-none',
          filename: category_file_name,
          action: newExportAction,
          exportOptions: {
            columns: [0, 1] // Export Category Name, Status
          }
        },
        {
          extend: 'pdf',
          className: 'd-none',
          filename: category_file_name,
          title: category_pdf_title,
          action: newExportAction,
          exportOptions: {
            columns: [0, 1] // Export Category Name, Status
          }
        }
      ],

      ajax: {
        url: base_url + "get_categories_ajax",
        type: "POST"
      },

      columns: [
        {
          data: 0,
          className: "cat-col-name text-left"
        },
        {
          data: 1,
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
          data: 2,
          width: "160px",
          className: "text-center cat-col-action",
          orderable: false,
          searchable: false
        }
      ],

      language: {
        processing: '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
        emptyTable: '<div class="cat-empty">No categories found.</div>',
        zeroRecords: '<div class="cat-empty">No records match your search.</div>',
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
      searching: true,
      autoWidth: true,
      scrollX: true,
      scrollY: true,
      scrollCollapse: true,
      lengthChange: true,

      drawCallback: function (settings) {
        $(".select2").select2();
        categoryPage.formInitiate();
      },

      initComplete: function () {
        this.api().columns.adjust();
      }
    });

    // --- Debounced search ---
    var searchTimer;
    $('#search-filter-input').on('keyup input', function () {
      var val = this.value;
      clearTimeout(searchTimer);
      searchTimer = setTimeout(function () {
        categoryTable.search(val).draw();
      }, 350);
    });

    // --- Custom Export Buttons ---
    $('#export-csv').on('click', function () {
      categoryTable.button('.buttons-csv').trigger();
    });

    $('#export-pdf').on('click', function () {
      categoryTable.button('.buttons-pdf').trigger();
    });
  },

  formInitiate: function () {
    var that = this;
    $(".addCategories,.update_categories").off('submit').submit(function (e) {
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
