$(document).ready(function () {
    supplierPage.init();

    // Delete Supplier
    $(document).on("click", ".delete_supplier", function () {
        var supplierId = $(this).data("id");

        Swal.fire({
            title: "Are you sure?",
            text: "This supplier will be moved to the trash!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, delete it!"
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "delete_supplier",
                    type: "POST",
                    data: { supplier_id: supplierId },
                    dataType: "json",
                    success: function (response) {
                        if (response.success == 1) {
                            toaster("success", response.msg);
                            setTimeout(function () {
                                location.reload();
                            }, 1000);
                        } else {
                            toaster("error", response.msg);
                        }
                    },
                    error: function () {
                        toaster("error", "Something went wrong.");
                    }
                });
            }
        });
    });
});

var supplierTable = '';
var supplier_file_name = "supplier_list";
var supplier_pdf_title = "Supplier List";

const supplierPage = {
    init: function () {
        this.dataTable();
        this.formInitiate();
        $(".select2").select2();
    },
    dataTable: function () {
        supplierTable = $("#suppliersTable").DataTable({
            dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"rt><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
            buttons: [
                {
                    extend: "csv",
                    text: '<i class="ti ti-file-type-csv"></i>',
                    titleAttr: "Download CSV",
                    filename: supplier_file_name
                },
                {
                    extend: "pdf",
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    titleAttr: "Download Pdf",
                    filename: supplier_file_name,
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = supplier_pdf_title;
                        doc.content[1].table.widths = ["20%", "20%", "20%", "20%", "10%", "10%"];
                    },
                },
            ],
            searching: true,
            pagingType: "full_numbers",
        });

        $('#search-filter-input').on('keyup', function () {
            supplierTable.search(this.value).draw();
        });


    },
    formInitiate: function () {
        let that = this;
        $("#addSupplierForm, .update-supplier-form").submit(function (e) {
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
                    if (response.success == 1) {
                        toaster("success", response.msg);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000);
                    } else {
                        toaster("error", response.msg);
                    }
                },
                error: function (error) {
                    console.error("Error:", error);
                    toaster("error", "An error occurred.");
                },
            });
        });
    },
    formValidate: function (form_id = '') {
        let flag = false;
        $("#" + form_id + " .required-input").each(function () {
            var value = $(this).val();
            if (value == '' || value == null) {
                flag = true;
                $(this).addClass("is-invalid");
                var label = $(this).closest(".form-group").find("label").text().replace("*", "").trim();
                if ($(this).closest(".form-group").find("label.error").length == 0) {
                    var action = $(this).is("select") ? "select" : "enter";
                    $(this).closest(".form-group").append("<label class='error text-danger' style='font-size: 12px;'>Please " + action + " " + label.toLowerCase() + "</label>");
                }
            } else {
                $(this).removeClass("is-invalid");
                $(this).closest(".form-group").find("label.error").remove();
            }
        });
        return flag;
    }
}
