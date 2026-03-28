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
      var gallery_id = $(this).data("id"); // Get category ID

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
            url: "delete_gallery_image_vedio", // Your backend PHP file
            type: "POST",
            data: { gallery_id: gallery_id },
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
    table = $("#brands").DataTable({
      dom: "<"row align- items - center mb - 2"<"col - sm - 12 col - md - 6"B><"col - sm - 12 col - md - 6 text - end"f>><"dt - scroll - body - wrapper"<"col - sm - 12"rt>><"dt - fixed - footer row align - items - center pt - 3 mt - 1 border - top"<"col - sm - 12 col - md - 5"i><"col - sm - 12 col - md - 7 d - flex align - items - center justify - content - end gap - 2"pl>>",
      buttons: [
      {
        extend: "csv",
        text: '<i class="ti ti-file-type-csv"></i>',
        init: function (api, node, config) {
          $(node).attr("title", "Download CSV");
        },
        customize: function (csv) {
          var lines = csv.split('\n');
          var modifiedLines = lines.map(function (line) {
            var values = line.split(',');
            // values.splice(7, 1);
            return values.join(',');
          });
          return modifiedLines.join('\n');
        },
        filename: file_name
      },

      {
        extend: "pdf",
        text: '<i class="ti ti-file-type-pdf"></i>',
        init: function (api, node, config) {
          $(node).attr("title", "Download Pdf");
        },
        filename: file_name,
        customize: function (doc) {
          doc.pageMargins = [15, 15, 15, 15];
          doc.content[0].text = pdf_title;
          doc.content[0].color = theme_color;
          doc.content[1].table.widths = ["50%", "50%"];
          doc.content[1].table.body[0].forEach(function (cell) {
            cell.fillColor = theme_color;
          });
          doc.content[1].table.body.forEach(function (row, index) {
            // row.splice(7, 1);
            row.forEach(function (cell) {
              // Set alignment for each cell
              cell.alignment = "center"; // Change to 'left' or 'right' as needed
            });
          });
        },
      },
    ],
      searching: true,
      // scrollX: true,
      scrollY: true,
      bScrollCollapse: true,
      // columnDefs: [{ sortable: false, targets: 7 }],
      pagingType: "full_numbers",
       
        
        });
$('#search-filter-input').on('keyup', function () {
  table.search(this.value).draw();
});
$('.dataTables_length').find('label').contents().filter(function () {
  return this.nodeType === 3; // Filter out text nodes
}).remove();
setTimeout(function () {
  $(".dataTables_length select").select2({
    minimumResultsForSearch: Infinity
  });
}, 1000)
    },
formInitiate: function() {
  let that = this;
  $(".add_brands,.update_brands").submit(function (e) {
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


