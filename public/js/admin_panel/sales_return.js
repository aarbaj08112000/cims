$(document).ready(function () {
    if ($("#returnListTable").length) {
        salesReturnPage.initList();
    }
    if ($("#salesReturnForm").length) {
        salesReturnPage.initCreate();
    }
});

var returnListTable = '';
var return_file_name = "sales_return_history";
var return_pdf_title = "Sales Return History Report";

const salesReturnPage = {
    initList: function () {
        this.dataTable();
        this.bindListEvents();
    },
    initCreate: function () {
        this.initSelect2();
        this.bindCreateEvents();
    },
    initSelect2: function (selector = ".select2") {
        $(selector).select2({
            width: '100%'
        });
    },
    bindListEvents: function () {
        let that = this;
        $(document).on("click", ".view-return-details", function () {
            let return_id = $(this).data("id");
            $.ajax({
                type: "POST",
                url: base_url + "sales_return_details_ajax",
                data: { return_id: return_id },
                dataType: "json",
                success: function (response) {
                    if (response.success == 1) {
                        $("#return-modal-content").html(response.html);
                        $("#returnDetailModal").modal("show");
                    }
                }
            });
        });
    },
    bindCreateEvents: function () {
        let that = this;

        // Change Bill - Load Items
        $("#sales_id").on("change", function () {
            let sales_id = $(this).val();
            if (sales_id) {
                $.ajax({
                    type: "POST",
                    url: base_url + "get_sale_items_for_return",
                    data: { sales_id: sales_id },
                    dataType: "json",
                    success: function (response) {
                        if (response.success == 1) {
                            that.renderReturnItems(response.items);
                            if (response.sale) {
                                let customer = response.sale.customer_mobile || response.sale.customer_phone_number || 'Walk-in';
                                $("#billCustomer").text(customer);
                                $("#billDate").text(response.sale.sales_date);
                                $("#billAmount").text(parseFloat(response.sale.payable_amount || 0).toLocaleString("en-IN", {minimumFractionDigits: 2}));
                                $("#billItems").text(response.items.length);
                                $("#billInfoPanel").fadeIn(300);
                            }
                            $("#returnItemsCard").fadeIn(300);
                        } else {
                            $("#returnItemsTable tbody").html('<tr><td colspan="7" class="text-center text-danger">' + response.msg + '</td></tr>');
                            that.calculateGrandTotal();
                            $("#returnItemsCard").fadeIn(300);
                            $("#billInfoPanel").hide();
                        }
                    }
                });
            } else {
                $("#returnItemsTable tbody").html(`
                    <tr class="empty-state-row">
                        <td colspan="7">
                            <div class="empty-state">
                                <div class="empty-state-icon"><i class="ti ti-receipt-off"></i></div>
                                <span class="empty-state-text">No items to display</span>
                                <span class="empty-state-sub">Select an original sales bill above to load returnable items</span>
                            </div>
                        </td>
                    </tr>
                `);
                that.calculateGrandTotal();
                $("#returnItemsCard").hide();
                $("#billInfoPanel").hide();
            }
        });

        $(document).on("click", ".remove-return-row", function () {
            $(this).closest("tr").remove();
            that.calculateGrandTotal();
        });

        // Quantity Change
        $(document).on("input", ".return-qty", function () {
            let row = $(this).closest("tr");
            let qty = parseFloat($(this).val()) || 0;
            let available = parseFloat(row.find(".available-qty").text()) || 0;

            if (qty > available) {
                toaster("warning", "Return quantity cannot exceed available quantity!");
                $(this).val(available);
                qty = available;
            }

            let price = parseFloat(row.find(".price-text").val()) || 0;
            let total = qty * price;
            row.find(".row-total").val(total.toLocaleString("en-IN", {minimumFractionDigits: 2, maximumFractionDigits: 2}));
            that.calculateGrandTotal();
        });

        // Form Submit
        $("#salesReturnForm").submit(function (e) {
            e.preventDefault();
            let form = $(this);
            let invalid = false;

            $(".required-input").each(function () {
                if ($(this).val() == "") {
                    $(this).addClass("is-invalid");
                    invalid = true;
                } else {
                    $(this).removeClass("is-invalid");
                }
            });

            if (invalid) {
                toaster("error", "Please fill all required fields.");
                return;
            }

            let totalItems = 0;
            $(".return-qty").each(function () {
                totalItems += parseFloat($(this).val()) || 0;
            });

            if (totalItems <= 0) {
                toaster("error", "Please specify return quantity for at least one item.");
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
                            if (response.return_id) {
                                window.location.href = base_url + "sales_return_details/" + response.return_id;
                            } else {
                                window.location.href = base_url + "sales_return_list";
                            }
                        }, 1500);
                    } else {
                        toaster("error", response.msg);
                    }
                }
            });
        });
    },
    renderReturnItems: function (items) {
        let html = "";
        items.forEach(function (item) {
            html += `<tr>
                <td>
                    <strong>${item.product_name}</strong>
                    ${item.brand_name ? `<span style="color: grey; font-size: 0.85em;"> - ${item.brand_name}</span>` : ''}
                    <br>
                    <small class="text-muted">${item.product_code}</small>
                    <input type="hidden" name="product_id[]" value="${item.product_id}">
                </td>
                <td class="text-center">${item.qty}</td>
                <td class="text-center">${item.qty - item.available_qty}</td>
                <td class="text-center available-qty fw-bold text-primary">${item.available_qty}</td>
                <td>
                    <input type="text" name="return_qty[]" class="form-control return-qty onlyNumericInput text-center" value="0">
                </td>
                <td class="text-end">
                    ${item.currency_symbol || ''} ${parseFloat(item.sale_price).toLocaleString("en-IN", {minimumFractionDigits: 2, maximumFractionDigits: 2})}
                    <input type="hidden" name="price[]" class="price-text" value="${item.sale_price}">
                </td>
                <td class="text-end">
                    <div class="input-group"><span class="input-group-text">${item.currency_symbol || ''}</span><input type="text" name="total[]" class="form-control row-total text-end bg-light fw-bold" value="0.00" readonly></div>
                </td>
                <td class="text-center">
                    <button type="button" class="text-danger bg-transparent border-0 fs-4 remove-return-row" title="Remove"><i class="ti ti-trash"></i></button>
                </td>
            </tr>`;
        });
        
        if (items.length === 0) {
            html = `<tr class="empty-state-row">
                        <td colspan="7">
                            <div class="empty-state">
                                <div class="empty-state-icon"><i class="ti ti-alert-circle text-danger"></i></div>
                                <span class="empty-state-text text-danger">All items have been fully returned for this bill.</span>
                            </div>
                        </td>
                    </tr>`;
        }
        
        $("#returnItemsTable tbody").html(html);
        
        // Update stats
        $("#totalItemsCount").text(items.length);
        $("#returningCount").text('0');
        
        this.calculateGrandTotal();
    },
    calculateGrandTotal: function () {
        let grandTotal = 0;
        let returningCount = 0;
        
        $(".row-total").each(function () {
            grandTotal += parseFloat(String($(this).val()).replace(/,/g, '')) || 0;
        });
        
        $(".return-qty").each(function () {
            let val = parseFloat($(this).val()) || 0;
            if (val > 0) returningCount++;
        });
        
        $("#grand_total_display").text(grandTotal.toLocaleString("en-IN", {minimumFractionDigits: 2, maximumFractionDigits: 2}));
        $("#total_return_amount").val(grandTotal.toFixed(2));
        $("#returningCount").text(returningCount);
    },
    dataTable: function () {
        returnListTable = $("#returnListTable").DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "excel",
                    className: "d-none",
                    filename: return_file_name,
                    title: "Sales Return History",
                    exportOptions: { columns: [0, 1, 2, 3, 4] },
          customize: function (xlsx) {
            var sheet  = xlsx.xl.worksheets['sheet1.xml'];
            var styles = xlsx.xl['styles.xml'];

            var themeColor   = '5B5FC7';
            var themeLighter = '9B9ED8';
            var white        = 'FFFFFF';
            var borderColor  = 'C5C5D8';

            var fillsEl = $('fills', styles);
            var fCount  = parseInt(fillsEl.attr('count'));
            fillsEl.append('<fill><patternFill patternType="solid"><fgColor rgb="' + themeLighter + '"/><bgColor indexed="64"/></patternFill></fill>');
            var titleFillId = fCount++;
            fillsEl.append('<fill><patternFill patternType="solid"><fgColor rgb="' + themeColor + '"/><bgColor indexed="64"/></patternFill></fill>');
            var headerFillId = fCount++;
            fillsEl.attr('count', fCount);

            var fontsEl = $('fonts', styles);
            var ftCount = parseInt(fontsEl.attr('count'));
            fontsEl.append('<font><b/><sz val="13"/><color rgb="' + white + '"/><name val="Calibri"/></font>');
            var titleFontId = ftCount++;
            fontsEl.append('<font><b/><sz val="11"/><color rgb="' + white + '"/><name val="Calibri"/></font>');
            var headerFontId = ftCount++;
            fontsEl.attr('count', ftCount);

            var bordersEl = $('borders', styles);
            var bCount    = parseInt(bordersEl.attr('count'));
            var medBorder = '<border><left style="medium"><color rgb="' + borderColor + '"/></left><right style="medium"><color rgb="' + borderColor + '"/></right><top style="medium"><color rgb="' + borderColor + '"/></top><bottom style="medium"><color rgb="' + borderColor + '"/></bottom><diagonal/></border>';
            bordersEl.append(medBorder);
            var dataBorderId = bCount++;
            bordersEl.attr('count', bCount);

            var cellXfsEl = $('cellXfs', styles);
            var xfCount   = parseInt(cellXfsEl.attr('count'));
            cellXfsEl.append('<xf numFmtId="0" fontId="' + titleFontId  + '" fillId="' + titleFillId  + '" borderId="' + dataBorderId + '" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>');
            var titleStyleId = xfCount++;
            cellXfsEl.append('<xf numFmtId="0" fontId="' + headerFontId + '" fillId="' + headerFillId + '" borderId="' + dataBorderId + '" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center"/></xf>');
            var headerStyleId = xfCount++;
            cellXfsEl.append('<xf numFmtId="0" fontId="0" fillId="0" borderId="' + dataBorderId + '" xfId="0" applyBorder="1" applyAlignment="1"><alignment vertical="center"/></xf>');
            var dataStyleId = xfCount++;
            cellXfsEl.attr('count', xfCount);

            var rows = $('row', sheet);
            rows.eq(0).find('c').attr('s', titleStyleId);
            rows.eq(1).find('c').attr('s', headerStyleId);
            rows.each(function (i) { if (i >= 2) { $(this).find('c').attr('s', dataStyleId); } });

            $('sheetData', sheet).after('<mergeCells count="1"><mergeCell ref="A1:E1"/></mergeCells>');
            rows.eq(0).attr({ ht: '28', customHeight: '1' });
            rows.eq(1).attr({ ht: '20', customHeight: '1' });

            $('cols', sheet).remove();
            $('sheetData', sheet).before('<cols><col min="1" max="1" width="15" customWidth="1"/><col min="2" max="2" width="20" customWidth="1"/><col min="3" max="3" width="30" customWidth="1"/><col min="4" max="4" width="20" customWidth="1"/><col min="5" max="5" width="15" customWidth="1"/></cols>');
          }
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    filename: return_file_name,
                    exportOptions: {
                        columns: [0, 1, 2, 3, 4]
                    },
                    customize: function (doc) {
                        doc.pageMargins = [40, 40, 40, 40];
                        
                        if (doc.content[0]) {
                            doc.content[0].text = return_pdf_title.toUpperCase();
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
                            
                            doc.content[3].table.widths = ["15%", "20%", "30%", "20%", "15%"];
                            
                            var tableHeader = tableBody[0];
                            for (var i = 0; i < tableHeader.length; i++) {
                                tableHeader[i].fillColor = '#eef0f2';
                                tableHeader[i].color = '#333333';
                                tableHeader[i].bold = true;
                                tableHeader[i].margin = [5, 5, 5, 5];
                            }

                            for (var r = 1; r < tableBody.length; r++) {
                                var row = tableBody[r];
                                for (var c = 0; c < row.length; c++) {
                                    if (row[c]) {
                                        row[c].fillColor = '#ffffff';
                                        if (row[c].text) {
                                            row[c].margin = [5, 5, 5, 5];
                                        }
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
            order: [[3, "desc"]], // Sort by Date
            pagingType: "full_numbers",
            language: {
                processing:   '<div class="cat-processing"><i class="ti ti-loader-2 cat-spin"></i>&nbsp;Loading...</div>',
                emptyTable:   '<div class="cat-empty text-center">No returns found.</div>',
                zeroRecords:  '<div class="cat-empty text-center">No records match your search.</div>',
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
            returnListTable.search(this.value).draw();
        });

        $('#export-excel').on('click', function () {
            returnListTable.button('.buttons-excel').trigger();
        });

        $('#export-pdf').on('click', function () {
            returnListTable.button('.buttons-pdf').trigger();
        });
    },
}
