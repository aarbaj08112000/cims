# Table Usage Report (Module-wise)

This document provides a comprehensive list of all pages in the CIMS project where tables are used, detailing whether DataTables is implemented and its processing type.

**Note:** Based on the codebase analysis, all DataTables implementations in the project use **Client-side processing**. There is no `serverSide: true` configuration found in the `public/js` directory.

---

## Module: Banner

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `banner.tpl` | `banner` | Yes | Client-side | Initialized in `banner.js` |

---

## Module: Brand

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `brands.tpl` | `brandsTable` | Yes | Client-side | Initialized in `brands.js` |

---

## Module: Category

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `categories.tpl` | `categoriesTable` | Yes | Client-side | Initialized in `categories.js` |

---

## Module: Company

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `company.tpl` | `companyListTable` | No | N/A | Standard HTML table |

---

## Module: Customer

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `customer.tpl` | `customerListTable` | No | N/A | Standard HTML table |
| `customer_invoice.tpl` | `product_list` | Yes | Client-side | Initialized in `product_list.js` |
| `customer_detail.tpl` | No ID | No | N/A | Standard HTML table |

---

## Module: Dashboard

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `dashboard.tpl` | No ID | No | N/A | Standard HTML table |

---

## Module: Documentation

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `user_guide.tpl` | No ID | No | N/A | Standard HTML table |

---

## Module: Product

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `product_list.tpl` | `product_list` | Yes | Client-side | Initialized in `product_list.js` |

---

## Module: Purchase

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `purchase_list.tpl` | `purchaseListTable` | Yes | Client-side | Initialized in `purchase_list.js` |
| `purchase_return_list.tpl`| `returnListTable` | Yes | Client-side | Initialized in `purchase_return.js` |
| `create_purchase.tpl` | `purchaseTable` | No | N/A | Standard HTML table |
| `create_purchase_return.tpl`| `returnTable` | No | N/A | Standard HTML table |
| `purchase_details.tpl` | No ID | No | N/A | Standard HTML table |
| `purchase_details_modal.tpl`| No ID | No | N/A | Standard HTML table (Modal) |
| `purchase_return_details_modal.tpl`| No ID | No | N/A | Standard HTML table (Modal) |

---

## Module: Reports

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `sales_report_table.tpl` | `salesReportTable` | Yes | Client-side | Initialized dynamically in `reports.js` |
| `purchase_report_table.tpl`| `purchaseReportTable`| Yes | Client-side | Initialized dynamically in `reports.js` |
| `stock_valuation_table.tpl`| `stockReportTable` | Yes | Client-side | Initialized dynamically in `reports.js` |
| `stock_valuation_report.tpl`| `stockValuationTable`| Yes | Client-side | Initialized in `stock_valuation_report.js` |
| `sales_report.tpl` | `salesReportTable` | No | N/A | Wrapper page containing the table component |
| `purchase_report.tpl` | `purchaseReportTable`| No | N/A | Wrapper page containing the table component |

---

## Module: Sales

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `sales_list.tpl` | `salesListTable` | Yes | Client-side | Initialized in `sales_list.js` |
| `sales_return_list.tpl` | `returnListTable` | Yes | Client-side | Initialized in `sales_return.js` (Fixed in previous session) |
| `create_sale.tpl` | `salesTable` | No | N/A | Standard HTML table for item entry |
| `create_sales_return.tpl` | `returnItemsTable` | No | N/A | Standard HTML table for return entry |
| `pos_billing.tpl` | `pos_table` | No | N/A | Standard HTML table for POS |
| `sales_details_modal.tpl` | No ID | No | N/A | Standard HTML table (Modal) |
| `sales_return_details_modal.tpl`| No ID | No | N/A | Standard HTML table (Modal) |
| `pos_bill_print.tpl` | No ID | No | N/A | Standard HTML table for printing |

---

## Module: Stock

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `stock_list.tpl` | `stockListTable` | Yes | Client-side | Initialized in `stock.js` |
| `stock_ledger_modal.tpl` | No ID | No | N/A | Standard HTML table (Modal) |

---

## Module: Supplier

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `suppliers.tpl` | `suppliersTable` | Yes | Client-side | Initialized in `suppliers.js` |

---

## Module: User

| URL / Page Name | Table Name / ID | DataTables Implemented | DataTable Type | Remarks / Notes |
| :--- | :--- | :--- | :--- | :--- |
| `group_master.tpl` | `process` | Yes | Client-side | Initialized in `process.js` |
| `user_details.tpl` | `erp_users` | Yes | Client-side | Initialized in `user_list.js` |
