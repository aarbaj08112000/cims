-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 28, 2026 at 10:36 AM
-- Server version: 8.0.45-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cims`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brand_id` int NOT NULL,
  `brand_name` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`, `status`, `is_delete`, `added_date`, `added_by`, `updated_date`, `updated_by`) VALUES
(1, 'Peter England', 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(2, 'Louis Philippe', 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(3, 'FabIndia', 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(4, 'Levi\'s', 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL),
(5, 'Pantaloons', 'Active', 0, '2026-02-13 12:35:39', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `parent_category_id` int DEFAULT '0',
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `parent_category_id`, `status`, `is_delete`, `added_date`, `added_by`, `updated_date`, `updated_by`) VALUES
(1, 'Shirts', 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(2, 'Pants & Jeans', 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(3, 'Sarees & Ethnic Wear', 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(4, 'T-Shirts & Tops', 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL),
(5, 'Jackets & Outerwear', 0, 'Active', 0, '2026-02-13 12:35:13', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int NOT NULL,
  `client_unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contact_person` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pan_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `billing_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shifting_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gst_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_id` int DEFAULT NULL,
  `date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` int DEFAULT '0',
  `state` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `state_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bank_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `client_unit`, `client_name`, `contact_person`, `pan_no`, `billing_address`, `shifting_address`, `phone_no`, `gst_number`, `created_id`, `date`, `time`, `timestamp`, `deleted`, `state`, `state_no`, `bank_details`, `address1`, `location`, `pin`) VALUES
(1, 'Talegaon Unit', 'TEST TECHNOPLAST', 'MR. Suresh Kamat', 'BIZPB5715', 'S.no. 123/4, Near PCMC water tank, Whalekarwadi Road, Pimple Goan, Pune-411111  Email: xxxxaaa@yahoo.com   PH: 1234567890', 'Gat no.5648, House no 133, near Hotel, Pimple Road, Pune-411111', '1111111110', '11ABCDE2222FGHI', 3, '03-04-2024', '10:58:33', '2024-02-09 08:27:30', 0, 'MAHARASHTRA', '27', 'ICICI BANK - Ac.No. 1111', 'xxxxx, xxxxxxxxxxx, xxxxxxxxxxxxxxxxxxxxxxx', 'Chinchwad', '411111'),
(2, 'Akurdi Unit', 'TEST TECHNOPLAST', 'MR. Suresh Kamat', 'BIZPB5715', 'S.no. 123/4, Near PCMC water tank, Whalekarwadi Road, Pimple Goan, Pune-411111  Email: xxxxaaa@yahoo.com   PH: 1234567890', 'Gat no.5648, House no 133, near Hotel, Pimple Road, Pune-411111', '1111111110', '11ABCDE2222FGHI', 3, '21-04-2024', '06:53:03', '2024-02-09 10:29:41', 0, 'Maharashtra', '27', 'ICICI BANK 1111', 'xxxxx, xxxxxxxxxxx, xxxxxxxxxxxxxxxxxxxxxxx', 'Chinchwad', '411111');

-- --------------------------------------------------------

--
-- Table structure for table `color_master`
--

