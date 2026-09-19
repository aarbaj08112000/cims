CREATE TABLE IF NOT EXISTS activity_logs (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  user_name VARCHAR(150) NOT NULL,
  module_name VARCHAR(100) NOT NULL,
  action VARCHAR(100) NOT NULL,
  description TEXT,
  ip_address VARCHAR(45),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add user_role column to userinfo if missing
ALTER TABLE userinfo ADD COLUMN IF NOT EXISTS user_role VARCHAR(100) DEFAULT NULL AFTER user_password;

-- Ensure group_master table exists for dynamic user role assignment
CREATE TABLE IF NOT EXISTS group_master (
  group_master_id INT AUTO_INCREMENT PRIMARY KEY,
  group_name VARCHAR(100) NOT NULL,
  group_code VARCHAR(50) NOT NULL,
  status ENUM('Active','Inactive') DEFAULT 'Active',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;