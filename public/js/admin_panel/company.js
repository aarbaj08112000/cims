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
  var pdf_title = "Company List";
  table = $("#companyListTable").DataTable({
    dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
    buttons: [
      {
        extend: "csv",
        className: "d-none",
        filename: file_name,
        exportOptions: {
            columns: [0, 2, 3, 4, 5, 6]
        }
      },
      {
        extend: "pdf",
        className: "d-none",
        filename: file_name,
        customize: function (doc) {
          doc.pageMargins = [15, 15, 15, 15];
          doc.content[0].text = pdf_title;
          doc.content[1].table.widths = ["10%", "20%", "20%", "20%", "20%", "10%"];
        },
        exportOptions: {
            columns: [0, 2, 3, 4, 5, 6]
        }
      }
    ],
    searching: true,
    pagingType: "full_numbers",
    language: {
        processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
        emptyTable:   '<div class="cat-empty">No companies found.</div>',
        zeroRecords:  '<div class="cat-empty">No records match your search.</div>',
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
    table.search(this.value).draw();
  });

  $('#export-csv').on('click', function () {
    table.button('.buttons-csv').trigger();
  });

  $('#export-pdf').on('click', function () {
    table.button('.buttons-pdf').trigger();
  });


});

