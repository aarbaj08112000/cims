-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 19, 2026 at 12:35 PM
-- Server version: 11.8.9-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u875583157_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(150) NOT NULL,
  `module_name` varchar(100) NOT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `attribute_id` int(11) NOT NULL,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_code` varchar(100) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(255) NOT NULL,
  `brand_code` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`, `brand_code`, `status`, `is_delete`, `added_date`, `added_by`, `updated_date`, `updated_by`) VALUES
(1, 'Peter England', NULL, 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(2, 'Louis Philippe', NULL, 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(3, 'FabIndiaa', NULL, 'Active', 0, '2026-02-13 12:35:39', NULL, '2026-06-01 15:19:24', 2),
(4, 'Levi\'s', NULL, 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(5, 'Pantaloons', NULL, 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(6, 'Tesla', NULL, 'Active', 0, '2026-06-01 15:19:16', 2, NULL, NULL),
(7, 'Brand1', NULL, 'Active', 0, '2026-08-30 10:59:07', 2, NULL, NULL),
(8, 'Apple', NULL, 'Active', 0, '2026-08-30 11:30:35', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `category_code` varchar(255) DEFAULT NULL,
  `parent_category_id` int(11) DEFAULT 0,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `category_code`, `parent_category_id`, `status`, `is_delete`, `added_date`, `added_by`, `updated_date`, `updated_by`) VALUES
(1, 'Shirts', NULL, 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(2, 'Pants & Jeans', NULL, 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(3, 'Sarees & Ethnic Wear', NULL, 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(4, 'T-Shirts & Tops', NULL, 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(5, 'Jackets & Outerwear', NULL, 0, 'Active', 0, '2026-02-13 12:35:13', NULL, '2026-06-02 13:26:50', 2),
(6, 'Keychain', NULL, 0, 'Active', 0, '2026-06-01 15:06:57', 2, NULL, NULL),
(7, 'Keychain1', NULL, 0, 'Inactive', 0, '2026-06-02 13:21:02', 2, '2026-06-02 13:58:23', 2),
(8, 'Festive', NULL, 0, 'Active', 0, '2026-06-02 14:08:06', 2, NULL, NULL),
(9, 'Food', NULL, 0, 'Active', 0, '2026-08-30 10:58:15', 2, '2026-08-30 10:58:52', 2),
(10, 'Electronic', NULL, 0, 'Active', 0, '2026-08-30 11:30:26', 2, NULL, NULL),
(11, 'Testing', NULL, 0, 'Active', 0, '2026-09-11 23:25:35', 2, NULL, NULL),
(12, 'Test Festive edit', 'CAT-6939', 0, 'Active', 0, '2026-09-13 00:31:28', 2, '2026-09-15 19:54:35', 2);

-- --------------------------------------------------------

--
-- Table structure for table `company_master`
--

CREATE TABLE `company_master` (
  `company_id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `company_code` varchar(100) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `gst_number` varchar(50) DEFAULT NULL,
  `pan_number` varchar(50) DEFAULT NULL,
  `company_logo` varchar(255) DEFAULT NULL,
  `gst_certificate` varchar(255) DEFAULT NULL,
  `pan_card_img` varchar(255) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_master`
--

INSERT INTO `company_master` (`company_id`, `company_name`, `company_code`, `contact_person`, `email`, `phone`, `address`, `city`, `state`, `pincode`, `country`, `gst_number`, `pan_number`, `company_logo`, `gst_certificate`, `pan_card_img`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 'Code Crafter Infotech', 'CC', 'Gayu Hedau', 'codecrafter.help@gmail.com', '9874563210', 'Baner', 'Pune', 'Maharashtra', '411046', 'India', 'GSTIN123456789', 'ABCDE1234F', '1775641875_logo2.png', '1788252947_blank.pdf', '1788252947_blank.pdf', '2025-05-25 10:29:35', 1, '2025-05-25 10:29:53', 1, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `config_setting`
--

CREATE TABLE `config_setting` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `type` enum('check_box','input','date','file') NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `config_setting`
--

INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES
(9, 'company_logo', 'Company Logo', 'public/uploads/settings/1775642274_logo2.png', 'Company logo', 'file', 0),
(10, 'company_name', 'Company name', 'Code Crafter Infotech', 'Company name', 'input', 0),
(11, 'company_fav_icon', 'Company fav icon', 'public/uploads/settings/1775642274_logo2(1)(1).png', 'Company fav icon', 'file', 0),
(12, 'login_attempt', 'Login attempt', '6', 'Login attempt', 'input', 0),
(13, 'menu_type', 'Menu Type', 'horizontal', 'horizontal|vertical', 'input', 0),
(14, 'default_page_view_type', 'Default Page View Type for listing', '{\"User\":\"Grid\"}', 'Table/Grid', 'input', 0),
(15, 'smtp_user_name', 'SMTP User Name', 'mullaaarbaj10@gmail.com', 'SMTP User Name', 'input', 0),
(16, 'smtp_user_password', 'SMTP User Password', 'csoh fxfg hvfk egju', 'SMTP User Password', 'input', 0),
(17, 'company_email', 'Company Email', 'erp.system@gmail.com', 'Company Email', 'input', 0),
(18, 'password_link_expiry', 'Password Link Expiry', '10', 'Password Link Expiry In Minutes', 'input', 0),
(19, 'email_notification_enable', 'Email Notification Enable', 'Yes', 'Email Notification Enable', 'input', 0),
(20, 'pos_tax_enabled', 'Enable POS Tax', 'Yes', 'Enable or disable tax on POS bills', 'input', 0),
(21, 'pos_tax_percentage', 'POS Tax Percentage', '1', 'Tax percentage to apply on POS bills', 'input', 0),
(22, 'pos_receipt_print_type', 'POS Receipt Print Type', 'PDF', 'Set to PDF for direct PDF print popup, or HTML for the standard receipt style', 'check_box', 1);

-- --------------------------------------------------------

--
-- Table structure for table `currency_master`
--

CREATE TABLE `currency_master` (
  `currency_id` int(11) NOT NULL,
  `currency_name` varchar(100) NOT NULL,
  `currency_code` varchar(10) NOT NULL,
  `currency_symbol` varchar(10) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `added_by` int(11) DEFAULT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `currency_master`
--

INSERT INTO `currency_master` (`currency_id`, `currency_name`, `currency_code`, `currency_symbol`, `status`, `added_by`, `added_date`, `updated_by`, `updated_date`) VALUES
(1, 'Indian Rupee', 'INR', '₹', 'Active', NULL, '2026-09-17 12:37:14', NULL, NULL),
(2, 'US Dollar', 'USD', '$', 'Active', NULL, '2026-09-17 12:37:14', NULL, NULL),
(3, 'Euro', 'EUR', '€', 'Active', NULL, '2026-09-17 12:37:14', NULL, NULL),
(4, 'British Pound', 'GBP', '£', 'Active', NULL, '2026-09-17 12:37:14', NULL, NULL),
(5, 'Japanese Yen', 'JPY', '¥', 'Active', NULL, '2026-09-17 12:37:14', NULL, NULL),
(6, 'Australian Dollar', 'AUD', 'A$', 'Active', NULL, '2026-09-17 12:37:14', NULL, NULL),
(7, 'Indian Rupee', 'INR', '₹', 'Active', NULL, '2026-09-19 08:40:03', NULL, NULL),
(8, 'US Dollar', 'USD', '$', 'Active', NULL, '2026-09-19 08:40:03', NULL, NULL),
(9, 'Euro', 'EUR', '€', 'Active', NULL, '2026-09-19 08:40:03', NULL, NULL),
(10, 'British Pound', 'GBP', '£', 'Active', NULL, '2026-09-19 08:40:03', NULL, NULL),
(11, 'Japanese Yen', 'JPY', '¥', 'Active', NULL, '2026-09-19 08:40:03', NULL, NULL),
(12, 'Australian Dollar', 'AUD', 'A$', 'Active', NULL, '2026-09-19 08:40:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_master`
--

CREATE TABLE `customer_master` (
  `customer_id` int(11) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `customer_number` varchar(50) DEFAULT NULL,
  `alternate_contact` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `address1` text DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `pan_number` varchar(50) DEFAULT NULL,
  `aadhar_number` varchar(50) DEFAULT NULL,
  `gst_number` varchar(50) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `business_type` varchar(100) DEFAULT NULL,
  `business_contact` varchar(20) DEFAULT NULL,
  `business_address` text DEFAULT NULL,
  `gst_registered` enum('Yes','No') DEFAULT NULL,
  `business_pan` varchar(50) DEFAULT NULL,
  `business_email` varchar(255) DEFAULT NULL,
  `payment_mode` varchar(50) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_holder` varchar(255) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `ifsc` varchar(20) DEFAULT NULL,
  `upi_id` varchar(100) DEFAULT NULL,
  `payment_terms` text DEFAULT NULL,
  `payment_notes` text DEFAULT NULL,
  `customer_type` varchar(100) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `gst_type` varchar(50) DEFAULT NULL,
  `gst_percentage` decimal(5,2) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `pan_image` varchar(255) DEFAULT NULL,
  `aadhar_image` varchar(255) DEFAULT NULL,
  `gst_certificate` varchar(255) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `is_delete` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_master`
--

INSERT INTO `customer_master` (`customer_id`, `full_name`, `mobile_number`, `customer_number`, `alternate_contact`, `email`, `dob`, `gender`, `address1`, `address2`, `city`, `state`, `pincode`, `country`, `pan_number`, `aadhar_number`, `gst_number`, `company_name`, `business_type`, `business_contact`, `business_address`, `gst_registered`, `business_pan`, `business_email`, `payment_mode`, `bank_name`, `account_holder`, `account_number`, `ifsc`, `upi_id`, `payment_terms`, `payment_notes`, `customer_type`, `company_id`, `gst_type`, `gst_percentage`, `notes`, `profile_photo`, `pan_image`, `aadhar_image`, `gst_certificate`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 'Gayatri Narayan Hedau', '9874563210', 'BH001', '', 'gayatri.cc@gmail.com', '2025-05-15', 'Female', 'Plot No - G-10 ,Vaishali Nagar Nagpur', '', 'Nagpur', 'Maharashtra', '440017', 'India', 'ABCDE1234F', '123456789124', '27AAECM2936N1Z2', '', '', '', '', 'No', '', '', '', '', '', '', '', '', '', '30%\r\n40%\r\n30%', 'Business', 1, 'No', 0.00, 'Have Bulk Order', '197b67eb8d3e209106b6ef3fffd7eaab.jpg', '3cb9bc85be31204edaebbc9a829b5efb.png', '356fa9cd5ef04b615c7dc27c28e76aa2.jpg', '8fb7aff62b51c309acf06d35f29792f9.jpg', '2025-05-25 10:33:40', 1, NULL, NULL, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `customer_payments_invoice`
--

CREATE TABLE `customer_payments_invoice` (
  `customer_payments_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `handover_qty` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `invoice_name` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `transaction_image` varchar(255) DEFAULT NULL,
  `transaction_type` varchar(100) DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `is_delete` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_payments_invoice`
--

INSERT INTO `customer_payments_invoice` (`customer_payments_id`, `customer_id`, `product_id`, `handover_qty`, `amount`, `invoice_name`, `payment_date`, `transaction_image`, `transaction_type`, `added_by`, `added_date`, `updated_by`, `updated_date`, `status`, `is_delete`) VALUES
(1, 1, 1, 1, 100.00, 'INV_6832D63677F66', '2025-05-25 10:35:02', '1748162102_transaction.png', 'Cash', 1, '2025-05-25 10:35:02', NULL, NULL, 'Active', '0'),
(2, 1, 1, 1, 100.00, 'INV_6832D642391FB', '2025-05-25 10:35:14', '1748162114_transaction.png', 'Cash', 1, '2025-05-25 10:35:14', NULL, NULL, 'Active', '0'),
(3, 1, 1, 1, 100.00, 'INV_6832D667C83F4', '2025-05-25 10:35:51', '1748162151_transaction.png', 'Cash', 1, '2025-05-25 10:35:51', NULL, NULL, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `customer_product`
--

CREATE TABLE `customer_product` (
  `customer_product_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `handover_qty` int(11) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `is_delete` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_product`
--

INSERT INTO `customer_product` (`customer_product_id`, `product_id`, `customer_id`, `price`, `qty`, `handover_qty`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 1, 1, 500.00, 5, 1, '2025-05-25 10:33:40', 1, NULL, NULL, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `group_master`
--

CREATE TABLE `group_master` (
  `group_master_id` int(11) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `group_code` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group_master`
--

INSERT INTO `group_master` (`group_master_id`, `group_name`, `group_code`, `status`) VALUES
(1, 'Super Admin', 'super_admin', 'Active'),
(2, 'Admin', 'Admin', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `group_rights`
--

CREATE TABLE `group_rights` (
  `group_rights_id` int(11) NOT NULL,
  `group_master_id` int(11) NOT NULL,
  `menu_master_id` int(11) NOT NULL,
  `list` enum('Yes','No') DEFAULT 'No',
  `add` enum('Yes','No') NOT NULL DEFAULT 'No',
  `update` enum('Yes','No') NOT NULL DEFAULT 'No',
  `delete` enum('Yes','No') NOT NULL DEFAULT 'No',
  `export` enum('Yes','No') NOT NULL DEFAULT 'No',
  `import` enum('Yes','No') NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group_rights`
--

INSERT INTO `group_rights` (`group_rights_id`, `group_master_id`, `menu_master_id`, `list`, `add`, `update`, `delete`, `export`, `import`) VALUES
(26, 1, 1, 'No', 'No', 'No', 'Yes', 'No', 'No'),
(27, 1, 2, 'Yes', 'No', 'Yes', 'No', 'No', 'No'),
(28, 1, 3, 'Yes', 'No', 'Yes', 'No', 'No', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `material_master`
--

CREATE TABLE `material_master` (
  `material_id` int(11) NOT NULL,
  `material_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `material_master`
--

INSERT INTO `material_master` (`material_id`, `material_name`) VALUES
(1, 'Cotton'),
(2, 'Denim'),
(3, 'Silk'),
(4, 'Polyester'),
(5, 'Rayon'),
(6, 'Linen');

-- --------------------------------------------------------

--
-- Table structure for table `menu_category`
--

CREATE TABLE `menu_category` (
  `menu_category_id` int(11) NOT NULL,
  `menu_category_code` varchar(255) NOT NULL,
  `menu_category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_category`
--

INSERT INTO `menu_category` (`menu_category_id`, `menu_category_code`, `menu_category_name`) VALUES
(1, 'user_managemnet', 'User Management'),
(2, 'purchase', 'Purchase');

-- --------------------------------------------------------

--
-- Table structure for table `menu_master`
--

CREATE TABLE `menu_master` (
  `menu_master_id` int(11) NOT NULL,
  `menu_category_id` int(11) NOT NULL,
  `diaplay_name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_master`
--

INSERT INTO `menu_master` (`menu_master_id`, `menu_category_id`, `diaplay_name`, `url`, `status`) VALUES
(1, 1, 'User', 'user_list', 'Inactive'),
(2, 1, 'Group Master', 'group_master', 'Inactive'),
(3, 2, 'Sitemap', 'sitemap', 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `product_activity_logs`
--

CREATE TABLE `product_activity_logs` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `action_type` enum('created','updated','stock_added','stock_removed','stock_adjusted','sale','sale_return','purchase','purchase_return','deleted','restored') NOT NULL DEFAULT 'updated',
  `old_values` longtext DEFAULT NULL,
  `new_values` longtext DEFAULT NULL,
  `qty_change` decimal(10,2) DEFAULT 0.00,
  `price_change` decimal(10,2) DEFAULT 0.00,
  `reference_no` varchar(100) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `user_name` varchar(150) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `attr_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `attr_name` varchar(255) NOT NULL,
  `attr_value` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT 0,
  `added_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `added_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_master`
--

CREATE TABLE `product_master` (
  `product_id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL COMMENT 'Unique auto-generated code',
  `line_bar_code` varchar(255) DEFAULT NULL COMMENT 'Barcode for scanning',
  `name` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `hsn_code` varchar(20) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `alert_qty` int(11) DEFAULT 0,
  `qty` int(11) DEFAULT 0,
  `purchase_price` decimal(10,2) DEFAULT 0.00,
  `purchase_currency_id` int(11) DEFAULT NULL,
  `actual_price` decimal(10,2) DEFAULT 0.00,
  `discount` decimal(5,2) DEFAULT 0.00,
  `price` decimal(10,2) NOT NULL,
  `selling_currency_id` int(11) DEFAULT NULL,
  `tax_rate` decimal(5,2) DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `material` varchar(100) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` enum('0','1') DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_master`
--

INSERT INTO `product_master` (`product_id`, `product_code`, `line_bar_code`, `name`, `category_id`, `brand_id`, `hsn_code`, `unit`, `alert_qty`, `qty`, `purchase_price`, `purchase_currency_id`, `actual_price`, `discount`, `price`, `selling_currency_id`, `tax_rate`, `description`, `image`, `size`, `color`, `material`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 'MSH-BL-M', '8901234567890', 'Men\'s Formal Shirt', 1, 1, '6205', 'Piece', 10, 92, 400.00, 1, 999.00, 0.00, 999.00, 1, 5.00, 'Cotton formal shirt for men', 'b9fdda782294d749117005751d362a30.jpg', 'M', 'Blue', 'Cotton', '2025-05-25 10:00:00', 1, '2026-02-13 14:27:43', 2, 'Active', '0'),
(2, 'MSH-BL-L', '8901234567891', 'Men\'s Formal Shirt', 1, 1, '6205', 'Piece', 10, 87, 400.00, 1, 1049.00, 0.00, 1049.00, 1, 5.00, 'Cotton formal shirt for men', 'shirt_blue_l.jpg', 'L', 'Blue', 'Cotton', '2025-05-25 10:00:00', 1, NULL, NULL, 'Active', '0'),
(3, 'MJE-BK-32', '8901234567892', 'Men\'s Slim Fit Jeans', 1, 2, '6203', 'Piece', 5, 86, 600.00, 1, 1499.00, 0.00, 1499.00, 1, 12.00, 'Black slim fit denim jeans', 'jeans_black_32.jpg', '32', 'Black', 'Denim', '2025-05-25 10:05:00', 1, NULL, NULL, 'Active', '0'),
(4, 'MJE-BK-34', '8901234567893', 'Men\'s Slim Fit Jeans', 1, 2, '6203', 'Piece', 5, 40, 600.00, 1, 1499.00, 0.00, 1499.00, 1, 12.00, 'Black slim fit denim jeans', '6bc18672f260b5a82883c63701e97039.jpg', '34', 'Black', 'Denim', '2025-05-25 10:05:00', 1, '2026-08-25 13:52:01', 2, 'Active', '0'),
(5, 'WKU-RD-S', '8901234567894', 'Women\'s Cotton Kurti', 2, 1, '6204', 'Piece', 8, 57, 250.00, 1, 599.00, 0.00, 599.00, 1, 5.00, 'Traditional red cotton kurti', 'kurti_red_s.jpg', 'S', 'Red', 'Cotton', '2025-05-25 10:10:00', 1, NULL, NULL, 'Active', '0'),
(6, 'WKU-RD-M', '8901234567895', 'Women\'s Cotton Kurti', 2, 1, '6204', 'Piece', 8, 54, 250.00, 1, 599.00, 0.00, 599.00, 1, 5.00, 'Traditional red cotton kurti', 'kurti_red_m.jpg', 'M', 'Red', 'Cotton', '2025-05-25 10:10:00', 1, NULL, NULL, 'Active', '0'),
(7, 'MTS-WH-M', '8901234567896', 'Men\'s Polo T-Shirt', 1, 2, '6109', 'Piece', 15, 120, 200.00, 1, 499.00, 0.00, 499.00, 1, 5.00, 'White polo t-shirt', 'tshirt_white_m.jpg', 'M', 'White', 'Cotton Blend', '2025-05-25 10:15:00', 1, NULL, NULL, 'Active', '0'),
(8, 'WDR-PK-L', '8901234567897', 'Women\'s Floral Dress', 2, 2, '6204', 'Piece', 5, 29, 500.00, 1, 1299.00, 0.00, 1299.00, 1, 12.00, 'Pink floral summer dress', 'dress_pink_l.jpg', 'L', 'Pink', 'Rayon', '2025-05-25 10:20:00', 1, NULL, NULL, 'Active', '0'),
(9, 'KTS-YL-4', '8901234567898', 'Kid\'s Cartoon T-Shirt', 3, 1, '6109', 'Piece', 10, 25, 150.00, 1, 349.00, 0.00, 349.00, 1, 5.00, 'Yellow t-shirt with cartoon print', 'kid_tshirt_yellow.jpg', '4Y', 'Yellow', 'Cotton', '2025-05-25 10:25:00', 1, NULL, NULL, 'Active', '0'),
(10, 'MSP-GR-40', '8901234567899', 'Men\'s Sports Track Pant', 1, 2, '6103', 'Piece', 8, 23, 350.00, 1, 799.00, 0.00, 799.00, 1, 12.00, 'Grey sports track pant', 'trackpant_grey.jpg', '40', 'Grey', 'Polyester', '2025-05-25 10:30:00', 1, NULL, NULL, 'Active', '0'),
(11, 'PRD-1770972630', '1770972630785', 'Shirt', 2, 2, '87089900', 'Meter', 10, 4, 400.00, 1, 400.00, 0.00, 400.00, 1, 5.00, 'Shirt', '6c1364f279e52cd74aa8599f50d2a108.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:20:30', 2, NULL, NULL, 'Active', '0'),
(12, 'PRD-1770972658', '1770972658401', 'Shirt', 2, 2, '87089900', 'Meter', 10, 93, 400.00, 1, 400.00, 0.00, 400.00, 1, 5.00, 'Shirt', '0053fc7155b1d22deb004fa42caca3db.webp', 'M', 'Blue', 'Cotton', '2026-02-13 14:20:58', 2, '2026-09-01 14:10:44', 2, 'Active', '0'),
(13, 'PRD-1770972672', '1770972672274', 'Shirt', 2, 2, '87089900', 'Meter', 10, 4, 400.00, 1, 400.00, 0.00, 400.00, 1, 5.00, 'Shirt', '4887b134ef1be4f4a12bb0d44db38e2b.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:21:12', 2, NULL, NULL, 'Active', '0'),
(14, 'PRD-1770972756', '1770972756827', 'Shirt', 2, 2, '87089900', 'Meter', 10, 4, 400.00, 1, 400.00, 0.00, 400.00, 1, 5.00, 'Shirt', 'e40d332aa26e9298207b1ff384edff4c.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:22:36', 2, '2026-02-13 14:27:24', 2, 'Active', '0'),
(15, 'PRD-1787407614', '1787407614602', 'Tables', 1, 2, '84779000', 'Meter', 1, 10, 700.00, 1, 300.00, 0.00, 300.00, 1, 0.00, 'ajsdvhsaj', '9ddea82f903ebb1968464ead6a9480f4.png', '123', 'Green', 'Cotton', '2026-08-22 19:36:54', 2, NULL, NULL, 'Active', '0'),
(16, 'PRD-1788069818', '1788069818659', 'Iphone 17 Pro', 10, 8, '84779000', 'Piece', 20, 206, 8000.00, 1, 10000.00, 0.00, 10000.00, 1, 0.00, 'Iphone 17 Pro', '3335e67324b3ff48588f37ae46a8e8cb.jpeg', '', 'Red', 'Metal', '2026-08-30 11:33:38', 2, '2026-09-10 22:57:30', 2, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

CREATE TABLE `purchase_details` (
  `purchase_detail_id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT 0.00,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_details`
--

INSERT INTO `purchase_details` (`purchase_detail_id`, `purchase_id`, `product_id`, `qty`, `purchase_price`, `tax_amount`, `total_amount`) VALUES
(1, 1, 3, 45, 600.00, 0.00, 27000.00),
(2, 2, 3, 1, 600.00, 0.00, 600.00),
(3, 3, 16, 100, 8000.00, 0.00, 800000.00),
(4, 4, 16, 1, 7000.00, 0.00, 7000.00),
(5, 5, 2, 1, 400.00, 0.00, 400.00),
(6, 5, 3, 1, 600.00, 0.00, 600.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_master`
--

CREATE TABLE `purchase_master` (
  `purchase_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `bill_no` varchar(100) NOT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(15,2) DEFAULT 0.00,
  `paid_amount` decimal(15,2) DEFAULT 0.00,
  `payment_status` enum('Paid','Partially Paid','Unpaid') DEFAULT 'Unpaid',
  `status` enum('Completed','Pending','Cancelled') DEFAULT 'Completed',
  `added_date` datetime DEFAULT current_timestamp(),
  `added_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_master`
--

INSERT INTO `purchase_master` (`purchase_id`, `supplier_id`, `bill_no`, `purchase_date`, `total_amount`, `paid_amount`, `payment_status`, `status`, `added_date`, `added_by`) VALUES
(1, 2, 'ABS7485', '2026-02-16', 27000.00, 0.00, 'Unpaid', 'Completed', '2026-02-16 14:00:41', 17),
(2, 2, 'ABS7485', '2026-03-09', 600.00, 0.00, 'Unpaid', 'Completed', '2026-03-08 13:47:28', 2),
(3, 3, 'BN00001', '2026-08-30', 800000.00, 0.00, 'Unpaid', 'Completed', '2026-08-30 11:45:20', 2),
(4, 3, 'BN00001', '2026-08-30', 7000.00, 0.00, 'Unpaid', 'Completed', '2026-08-30 15:03:04', 2),
(5, 3, 'ABS7485', '2026-09-13', 1000.00, 0.00, 'Unpaid', 'Completed', '2026-09-13 00:42:26', 2);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_details`
--

CREATE TABLE `purchase_return_details` (
  `return_detail_id` int(11) NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_return_details`
--

INSERT INTO `purchase_return_details` (`return_detail_id`, `return_id`, `product_id`, `qty`, `purchase_price`, `total_amount`) VALUES
(1, 1, 3, 5, 600.00, 3000.00),
(2, 2, 16, 50, 8000.00, 400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_master`
--

CREATE TABLE `purchase_return_master` (
  `return_id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `return_no` varchar(100) NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(15,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `added_date` datetime DEFAULT current_timestamp(),
  `added_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_return_master`
--

INSERT INTO `purchase_return_master` (`return_id`, `purchase_id`, `return_no`, `return_date`, `total_return_amount`, `remarks`, `added_date`, `added_by`) VALUES
(1, 1, 'RET-3894', '2026-02-16', 3000.00, '', '2026-02-16 14:10:32', 17),
(2, 3, 'RET-7824', '2026-08-30', 400000.00, 'Extra qty', '2026-08-30 11:49:50', 2);

-- --------------------------------------------------------

--
-- Table structure for table `sales_details`
--

CREATE TABLE `sales_details` (
  `sales_detail_id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `sale_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_details`
--

INSERT INTO `sales_details` (`sales_detail_id`, `sales_id`, `product_id`, `qty`, `sale_price`, `total_amount`) VALUES
(1, 1, 3, 1, 480.00, 480.00),
(2, 2, 5, 1, 450.00, 450.00),
(3, 3, 10, 1, 799.00, 799.00),
(4, 7, 1, 1, 999.00, 999.00),
(5, 8, 2, 2, 1049.00, 2098.00),
(6, 9, 4, 1, 1499.00, 1499.00),
(7, 10, 4, 2, 1499.00, 1049.00),
(8, 10, 2, 1, 1049.00, 1049.00),
(9, 11, 5, 2, 599.00, 1198.00),
(10, 12, 3, 1, 1499.00, 1499.00),
(11, 13, 4, 1, 1499.00, 1499.00),
(12, 14, 4, 1, 1499.00, 1499.00),
(13, 15, 3, 2, 1499.00, 2998.00),
(14, 15, 1, 2, 999.00, 1998.00),
(15, 16, 10, 1, 799.00, 799.00),
(16, 17, 2, 2, 1049.00, 2098.00),
(17, 17, 8, 1, 1299.00, 1299.00),
(18, 18, 4, 1, 1499.00, 1499.00),
(19, 18, 6, 1, 599.00, 599.00),
(23, 19, 9, 1, 349.00, 349.00),
(24, 20, 9, 2, 349.00, 698.00),
(25, 21, 9, 1, 349.00, 349.00),
(26, 22, 9, 1, 349.00, 349.00),
(27, 23, 9, 1, 349.00, 349.00),
(28, 24, 9, 2, 349.00, 698.00),
(29, 25, 9, 1, 349.00, 349.00),
(30, 26, 9, 2, 349.00, 698.00),
(31, 27, 9, 1, 349.00, 349.00),
(32, 28, 9, 1, 349.00, 349.00),
(33, 29, 1, 10, 999.00, 9990.00),
(34, 30, 9, 1, 349.00, 349.00),
(35, 31, 9, 1, 349.00, 349.00),
(36, 32, 3, 1, 1499.00, 1499.00),
(37, 33, 16, 4, 10000.00, 40000.00),
(38, 33, 15, 1, 300.00, 300.00),
(39, 34, 16, 2, 10000.00, 20000.00),
(40, 35, 2, 1, 1049.00, 1049.00),
(41, 36, 3, 2, 1499.00, 2998.00),
(42, 37, 1, 0, 999.00, 0.00),
(43, 38, 1, 0, 999.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `sales_master`
--

CREATE TABLE `sales_master` (
  `sales_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_phone_number` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `bill_no` varchar(100) NOT NULL,
  `sales_date` date NOT NULL,
  `total_amount` decimal(15,2) DEFAULT 0.00,
  `tax_amount` decimal(15,2) DEFAULT 0.00,
  `discount_amount` decimal(15,2) DEFAULT 0.00,
  `payable_amount` decimal(15,2) DEFAULT 0.00,
  `paid_amount` decimal(15,2) DEFAULT 0.00,
  `payment_status` enum('Paid','Partially Paid','Unpaid') DEFAULT 'Unpaid',
  `payment_mode` enum('Cash','Card','UPI','Net Banking','Credit') DEFAULT 'Cash',
  `added_date` datetime DEFAULT current_timestamp(),
  `added_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_master`
--

INSERT INTO `sales_master` (`sales_id`, `customer_id`, `customer_phone_number`, `customer_name`, `bill_no`, `sales_date`, `total_amount`, `tax_amount`, `discount_amount`, `payable_amount`, `paid_amount`, `payment_status`, `payment_mode`, `added_date`, `added_by`) VALUES
(1, 1, NULL, NULL, 'INV-6120', '2026-02-16', 480.00, 0.00, 0.00, 480.00, 480.00, 'Paid', 'Cash', '2026-02-16 14:24:22', 17),
(2, NULL, '9874563210', NULL, 'INV-9871', '2026-02-16', 450.00, 0.00, 0.00, 450.00, 450.00, 'Paid', 'Cash', '2026-02-16 14:28:12', 17),
(3, NULL, '', NULL, 'POS-1775645485', '2026-04-08', 799.00, 0.00, 0.00, 799.00, 799.00, 'Paid', 'Cash', '2026-04-08 16:21:53', 2),
(7, NULL, '', NULL, 'POS-1775646764', '2026-04-08', 999.00, 0.00, 0.00, 1023.98, 1023.98, 'Paid', 'Cash', '2026-04-08 16:43:46', 2),
(8, NULL, '', NULL, 'POS-1775647157', '2026-04-08', 0.00, 0.00, 0.00, 0.00, 0.00, 'Paid', 'UPI', '2026-04-08 16:51:53', 2),
(9, NULL, '', NULL, 'POS-1775647380', '2026-04-08', 1499.00, 0.00, 0.00, 1536.47, 1536.47, 'Paid', 'Cash', '2026-04-08 16:54:14', 2),
(10, NULL, '', NULL, 'POS-1775647464', '2026-04-08', 1049.00, 0.00, 0.00, 1075.22, 1075.22, 'Paid', 'Cash', '2026-04-08 16:55:19', 2),
(11, NULL, '', NULL, 'POS-1775647913', '2026-04-08', 1198.00, 0.00, 0.00, 1227.95, 1227.95, 'Paid', 'Cash', '2026-04-08 17:02:18', 2),
(12, NULL, '', NULL, 'POS-1775648131', '2026-04-08', 1499.00, 0.00, 0.00, 1536.47, 1536.47, 'Paid', 'Cash', '2026-04-08 17:05:39', 2),
(13, NULL, '', NULL, 'POS-1775651237', '2026-04-08', 1499.00, 0.00, 0.00, 1539.47, 1539.47, 'Paid', 'Cash', '2026-04-08 17:57:29', 2),
(14, NULL, '7845961302', NULL, 'POS-1775651667', '2026-04-08', 1499.00, 0.00, 0.00, 1513.99, 1513.99, 'Paid', 'Cash', '2026-04-08 18:04:43', 2),
(15, NULL, '', NULL, 'POS-1775669867', '2026-04-08', 4996.00, 0.00, 0.00, 5045.96, 5045.96, 'Paid', 'Cash', '2026-04-08 23:08:47', 2),
(16, NULL, '7845961230', NULL, 'POS-1776081469', '2026-04-13', 799.00, 0.00, 0.00, 806.99, 806.99, 'Paid', 'Cash', '2026-04-13 17:28:14', 2),
(17, NULL, '7845961302', NULL, 'POS-1779534007', '2026-05-23', 3397.00, 0.00, 0.00, 3425.97, 3425.97, 'Paid', 'Cash', '2026-05-23 16:31:14', 2),
(18, NULL, '7845961302', NULL, 'POS-1780426417', '2026-06-03', 2098.00, 0.00, 0.00, 2118.98, 2118.98, 'Paid', 'Cash', '2026-06-03 00:25:30', 2),
(19, NULL, '8485835691', 'Aarbaj', 'POS-1787496632', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 20:24:33', 2),
(20, NULL, 'Mulla', 'Aarbaj', 'POS-1787496566', '2026-08-23', 698.00, 0.00, 0.00, 704.98, 704.98, 'Paid', 'Cash', '2026-08-23 20:25:02', 2),
(21, NULL, '8485835691', 'Aarbaj', 'POS-1787496918', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 20:25:31', 2),
(22, NULL, '8485835691', 'Aarbaj', 'POS-1787496918', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 20:28:11', 2),
(23, NULL, '8485835691', 'Aarbaj', 'POS-1787496918', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 20:28:28', 2),
(24, NULL, 'Mulla', 'Aarbaj', 'POS-1787496566', '2026-08-23', 698.00, 0.00, 0.00, 704.98, 704.98, 'Paid', 'Cash', '2026-08-23 20:28:33', 2),
(25, NULL, '8485835691', 'Aarbaj', 'POS-1787497121', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 20:29:09', 2),
(26, NULL, '8485835692', 'A', 'POS-1787497570', '2026-08-23', 698.00, 0.00, 0.00, 704.98, 704.98, 'Paid', 'Cash', '2026-08-23 20:36:36', 2),
(27, NULL, '377372', 'Hdhe', 'POS-1787497726', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 20:39:01', 2),
(28, NULL, '8485835691', 'Aarbaj', 'POS-1787502253', '2026-08-23', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-23 21:55:04', 2),
(29, NULL, '9874563210', 'Aarav Patel', 'INV-9502', '2026-08-25', 9990.00, 0.00, 100.00, 9890.00, 9890.00, 'Paid', 'Cash', '2026-08-25 13:59:34', 2),
(30, NULL, '8485835691', 'Gayatri', 'POS-1788031505', '2026-08-30', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Cash', '2026-08-30 00:55:14', 2),
(31, NULL, '8485835691', 'Gayatri', 'POS-1788031544', '2026-08-30', 349.00, 0.00, 0.00, 352.49, 352.49, 'Paid', 'Card', '2026-08-30 00:55:54', 2),
(32, NULL, '8485835691', 'Aarbaj', 'POS-1788031819', '2026-08-30', 1499.00, 0.00, 0.00, 1513.99, 1513.99, 'Paid', 'UPI', '2026-08-30 01:00:44', 2),
(33, NULL, '8485835691', 'Aarbaj', 'POS-1788070138', '2026-08-30', 40300.00, 0.00, 0.00, 40703.00, 40703.00, 'Paid', 'Card', '2026-08-30 11:41:26', 2),
(34, NULL, '8495838282', 'Gayatri ', 'POS-1788071227', '2026-08-30', 20000.00, 0.00, 0.00, 20200.00, 20200.00, 'Paid', 'Card', '2026-08-30 11:58:27', 2),
(35, NULL, '9874563210', 'Aarav Patel', 'INV-3070', '2026-09-13', 1049.00, 0.00, 50.00, 999.00, 999.00, 'Paid', 'Cash', '2026-09-13 00:48:46', 2),
(36, NULL, '784596123', 'test', 'POS-1789240765', '2026-09-13', 2998.00, 0.00, 0.00, 3019.98, 3019.98, 'Paid', 'Cash', '2026-09-13 00:50:24', 2),
(37, NULL, '9874563210', 'Nitesh', '0', '2026-09-16', 0.00, 0.00, 0.00, 0.00, 0.00, 'Paid', 'Cash', '2026-09-16 22:45:24', 2),
(38, NULL, '9874563210', 'Aarav Patel', 'INV-1911', '2026-09-16', 0.00, 0.00, 0.00, 0.00, 0.00, 'Paid', 'Cash', '2026-09-16 22:53:28', 2);

-- --------------------------------------------------------

--
-- Table structure for table `sales_return_details`
--

CREATE TABLE `sales_return_details` (
  `return_detail_id` int(11) NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `sale_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_return_details`
--

INSERT INTO `sales_return_details` (`return_detail_id`, `return_id`, `product_id`, `qty`, `sale_price`, `total_amount`) VALUES
(1, 1, 3, 1, 480.00, 480.00),
(2, 2, 4, 1, 1499.00, 1499.00),
(3, 3, 15, 1, 300.00, 300.00);

-- --------------------------------------------------------

--
-- Table structure for table `sales_return_master`
--

CREATE TABLE `sales_return_master` (
  `return_id` int(11) NOT NULL,
  `sales_id` int(11) NOT NULL,
  `return_no` varchar(100) NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(15,2) DEFAULT 0.00,
  `remarks` text DEFAULT NULL,
  `added_date` datetime DEFAULT current_timestamp(),
  `added_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_return_master`
--

INSERT INTO `sales_return_master` (`return_id`, `sales_id`, `return_no`, `return_date`, `total_return_amount`, `remarks`, `added_date`, `added_by`) VALUES
(1, 1, 'RET-1771232608', '2026-02-17', 480.00, 'Remarks', '2026-02-16 14:33:57', 17),
(2, 14, 'SR-1780304144', '2026-06-01', 1499.00, '', '2026-06-01 14:25:44', 2),
(3, 33, 'SR-1788070939', '2026-08-30', 300.00, 'Damage', '2026-08-30 11:52:19', 2);

-- --------------------------------------------------------

--
-- Table structure for table `stock_master`
--

CREATE TABLE `stock_master` (
  `stock_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL COMMENT 'typically the added amount',
  `previous_qty` int(11) NOT NULL,
  `new_qty` int(11) NOT NULL,
  `remarks` text DEFAULT NULL,
  `added_by` int(11) NOT NULL,
  `added_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `stock_master`
--

INSERT INTO `stock_master` (`stock_id`, `product_id`, `qty`, `previous_qty`, `new_qty`, `remarks`, `added_by`, `added_date`) VALUES
(1, 2, 12, 80, 92, '', 2, '2026-02-13 14:44:15'),
(2, 1, 5, 100, 105, '', 2, '2026-02-13 15:01:57'),
(3, 3, 45, 50, 95, 'Purchase Bill No: ABS7485', 17, '2026-02-16 14:00:41'),
(4, 3, -5, 95, 90, 'Purchase Return No: RET-3894 (Original Bill: 1)', 17, '2026-02-16 14:10:32'),
(5, 3, -1, 90, 89, 'Sale Bill No: INV-6120', 17, '2026-02-16 14:24:22'),
(6, 5, -1, 60, 59, 'Sale Bill No: INV-9871', 17, '2026-02-16 14:28:12'),
(7, 3, 1, 89, 90, 'Sales Return No: RET-1771232608', 17, '2026-02-16 14:33:57'),
(8, 12, 89, 4, 93, 'add 89 qty', 17, '2026-02-16 14:55:06'),
(9, 3, 1, 90, 91, 'Purchase Bill No: ABS7485', 2, '2026-03-08 13:47:28'),
(10, 10, -1, 25, 24, 'Sale Bill No: POS-1775645485', 2, '2026-04-08 16:21:53'),
(11, 1, -1, 105, 104, 'Sale Bill No: POS-1775646764', 2, '2026-04-08 16:43:46'),
(12, 2, -2, 92, 90, 'Sale Bill No: POS-1775647157', 2, '2026-04-08 16:51:53'),
(13, 4, -1, 45, 44, 'Sale Bill No: POS-1775647380', 2, '2026-04-08 16:54:14'),
(14, 4, -2, 44, 42, 'Sale Bill No: POS-1775647464', 2, '2026-04-08 16:55:19'),
(15, 2, -1, 90, 89, 'Sale Bill No: POS-1775647464', 2, '2026-04-08 16:55:19'),
(16, 5, -2, 59, 57, 'Sale Bill No: POS-1775647913', 2, '2026-04-08 17:02:18'),
(17, 3, -1, 91, 90, 'Sale Bill No: POS-1775648131', 2, '2026-04-08 17:05:39'),
(18, 4, -1, 42, 41, 'Sale Bill No: POS-1775651237', 2, '2026-04-08 17:57:29'),
(19, 4, -1, 41, 40, 'Sale Bill No: POS-1775651667', 2, '2026-04-08 18:04:43'),
(20, 3, -2, 90, 88, 'Sale Bill No: POS-1775669867', 2, '2026-04-08 23:08:47'),
(21, 1, -2, 104, 102, 'Sale Bill No: POS-1775669867', 2, '2026-04-08 23:08:47'),
(22, 10, -1, 24, 23, 'Sale Bill No: POS-1776081469', 2, '2026-04-13 17:28:14'),
(23, 2, -2, 89, 87, 'Sale Bill No: POS-1779534007', 2, '2026-05-23 16:31:14'),
(24, 8, -1, 30, 29, 'Sale Bill No: POS-1779534007', 2, '2026-05-23 16:31:14'),
(25, 4, 1, 40, 41, 'Sales Return ID: 2 (Against Bill: SR-1780304144)', 2, '2026-06-01 14:25:44'),
(26, 4, -1, 41, 40, 'Sale Bill No: POS-1780426417', 2, '2026-06-03 00:25:31'),
(27, 6, -1, 55, 54, 'Sale Bill No: POS-1780426417', 2, '2026-06-03 00:25:31'),
(31, 9, -1, 40, 39, 'Sale Bill No: POS-1787496632', 2, '2026-08-23 20:24:33'),
(32, 9, -2, 39, 37, 'Sale Bill No: POS-1787496566', 2, '2026-08-23 20:25:02'),
(33, 9, -1, 37, 36, 'Sale Bill No: POS-1787496918', 2, '2026-08-23 20:25:31'),
(34, 9, -1, 36, 35, 'Sale Bill No: POS-1787496918', 2, '2026-08-23 20:28:11'),
(35, 9, -1, 35, 34, 'Sale Bill No: POS-1787496918', 2, '2026-08-23 20:28:28'),
(36, 9, -2, 34, 32, 'Sale Bill No: POS-1787496566', 2, '2026-08-23 20:28:33'),
(37, 9, -1, 32, 31, 'Sale Bill No: POS-1787497121', 2, '2026-08-23 20:29:09'),
(38, 9, -2, 31, 29, 'Sale Bill No: POS-1787497570', 2, '2026-08-23 20:36:36'),
(39, 9, -1, 29, 28, 'Sale Bill No: POS-1787497726', 2, '2026-08-23 20:39:01'),
(40, 9, -1, 28, 27, 'Sale Bill No: POS-1787502253', 2, '2026-08-23 21:55:04'),
(41, 1, -10, 102, 92, 'Sale Bill No: INV-9502', 2, '2026-08-25 13:59:34'),
(42, 9, -1, 27, 26, 'Sale Bill No: POS-1788031505', 2, '2026-08-30 00:55:14'),
(43, 9, -1, 26, 25, 'Sale Bill No: POS-1788031544', 2, '2026-08-30 00:55:54'),
(44, 3, -1, 88, 87, 'Sale Bill No: POS-1788031819', 2, '2026-08-30 01:00:44'),
(45, 16, 10, 150, 160, 'For Additional Qty', 2, '2026-08-30 11:37:11'),
(46, 16, -4, 160, 156, 'Sale Bill No: POS-1788070138', 2, '2026-08-30 11:41:26'),
(47, 15, -1, 10, 9, 'Sale Bill No: POS-1788070138', 2, '2026-08-30 11:41:26'),
(48, 16, 100, 156, 256, 'Purchase Bill No: BN00001', 2, '2026-08-30 11:45:21'),
(49, 16, -50, 256, 206, 'Purchase Return No: RET-7824 (Original Bill: 3)', 2, '2026-08-30 11:49:50'),
(50, 15, 1, 9, 10, 'Sales Return ID: 3 (Against Bill: SR-1788070939)', 2, '2026-08-30 11:52:19'),
(51, 16, 1, 206, 207, 'extra qty add', 2, '2026-08-30 11:53:38'),
(52, 16, -2, 207, 205, 'Sale Bill No: POS-1788071227', 2, '2026-08-30 11:58:27'),
(53, 16, 1, 205, 206, 'Purchase Bill No: BN00001', 2, '2026-08-30 15:03:04'),
(54, 2, 1, 87, 88, 'Purchase Bill No: ABS7485', 2, '2026-09-13 00:42:26'),
(55, 3, 1, 87, 88, 'Purchase Bill No: ABS7485', 2, '2026-09-13 00:42:26'),
(56, 2, -1, 88, 87, 'Sale Bill No: INV-3070', 2, '2026-09-13 00:48:46'),
(57, 3, -2, 88, 86, 'Sale Bill No: POS-1789240765', 2, '2026-09-13 00:50:24'),
(58, 1, 0, 92, 92, 'Sale Bill No: 0', 2, '2026-09-16 22:45:24'),
(59, 1, 0, 92, 92, 'Sale Bill No: INV-1911', 2, '2026-09-16 22:53:28');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_master`
--

CREATE TABLE `supplier_master` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `gst_number` varchar(50) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `is_delete` tinyint(1) DEFAULT 0,
  `added_date` datetime DEFAULT current_timestamp(),
  `added_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `supplier_master`
--

INSERT INTO `supplier_master` (`supplier_id`, `supplier_name`, `contact_person`, `email`, `phone`, `address`, `gst_number`, `status`, `is_delete`, `added_date`, `added_by`) VALUES
(1, 'Vardan Textiles', 'Rajesh Kumar', 'vardan@textiles.com', '9890012345', NULL, '27AAACV1234R1Z1', 'Active', 0, '2026-02-16 08:23:17', NULL),
(2, 'Everest Cloths', 'Sunita Sharma', 'sales@everest.com', '9890054321', '', '27BBBCV4321S1Z2', 'Active', 0, '2026-02-16 08:23:17', NULL),
(3, 'Abhishek Treder', 'Rehan Mulla', 'rehan1@yopmail.com', '8485835691', 'Pattan kodoli', 'GST0000000090912133', 'Active', 0, '2026-08-30 11:44:28', 2);

-- --------------------------------------------------------

--
-- Table structure for table `unit_master`
--

CREATE TABLE `unit_master` (
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `unit_master`
--

INSERT INTO `unit_master` (`unit_id`, `unit_name`) VALUES
(1, 'Pieces'),
(2, 'Meters'),
(3, 'Sets'),
(4, 'Rolls');

-- --------------------------------------------------------

--
-- Table structure for table `userinfo`
--

CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL,
  `user_email` text DEFAULT NULL,
  `user_role` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_password` text DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int(11) NOT NULL,
  `deleted` text DEFAULT NULL,
  `unit_ids` varchar(255) NOT NULL,
  `groups` varchar(255) NOT NULL,
  `login_attempt` int(11) NOT NULL DEFAULT 0,
  `status` enum('Active','Inactive','Block') NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userinfo`
--

INSERT INTO `userinfo` (`id`, `user_email`, `user_role`, `user_name`, `user_password`, `added_date`, `added_by`, `deleted`, `unit_ids`, `groups`, `login_attempt`, `status`) VALUES
(1, 'codecrafterinfotech@gmail.com', 1, 'Code Crafter', 'Test@123', '2024-11-19 12:41:29', 3, NULL, '1,2', '1', 0, 'Active'),
(2, 'admin@gmail.com', 2, 'Admin', 'Test@123', '2024-11-19 12:42:40', 3, '0', '1,2', '1', 7, 'Active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`attribute_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `company_master`
--
ALTER TABLE `company_master`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `company_code` (`company_code`);

--
-- Indexes for table `config_setting`
--
ALTER TABLE `config_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency_master`
--
ALTER TABLE `currency_master`
  ADD PRIMARY KEY (`currency_id`);

--
-- Indexes for table `customer_master`
--
ALTER TABLE `customer_master`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `customer_number` (`customer_number`);

--
-- Indexes for table `customer_payments_invoice`
--
ALTER TABLE `customer_payments_invoice`
  ADD PRIMARY KEY (`customer_payments_id`);

--
-- Indexes for table `customer_product`
--
ALTER TABLE `customer_product`
  ADD PRIMARY KEY (`customer_product_id`);

--
-- Indexes for table `group_master`
--
ALTER TABLE `group_master`
  ADD PRIMARY KEY (`group_master_id`);

--
-- Indexes for table `group_rights`
--
ALTER TABLE `group_rights`
  ADD PRIMARY KEY (`group_rights_id`);

--
-- Indexes for table `material_master`
--
ALTER TABLE `material_master`
  ADD PRIMARY KEY (`material_id`);

--
-- Indexes for table `menu_category`
--
ALTER TABLE `menu_category`
  ADD PRIMARY KEY (`menu_category_id`);

--
-- Indexes for table `menu_master`
--
ALTER TABLE `menu_master`
  ADD PRIMARY KEY (`menu_master_id`);

--
-- Indexes for table `product_activity_logs`
--
ALTER TABLE `product_activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`attr_id`),
  ADD KEY `fk_pa_product_id` (`product_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `fk_pi_product_id` (`product_id`);

--
-- Indexes for table `product_master`
--
ALTER TABLE `product_master`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `product_code` (`product_code`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD PRIMARY KEY (`purchase_detail_id`);

--
-- Indexes for table `purchase_master`
--
ALTER TABLE `purchase_master`
  ADD PRIMARY KEY (`purchase_id`);

--
-- Indexes for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  ADD PRIMARY KEY (`return_detail_id`);

--
-- Indexes for table `purchase_return_master`
--
ALTER TABLE `purchase_return_master`
  ADD PRIMARY KEY (`return_id`);

--
-- Indexes for table `sales_details`
--
ALTER TABLE `sales_details`
  ADD PRIMARY KEY (`sales_detail_id`);

--
-- Indexes for table `sales_master`
--
ALTER TABLE `sales_master`
  ADD PRIMARY KEY (`sales_id`);

--
-- Indexes for table `sales_return_details`
--
ALTER TABLE `sales_return_details`
  ADD PRIMARY KEY (`return_detail_id`);

--
-- Indexes for table `sales_return_master`
--
ALTER TABLE `sales_return_master`
  ADD PRIMARY KEY (`return_id`);

--
-- Indexes for table `stock_master`
--
ALTER TABLE `stock_master`
  ADD PRIMARY KEY (`stock_id`);

--
-- Indexes for table `supplier_master`
--
ALTER TABLE `supplier_master`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `unit_master`
--
ALTER TABLE `unit_master`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `userinfo`
--
ALTER TABLE `userinfo`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `attribute_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `company_master`
--
ALTER TABLE `company_master`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `config_setting`
--
ALTER TABLE `config_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `currency_master`
--
ALTER TABLE `currency_master`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customer_master`
--
ALTER TABLE `customer_master`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_payments_invoice`
--
ALTER TABLE `customer_payments_invoice`
  MODIFY `customer_payments_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_product`
--
ALTER TABLE `customer_product`
  MODIFY `customer_product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `group_master`
--
ALTER TABLE `group_master`
  MODIFY `group_master_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `group_rights`
--
ALTER TABLE `group_rights`
  MODIFY `group_rights_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `material_master`
--
ALTER TABLE `material_master`
  MODIFY `material_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menu_category`
--
ALTER TABLE `menu_category`
  MODIFY `menu_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_master`
--
ALTER TABLE `menu_master`
  MODIFY `menu_master_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_activity_logs`
--
ALTER TABLE `product_activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `attr_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_master`
--
ALTER TABLE `product_master`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `purchase_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchase_master`
--
ALTER TABLE `purchase_master`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  MODIFY `return_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_return_master`
--
ALTER TABLE `purchase_return_master`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales_details`
--
ALTER TABLE `sales_details`
  MODIFY `sales_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `sales_master`
--
ALTER TABLE `sales_master`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `sales_return_details`
--
ALTER TABLE `sales_return_details`
  MODIFY `return_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sales_return_master`
--
ALTER TABLE `sales_return_master`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `stock_master`
--
ALTER TABLE `stock_master`
  MODIFY `stock_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `supplier_master`
--
ALTER TABLE `supplier_master`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `unit_master`
--
ALTER TABLE `unit_master`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `userinfo`
--
ALTER TABLE `userinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `fk_pa_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_master` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_pi_product_id` FOREIGN KEY (`product_id`) REFERENCES `product_master` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
