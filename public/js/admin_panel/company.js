$(document).ready(function () {
  var mode = $("#mode").val();
  $(document).on("click", ".delete_data", function () {
    var company_id = $(this).data("id"); // Get category ID

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
          url: "delete_company_data", // Your backend PHP file
          type: "POST",
          data: { company_id: company_id },
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

  $("#company_form").validate({
    rules: {
      company_name: { required: true },
      company_code: { required: true },
      company_logo: {
        required: function () {
          return mode === 'Add';
        }
      },
      contact_person: { required: true },
      email: {
        required: true,
        email: true
      },
      phone: {
        required: true,
        digits: true,
        minlength: 10,
        maxlength: 15
      },
      address: { required: true },
      city: { required: true },
      state: { required: true },
      pincode: {
        required: true,
        digits: true,
        minlength: 4,
        maxlength: 10
      },
      country: { required: true },
      gst_number: { required: true },
      gst_certificate: {
        required: function () {
          return mode === 'Add';
        }
      },
      pan_number: {
        required: true,
        minlength: 10,
        maxlength: 10
      },
      pan_card_img: {
        required: function () {
          return mode === 'Add';
        }
      }
    },
    messages: {
      company_name: "Please enter company name",
      company_code: "Please enter company code",
      company_logo: "Please upload company logo",
      contact_person: "Please enter contact person",
      email: {
        required: "Please enter email",
        email: "Enter a valid email"
      },
      phone: {
        required: "Please enter phone number",
        digits: "Only digits allowed",
        minlength: "Phone must be at least 10 digits",
        maxlength: "Phone can't exceed 15 digits"
      },
      address: "Please enter address",
      city: "Please enter city",
      state: "Please enter state",
      pincode: {
        required: "Please enter pincode",
        digits: "Only digits allowed",
        minlength: "Too short",
        maxlength: "Too long"
      },
      country: "Please enter country",
      gst_number: "Please enter GST number",
      gst_certificate: "Please upload GST certificate",
      pan_number: {
        required: "Please enter PAN number",
        minlength: "PAN should be 10 characters",
        maxlength: "PAN should be 10 characters"
      },
      pan_card_img: "Please upload PAN card image"
    },
    errorClass: "is-invalid",
    validClass: "is-valid",
    errorElement: "div",
    errorPlacement: function (error, element) {
      error.addClass("invalid-feedback");
      if (element.prop("type") === "file") {
        error.insertAfter(element.closest("div"));
      } else {
        error.insertAfter(element);
      }
    },
    highlight: function (element) {
      $(element).addClass("is-invalid").removeClass("is-valid");
    },
    unhighlight: function (element) {
      $(element).removeClass("is-invalid").addClass("is-valid");
    },
    submitHandler: function (form) {
      var formData = new FormData(form);
      var company_id = $("#company_id").val();
      if (company_id == "") {
        var url = 'save_company_data';
      } else {
        var url = 'update_company_data';
      }

      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (response) {
          //  response = JSON.parse(response);
          var msg = response.msg;
          var success = response.success;
          if (success == 1) {
            toaster("success", msg);
            setTimeout(function () {
              window.location.href = base_url + "company";
            }, 1000);
          } else {
            toaster("error", msg);
          }
        },
        error: function (xhr, status, error) {
          console.error("AJAX Error:", error);
          alert("Something went wrong. Please try again.");
        }
      });

      return false;
    }

  });

  var table = '';
  var file_name = "company_list";
  var pdf_title = "company_list";
  table = $("#product_list").DataTable({
    dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"<"col-sm-12"rt>><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
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


});

