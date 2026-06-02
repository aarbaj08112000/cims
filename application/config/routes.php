<?php
defined('BASEPATH') or exit('No direct script access allowed');

#------------ Login -----------------------------
$route['default_controller'] = 'auth/login/index';
/* login & forgot password */
$route['login'] = 'auth/login/index';
$route['forgot_password/(:any)/(:any)'] = 'auth/login/forgot_password/$1/$2';
$route['logout'] = 'auth/login/logout';

/* admin */
$route['sitemap'] = 'auth/login/site_map';
$route['user_list'] = 'user/user/user_list';
$route['group_master'] = 'user/user/groupMaster';
$route['group_menu'] = 'user/user/groupMenu';

$route['product'] = 'product/product/product';
$route['add_product'] = 'product/product/add_product';
$route['save_product_data'] = 'product/product/save_product_data';
$route['update_product_data'] = 'product/product/update_product_data';
$route['delete_product_data'] = 'product/product/delete_product_data';
$route['delete_product_image'] = 'product/product/delete_product_image';
$route['update_product/(:any)'] = 'product/product/add_product/$1';
$route['product_details/(:any)'] = 'product/product/product_details/$1';
$route['regenerate_barcode'] = 'product/product/regenerate_barcode';
$route['update_stock'] = 'product/product/update_stock';

$route['company'] = 'company/company/company';
$route['add_company'] = 'company/company/add_company';
$route['edit_company/(:num)'] = 'company/company/add_company/$1';
$route['save_company_data'] = 'company/company/save_company_data';
$route['update_company_data'] = 'company/company/update_company_data';
$route['delete_company_data'] = 'company/company/delete_company_data';

$route['customer'] = 'customer/customer/customer';
$route['add_customer'] = 'customer/customer/add_customer';
$route['save_customer_data'] = 'customer/customer/save_customer_data';
$route['update_customer_data'] = 'customer/customer/update_customer_data';
$route['update_customer/(:any)'] = 'customer/customer/add_customer/$1';
$route['customer_detail/(:any)'] = 'customer/customer/customer_detail/$1';
$route['customer_invoice/(:any)'] = 'customer/customer/customer_invoice/$1';
$route['download_invoice/(:any)/(:any)'] = 'customer/customer/download_invoice/$1/$1';
$route['delete_customer_data'] = 'customer/customer/delete_customer_data';
$route['get_product_payment_html'] = 'customer/customer/get_product_payment_html';
$route['save_product_payment'] = 'customer/customer/save_product_payment';


$route['category'] = 'category/category/category';
$route['get_categories_ajax'] = 'category/category/get_categories_ajax';
$route['delete_category'] = 'category/category/delete_category';
$route['update_categories'] = 'category/category/update_categories';
$route['add_categories'] = 'category/category/add_categories';

$route['brand'] = 'brand/brand/brand';
$route['get_brands_ajax'] = 'brand/brand/get_brands_ajax';
$route['delete_brand'] = 'brand/brand/delete_brand';
$route['update_brands'] = 'brand/brand/update_brands';
$route['add_brand'] = 'brand/brand/add_brand';

$route['dashboard'] = 'dashboard/dashboard/index';
$route['get_product_for_print'] = 'product/product/get_product_for_print';

$route['supplier'] = 'supplier/supplier/index';
$route['add_supplier'] = 'supplier/supplier/add_supplier';
$route['update_supplier'] = 'supplier/supplier/update_supplier';
$route['delete_supplier'] = 'supplier/supplier/delete_supplier';

$route['create_purchase'] = 'purchase/purchase/create_purchase';
$route['save_purchase'] = 'purchase/purchase/save_purchase';
$route['purchase_list'] = 'purchase/purchase/index';
$route['purchase_details/(:num)'] = 'purchase/purchase/purchase_details/$1';
$route['get_purchase_details_ajax'] = 'purchase/purchase/get_purchase_details_ajax';

$route['purchase_return_list'] = 'purchase/purchase_return/index';
$route['purchase_return'] = 'purchase/purchase_return/index';
$route['create_purchase_return'] = 'purchase/purchase_return/create_return';
$route['save_purchase_return'] = 'purchase/purchase_return/save_return';
$route['get_purchase_items_for_return'] = 'purchase/purchase_return/get_purchase_items_for_return';
$route['return_details_ajax'] = 'purchase/purchase_return/return_details_ajax';

$route['sales_list'] = 'sales/sales/index';
$route['sales'] = 'sales/sales/index';
$route['create_sale'] = 'sales/sales/create_sale';
$route['save_sale'] = 'sales/sales/save_sale';
$route['sales_details_ajax'] = 'sales/Sales/sales_details_ajax';

// POS Billing Routes
$route['pos'] = 'sales/Pos/index';
$route['save_pos_bill'] = 'sales/Pos/save_bill';
$route['pos_product_search'] = 'sales/Pos/search_products_ajax';
$route['pos_get_product'] = 'sales/Pos/get_product_ajax';

// Sales Return Routes
$route['sales_return'] = 'sales/Sales_return/index';
$route['sales_return_list'] = 'sales/Sales_return/index';
$route['create_sales_return'] = 'sales/Sales_return/create_sales_return';
$route['create_sales_return/(:num)'] = 'sales/Sales_return/create_sales_return/$1';
$route['save_sales_return'] = 'sales/Sales_return/save_sales_return';
$route['get_sale_items_for_return'] = 'sales/Sales_return/get_sale_items_for_return';
$route['sales_return_details_ajax'] = 'sales/Sales_return/return_details_ajax';

// Stock Management Routes
$route['stock'] = 'stock/Stock';
$route['stock_ledger_ajax'] = 'stock/Stock/stock_ledger_ajax';

// Reports Routes
$route['reports'] = 'reports/Reports';
$route['sales_report'] = 'reports/Reports/sales_report';
$route['purchase_report'] = 'reports/Reports/purchase_report';
$route['stock_valuation_report'] = 'reports/Reports/stock_valuation_report';
$route['get_sales_report_ajax'] = 'reports/Reports/get_sales_report_ajax';
$route['get_purchase_report_ajax'] = 'reports/Reports/get_purchase_report_ajax';
$route['get_stock_valuation_ajax'] = 'reports/Reports/get_stock_valuation_ajax';

// Settings Routes
$route['settings'] = 'settings/Settings';
$route['update_settings'] = 'settings/Settings/update_settings';

$route['documentation'] = 'documentation/Documentation';

$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;
