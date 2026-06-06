$(document).ready(function () {
    purchasePage.init();
});

const purchasePage = {
    init: function () {
        this.initSelect2();
        this.bindEvents();
    },
    initSelect2: function (selector = ".select2") {
        $(selector).select2();
    },
    bindEvents: function () {
        let that = this;

        // Add Row
        $("#addRow").click(function () {
            let template = $("#rowTemplate").html();
            $("#purchaseTable tbody").append(template);

            // Re-init select2 for the new row
            that.initSelect2($("#purchaseTable tbody tr:last .select2"));
        });

        // Remove Row
        $(document).on("click", ".remove-row", function () {
            if ($("#purchaseTable tbody tr").length > 1) {
                $(this).closest("tr").remove();
                that.calculateGrandTotal();
            } else {
                toaster("error", "At least one item is required.");
            }
        });

        // Product Selection - Auto-fill price
        $(document).on("change", ".product-select", function () {
            let price = $(this).find(":selected").data("price") || 0;
            $(this).closest("tr").find(".price-input").val(price);
            that.calculateRowTotal($(this).closest("tr"));
        });

        // Qty or Price Change
        $(document).on("input", ".qty-input, .price-input", function () {
            that.calculateRowTotal($(this).closest("tr"));
        });

        // Form Submission
        $("#purchaseForm").submit(function (e) {
            e.preventDefault();
            let form = $(this);
            let id = form.attr("id");

            if (that.formValidate(id)) {
                return;
            }

            let formData = new FormData(form[0]);
            $.ajax({
                type: "POST",
                url: form.attr("action"),
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        toaster("success", response.msg);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1500);
                    } else {
                        toaster("error", response.msg);
                    }
                },
                error: function () {
                    toaster("error", "An error occurred during submission.");
                }
            });
        });
    },
    calculateRowTotal: function (row) {
        let qty = parseFloat(row.find(".qty-input").val()) || 0;
        let price = parseFloat(row.find(".price-input").val()) || 0;
        let total = qty * price;
        row.find(".total-input").val(total.toFixed(2));
        this.calculateGrandTotal();
    },
    calculateGrandTotal: function () {
        let grandTotal = 0;
        $(".total-input").each(function () {
            grandTotal += parseFloat($(this).val()) || 0;
        });
        $("#grand_total").val(grandTotal.toFixed(2));
    },
    formValidate: function (form_id) {
        let flag = false;
        $("#" + form_id + " .required-input").each(function () {
            var value = $(this).val();
            if (value == '' || value == null) {
                flag = true;
                $(this).addClass("is-invalid");
                if ($(this).closest(".form-group, td").find("label.error").length == 0) {
                    $(this).after("<label class='error text-danger' style='font-size: 11px; display: block;'>Required</label>");
                }
            } else {
                $(this).removeClass("is-invalid");
                $(this).closest(".form-group, td").find("label.error").remove();
            }
        });
        return flag;
    }
}
