-- Database Upgrade Script for Cloth Inventory Management System (CIMS)
-- This file adds essential tables for Suppliers, Transactions, and Master Constants.

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- Table structure for table `supplier_master`
--
CREATE TABLE IF NOT EXISTS `supplier_master` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `gst_number` varchar(50) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `is_delete` tinyint(1) DEFAULT '0',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Master Tables for Attributes
--
CREATE TABLE IF NOT EXISTS `unit_master` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(50) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `color_master` (
  `color_id` int NOT NULL AUTO_INCREMENT,
  `color_name` varchar(100) NOT NULL,
  PRIMARY KEY (`color_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `size_master` (
  `size_id` int NOT NULL AUTO_INCREMENT,
  `size_name` varchar(50) NOT NULL,
  PRIMARY KEY (`size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `material_master` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `material_name` varchar(100) NOT NULL,
  PRIMARY KEY (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `purchase_master`
--
CREATE TABLE IF NOT EXISTS `purchase_master` (
  `purchase_id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int NOT NULL,
  `bill_no` varchar(100) NOT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(15,2) DEFAULT '0.00',
  `paid_amount` decimal(15,2) DEFAULT '0.00',
  `payment_status` enum('Paid','Partially Paid','Unpaid') DEFAULT 'Unpaid',
  `status` enum('Completed','Pending','Cancelled') DEFAULT 'Completed',
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `purchase_details`
--
CREATE TABLE IF NOT EXISTS `purchase_details` (
  `purchase_detail_id` int NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`purchase_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `sales_master`
--
CREATE TABLE IF NOT EXISTS `sales_master` (
  `sales_id` int NOT NULL AUTO_INCREMENT,
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
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`sales_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `sales_details`
--
CREATE TABLE IF NOT EXISTS `sales_details` (
  `sales_detail_id` int NOT NULL AUTO_INCREMENT,
  `sales_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `sale_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sales_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `expense_category`
--
CREATE TABLE IF NOT EXISTS `expense_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `expense_master`
--
CREATE TABLE IF NOT EXISTS `expense_master` (
  `expense_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `expense_date` date NOT NULL,
  `remarks` text,
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Dumping Data
--
INSERT INTO `supplier_master` (`supplier_name`, `contact_person`, `phone`, `email`, `gst_number`) VALUES
('Vardan Textiles', 'Rajesh Kumar', '9890012345', 'vardan@textiles.com', '27AAACV1234R1Z1'),
('Everest Garments', 'Sunita Sharma', '9890054321', 'sales@everest.com', '27BBBCV4321S1Z2');

INSERT INTO `unit_master` (`unit_name`) VALUES ('Pieces'), ('Meters'), ('Sets'), ('Rolls');

INSERT INTO `color_master` (`color_name`) VALUES ('Red'), ('Blue'), ('Black'), ('White'), ('Green'), ('Yellow');

INSERT INTO `size_master` (`size_name`) VALUES ('S'), ('M'), ('L'), ('XL'), ('XXL'), ('32'), ('34'), ('36');

INSERT INTO `material_master` (`material_name`) VALUES ('Cotton'), ('Denim'), ('Silk'), ('Polyester'), ('Rayon'), ('Linen');

INSERT INTO `expense_category` (`category_name`) VALUES ('Rent'), ('Electricity'), ('Salary'), ('Maintenance'), ('Travel'), ('Stationery');

-- --------------------------------------------------------
-- Table structure for table `purchase_return_master`
--
CREATE TABLE IF NOT EXISTS `purchase_return_master` (
  `return_id` int NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `return_no` varchar(100) NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(15,2) DEFAULT '0.00',
  `remarks` text,
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `purchase_return_details`
--
CREATE TABLE IF NOT EXISTS `purchase_return_details` (
  `return_detail_id` int NOT NULL AUTO_INCREMENT,
  `return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `purchase_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`return_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `sales_return_master`
--
CREATE TABLE IF NOT EXISTS `sales_return_master` (
  `return_id` int NOT NULL AUTO_INCREMENT,
  `sales_id` int NOT NULL,
  `return_no` varchar(100) NOT NULL,
  `return_date` date NOT NULL,
  `total_return_amount` decimal(15,2) DEFAULT '0.00',
  `remarks` text,
  `added_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `sales_return_details`
--
CREATE TABLE IF NOT EXISTS `sales_return_details` (
  `return_detail_id` int NOT NULL AUTO_INCREMENT,
  `return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `sale_price` decimal(15,2) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`return_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
