-- DB Upgrade Script for Product Log Reports & Audit History
-- File: public/database/db_upgrade_1.sql
-- Date: 2026-09-16

CREATE TABLE IF NOT EXISTS product_activity_logs (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NULL DEFAULT NULL,
  product_name VARCHAR(255) NOT NULL,
  action_type ENUM('created', 'updated', 'stock_added', 'stock_removed', 'stock_adjusted', 'sale', 'sale_return', 'purchase', 'purchase_return', 'deleted', 'restored') NOT NULL DEFAULT 'updated',
  old_values LONGTEXT NULL DEFAULT NULL,
  new_values LONGTEXT NULL DEFAULT NULL,
  qty_change DECIMAL(10,2) NULL DEFAULT 0.00,
  price_change DECIMAL(10,2) NULL DEFAULT 0.00,
  reference_no VARCHAR(100) NULL DEFAULT NULL,
  remarks TEXT NULL DEFAULT NULL,
  created_by INT NULL DEFAULT NULL,
  user_name VARCHAR(150) NULL DEFAULT NULL,
  ip_address VARCHAR(45) NULL DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_product_id (product_id),
  KEY idx_action_type (action_type),
  KEY idx_created_by (created_by),
  KEY idx_created_at (created_at),
  CONSTRAINT fk_pal_product_id FOREIGN KEY (product_id) REFERENCES product_master (product_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
