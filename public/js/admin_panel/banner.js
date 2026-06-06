$(document).ready(function () {
  page.init();
});
var table = '';
var file_name = "item_par_list";
var pdf_title = "Item part List";
const page = {
  init: function () {
    this.dataTable();
    this.formInitiate();
    $("#group_code").on("input", function () {
      let value = $(this).val();
      $(this).val((value.replace(/[^a-zA-Z_]/g, '')).toLowerCase());
    })
    $(".select2").select2();

    $(document).on("click", ".delete_data", function () {
      var banners_id = $(this).data("id"); // Get category ID

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
            url: "delete_banners", // Your backend PHP file
            type: "POST",
            data: { banners_id: banners_id },
            dataType: "json",
            success: function (response) {
              //  response = JSON.parse(response);
              if (response.success == 1) {
                Swal.fire("Deleted!", response.msg, "success").then(() => {
                  location.reload();
                });
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


  },
  dataTable: function () {
    table = $("#banner").DataTable({
      dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
      buttons: [
      {
        extend: "csv",
        className: "d-none",
        filename: file_name
      },
      {
        extend: "pdf",
        className: "d-none",
        title: pdf_title,
        filename: file_name,
        customize: function (doc) {
          doc.pageMargins = [15, 15, 15, 15];
          doc.styles.tableHeader.fillColor = '#f8f7fa';
          doc.styles.tableHeader.color = '#333333';
        },
      },
    ],
      language: {
          emptyTable: '<div class="cat-empty">No banners found.</div>',
          zeroRecords: '<div class="cat-empty">No records match your search.</div>',
          info: 'Showing _START_ to _END_ of _TOTAL_ entries',
          infoEmpty: 'Showing 0 to 0 of 0 entries',
          infoFiltered: '(filtered from _MAX_ total)',
          lengthMenu: '_MENU_',
          paginate: {
            first: '<i class="ti ti-chevrons-left"></i>',
            last: '<i class="ti ti-chevrons-right"></i>',
            next: '<i class="ti ti-chevron-right"></i>',
            previous: '<i class="ti ti-chevron-left"></i>'
          }
      },
      searching: true,
      scrollY: true,
      scrollX: true,
      bScrollCollapse: true,
      pagingType: "full_numbers",
      initComplete: function () {
          this.api().columns.adjust();
      },
    });

    var searchTimer;
    $('#search-filter-input').on('keyup input', function () {
      var val = this.value;
      clearTimeout(searchTimer);
      searchTimer = setTimeout(function () {
          table.search(val).draw();
      }, 350);
    });

    setTimeout(function () {
      $(".dataTables_length select").select2({
        minimumResultsForSearch: Infinity
      });
    }, 200);
    },
formInitiate: function() {
  let that = this;
  $(".add_banner,.update_banner").submit(function (e) {
    e.preventDefault();
    var href = $(this).attr("action");
    var id = $(this).attr("id");
    let flag = that.formValidate(id);
    if (flag) {
      return;
    }
    var formData = new FormData($('.' + id)[0]);
    $.ajax({
      type: "POST",
      url: href,
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        var responseObject = JSON.parse(response);
        var msg = responseObject.msg;
        var success = responseObject.success;
        if (success == 1) {
          toaster("success", msg);
          $(this).parents(".modal").modal("hide")
          setTimeout(function () {
            window.location.reload();
          }, 1000);

        } else {
          toaster("error", msg);
        }
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });

},
formValidate: function(form_class = '') {
  let flag = false;
  $(".custom-form." + form_class + " .required-input").each(function (index) {
    var value = $(this).val();
    var dataMax = parseFloat($(this).attr('data-max'));
    var dataMin = parseFloat($(this).attr('data-min'));
    if (value == '') {
      flag = true;
      var label = $(this).parents(".form-group").find("label").contents().filter(function () {
        return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
      }).text().trim();
      var exit_ele = $(this).parents(".form-group").find("label.error");
      if (exit_ele.length == 0) {
        var start = "Please enter ";
        if ($(this).prop("localName") == "select") {
          var start = "Please select ";
        }
        label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
        var validation_message = start + (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
        var label_html = "<label class='error'>" + validation_message + "</label>";
        $(this).parents(".form-group").append(label_html)
      }
    }
    else if (dataMin !== undefined && dataMin > value) {
      flag = true;
      var label = $(this).parents(".form-group").find("label").contents().filter(function () {
        return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
      }).text().trim();
      var exit_ele = $(this).parents(".form-group").find("label.error");
      if (exit_ele.length == 0) {
        var end = " must be greater than or equal to " + dataMin;
        label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
        label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
        label = label.charAt(0).toUpperCase() + label.slice(1);
        var validation_message = label + end;
        var label_html = "<label class='error'>" + validation_message + "</label>";
        $(this).parents(".form-group").append(label_html)
      }
    } else if (dataMax !== undefined && dataMax < value) {
      flag = true;
      var label = $(this).parents(".form-group").find("label").contents().filter(function () {
        return this.nodeType === 3; // Filter out non-text nodes (nodeType 3 is Text node)
      }).text().trim();
      var exit_ele = $(this).parents(".form-group").find("label.error");
      if (exit_ele.length == 0) {
        var end = " must be less than or equal to " + dataMax;
        label = ((label.toLowerCase()).replace("enter", "")).replace("select", "");
        label = (label.toLowerCase()).replace(/[^\w\s*]/gi, '');
        label = label.charAt(0).toUpperCase() + label.slice(1)
        var validation_message = label + end;
        var label_html = "<label class='error'>" + validation_message + "</label>";
        $(this).parents(".form-group").append(label_html)
      }
    }
  });

  return flag;
}
    
}


