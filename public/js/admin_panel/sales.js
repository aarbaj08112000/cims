$(document).ready(function () {
    salesPage.init();
});

const salesPage = {
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
        $("#addSaleRow").on("click", function () {
            let template = $("#saleRowTemplate").html();
            $("#salesTable tbody").append(template);
            that.initSelect2("#salesTable tbody tr:last-child .select2");
        });

        // Remove Row
        $(document).on("click", ".remove-sale-row", function () {
            if ($("#salesTable tbody tr").length > 1) {
                $(this).closest("tr").remove();
                that.calculateGrandTotal();
            } else {
                toaster("error", "At least one item is required.");
            }
        });

        // Product Selection - Auto Fill Price and Stock
        $(document).on("change", ".product-select", function () {
            let row = $(this).closest("tr");
            let option = $(this).find("option:selected");
            let price = option.data("price") || 0;
            let stock = option.data("stock") || 0;

            row.find(".price-input").val(price);
            row.find(".stock-display").val(stock);
            
            if($(this).val() != "") {
                if(row.find(".qty-input").val() == 0 || row.find(".qty-input").val() == "") {
                    row.find(".qty-input").val(1);
                    row.find(".qty-input").removeClass("is-invalid");
                }
            } else {
                row.find(".qty-input").val(0);
            }

            that.calculateRowTotal(row);
        });

        // Qty/Price Change
        $(document).on("input", ".qty-input, .price-input", function () {
            let row = $(this).closest("tr");
            let qty = parseFloat(row.find(".qty-input").val()) || 0;
            let stock = parseFloat(row.find(".stock-display").val()) || 0;

            if (qty > stock) {
                toaster("warning", "Quantity exceeds available stock!");
                row.find(".qty-input").addClass("is-invalid");
            } else {
                row.find(".qty-input").removeClass("is-invalid");
            }

            that.calculateRowTotal(row);
        });

        // Discount Change
        $(document).on("input", "#discount", function () {
            that.calculateGrandTotal();
        });

        // Form Submit
        $("#salesForm").submit(function (e) {
            e.preventDefault();
            let form = $(this);

            // Basic Validation
            let invalid = false;
            $(".required-input").each(function () {
                if ($(this).val() == "") {
                    $(this).addClass("is-invalid");
                    invalid = true;
                } else {
                    $(this).removeClass("is-invalid");
                }
            });

            // Stock Check
            $(".qty-input").each(function () {
                let row = $(this).closest("tr");
                let qty = parseFloat($(this).val()) || 0;
                let stock = parseFloat(row.find(".stock-display").val()) || 0;
                if (qty > stock) {
                    toaster("error", "Some items exceed available stock.");
                    invalid = true;
                    return false;
                }
            });

            if (invalid) {
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
                        if (response.sales_id) {
                            window.open("sales/print_invoice/" + response.sales_id, "_blank");
                        }
                        setTimeout(function () {
                            window.location.href = "sales_list";
                        }, 1500);
                    } else {
                        toaster("error", response.msg);
                    }
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
        let subTotal = 0;
        $(".total-input").each(function () {
            subTotal += parseFloat($(this).val()) || 0;
        });
        
        let discount = parseFloat($("#discount").val()) || 0;
        
        // Ensure discount doesn't exceed subtotal
        if (discount > subTotal) {
            discount = subTotal;
            $("#discount").val(discount.toFixed(2));
        }

        let grandTotal = subTotal - discount;
        
        $("#sub_total").val(subTotal.toFixed(2));
        $("#grand_total").val(grandTotal.toFixed(2));
    }
}
