<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Api_docs extends Admin_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        // Enforce Super Admin only (Role ID 1)
        if (!$this->admin_data || ($this->admin_data['role_id'] != 1 && $this->admin_data['user_role'] != 1)) {
            show_404();
        }

        $data['title'] = "Dine Master API Reference";
        
        // Define all APIs in a structured array
        $data['apis'] = [
            [
                'category' => 'Auth',
                'name' => 'User Login',
                'url' => '/WS/auth/login',
                'method' => 'POST',
                'params' => [
                    ['name' => 'email', 'type' => 'string', 'description' => 'User email address'],
                    ['name' => 'password', 'type' => 'string', 'description' => 'User password']
                ],
                'description' => 'Authenticates a user and returns a JWT token.',
                'example_response' => '{
    "success": true,
    "message": "Login successful",
    "data": {
        "id": "1",
        "token": "eyJhbG...",
        "name": "John Doe",
        "email": "john@example.com",
        "restaurant_id": "1"
    }
}'
            ],
            [
                'category' => 'Auth',
                'name' => 'User Logout',
                'url' => '/WS/auth/logout',
                'method' => 'POST',
                'params' => [],
                'description' => 'Logs out the user and invalidates the token.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Logged out",
    "data": []
}'
            ],
            [
                'category' => 'Auth',
                'name' => 'Forgot Password',
                'url' => '/WS/user_login/forgot_password',
                'method' => 'POST',
                'params' => [
                    ['name' => 'email', 'type' => 'string', 'description' => 'Registered email address of the user'],
                    ['name' => 'password', 'type' => 'string', 'description' => 'New password to set']
                ],
                'description' => 'Resets the user password. Requires the registered email and the new password.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Password updated successfully.",
    "data": []
}'
            ],
            [
                'category' => 'User',
                'name' => 'Get User Details',
                'url' => '/WS/user_login/get_user_details',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'User ID (Optional, defaults to logged in user)']
                ],
                'description' => 'Fetches detailed information about a user.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "User details fetched successfully",
    "data": {
        "user_id": "1",
        "user_name": "odell44",
        "user_email": "adrienne.schaden@gmail.com",
        "status": "Active",
        "total_orders": 150,
        "today_orders": 5,
        "last_7_days_orders": 25,
        ...
    }
}'
            ],
            [
                'category' => 'Restaurant',
                'name' => 'Get Restaurant Details',
                'url' => '/WS/user_login/get_restaurant_details',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'User ID to fetch associated restaurant details']
                ],
                'description' => 'Fetches details of the restaurant associated with the given user.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Restaurant details fetched successfully",
    "data": {
        "restaurant_id": "1",
        "name": "Thiel, Batz and Labadie",
        "contact_email": "kiarra.gleason@hotmail.com",
        "city": "Lisandrobury",
        ...
    }
}'
            ],
            [
                'category' => 'Tables',
                'name' => 'Table Listing',
                'url' => '/WS/tables',
                'method' => 'GET',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'Restaurant ID to fetch tables for'],
                    ['name' => 'search', 'type' => 'string', 'description' => 'Search by table name or code (Optional)'],
                    ['name' => 'status', 'type' => 'string', 'description' => 'Filter by status: FREE, OCCUPIED, etc. (Optional, only for Super Admin)']
                ],
                'description' => 'Returns a list of tables for a specific restaurant. Regular users only see available (FREE) tables.',
                'example_response' => '{
  "status": true,
  "message": "Table list fetched successfully",
  "data": [
    {
      "table_id": 1,
      "table_code": "T1",
      "table_name": "Table 1",
      "capacity": 4,
      "status": "FREE",
      "restaurant_id": 1
    }
  ]
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'Add Items to Order',
                'url' => '/WS/add_order_items',
                'method' => 'POST',
                'params' => [
                    ['name' => 'order_id', 'type' => 'int', 'description' => 'Required. ID of the existing order'],
                    ['name' => 'items', 'type' => 'array', 'description' => 'Required. Array of items: { item_id, quantity, price }'],
                ],
                'description' => 'Appends new items to an existing order. Validates that order and menu items exist. Auto-recomputes subtotal_amount and total_payable.',
                'example_response' => '{
  "status": true,
  "message": "Items added to order successfully",
  "order_id": 22
}'
            ],
            [
                'category' => 'Menu',
                'name' => 'Get Menu',
                'url' => '/WS/menu_items/get_menu',
                'method' => 'GET',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'Required. ID of the restaurant'],
                    ['name' => 'category_id', 'type' => 'int', 'description' => 'Optional. Filter by category'],
                    ['name' => 'veg_type', 'type' => 'string', 'description' => 'Optional. Filter by VEG/NON_VEG/EGG'],
                    ['name' => 'search_param', 'type' => 'string', 'description' => 'Optional. Search by item name (LIKE search)']
                ],
                'description' => 'Retrieves the menu items for a restaurant.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Menus found successfully.",
    "data": [
        {
            "item_id": "1",
            "item_name": "Paneer Tikka",
            "price": "250.00",
            ...
        }
    ]
}'
            ],
            [
                'category' => 'Menu',
                'name' => 'Get Item Details',
                'url' => '/WS/menu_items/get_item_details',
                'method' => 'GET',
                'params' => [
                    ['name' => 'item_id', 'type' => 'int', 'description' => 'Required. ID of the menu item']
                ],
                'description' => 'Fetches detailed information about a specific menu item.',
                'example_response' => '{
    "success": true,
    "status": true,
    "message": "Item details found successfully.",
    "data": {
        "item_id": "1",
        "item_name": "Paneer Tikka",
        "price": "250.00",
        "description": "Grilled cottage cheese cubes marinated in spices",
        ...
    }
}'
            ],
            [
                'category' => 'Menu',
                'name' => 'Get Categories',
                'url' => '/WS/categories?id={restaurant_id}',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'Required. The unique ID of the restaurant']
                ],
                'description' => 'Fetches all menu categories for a specific restaurant.',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "catagories found successfully."
    },
    "data": [
        {
            "category_id": "1",
            "name": "Starters",
            "category_image": "starters.jpg"
        },
        {
            "category_id": "2",
            "name": "Main Course",
            "category_image": "main.jpg"
        }
    ]
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'gets_orders',
                'url' => '/WS/gets_orders',
                'method' => 'GET',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'Required. Filter orders by restaurant']
                ],
                'description' => 'Retrieves a list of orders for the authenticated user for a specific restaurant.',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "Orders fetched successfully"
    },
    "data": [
        {
            "order_id": "19",
            "restaurant_id": "4",
            "table_id": "60",
            "customer_id": "48",
            "waiter_id": "55",
            "order_type": "DINE_IN",
            "status": "PLACED",
            "placed_at": "2025-09-06 16:46:39",
            "items": [
                {
                    "id": "25",
                    "item_name": "Paneer Tikka",
                    "unit_price": "250.00",
                    "quantity": "2"
                }
            ]
        }
    ]
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'get_order_details',
                'url' => '/WS/get_order_details?id={order_id}',
                'method' => 'GET',
                'params' => [
                    ['name' => 'id', 'type' => 'int', 'description' => 'Required. The unique ID of the order']
                ],
                'description' => 'Fetches detailed information about a specific order, including items and addons.',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "Order details fetched successfully"
    },
    "data": {
        "order_id": "32",
        "order_number": "ODN20260325132431",
        "restaurant_id": "1",
        "table_id": "1",
        "customer_id": null,
        "waiter_id": null,
        "order_type": "DINE_IN",
        "status": "PENDING",
        "placed_at": "2026-03-25 13:24:31",
        "completed_at": null,
        "subtotal_amount": "580.00",
        "discount_amount": "0.00",
        "service_charge_pct": "0.00",
        "service_charge_amt": "0.00",
        "tax_amount": "0.00",
        "rounding_adjustment": "0.00",
        "total_payable": "580.00",
        "tax_breakdown": null,
        "notes": null,
        "payment_status": "UNPAID",
        "is_active": "1",
        "added_by": "1",
        "updated_by": null,
        "added_date": "2026-03-25 13:24:31",
        "updated_date": "2026-03-25 13:24:31",
        "restaurant_name": "Dine Master",
        "items": [
            {
                "order_item_id": "41",
                "order_id": "32",
                "item_id": "1",
                "item_name": "Paneer Tikka",
                "veg_type": "VEG",
                "unit_price": "250.00",
                "quantity": "1.00",
                "notes": null,
                "status": "PENDING",
                "tax_rate": "0.00",
                "tax_breakdown": null,
                "tax_amount": "0.00",
                "line_subtotal": "250.00",
                "line_discount": "0.00",
                "line_total": "250.00",
                "added_by": "1",
                "updated_by": null,
                "added_date": "2026-03-25 13:24:31",
                "updated_date": "2026-03-25 13:24:31",
                "addons": [
                    {
                        "order_item_addon_id": "1",
                        "order_item_id": "41",
                        "addon_option_id": "1",
                        "addon_name": "Extra Cheese",
                        "price": "50.00",
                        "added_date": "2025-09-06 16:46:40"
                    }
                ]
            }
        ]
    }
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'New Order',
                'url' => '/WS/new_orders',
                'method' => 'POST',
                'params' => [
                    ['name' => 'restaurant_id', 'type' => 'int', 'description' => 'ID of the restaurant'],
                    ['name' => 'table_no', 'type' => 'int', 'description' => 'Table number for the order'],
                    ['name' => 'items', 'type' => 'array', 'description' => 'Array of order items with IDs, names, and quantities']
                ],
                'description' => 'Creates a new order. Supports both nested "order" object or flat parameters (restaurant_id, table_no).',
                'example_response' => '{
    "settings": {
        "success": true,
        "message": "Order created successfully"
    },
    "data": {
        "order_id": 20
    }
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'Update Order Item',
                'url' => '/WS/update_item',
                'method' => 'POST',
                'params' => [
                    ['name' => 'order_id', 'type' => 'int', 'description' => 'Required. ID of the existing order'],
                    ['name' => 'items', 'type' => 'array', 'description' => 'Required. Array of items to update: { order_item_id OR menu_id, quantity, price }'],
                ],
                'description' => 'Updates quantity or price of existing order items. If quantity is 0, the item is removed. Auto-recomputes order totals.',
                'example_response' => '{
  "settings": {
    "success": true,
    "message": "Order items updated successfully"
  },
  "data": {
    "order_id": 101
  }
}'
            ],
            [
                'category' => 'Orders',
                'name' => 'Delete Order Item',
                'url' => '/WS/delete_item',
                'method' => 'POST',
                'params' => [
                    ['name' => 'order_id', 'type' => 'int', 'description' => 'Required. ID of the existing order'],
                    ['name' => 'item_id', 'type' => 'int', 'description' => 'ID of the menu item to remove'],
                    ['name' => 'order_item_id', 'type' => 'int', 'description' => 'Specific ID of the order item to remove (alternative to item_id)'],
                ],
                'description' => 'Removes an item and its associated addons from an order. Auto-recomputes order totals.',
                'example_response' => '{
  "settings": {
    "success": true,
    "message": "Item deleted successfully"
  },
  "data": {
    "order_id": 101
  }
}'
            ],
        ];

        $this->load->view('api_documentation', $data);
    }
}
