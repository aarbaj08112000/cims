$(document).ready(function () {
  $(".form-select").not("[name*='currency']").each(function () {
    var placeholderText = $(this).find('option:first').text() || "Select an option";
    $(this).select2({
      width: "100%",
      placeholder: placeholderText,
      allowClear: false
    });
  });

  // Revalidate select2 on change
  $(".form-select").on("change", function () {
    $(this).valid();
  });
  var mode = $("#mode").val();
  $("#product_form").validate({
    ignore: "input[type=hidden], .select2-input, .select2-focusser",
    rules: {
      category_id: { required: true },
      brand_id: { required: true },
      purchase_price: { required: true, number: true, min: 0.01 },
      name: {
        required: true,
        minlength: 2
      },
      actual_price: {
        required: true,
        number: true,
        min: 0.01
      },
      description: {
        required: true,
        minlength: 5
      },
      image: {
        required: function () {
          return mode === 'Add';
        }
      }
    },
    messages: {
      category_id: { required: "Please select a category" },
      brand_id: { required: "Please select a brand" },
      purchase_price: { required: "Please enter the purchase price" },
      name: {
        required: "Please enter product name",
        minlength: "Name must be at least 2 characters"
      },
      actual_price: {
        required: "Please enter the actual selling price",
        number: "Enter a valid number",
        min: "Price must be greater than 0"
      },

      description: {
        required: "Please enter a description",
        minlength: "Description must be at least 5 characters"
      },
      image: {
        required: "Please upload an image",
      }
    },
    errorClass: "is-invalid",
    validClass: "is-valid",
    errorElement: "div",
    errorPlacement: function (error, element) {
      error.addClass("invalid-feedback");
      if (element.hasClass("select2-hidden-accessible") || element.siblings(".select2-container").length > 0) {
        error.insertAfter(element.siblings(".select2-container").last());
      } else if (element.parent(".input-group").length > 0) {
        error.insertAfter(element.parent(".input-group"));
      } else if (element.prop("type") === "file") {
        error.insertAfter(element);
      } else {
        error.insertAfter(element);
      }
    },
    highlight: function (element) {
      $(element).addClass("is-invalid").removeClass("is-valid");
      if ($(element).hasClass("select2-hidden-accessible") || $(element).hasClass("form-select")) {
        $(element).siblings(".select2-container").last().find(".select2-selection").addClass("border-danger").removeClass("border-success");
      }
    },
    unhighlight: function (element) {
      $(element).removeClass("is-invalid").addClass("is-valid");
      if ($(element).hasClass("select2-hidden-accessible") || $(element).hasClass("form-select")) {
        $(element).siblings(".select2-container").last().find(".select2-selection").removeClass("border-danger").addClass("border-success");
      }
    },
    submitHandler: function (form) {
      var formData = new FormData(form);
      var product_id = $("#product_id").val();
      if (product_id == "") {
        var url = 'save_product_data';
      } else {
        var url = 'update_product_data';
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
              window.location.href = base_url + "product_details/" + response.product_id;
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

  function calculateSellingPrice() {
    var actualPrice = parseFloat($('#actual_price').val()) || 0;
    var discount = parseFloat($('#discount').val()) || 0;
    var sellingPrice = actualPrice;

    if (discount > 0 && actualPrice > 0) {
      sellingPrice = actualPrice - (actualPrice * discount / 100);
    }

    if (actualPrice > 0) {
      $('#price').val(sellingPrice.toFixed(2));
    } else {
      $('#price').val('');
    }
  }

  $('#actual_price, #discount').on('input', function () {
    calculateSellingPrice();
  });
});

// Handle Dynamic Attributes
function updateAttributeDropdowns() {
  // Collect all currently selected values
  var selectedVals = [];
  $(".attr-name-select").each(function () {
    if ($(this).val()) {
      selectedVals.push($(this).val());
    }
  });

  // Loop through all selects
  $(".attr-name-select").each(function () {
    var currentVal = $(this).val();
    // Loop through all options in this select
    $(this).find("option").each(function () {
      var optVal = $(this).val();
      if (optVal) {
        // Hide if it's selected in another row, show otherwise
        if (selectedVals.includes(optVal) && optVal !== currentVal) {
          $(this).hide();
        } else {
          $(this).show();
        }
      }
    });
  });
}

$(document).on("change", ".attr-name-select", function () {
  updateAttributeDropdowns();
});

$("#add_attribute_btn").on("click", function () {
  var optionsHtml = '<option value="">Select Attribute</option>';
  if (typeof master_attributes !== 'undefined') {
    master_attributes.forEach(function (ma) {
      optionsHtml += `<option value="${ma.attribute_name}">${ma.attribute_name}</option>`;
    });
  }

  var row = `
        <div class="attribute-row d-flex align-items-center gap-3 mb-3 p-3 rounded-3" style="background:#f8f8ff; border:1px solid #ebe9fe;">
            <div class="flex-fill">
                <select name="attr_name[]" class="form-select attr-name-select select2" style="border-color:#ddd;">
                    ${optionsHtml}
                </select>
            </div>
            <div class="flex-fill">
                <input type="text" name="attr_value[]" class="form-control select2" placeholder="e.g. 16GB, 256GB" style="border-color:#ddd;">
            </div>
            <div class="flex-shrink-0">
                <button type="button" class="remove-attr-btn d-flex align-items-center justify-content-center" title="Remove row"
                    style="width:34px;height:34px;border-radius:8px;border:1px solid #ffcdd2;background:#fff5f5;color:#ea5455;cursor:pointer;transition:all .2s;">
                    <i class="ti ti-trash" style="font-size:16px;"></i>
                </button>
            </div>
        </div>`;
  $("#attributes_container").append(row);
  updateAttributeDropdowns();
});

$(document).on("click", ".remove-attr-btn", function () {
  $(this).closest(".attribute-row").remove();
  updateAttributeDropdowns();
});

// Run on init
updateAttributeDropdowns();

// ─── Multi-Image Upload & Preview ───────────────────────────────────────────
var dt = new DataTransfer();

function updatePrimaryBadges() {
  var container = $("#multiImagePreviewContainer");
  container.find(".primary-badge").addClass("d-none");
  container.find(".img-preview-card").first().find(".primary-badge").removeClass("d-none");
  // Give first card the primary border via class
  container.find(".img-preview-card").attr("data-is-primary", "0");
  container.find(".img-preview-card").first().attr("data-is-primary", "1");
}

var MAX_IMAGES = 5;

$("#multiImageInput").on("change", function (e) {
  var files = e.target.files;
  var container = $("#multiImagePreviewContainer");

  // Count current images (existing + new)
  var currentCount = container.find(".img-preview-card").length;
  var allowed = MAX_IMAGES - currentCount;

  if (files.length > allowed) {
    toaster("warning", "You can upload a maximum of " + MAX_IMAGES + " images. Only " + (allowed > 0 ? allowed : 0) + " slot(s) remaining.");
    if (allowed <= 0) {
      this.value = "";
      return;
    }
  }

  var addedCount = 0;
  for (var i = 0; i < files.length; i++) {
    if (addedCount >= allowed) break;
    var file = files[i];
    if (!file.type.match("image.*")) continue;

    dt.items.add(file);
    addedCount++;

    (function (fileIndex, theFile) {
      var reader = new FileReader();
      reader.onload = function (ev) {
        var card = $(`
                    <div class="img-preview-card new-image-preview" data-index="${fileIndex}" data-is-primary="0">
                        <img src="${ev.target.result}" class="img-thumb" title="${escape(theFile.name)}">
                        <span class="primary-badge d-none">&#9733; Primary</span>
                        <button type="button" class="img-remove-btn remove-new-btn" title="Remove">&times;</button>
                    </div>`);
        container.append(card);
        updatePrimaryBadges();
      };
      reader.readAsDataURL(theFile);
    })(dt.items.length - 1, file);
  }
  // Sync file input
  e.target.files = dt.files;
});

// Remove new image
$(document).on("click", ".remove-new-btn", function () {
  var card = $(this).closest(".new-image-preview");
  var index = parseInt(card.data("index"));

  var newDt = new DataTransfer();
  for (var i = 0; i < dt.files.length; i++) {
    if (i !== index) newDt.items.add(dt.files[i]);
  }
  dt = newDt;
  $("#multiImageInput")[0].files = dt.files;

  card.nextAll(".new-image-preview").each(function () {
    $(this).data("index", parseInt($(this).data("index")) - 1);
  });

  card.remove();
  updatePrimaryBadges();
});

// Remove existing image
$(document).on("click", ".remove-existing-btn", function () {
  var card = $(this).closest(".existing-image-preview");
  var isPrimary = card.data("is-primary");
  var imageName = card.data("image-name") || "";

  var hidden = `<input type="hidden" name="removed_existing_images[]" value="${imageName}">`;
  if (isPrimary == "1") {
    hidden += `<input type="hidden" name="removed_primary_image" value="1">`;
  }
  $("#removedExistingImagesContainer").append(hidden);

  card.remove();
  updatePrimaryBadges();
});

// Init badges on page load (edit mode)
updatePrimaryBadges();
