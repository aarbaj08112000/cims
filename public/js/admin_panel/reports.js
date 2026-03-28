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

        // Filters
        $('#filter-sales-btn').on('click', function () {
            that.loadSalesReport();
        });
        $('#filter-purchase-btn').on('click', function () {
            that.loadPurchaseReport();
        });
        $('#refresh-stock-btn').on('click', function () {
            that.loadStockReport();
        });
    },
    loadSalesReport: function () {
        let from_date = $('#sales_from_date').val();
        let to_date = $('#sales_to_date').val();
        let container = $('#sales-report-container');

        container.html('<div class="text-center py-5"><div class="spinner-border text-primary"></div></div>');

        $.ajax({
            type: "POST",
            url: base_url + "get_sales_report_ajax",
            data: { from_date: from_date, to_date: to_date },
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
        let from_date = $('#purchase_from_date').val();
        let to_date = $('#purchase_to_date').val();
        let container = $('#purchase-report-container');

        container.html('<div class="text-center py-5"><div class="spinner-border text-primary"></div></div>');

        $.ajax({
            type: "POST",
            url: base_url + "get_purchase_report_ajax",
            data: { from_date: from_date, to_date: to_date },
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

        $(selector).DataTable({
            dom: '<"row align-items-center mb-2"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6 text-end"f>><"dt-scroll-body-wrapper"<"col-sm-12"rt>><"dt-fixed-footer row align-items-center pt-3 mt-1 border-top"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7 d-flex align-items-center justify-content-end gap-2"pl>>',
            buttons: [
                {
                    extend: "csv",
                    text: '<i class="ti ti-file-type-csv"></i>',
                    titleAttr: "Download CSV",
                    filename: filename
                },
                {
                    extend: "pdf",
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    titleAttr: "Download Pdf",
                    filename: filename,
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = filename.replace(/_/g, " ");
                        doc.styles.tableHeader.fontSize = 10;
                    },
                },
            ],
            searching: true,
            order: [],
            pagingType: "full_numbers",
        });
    }
}
