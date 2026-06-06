$(document).ready(function () {

  var mode = $("#mode").val();
  $(document).on("click", ".delete_data", function () {
    var customer_id = $(this).data("id"); // Get category ID

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
          url: "delete_customer_data", // Your backend PHP file
          type: "POST",
          data: { customer_id: customer_id },
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


  $.validator.addMethod("indianMobile", function (value, element) {
    return this.optional(element) || /^[6-9]\d{9}$/.test(value);
  }, "Enter a valid 10-digit Indian mobile number");

  $.validator.addMethod("panFormat", function (value, element) {
    return this.optional(element) || /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/.test(value.toUpperCase());
  }, "Enter a valid PAN number (e.g., ABCDE1234F)");

  $.validator.addMethod("aadharFormat", function (value, element) {
    return this.optional(element) || /^\d{12}$/.test(value);
  }, "Enter a valid 12-digit Aadhar number");

  $("#customer_form").validate({
    rules: {
      full_name: "required",
      mobile_number: {
        required: true,
        indianMobile: true
      },
      email: {
        required: true,
        email: true
      },
      dob: "required",
      gender: "required",
      address1: "required",
      city: "required",
      state: "required",
      pincode: {
        required: true,
        digits: true,
        minlength: 6,
        maxlength: 6
      },
      country: "required",
      pan_number: {
        required: true,
        panFormat: true
      },
      pan_image: {
        required: function () {
          return mode === 'Add';
        }
      },
      aadhar_number: {
        required: true,
        aadharFormat: true
      },
      aadhar_image: {
        required: function () {
          return mode === 'Add';
        }
      },
      customer_type: "required",
      company_id: "required",

      // Product related fields (arrays)
      'product_id[]': {
        required: true
      },
      'product_price[]': {
        required: true,
        number: true,
        min: 1
      },
      'quantity[]': {
        required: true,
        digits: true,
        min: 1
      },
      'total_price[]': {
        required: true,
        number: true,
        min: 1
      },

      gst_type: "required",
      gst_percentage: {
        required: function (element) {
          return $("select[name='gst_type']").val() === "Yes";
        },
        number: true,
        min: 0
      }
    },
    messages: {
      full_name: "Full Name is required",
      mobile_number: {
        required: "Mobile Number is required"
      },
      email: {
        required: "Email is required",
        email: "Enter a valid email address"
      },
      dob: "Date of Birth is required",
      gender: "Please select Gender",
      address1: "Address Line 1 is required",
      city: "City is required",
      state: "State is required",
      pincode: {
        required: "Pincode is required",
        digits: "Enter only digits",
        minlength: "Pincode must be 6 digits",
        maxlength: "Pincode must be 6 digits"
      },
      country: "Country is required",
      pan_number: {
        required: "PAN Number is required"
      },
      pan_image: "Please upload PAN image",
      aadhar_number: {
        required: "Aadhar Number is required"
      },
      aadhar_image: "Please upload Aadhar image",
      customer_type: "Select Customer Type",
      company_id: "Select a Company",

      'product_id[]': {
        required: "Select a Product"
      },
      'product_price[]': {
        required: "Product Price is required",
        number: "Enter a valid number",
        min: "Price must be at least 1"
      },
      'quantity[]': {
        required: "Quantity is required",
        digits: "Enter a valid quantity",
        min: "Quantity must be at least 1"
      },
      'total_price[]': {
        required: "Total Price is required",
        number: "Enter a valid number",
        min: "Price must be at least 1"
      },

      gst_type: "Select GST Type",
      gst_percentage: {
        required: "Enter GST Percentage",
        number: "Must be a number",
        min: "Must be 0 or more"
      }
    },
    errorClass: "text-danger",
    errorPlacement: function (error, element) {
      if (element.hasClass('select2-hidden-accessible')) {
        // Place error below the Select2 container
        error.insertAfter(element.next('.select2-container'));
      } else if (element.prop("type") === "file") {
        error.insertAfter(element.closest(".form-control"));
      } else {
        error.insertAfter(element);
      }
    },

    highlight: function (element) {
      $(element).addClass("is-invalid");
    },
    unhighlight: function (element) {
      $(element).removeClass("is-invalid");
    },
    submitHandler: function (form) {
      var formData = new FormData(form);
      var customer_id = $("#customer_id").val();
      if (customer_id == "") {
        var url = 'save_customer_data';
      } else {
        var url = 'update_customer_data';
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
              window.location.href = "customer";
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
  var file_name = "customer_list";
  var pdf_title = "Customer List";
  table = $("#customerListTable").DataTable({
    dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
    buttons: [
      {
        extend: "csv",
        className: "d-none",
        filename: file_name,
        exportOptions: {
            columns: [1, 2, 3, 4, 5] // Adjust columns as needed
        }
      },
      {
        extend: "pdf",
        className: "d-none",
        filename: file_name,
        title: pdf_title,
        customize: function (doc) {
          doc.pageMargins = [15, 15, 15, 15];
          doc.styles.tableHeader.fillColor = '#f8f7fa';
          doc.styles.tableHeader.color = '#333333';
        },
        exportOptions: {
            columns: [1, 2, 3, 4, 5] // Adjust columns as needed
        }
      },
    ],
    language: {
        emptyTable: '<div class="cat-empty">No customers found.</div>',
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
    columnDefs: [
        { targets: 0, orderable: false, searchable: false, className: "text-center" },
        { targets: 6, orderable: false, searchable: false, className: "text-center" }
    ],
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

  // Custom Export Buttons Integration
  $('#export-csv').on('click', function () {
      table.button('.buttons-csv').trigger();
  });

  $('#export-pdf').on('click', function () {
      table.button('.buttons-pdf').trigger();
  });

  // Update length dropdown
  setTimeout(function () {
      $(".dataTables_length select").select2({
          minimumResultsForSearch: Infinity
      });
  }, 200);

  function updateRowTotal(row) {
    const qty = parseFloat(row.find('.product-qty').val()) || 0;
    const price = parseFloat(row.find('.product-price').val()) || 0;
    const total = qty * price;
    row.find('.product-total').val(total.toFixed(2));
    updateGrandTotal();
  }

  // Update grand total and GST
  function updateGrandTotal() {
    let grandTotal = 0;

    $('.product-total').each(function () {
      const val = parseFloat($(this).val()) || 0;
      grandTotal += val;
    });

    $('input[name="grand_total"]').val(grandTotal.toFixed(2));

    const gstType = $('select[name="gst_type"]').val();
    const gstPercentage = parseFloat($('input[name="gst_percentage"]').val()) || 0;

    if (gstType === "Yes") {
      const gstAmount = (grandTotal * gstPercentage) / 100;
      const finalAmount = grandTotal + gstAmount;
      $('input[name="gst_total_price"]').val(finalAmount.toFixed(2));
    } else {
      $('input[name="gst_total_price"]').val(grandTotal.toFixed(2));
    }

  }

  // On product selection, fill price
  $(document).on('change', '.product-select', function () {
    const price = $(this).find(':selected').data('price') || 0;
    const row = $(this).closest('.product-row');
    row.find('.product-price').val(price);
    updateRowTotal(row);

    updateProductOptions();
  });

  // On qty or price input
  $(document).on('input', '.product-qty, .product-price', function () {
    const row = $(this).closest('.product-row');
    updateRowTotal(row);
  });

  // GST type or percentage change
  $(document).on('change input', 'select[name="gst_type"], input[name="gst_percentage"]', function () {
    updateGrandTotal();
  });

  // Add new product row
  $(document).on('click', '.add-row', function () {
    let hasEmpty = false;

    $('.product-row').each(function () {
      const product = $(this).find('.product-select').val();
      const price = $(this).find('.product-price').val();
      const qty = $(this).find('.product-qty').val();

      $(this).find('.required-input').removeClass('border-danger');

      if (!product || !price || !qty) {
        $(this).find('.required-input').each(function () {
          if (!$(this).val()) {
            $(this).addClass('border-danger');
          }
        });
        hasEmpty = true;
      }
    });

    if (hasEmpty) return;

    const clone = $('.product-row:first').clone();
    clone.find('input').val('');
    clone.find('select').val('');
    $('.product-row:last').after(clone);
    updateProductOptions();
  });

  // Disable already selected products in other rows
  function updateProductOptions() {
    const selectedValues = [];
    $('.product-select').each(function () {
      const val = $(this).val();
      if (val) selectedValues.push(val);
    });

    $('.product-select').each(function () {
      const current = $(this).val();
      $(this).find('option').each(function () {
        if ($(this).val() !== "" && $(this).val() !== current && selectedValues.includes($(this).val())) {
          $(this).attr('disabled', true);
        } else {
          $(this).attr('disabled', false);
        }
      });
    });
  }

  // Initial setup
  updateProductOptions();
  updateGrandTotal();

  $(document).on('click', '.view-products-payment', function () {
    const customerId = $(this).data('id');

    $('#modalContentLoader').show();
    $('#modalContentArea').hide();
    $('#productPaymentModal').modal('show');

    $.ajax({
      url: 'get_product_payment_html',
      method: 'POST',
      data: { customer_id: customerId },
      dataType: 'html', // expecting HTML content
      success: function (response) {
        $('#modalContentArea').html(response);
        $('#modalContentLoader').hide();
        $('#modalContentArea').show();
      },
      error: function (xhr, status, error) {
        console.error('AJAX Error:', status, error);
        $('#modalContentArea').html('<p class="text-danger">Failed to load data.</p>');
        $('#modalContentLoader').hide();
        $('#modalContentArea').show();
      }
    });
  });

  $(document).on('input', '.handover-input', function () {
    const $input = $(this);
    const maxQty = parseInt($input.attr('max')) || 0;
    let currentVal = parseInt($input.val()) || 0;

    if (currentVal > maxQty) {
      $input.val(maxQty);
    }
  });

  $(document).on('click', '#savePaymentBtn', function () {
    const customerId = $(this).data('id');
    const amountReceived = $('#amount_received').val();
    const transactionType = $('#transaction_type').val();
    const transactionImageFile = $('#transaction_image')[0]?.files[0];

    const handoverQty = {};
    const oldHandoverQty = {};
    let isValid = true;
    let errorMessage = '';

    $('.handover-input').each(function () {
      const $input = $(this);
      const enteredQty = parseInt($input.val()) || 0;
      const maxQty = parseInt($input.attr('max')) || 0;
      const oldQty = parseInt($input.attr('data-handover-qty')) || 0;

      if (enteredQty > 0 && enteredQty > maxQty) {
        isValid = false;
        errorMessage = 'Entered quantity exceeds the maximum allowed.';
        return false; // break
      }

      if (enteredQty > 0) {
        const productId = $input.attr('name').match(/\d+/)[0];
        handoverQty[productId] = enteredQty;
        oldHandoverQty[productId] = oldQty;
      }
    });

    if (!isValid) {
      showModalAlert(errorMessage, 'danger');
      return;
    }

    if (!amountReceived || amountReceived <= 0) {
      showModalAlert('Please enter a valid amount received.', 'danger');
      return;
    }

    if (!transactionType) {
      showModalAlert('Transaction type is required.', 'danger');
      return;
    }

    if (!transactionImageFile) {
      showModalAlert('Transaction image is required.', 'danger');
      return;
    }

    let formData = new FormData();
    formData.append('customer_id', customerId);
    formData.append('amount_received', amountReceived);
    formData.append('transaction_type', transactionType);
    formData.append('transaction_image', transactionImageFile);

    if (Object.keys(handoverQty).length > 0) {
      formData.append('product_ids', Object.keys(handoverQty).join(','));
      formData.append('handover_qtys', Object.values(handoverQty).join(','));
      formData.append('old_handover_qtys', Object.values(oldHandoverQty).join(','));
    }

    $.ajax({
      url: 'save_product_payment',
      type: 'POST',
      data: formData,
      contentType: false,
      processData: false,
      dataType: 'json',
      success: function (response) {
        if (response.status === 'success') {
          showModalAlert('Payment saved successfully!', 'success');
          setTimeout(() => {
            $('#productPaymentModal').modal('hide');
          }, 2000);
        } else {
          showModalAlert(response.message || 'Something went wrong.', 'danger');
        }
      },
      error: function () {
        showModalAlert('Something went wrong. Please try again.', 'danger');
      }
    });
  });








});

function showModalAlert(message, type = 'danger') {
  const alertBox = $('#modelAlertBox');
  alertBox
    .removeClass('d-none alert-danger alert-success')
    .addClass(`alert-${type}`)
    .text(message)
    .fadeIn();

  setTimeout(() => {
    alertBox.fadeOut(300, function () {
      alertBox.addClass('d-none');
    });
  }, 2000);
}

