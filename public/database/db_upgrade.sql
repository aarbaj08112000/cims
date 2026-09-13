-- DB Upgrade Script
-- Date: 2026-09-13
-- Product attributes and multiple images support


CREATE TABLE IF NOT EXISTS product_attributes (
  attr_id int NOT NULL AUTO_INCREMENT,
  product_id int NOT NULL,
  attr_name varchar(255) NOT NULL,
  attr_value varchar(255) NOT NULL,
  sort_order int DEFAULT 0,
  added_date datetime DEFAULT NULL,
  PRIMARY KEY (attr_id),
  KEY fk_pa_product_id (product_id),
  CONSTRAINT fk_pa_product_id FOREIGN KEY (product_id) REFERENCES product_master (product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_images (
  image_id int NOT NULL AUTO_INCREMENT,
  product_id int NOT NULL,
  image varchar(255) NOT NULL,
  is_primary tinyint(1) DEFAULT 0,
  sort_order int DEFAULT 0,
  added_date datetime DEFAULT NULL,
  PRIMARY KEY (image_id),
  KEY fk_pi_product_id (product_id),
  CONSTRAINT fk_pi_product_id FOREIGN KEY (product_id) REFERENCES product_master (product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
