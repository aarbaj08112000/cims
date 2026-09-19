-- DB Upgrade Script for Currency Master
-- File: public/database/db_upgrade_2.sql
-- Date: 2026-09-17

CREATE TABLE IF NOT EXISTS `currency_master` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(100) NOT NULL,
  `currency_code` varchar(10) NOT NULL,
  `currency_symbol` varchar(10) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `added_by` int(11) DEFAULT NULL,
  `added_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `currency_master` (`currency_name`, `currency_code`, `currency_symbol`, `status`) VALUES
('Indian Rupee', 'INR', '₹', 'Active'),
('US Dollar', 'USD', '$', 'Active'),
('Euro', 'EUR', '€', 'Active'),
('British Pound', 'GBP', '£', 'Active'),
('Japanese Yen', 'JPY', '¥', 'Active'),
('Australian Dollar', 'AUD', 'A$', 'Active');

-- Add currency IDs to product_master
ALTER TABLE `product_master` 
ADD COLUMN `purchase_currency_id` INT NULL DEFAULT NULL AFTER `purchase_price`,
ADD COLUMN `selling_currency_id` INT NULL DEFAULT NULL AFTER `price`;

-- Set default currency (1 = INR) for all existing products
UPDATE `product_master` 
SET `purchase_currency_id` = 1, `selling_currency_id` = 1;

-- User Activity Log Table
CREATE TABLE IF NOT EXISTS `activity_logs` (
  `log_id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(150) NOT NULL,
  `module_name` VARCHAR(100) NOT NULL,
  `action` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `ip_address` VARCHAR(45),
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
