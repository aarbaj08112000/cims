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
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: supplier_file_name,
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4]
                    }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: supplier_file_name,
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4]
                    },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];
                        
                        if (doc.content[0]) {
                            doc.content[0].text = supplier_pdf_title.toUpperCase();
                            doc.content[0].color = '#5b5fc7';
                            doc.content[0].fontSize = 20;
                            doc.content[0].bold = true;
                            doc.content[0].alignment = 'center';
                            doc.content[0].margin = [0, 0, 0, 5];
                        }

                        var now = new Date();
                        var dateStr = now.getDate() + ' ' + now.toLocaleString('default', { month: 'short' }) + ' ' + now.getFullYear();
                        
                        doc.content.splice(1, 0, {
                            text: 'Generated on: ' + dateStr,
                            color: '#888888',
                            fontSize: 10,
                            alignment: 'center',
                            margin: [0, 0, 0, 15]
                        });
                        
                        doc.content.splice(2, 0, {
                            canvas: [
                                {
                                    type: 'line',
                                    x1: 0, y1: 0,
                                    x2: 515, y2: 0,
                                    lineWidth: 2,
                                    lineColor: '#5b5fc7'
                                }
                            ],
                            margin: [0, 0, 0, 20]
                        });

                        if (doc.content[3] && doc.content[3].table && doc.content[3].table.body) {
                            var tableBody = doc.content[3].table.body;
                            
                            var colCount = tableBody[0].length;
                            var widths = [];
                            for (var j = 0; j < colCount; j++) { widths.push((100 / colCount) + '%'); }
                            doc.content[3].table.widths = widths; 
                            
                            var tableHeader = tableBody[0];
                            for (var i = 0; i < tableHeader.length; i++) {
                                tableHeader[i].fillColor = '#eef0f2';
                                tableHeader[i].color = '#333333';
                                tableHeader[i].bold = true;
                                tableHeader[i].margin = [5, 5, 5, 5];
                                if (i === tableHeader.length - 1) {
                                    tableHeader[i].alignment = 'center';
                                }
                            }

                            for (var r = 1; r < tableBody.length; r++) {
                                var row = tableBody[r];
                                var statusColIdx = row.length - 1; 
                                if (row[statusColIdx] && row[statusColIdx].text) {
                                    var statusText = row[statusColIdx].text.trim();
                                    var bgColor = '#ffffff';
                                    var textColor = '#0f5132'; 
                                    
                                    if (statusText.toLowerCase() === 'inactive') {
                                        bgColor = '#ffffff';
                                        textColor = '#842029'; 
                                    }

                                    row[statusColIdx] = {
                                        text: '   ' + statusText + '   ',
                                        background: bgColor,
                                        color: textColor,
                                        bold: true,
                                        alignment: 'center',
                                        margin: [0, 5, 0, 5]
                                    };
                                }
                                
                                for (var c = 0; c < row.length; c++) {
                                    if (row[c]) {
                                        row[c].fillColor = '#ffffff';
                                    }
                                    if (c !== statusColIdx && row[c] && row[c].text) {
                                        row[c].margin = [5, 5, 5, 5];
                                    }
                                }
                            }
                            
                            doc.content[3].layout = {
                                hLineWidth: function (i, node) { return 1; },
                                vLineWidth: function (i, node) { return 1; },
                                hLineColor: function (i, node) { return '#dee2e6'; },
                                vLineColor: function (i, node) { return '#dee2e6'; },
                                fillColor: function (rowIndex, node, columnIndex) {
                                    return '#ffffff';
                                }
                            };
                        }
                    }
                },
            ],
            searching: true,
            pagingType: "full_numbers",
            language: {
                processing: '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
                emptyTable: '<div class="cat-empty">No suppliers found.</div>',
                zeroRecords: '<div class="cat-empty">No records match your search.</div>',
                info: 'Showing _START_ to _END_ of _TOTAL_ entries',
                infoEmpty: 'Showing 0 to 0 of 0 entries',
                infoFiltered: '(filtered from _MAX_ total)',
                lengthMenu: 'Show _MENU_ entries',
                paginate: {
                    first: '<i class="ti ti-chevrons-left"></i>',
                    last: '<i class="ti ti-chevrons-right"></i>',
                    next: '<i class="ti ti-chevron-right"></i>',
                    previous: '<i class="ti ti-chevron-left"></i>'
                }
            },
        });

        $('#search-filter-input').on('keyup input', function () {
            supplierTable.search(this.value).draw();
        });

        $('#export-csv').on('click', function () {
            supplierTable.button('.buttons-csv').trigger();
        });

        $('#export-pdf').on('click', function () {
            supplierTable.button('.buttons-pdf').trigger();
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
