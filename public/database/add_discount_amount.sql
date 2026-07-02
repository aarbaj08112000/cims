ALTER TABLE `sales_master` 
ADD COLUMN `discount_amount` DECIMAL(15,2) DEFAULT '0.00' 
AFTER `tax_amount`;
