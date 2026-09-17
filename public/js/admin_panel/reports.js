$(document).ready(function () {
    if ($("#sales-report-tab").length) {
        reportsPage.init();
    }
});

const reportsPage = {
    init: function () {
        this.loadSalesReport();
        this.bindEvents();
    },
        bindEvents: function () {
        let that = this;

        // Tab Switches
        $('#sales-report-tab').on('click', function () {
            that.loadSalesReport();
        });
        $('#purchase-report-tab').on('click', function () {
            that.loadPurchaseReport();
        });
        $('#stock-report-tab').on('click', function () {
            that.loadStockReport();
        });

        $('#report_month_filter').on('change', function() {
            that.updateMonthlySummary();
            if ($('#navs-sales').hasClass('active')) {
                that.loadSalesReport();
            } else if ($('#navs-purchase').hasClass('active')) {
                that.loadPurchaseReport();
            } else {
                that.loadStockReport();
            }
        });
    },

    updateMonthlySummary: function() {
        let month = $('#report_month_filter').val();
        if (month) {
            let d = new Date(month.split('-')[0], month.split('-')[1] - 1);
            let monthName = d.toLocaleString('default', { month: 'long' }).toLowerCase();
            $('#dynamic-month-name').text(monthName);
        }
        $.ajax({
            type: "POST",
            url: base_url + "get_monthly_summary_ajax",
            data: { month: month },
            dataType: "json",
            success: function(response) {
                if (response.success == 1) {
                    $('#card-sales-total').text(response.sales_total);
                    $('#card-purchase-total').text(response.purchase_total);
                    $('#card-inventory-total').text(response.inventory_total);
                }
            }
        });
    },
            loadSalesReport: function () {
        let month = $('#report_month_filter').val();
        let container = $('#sales-report-container');

        container.html('<div class="text-center py-5"><div class="spinner-border text-primary"></div></div>');

        $.ajax({
            type: "POST",
            url: base_url + "get_sales_report_ajax",
            data: { month: month },
            dataType: "json",
            success: function (response) {
                if (response.success == 1) {
                    container.html(response.html);
                    reportsPage.initDataTable("#salesReportTable", "Sales_Report");
                }
            }
        });
    },
        loadPurchaseReport: function () {
        let month = $('#report_month_filter').val();
        let container = $('#purchase-report-container');

        container.html('<div class="text-center py-5"><div class="spinner-border text-primary"></div></div>');

        $.ajax({
            type: "POST",
            url: base_url + "get_purchase_report_ajax",
            data: { month: month },
            dataType: "json",
            success: function (response) {
                if (response.success == 1) {
                    container.html(response.html);
                    reportsPage.initDataTable("#purchaseReportTable", "Purchase_Report");
                }
            }
        });
    },
    loadStockReport: function () {
        let container = $('#stock-report-container');

        container.html('<div class="text-center py-5"><div class="spinner-border text-primary"></div></div>');

        $.ajax({
            type: "POST",
            url: base_url + "get_stock_valuation_ajax",
            dataType: "json",
            success: function (response) {
                if (response.success == 1) {
                    container.html(response.html);
                    reportsPage.initDataTable("#stockReportTable", "Stock_Valuation_Report");
                }
            }
        });
    },
    initDataTable: function (selector, filename) {
        if ($.fn.DataTable.isDataTable(selector)) {
            $(selector).DataTable().destroy();
        }

        let table = $(selector).DataTable({
            dom: 'Brt<"cat-dt-footer"<"cat-dt-info"i><"cat-dt-controls"<"cat-dt-length"l><"cat-dt-paging"p>>>',
            buttons: [
                {
                    extend: "csv",
                    className: "d-none",
                    filename: filename
                },
                {
                    extend: "pdf",
                    className: "d-none",
                    title: filename.replace(/_/g, " "),
                    filename: filename,
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.styles.tableHeader.fillColor = '#f8f7fa';
                        doc.styles.tableHeader.color = '#333333';
                    },
                },
            ],
            language: {
                emptyTable: '<div class="cat-empty text-center">No reports found.</div>',
                zeroRecords: '<div class="cat-empty text-center">No records match your search.</div>',
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
            order: [],
            pagingType: "full_numbers",
            autoWidth: false
        });

        // Ensure perfect alignment of headers and columns after rendering
        setTimeout(function() {
            table.columns.adjust().draw();
        }, 150);
    }
}

