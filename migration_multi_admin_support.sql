-- Migration: Multi-Admin Data Isolation Support
-- This migration ensures proper admin_id tracking across all tables
-- Note: IF NOT EXISTS is MySQL 5.7.6+. For older versions, run statements individually and ignore errors for existing columns.

-- 1. Ensure users table has admin_id column
ALTER TABLE `users` ADD COLUMN `admin_id` INT DEFAULT NULL COMMENT 'Admin who created this user';
ALTER TABLE `users` ADD INDEX `idx_users_admin_id` (`admin_id`);

-- 2. Ensure cases table has admin_id column  
ALTER TABLE `cases` ADD COLUMN `admin_id` INT DEFAULT NULL COMMENT 'Admin who created this case';
ALTER TABLE `cases` ADD INDEX `idx_cases_admin_id` (`admin_id`);

-- 3. Ensure admin_logs already has admin_id (it should, but verify index)
ALTER TABLE `admin_logs` ADD INDEX `idx_admin_logs_admin_id` (`admin_id`);

-- 4. Add admin_id to other relevant tables if they exist

-- Withdrawals
ALTER TABLE `withdrawals` ADD COLUMN `admin_id` INT DEFAULT NULL COMMENT 'Admin who processed this withdrawal';
ALTER TABLE `withdrawals` ADD INDEX `idx_withdrawals_admin_id` (`admin_id`);

-- Deposits
ALTER TABLE `deposits` ADD COLUMN `admin_id` INT DEFAULT NULL COMMENT 'Admin who processed this deposit';
ALTER TABLE `deposits` ADD INDEX `idx_deposits_admin_id` (`admin_id`);

-- Support tickets
ALTER TABLE `support_tickets` ADD COLUMN `assigned_admin_id` INT DEFAULT NULL COMMENT 'Admin assigned to this ticket';
ALTER TABLE `support_tickets` ADD INDEX `idx_support_tickets_admin_id` (`assigned_admin_id`);

-- User documents
ALTER TABLE `user_documents` ADD COLUMN `reviewed_by_admin_id` INT DEFAULT NULL COMMENT 'Admin who reviewed this document';
ALTER TABLE `user_documents` ADD INDEX `idx_user_documents_admin_id` (`reviewed_by_admin_id`);

-- Case recovery transactions
ALTER TABLE `case_recovery_transactions` ADD COLUMN `added_by_admin_id` INT DEFAULT NULL COMMENT 'Admin who added this recovery';
ALTER TABLE `case_recovery_transactions` ADD INDEX `idx_case_recovery_transactions_admin_id` (`added_by_admin_id`);

-- Admin notifications (each admin sees their own notifications)
ALTER TABLE `admin_notifications` ADD INDEX `idx_admin_notifications_admin_id` (`admin_id`);

-- 5. Add foreign key constraints (optional, for referential integrity)
-- Uncomment if you want strict foreign key enforcement

-- ALTER TABLE `users` 
-- ADD CONSTRAINT `fk_users_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE SET NULL;

-- ALTER TABLE `cases`
-- ADD CONSTRAINT `fk_cases_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE SET NULL;

-- ALTER TABLE `withdrawals`
-- ADD CONSTRAINT `fk_withdrawals_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE SET NULL;

-- ALTER TABLE `deposits`
-- ADD CONSTRAINT `fk_deposits_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins`(`id`) ON DELETE SET NULL;

-- 6. Update existing records with NULL admin_id to a default admin (optional)
-- Uncomment and modify if you want to assign existing records to a specific admin

-- UPDATE `users` SET `admin_id` = 1 WHERE `admin_id` IS NULL;
-- UPDATE `cases` SET `admin_id` = 1 WHERE `admin_id` IS NULL;

-- Migration complete!
-- Each admin will now only see:
-- - Users they created (WHERE admin_id = current_admin_id)
-- - Cases they created (WHERE admin_id = current_admin_id)  
-- - Logs from their actions (WHERE admin_id = current_admin_id)
