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

const categoryPage = {
  init: function () {
    this.dataTable();
    this.formInitiate();
    $(".select2").select2();
  },
  dataTable: function () {
    categoryTable = $("#categoriesTable").DataTable({
      dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"rt><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
      buttons: [
        {
          extend: "csv",
          text: '<i class="ti ti-file-type-csv"></i>',
          init: function (api, node, config) {
            $(node).attr("title", "Download CSV");
          },
          filename: category_file_name
        },
        {
          extend: "pdf",
          text: '<i class="ti ti-file-type-pdf"></i>',
          init: function (api, node, config) {
            $(node).attr("title", "Download Pdf");
          },
          filename: category_file_name,
          customize: function (doc) {
            doc.pageMargins = [15, 15, 15, 15];
            doc.content[0].text = category_pdf_title;
            doc.content[1].table.widths = ["50%", "50%"];
          },
        },
      ],
      searching: true,
      pagingType: "full_numbers",
    });
    $('#search-filter-input').on('keyup', function () {
      categoryTable.search(this.value).draw();
    });


  },
  formInitiate: function () {
    let that = this;
    $(".addCategories,.update_categories").submit(function (e) {
      e.preventDefault();
      var href = $(this).attr("action");
      var id = $(this).attr("id");
      let flag = that.formValidate(id);
      if (flag) {
        return;
      }
      var formData = new FormData($(this)[0]);
      $.ajax({
        type: "POST",
        url: href,
        data: formData,
        processData: false,
        contentType: false,
        dataType: "json",
        success: function (response) {
          var msg = response.msg;
          var success = response.success;
          if (success == 1) {
            toaster("success", msg);
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
  formValidate: function (form_id = '') {
    let flag = false;
    $("#" + form_id + " .required-input").each(function (index) {
      var value = $(this).val();
      if (value == '') {
        flag = true;
        var label = $(this).parents(".form-group").find("label").contents().filter(function () {
          return this.nodeType === 3;
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
    });
  }
}