CREATE TABLE `color_master` (
  `color_id` int NOT NULL,
  `color_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `color_master`
--

INSERT INTO `color_master` (`color_id`, `color_name`) VALUES
(1, 'Red'),
(2, 'Blue'),
(3, 'Black'),
(4, 'White'),
(5, 'Green'),
(6, 'Yellow');

-- --------------------------------------------------------

--
-- Table structure for table `company_master`
--

CREATE TABLE `company_master` (
  `company_id` int NOT NULL,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `company_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contact_person` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pincode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gst_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pan_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gst_certificate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pan_card_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active',
  `is_delete` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company_master`
--

INSERT INTO `company_master` (`company_id`, `company_name`, `company_code`, `contact_person`, `email`, `phone`, `address`, `city`, `state`, `pincode`, `country`, `gst_number`, `pan_number`, `company_logo`, `gst_certificate`, `pan_card_img`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 'Code Crafter', 'CC', 'Gayu Hedau', 'codecrafter.help@gmail.com', '9874563210', 'Baner', 'Pune', 'Maharashtra', '411046', 'India', 'GSTIN123456789', 'ABCDE1234F', '4c789908faa181fe51ad2e76dfe593e6.png', 'c5533ca174914e5f5cc5b95db92917bf.jpg', '45abc8d56c91f493b0271706fe021eb7.png', '2025-05-25 10:29:35', 1, '2025-05-25 10:29:53', 1, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `config_setting`
--

CREATE TABLE `config_setting` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('check_box','input','date','file') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `company_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `config_setting`
--

INSERT INTO `config_setting` (`id`, `name`, `title`, `value`, `description`, `type`, `company_id`) VALUES
(9, 'company_logo', 'Company Logo', 'public/assets/images/bharat_id_logo.png', 'Company logo', 'file', 0),
(10, 'company_name', 'Company name', 'Code Crafter Infotech', 'Company name', 'input', 0),
(11, 'company_fav_icon', 'Company fav icon', 'public/assets/img/favicon/favicon.png', 'Company fav icon', 'file', 0),
(12, 'login_attempt', 'Login attempt', '6', 'Login attempt', 'input', 0),
(13, 'menu_type', 'Menu Type', 'horizontal', 'horizontal|vertical', 'input', 0),
(14, 'default_page_view_type', 'Default Page View Type for listing', '{\"User\":\"Grid\"}', 'Table/Grid', 'input', 0),
(15, 'smtp_user_name', 'SMTP User Name', 'mullaaarbaj10@gmail.com', 'SMTP User Name', 'input', 0),
(16, 'smtp_user_password', 'SMTP User Password', 'csoh fxfg hvfk egju', 'SMTP User Password', 'input', 0),
(17, 'company_email', 'Company Email', 'erp.system@gmail.com', 'Company Email', 'input', 0),
(18, 'password_link_expiry', 'Password Link Expiry', '10', 'Password Link Expiry In Minutes', 'input', 0),
(19, 'email_notification_enable', 'Email Notification Enable', 'Yes', 'Email Notification Enable', 'input', 0);

-- --------------------------------------------------------

--
-- Table structure for table `customer_master`
--

CREATE TABLE `customer_master` (
  `customer_id` int NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alternate_contact` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `address2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pincode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pan_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aadhar_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gst_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `business_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `business_contact` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `business_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `gst_registered` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `business_pan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `business_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_mode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_holder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `account_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ifsc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `upi_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_terms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `payment_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `customer_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `gst_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gst_percentage` decimal(5,2) DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `profile_photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pan_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aadhar_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gst_certificate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Active',
  `is_delete` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_master`
--

INSERT INTO `customer_master` (`customer_id`, `full_name`, `mobile_number`, `customer_number`, `alternate_contact`, `email`, `dob`, `gender`, `address1`, `address2`, `city`, `state`, `pincode`, `country`, `pan_number`, `aadhar_number`, `gst_number`, `company_name`, `business_type`, `business_contact`, `business_address`, `gst_registered`, `business_pan`, `business_email`, `payment_mode`, `bank_name`, `account_holder`, `account_number`, `ifsc`, `upi_id`, `payment_terms`, `payment_notes`, `customer_type`, `company_id`, `gst_type`, `gst_percentage`, `notes`, `profile_photo`, `pan_image`, `aadhar_image`, `gst_certificate`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 'Gayatri Narayan Hedau', '9874563210', 'BH001', '', 'gayatri.cc@gmail.com', '2025-05-15', 'Female', 'Plot No - G-10 ,Vaishali Nagar Nagpur', '', 'Nagpur', 'Maharashtra', '440017', 'India', 'ABCDE1234F', '123456789124', '27AAECM2936N1Z2', '', '', '', '', 'No', '', '', '', '', '', '', '', '', '', '30%\r\n40%\r\n30%', 'Business', 1, 'No', '0.00', 'Have Bulk Order', '197b67eb8d3e209106b6ef3fffd7eaab.jpg', '3cb9bc85be31204edaebbc9a829b5efb.png', '356fa9cd5ef04b615c7dc27c28e76aa2.jpg', '8fb7aff62b51c309acf06d35f29792f9.jpg', '2025-05-25 10:33:40', 1, NULL, NULL, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `customer_payments_invoice`
--

CREATE TABLE `customer_payments_invoice` (
  `customer_payments_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `handover_qty` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `invoice_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `transaction_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transaction_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Active',
  `is_delete` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_payments_invoice`
--

INSERT INTO `customer_payments_invoice` (`customer_payments_id`, `customer_id`, `product_id`, `handover_qty`, `amount`, `invoice_name`, `payment_date`, `transaction_image`, `transaction_type`, `added_by`, `added_date`, `updated_by`, `updated_date`, `status`, `is_delete`) VALUES
(1, 1, 1, 1, '100.00', 'INV_6832D63677F66', '2025-05-25 10:35:02', '1748162102_transaction.png', 'Cash', 1, '2025-05-25 10:35:02', NULL, NULL, 'Active', '0'),
(2, 1, 1, 1, '100.00', 'INV_6832D642391FB', '2025-05-25 10:35:14', '1748162114_transaction.png', 'Cash', 1, '2025-05-25 10:35:14', NULL, NULL, 'Active', '0'),
(3, 1, 1, 1, '100.00', 'INV_6832D667C83F4', '2025-05-25 10:35:51', '1748162151_transaction.png', 'Cash', 1, '2025-05-25 10:35:51', NULL, NULL, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `customer_product`
--

CREATE TABLE `customer_product` (
  `customer_product_id` int NOT NULL,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `handover_qty` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Active',
  `is_delete` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_product`
--

INSERT INTO `customer_product` (`customer_product_id`, `product_id`, `customer_id`, `price`, `qty`, `handover_qty`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 1, 1, '500.00', 5, 1, '2025-05-25 10:33:40', 1, NULL, NULL, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `expense_category`
--

CREATE TABLE `expense_category` (
  `id` int NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `expense_category`
--

INSERT INTO `expense_category` (`id`, `category_name`) VALUES
(1, 'Rent'),
(2, 'Electricity'),
(3, 'Salary'),
(4, 'Maintenance'),
(5, 'Travel'),
(6, 'Stationery');

-- --------------------------------------------------------

--
-- Table structure for table `expense_master`
--

CREATE TABLE `expense_master` (
  `expense_id` int NOT NULL,
  `category_id` int NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `expense_date` date NOT NULL,
  `remarks` text,
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_master`
--

CREATE TABLE `group_master` (
  `group_master_id` int NOT NULL,
  `group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `group_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `group_master`
--

INSERT INTO `group_master` (`group_master_id`, `group_name`, `group_code`, `status`) VALUES
(1, 'Admin', 'Admin', 'Active'),
(2, 'AROM', 'AROM', 'Active'),
(5, 'Purchase', 'purchase', 'Active'),
(6, 'Sales', 'sales', 'Active'),
(7, 'Quality', 'quality', 'Active'),
(13, 'Super Admin', 'super_admin', 'Active'),
(14, 'Super Admin2', 'super_adminw', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `group_rights`
--

CREATE TABLE `group_rights` (
  `group_rights_id` int NOT NULL,
  `group_master_id` int NOT NULL,
  `menu_master_id` int NOT NULL,
  `list` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'No',
  `add` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `update` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `delete` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `export` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `import` enum('Yes','No') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No'
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
  `material_id` int NOT NULL,
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
  `menu_category_id` int NOT NULL,
  `menu_category_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `menu_category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
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
  `menu_master_id` int NOT NULL,
  `menu_category_id` int NOT NULL,
  `diaplay_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Inactive'
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
-- Table structure for table `product_master`
--

CREATE TABLE `product_master` (
  `product_id` int NOT NULL,
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Unique auto-generated code',
  `line_bar_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Barcode for scanning',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `hsn_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alert_qty` int DEFAULT '0',
  `qty` int DEFAULT '0',
  `purchase_price` decimal(10,2) DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL,
  `tax_rate` decimal(5,2) DEFAULT '0.00',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `size` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active',
  `is_delete` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_master`
--

INSERT INTO `product_master` (`product_id`, `product_code`, `line_bar_code`, `name`, `category_id`, `brand_id`, `hsn_code`, `unit`, `alert_qty`, `qty`, `purchase_price`, `price`, `tax_rate`, `description`, `image`, `size`, `color`, `material`, `added_date`, `added_by`, `updated_date`, `updated_by`, `status`, `is_delete`) VALUES
(1, 'MSH-BL-M', '8901234567890', 'Men\'s Formal Shirt', 1, 1, '6205', 'Piece', 10, 105, '400.00', '999.00', '5.00', 'Cotton formal shirt for men', 'b9fdda782294d749117005751d362a30.jpg', 'M', 'Blue', 'Cotton', '2025-05-25 10:00:00', 1, '2026-02-13 14:27:43', 2, 'Active', '0'),
(2, 'MSH-BL-L', '8901234567891', 'Men\'s Formal Shirt', 1, 1, '6205', 'Piece', 10, 92, '400.00', '1049.00', '5.00', 'Cotton formal shirt for men', 'shirt_blue_l.jpg', 'L', 'Blue', 'Cotton', '2025-05-25 10:00:00', 1, NULL, NULL, 'Active', '0'),
(3, 'MJE-BK-32', '8901234567892', 'Men\'s Slim Fit Jeans', 1, 2, '6203', 'Piece', 5, 91, '600.00', '1499.00', '12.00', 'Black slim fit denim jeans', 'jeans_black_32.jpg', '32', 'Black', 'Denim', '2025-05-25 10:05:00', 1, NULL, NULL, 'Active', '0'),
(4, 'MJE-BK-34', '8901234567893', 'Men\'s Slim Fit Jeans', 1, 2, '6203', 'Piece', 5, 45, '600.00', '1499.00', '12.00', 'Black slim fit denim jeans', 'jeans_black_34.jpg', '34', 'Black', 'Denim', '2025-05-25 10:05:00', 1, NULL, NULL, 'Active', '0'),
(5, 'WKU-RD-S', '8901234567894', 'Women\'s Cotton Kurti', 2, 1, '6204', 'Piece', 8, 59, '250.00', '599.00', '5.00', 'Traditional red cotton kurti', 'kurti_red_s.jpg', 'S', 'Red', 'Cotton', '2025-05-25 10:10:00', 1, NULL, NULL, 'Active', '0'),
(6, 'WKU-RD-M', '8901234567895', 'Women\'s Cotton Kurti', 2, 1, '6204', 'Piece', 8, 55, '250.00', '599.00', '5.00', 'Traditional red cotton kurti', 'kurti_red_m.jpg', 'M', 'Red', 'Cotton', '2025-05-25 10:10:00', 1, NULL, NULL, 'Active', '0'),
(7, 'MTS-WH-M', '8901234567896', 'Men\'s Polo T-Shirt', 1, 2, '6109', 'Piece', 15, 120, '200.00', '499.00', '5.00', 'White polo t-shirt', 'tshirt_white_m.jpg', 'M', 'White', 'Cotton Blend', '2025-05-25 10:15:00', 1, NULL, NULL, 'Active', '0'),
(8, 'WDR-PK-L', '8901234567897', 'Women\'s Floral Dress', 2, 2, '6204', 'Piece', 5, 30, '500.00', '1299.00', '12.00', 'Pink floral summer dress', 'dress_pink_l.jpg', 'L', 'Pink', 'Rayon', '2025-05-25 10:20:00', 1, NULL, NULL, 'Active', '0'),
(9, 'KTS-YL-4', '8901234567898', 'Kid\'s Cartoon T-Shirt', 3, 1, '6109', 'Piece', 10, 40, '150.00', '349.00', '5.00', 'Yellow t-shirt with cartoon print', 'kid_tshirt_yellow.jpg', '4Y', 'Yellow', 'Cotton', '2025-05-25 10:25:00', 1, NULL, NULL, 'Active', '0'),
(10, 'MSP-GR-40', '8901234567899', 'Men\'s Sports Track Pant', 1, 2, '6103', 'Piece', 8, 25, '350.00', '799.00', '12.00', 'Grey sports track pant', 'trackpant_grey.jpg', '40', 'Grey', 'Polyester', '2025-05-25 10:30:00', 1, NULL, NULL, 'Active', '0'),
(11, 'PRD-1770972630', '1770972630785', 'Shirt', 2, 2, '87089900', 'Meter', 10, 4, '400.00', '400.00', '5.00', 'Shirt', '6c1364f279e52cd74aa8599f50d2a108.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:20:30', 2, NULL, NULL, 'Active', '0'),
(12, 'PRD-1770972658', '1770972658401', 'Shirt', 2, 2, '87089900', 'Meter', 10, 93, '400.00', '400.00', '5.00', 'Shirt', '6907ed1a515e180ed6f3becbd4cc5332.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:20:58', 2, NULL, NULL, 'Active', '0'),
(13, 'PRD-1770972672', '1770972672274', 'Shirt', 2, 2, '87089900', 'Meter', 10, 4, '400.00', '400.00', '5.00', 'Shirt', '4887b134ef1be4f4a12bb0d44db38e2b.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:21:12', 2, NULL, NULL, 'Active', '0'),
(14, 'PRD-1770972756', '1770972756827', 'Shirt', 2, 2, '87089900', 'Meter', 10, 4, '400.00', '400.00', '5.00', 'Shirt', 'e40d332aa26e9298207b1ff384edff4c.png', 'M', 'Blue', 'Cotton', '2026-02-13 14:22:36', 2, '2026-02-13 14:27:24', 2, 'Active', '0');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

CREATE TABLE `purchase_details` (
  `purchase_detail_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_details`
--

INSERT INTO `purchase_details` (`purchase_detail_id`, `purchase_id`, `product_id`, `qty`, `purchase_price`, `tax_amount`, `total_amount`) VALUES
(1, 1, 3, 45, '600.00', '0.00', '27000.00'),
(2, 2, 3, 1, '600.00', '0.00', '600.00');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_master`
--

CREATE TABLE `purchase_master` (
  `purchase_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `bill_no` varchar(100) NOT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(15,2) DEFAULT '0.00',
  `paid_amount` decimal(15,2) DEFAULT '0.00',
  `payment_status` enum('Paid','Partially Paid','Unpaid') DEFAULT 'Unpaid',
  `status` enum('Completed','Pending','Cancelled') DEFAULT 'Completed',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_master`
--

INSERT INTO `purchase_master` (`purchase_id`, `supplier_id`, `bill_no`, `purchase_date`, `total_amount`, `paid_amount`, `payment_status`, `status`, `added_date`, `added_by`) VALUES
(1, 2, 'ABS7485', '2026-02-16', '27000.00', '0.00', 'Unpaid', 'Completed', '2026-02-16 14:00:41', 17),
(2, 2, 'ABS7485', '2026-03-09', '600.00', '0.00', 'Unpaid', 'Completed', '2026-03-08 13:47:28', 2);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_details`
--

CREATE TABLE `purchase_return_details` (
  `return_detail_id` int NOT NULL,
  `return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_return_details`
--

INSERT INTO `purchase_return_details` (`return_detail_id`, `return_id`, `product_id`, `qty`, `purchase_price`, `total_amount`) VALUES
(1, 1, 3, 5, '600.00', '3000.00');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_master`
--

CREATE TABLE `purchase_return_master` (
  `return_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  `return_no` varchar(100) NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(15,2) DEFAULT '0.00',
  `remarks` text,
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_return_master`
--

INSERT INTO `purchase_return_master` (`return_id`, `purchase_id`, `return_no`, `return_date`, `total_return_amount`, `remarks`, `added_date`, `added_by`) VALUES
(1, 1, 'RET-3894', '2026-02-16', '3000.00', '', '2026-02-16 14:10:32', 17);

-- --------------------------------------------------------

--
-- Table structure for table `sales_details`
--

CREATE TABLE `sales_details` (
  `sales_detail_id` int NOT NULL,
  `sales_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `sale_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_details`
--

INSERT INTO `sales_details` (`sales_detail_id`, `sales_id`, `product_id`, `qty`, `sale_price`, `total_amount`) VALUES
(1, 1, 3, 1, '480.00', '480.00'),
(2, 2, 5, 1, '450.00', '450.00');

-- --------------------------------------------------------

--
-- Table structure for table `sales_master`
--

CREATE TABLE `sales_master` (
  `sales_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `customer_phone_number` varchar(255) DEFAULT NULL,
  `bill_no` varchar(100) NOT NULL,
  `sales_date` date NOT NULL,
  `total_amount` decimal(15,2) DEFAULT '0.00',
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `discount_amount` decimal(15,2) DEFAULT '0.00',
  `payable_amount` decimal(15,2) DEFAULT '0.00',
  `paid_amount` decimal(15,2) DEFAULT '0.00',
  `payment_status` enum('Paid','Partially Paid','Unpaid') DEFAULT 'Unpaid',
  `payment_mode` enum('Cash','Card','UPI','Net Banking','Credit') DEFAULT 'Cash',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_master`
--

INSERT INTO `sales_master` (`sales_id`, `customer_id`, `customer_phone_number`, `bill_no`, `sales_date`, `total_amount`, `tax_amount`, `discount_amount`, `payable_amount`, `paid_amount`, `payment_status`, `payment_mode`, `added_date`, `added_by`) VALUES
(1, 1, NULL, 'INV-6120', '2026-02-16', '480.00', '0.00', '0.00', '480.00', '480.00', 'Paid', 'Cash', '2026-02-16 14:24:22', 17),
(2, NULL, '9874563210', 'INV-9871', '2026-02-16', '450.00', '0.00', '0.00', '450.00', '450.00', 'Paid', 'Cash', '2026-02-16 14:28:12', 17);

-- --------------------------------------------------------

--
-- Table structure for table `sales_return_details`
--

CREATE TABLE `sales_return_details` (
  `return_detail_id` int NOT NULL,
  `return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `sale_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_return_details`
--

INSERT INTO `sales_return_details` (`return_detail_id`, `return_id`, `product_id`, `qty`, `sale_price`, `total_amount`) VALUES
(1, 1, 3, 1, '480.00', '480.00');

-- --------------------------------------------------------

--
-- Table structure for table `sales_return_master`
--

CREATE TABLE `sales_return_master` (
  `return_id` int NOT NULL,
  `sales_id` int NOT NULL,
  `return_no` varchar(100) NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(15,2) DEFAULT '0.00',
  `remarks` text,
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_return_master`
--

INSERT INTO `sales_return_master` (`return_id`, `sales_id`, `return_no`, `return_date`, `total_return_amount`, `remarks`, `added_date`, `added_by`) VALUES
(1, 1, 'RET-1771232608', '2026-02-17', '480.00', 'Remarks', '2026-02-16 14:33:57', 17);

-- --------------------------------------------------------

--
-- Table structure for table `size_master`
--

CREATE TABLE `size_master` (
  `size_id` int NOT NULL,
  `size_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `size_master`
--

INSERT INTO `size_master` (`size_id`, `size_name`) VALUES
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL'),
(5, 'XXL'),
(6, '32'),
(7, '34'),
(8, '36');

-- --------------------------------------------------------

--
-- Table structure for table `stock_master`
--

CREATE TABLE `stock_master` (
  `stock_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL COMMENT 'typically the added amount',
  `previous_qty` int NOT NULL,
  `new_qty` int NOT NULL,
  `remarks` text,
  `added_by` int NOT NULL,
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
(9, 3, 1, 90, 91, 'Purchase Bill No: ABS7485', 2, '2026-03-08 13:47:28');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_master`
--

CREATE TABLE `supplier_master` (
  `supplier_id` int NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `gst_number` varchar(50) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `is_delete` tinyint(1) DEFAULT '0',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `supplier_master`
--

INSERT INTO `supplier_master` (`supplier_id`, `supplier_name`, `contact_person`, `email`, `phone`, `address`, `gst_number`, `status`, `is_delete`, `added_date`, `added_by`) VALUES
(1, 'Vardan Textiles', 'Rajesh Kumar', 'vardan@textiles.com', '9890012345', NULL, '27AAACV1234R1Z1', 'Active', 0, '2026-02-16 08:23:17', NULL),
(2, 'Everest Garments', 'Sunita Sharma', 'sales@everest.com', '9890054321', NULL, '27BBBCV4321S1Z2', 'Active', 0, '2026-02-16 08:23:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `unit_master`
--

CREATE TABLE `unit_master` (
  `unit_id` int NOT NULL,
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
  `id` int NOT NULL,
  `user_email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `user_role` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `added_date` datetime DEFAULT NULL,
  `added_by` int NOT NULL,
  `deleted` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `unit_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `groups` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login_attempt` int NOT NULL DEFAULT '0',
  `status` enum('Active','Inactive','Block') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userinfo`
--

INSERT INTO `userinfo` (`id`, `user_email`, `user_role`, `user_name`, `user_password`, `added_date`, `added_by`, `deleted`, `unit_ids`, `groups`, `login_attempt`, `status`) VALUES
(1, 'mullaaarbaj10@gmail.com', 'Admin', 'Aarbaj Mulla', 'Test@123', '2024-11-19 12:41:29', 3, NULL, '1,2', '1', 3, 'Active'),
(2, 'admin@gmail.com', 'Admin', 'Admin', 'Test@123', '2024-11-19 12:42:40', 3, '0', '1,2', '1', 0, 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(5, 'Salman', 'salman@gmail.com', NULL, '$2y$12$fs7BtR3u9LWaPJQ4OzKuEOIBddsTZPjw4NBC3W1xu4c7zqlsUeB4y', NULL, '2025-03-12 04:16:29', '2025-03-12 04:16:29');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `color_master`
--
ALTER TABLE `color_master`
  ADD PRIMARY KEY (`color_id`);

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
-- Indexes for table `expense_category`
--
ALTER TABLE `expense_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_master`
--
ALTER TABLE `expense_master`
  ADD PRIMARY KEY (`expense_id`);

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
-- Indexes for table `size_master`
--
ALTER TABLE `size_master`
  ADD PRIMARY KEY (`size_id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `color_master`
--
ALTER TABLE `color_master`
  MODIFY `color_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `company_master`
--
ALTER TABLE `company_master`
  MODIFY `company_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `config_setting`
--
ALTER TABLE `config_setting`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `customer_master`
--
ALTER TABLE `customer_master`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer_payments_invoice`
--
ALTER TABLE `customer_payments_invoice`
  MODIFY `customer_payments_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_product`
--
ALTER TABLE `customer_product`
  MODIFY `customer_product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_category`
--
ALTER TABLE `expense_category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `expense_master`
--
ALTER TABLE `expense_master`
  MODIFY `expense_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group_master`
--
ALTER TABLE `group_master`
  MODIFY `group_master_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `group_rights`
--
ALTER TABLE `group_rights`
  MODIFY `group_rights_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `material_master`
--
ALTER TABLE `material_master`
  MODIFY `material_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menu_category`
--
ALTER TABLE `menu_category`
  MODIFY `menu_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_master`
--
ALTER TABLE `menu_master`
  MODIFY `menu_master_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_master`
--
ALTER TABLE `product_master`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `purchase_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_master`
--
ALTER TABLE `purchase_master`
  MODIFY `purchase_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  MODIFY `return_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_return_master`
--
ALTER TABLE `purchase_return_master`
  MODIFY `return_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales_details`
--
ALTER TABLE `sales_details`
  MODIFY `sales_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales_master`
--
ALTER TABLE `sales_master`
  MODIFY `sales_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales_return_details`
--
ALTER TABLE `sales_return_details`
  MODIFY `return_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales_return_master`
--
ALTER TABLE `sales_return_master`
  MODIFY `return_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `size_master`
--
ALTER TABLE `size_master`
  MODIFY `size_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `stock_master`
--
ALTER TABLE `stock_master`
  MODIFY `stock_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `supplier_master`
--
ALTER TABLE `supplier_master`
  MODIFY `supplier_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `unit_master`
--
ALTER TABLE `unit_master`
  MODIFY `unit_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `userinfo`
--
ALTER TABLE `userinfo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
