var table = '';
var file_name = "users";
var pdf_title = "Users";
var accessGroupsModel = new bootstrap.Modal(document.getElementById('accessGroups'))
$(document).ready(function () {
    grid.setDefaultView(module_name);
    user_app.init();

});


const user_app = {
    init: function () {
        this.formInit();
        this.dataTableInit();
    },
    dataTableInit: function () {

        // Initialize the DataTable
        table = $("#erp_users").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: file_name,
                    exportOptions: {
                        columns: [0, 1, 3, 4] // Full Name, Email, Role, Status (no Password, no Action)
                    }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    title: pdf_title,
                    filename: file_name,
                    exportOptions: {
                        columns: [0, 1, 3, 4] // Full Name, Email, Role, Status (no Password, no Action)
                    },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];

                        if (doc.content[0]) {
                            doc.content[0].text = pdf_title.toUpperCase();
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

                            // 4 cols: Full Name, Email, Role, Status
                            doc.content[3].table.widths = ["28%", "30%", "20%", "22%"];

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
                                    var textColor = '#0f5132';
                                    if (statusText.toLowerCase() === 'inactive') {
                                        textColor = '#842029';
                                    }
                                    row[statusColIdx] = {
                                        text: '   ' + statusText + '   ',
                                        color: textColor,
                                        bold: true,
                                        alignment: 'center',
                                        margin: [0, 5, 0, 5],
                                        fillColor: '#ffffff'
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
                    },
                },
            ],
            language: {
                emptyTable: '<div class="cat-empty">No users found.</div>',
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
            scrollX: true,
            scrollY: true,
            bScrollCollapse: true,
            pagingType: "full_numbers",
            initComplete: function () {
                this.api().columns.adjust();
            },
            "preDrawCallback": function (settings) {
                var start = settings._iDisplayStart;
                var end = settings.fnDisplayEnd();

                var pageData = settings.aoData.slice(start, end);
                var html = grid.gridStructure(module_name, pageData, no_data_message);
                $(".dataTables_wrapper .grid-block").remove();
                var view_type = $(".toggle-grid-btn .grid").hasClass("active") ? "Grid" : "Table";
                var grid_enable = !$(".toggle-grid-btn .grid").hasClass("active") ? "hide-grid-table" : "";
                $(".dataTables_wrapper .dataTables_scroll").after("<div class='grid-block " + grid_enable + "'>" + html + "</div>");
                if (view_type == "Grid") {
                    $(".dataTables_scroll").addClass("hide-grid-table");
                    $("body").addClass("grid-layout");
                }
            }
        });

        var searchTimer;
        $('#search-filter-input').on('keyup input', function () {
            var val = this.value;
            clearTimeout(searchTimer);
            searchTimer = setTimeout(function () {
                table.search(val).draw();
            }, 350);
        });

        setTimeout(function () {
            $(".dataTables_length select").select2({
                minimumResultsForSearch: Infinity
            });
            $(".select2-multiple").select2();
        }, 200);
    },
    formInit: function () {
        let that = this;
        $("#addTransporterForm").validate({
            rules: {
                user_name: {
                    required: true,
                    minlength: 3
                },
                user_email: {
                    required: true,
                    email: true
                },
                user_password: {
                    required: true,
                    minlength: 6
                },
                user_role: {
                    required: true
                },
                // 'groups[]': {
                //     required: true
                // }
            },
            messages: {
                user_name: {
                    required: "Please enter the user full name",
                    minlength: "The name must be at least 3 characters long"
                },
                user_email: {
                    required: "Please enter the user email",
                    email: "Please enter a valid email address"
                },
                user_password: {
                    required: "Please enter the password",
                    minlength: "The password must be at least 6 characters long"
                },
                user_role: {
                    required: "Please select a role"
                },
                // 'groups[]': {
                //     required: "Please select groups"
                // }
            },
            errorPlacement: function (error, element) {
                if (element.context.type == 'checkbox') {
                    $(element).parents(".form-group").find(".row").after(error)
                } else {
                    error.insertAfter(element);
                }
            },
            submitHandler: function (form) {
                // Perform AJAX form submission
                $.ajax({
                    url: $(form).attr('action'),
                    type: 'POST',
                    data: $(form).serialize(),
                    success: function (response) {
                        // Handle successful response
                        if (response != '' && response != null && typeof response != 'undefined') {
                            let res = JSON.parse(response);
                            if (res['success'] == 1) {
                                toaster("success", res['msg']);
                                setTimeout(() => {
                                    $('#addPromo').modal('hide');
                                    // Optionally, refresh the table or perform other actions
                                    window.location.reload();
                                }, 1000);
                            } else {
                                toaster("error", res['msg']);
                            }
                        }
                    },
                    error: function (xhr, status, error) {
                        // Handle errors
                        console.error('Form submission failed:', error);
                    }
                });
            }
        });

        $(".update_users_data").submit(function (e) {
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
                    var msg = responseObject.messages;
                    var success = responseObject.success;
                    if (success == 1) {
                        toaster("success", msg);
                        $(this).parents(".modal").modal("hide")
                        setTimeout(function () {
                            window.location.reload();
                        }, 2000);

                    } else {
                        toaster("error", msg);
                    }
                },
                error: function (error) {
                    console.error("Error:", error);
                },
            });
        });

        $(".page-access-btn").on("click", function () {
            var groups = $(this).parents("form").find(".select2-multiple").val();
            groups = groups != null && groups != undefined ? groups : [];

            if (groups.length > 0) {
                accessGroupsModel.show();
                $(".modal-backdrop").eq(1).css("z-index", '1090');
                $("#accessGroups").css("z-index", '1091');
                $.ajax({
                    url: base_url + 'welcome/get_access_page',
                    type: 'POST',
                    data: { groups: groups },
                    success: function (response) {
                        if (response) {
                            let res = JSON.parse(response);
                            $("#accessGroups .modal-body .row").html(res.access_html)
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert('An error occurred: ' + errorThrown);
                    }
                });
            } else {
                toastr.error("Please select groups");
            }
        })
    },
    formValidate: function (form_class = '') {
        let flag = false;
        $(".custom-form." + form_class + " .required-input").each(function (index) {
            var value = $(this).val();
            var dataMax = parseFloat($(this).attr('data-max'));
            var dataMin = parseFloat($(this).attr('data-min'));
            if (value == '' || value == null) {
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



        const clients = $('.custom-form.' + form_class + ' input[name="client[]"]:checked').map(function () {
            return $(this).val();
        }).get();

        return flag;
    }
}
