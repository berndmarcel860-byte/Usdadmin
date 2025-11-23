-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 23, 2025 at 01:09 AM
-- Server version: 8.0.42-0ubuntu0.20.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kryptox`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `role` enum('superadmin','admin','support') NOT NULL DEFAULT 'support',
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('active','suspended') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password_hash`, `first_name`, `last_name`, `role`, `last_login`, `created_at`, `status`) VALUES
(1, 'admin@scamrecovery.com', '$2y$12$3Hy8ykdirYbb.fgu1sboNe4n0xZgwoRGohoFLr9I6eiP/19cl.SRq', 'Admin', 'User', 'superadmin', '2025-11-22 20:18:26', '2025-07-18 22:19:13', 'active'),
(2, 'support@scamrecovery.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Support', 'Agent', 'support', '2025-07-18 22:19:13', '2025-07-18 22:19:13', 'active'),
(3, 'admin@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Admin', 'User', 'superadmin', NULL, '2025-07-20 04:57:41', 'active'),
(4, 'a@a.com', '$2y$10$jgnvw9GJbibWV9G9fIVoteudxKqyWZ8PkZBHALADy5jQ16RIjjpiO', 'Supad1', 'Aaa', 'admin', '2025-08-02 07:31:16', '2025-08-01 05:44:46', 'active'),
(5, 'kialgorithm@kryptox.co.uk', '$2y$10$wAIGqV5CO2qjEmeU24jFmuNkf7vNrexfuc0aRAPlqUC23vg.M6VcG', 'KI', 'Algorithm', 'superadmin', NULL, '2025-11-10 21:39:25', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `admin_login_logs`
--

CREATE TABLE `admin_login_logs` (
  `id` int NOT NULL,
  `admin_id` int DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `success` tinyint(1) DEFAULT '1',
  `attempted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` int DEFAULT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','warning','danger','success') NOT NULL DEFAULT 'info',
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_remember_tokens`
--

CREATE TABLE `admin_remember_tokens` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_remember_tokens`
--

INSERT INTO `admin_remember_tokens` (`id`, `admin_id`, `token`, `expires`, `created_at`) VALUES
(1, 1, 'c302ed851ed42e62e87e38932f60a43e06d77322a83246e011933b39e193cd89', '2025-08-29 22:28:32', '2025-07-30 22:28:32');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL COMMENT 'NULL if system action',
  `admin_id` int DEFAULT NULL COMMENT 'NULL if not admin action',
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(100) DEFAULT NULL,
  `entity_id` int DEFAULT NULL,
  `old_value` text,
  `new_value` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `id` int NOT NULL,
  `case_number` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `platform_id` int NOT NULL,
  `reported_amount` decimal(15,2) NOT NULL,
  `recovered_amount` decimal(15,2) DEFAULT '0.00',
  `status` enum('open','documents_required','under_review','refund_approved','refund_rejected','closed') DEFAULT 'open',
  `description` text,
  `admin_notes` text,
  `assigned_to` int DEFAULT NULL,
  `last_updated_by` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `recovery_stage` varchar(50) DEFAULT 'initial',
  `recovery_progress` int DEFAULT '0',
  `admin_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`id`, `case_number`, `user_id`, `platform_id`, `reported_amount`, `recovered_amount`, `status`, `description`, `admin_notes`, `assigned_to`, `last_updated_by`, `created_at`, `recovery_stage`, `recovery_progress`, `admin_id`) VALUES
(46, 'SCM-2025-4392', 43, 5, '152364.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-05 23:53:55', 'initial', 0, 1),
(47, 'SCM-2025-1146', 42, 4, '509713.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', '', NULL, NULL, '2025-11-10 21:29:43', 'initial', 0, 5),
(48, 'SCM-2025-1437', 42, 11, '27851.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', '', NULL, NULL, '2025-11-10 21:37:00', 'initial', 0, 5),
(49, 'SCM-2025-0550', 42, 12, '35401.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:40:42', 'initial', 0, 5),
(50, 'SCM-2025-5992', 42, 13, '27480.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:42:39', 'initial', 0, 5),
(51, 'SCM-2025-8490', 42, 16, '37370.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:45:10', 'initial', 0, 5),
(52, 'SCM-2025-1957', 42, 8, '11750.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:45:56', 'initial', 0, 5),
(53, 'SCM-2025-3342', 42, 9, '27450.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:46:25', 'initial', 0, 5),
(54, 'SCM-2025-0415', 42, 17, '21850.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:47:09', 'initial', 0, 5),
(55, 'SCM-2025-2154', 42, 18, '132202.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:48:00', 'initial', 0, 5),
(56, 'SCM-2025-5656', 42, 19, '49850.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:49:05', 'initial', 0, 5),
(57, 'SCM-2025-1121', 42, 20, '31500.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:49:35', 'initial', 0, 5),
(58, 'SCM-2025-3042', 42, 14, '72740.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:50:19', 'initial', 0, 5),
(59, 'SCM-2025-4314', 42, 21, '24500.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:50:41', 'initial', 0, 5),
(60, 'SCM-2025-9070', 42, 22, '461720.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:51:27', 'initial', 0, 5),
(61, 'SCM-2025-6819', 42, 23, '17500.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:52:09', 'initial', 0, 5),
(62, 'SCM-2025-8226', 42, 24, '17000.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:52:26', 'initial', 0, 5),
(63, 'SCM-2025-7527', 42, 10, '1069046.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-10 21:53:46', 'initial', 0, 5),
(66, 'SCM-2025-1614', 29, 2, '123456.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-11 00:56:12', 'initial', 0, 5),
(67, 'SCM-2025-5493', 36, 1, '132.00', '15.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-11 00:57:16', 'initial', 0, 5),
(68, 'SCM-2025-5276', 39, 6, '1492221.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-13 14:53:16', 'initial', 0, 5),
(69, 'SCM-2025-2069', 44, 1, '2500.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-19 20:24:12', 'initial', 0, 5),
(70, 'SCM-2025-7381', 44, 1, '56137.00', '0.00', 'open', 'KI-gestützte Fallregistrierung erfolgreich abgeschlossen. Erste Rückverfolgung der Transaktionen läuft.', NULL, NULL, NULL, '2025-11-22 18:22:51', 'initial', 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `case_documents`
--

CREATE TABLE `case_documents` (
  `id` int NOT NULL,
  `case_id` int NOT NULL,
  `document_type` varchar(100) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_by` int NOT NULL COMMENT 'User ID who uploaded',
  `notes` text,
  `verified` tinyint(1) DEFAULT '0',
  `verified_by` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `case_recovery_transactions`
--

CREATE TABLE `case_recovery_transactions` (
  `id` int NOT NULL,
  `case_id` int NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `transaction_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_by` int NOT NULL COMMENT 'Admin ID who processed this',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `case_recovery_transactions`
--

INSERT INTO `case_recovery_transactions` (`id`, `case_id`, `amount`, `transaction_date`, `processed_by`, `notes`) VALUES
(42, 67, '15.00', '2025-11-11 01:03:09', 1, '15');

--
-- Triggers `case_recovery_transactions`
--
DELIMITER $$
CREATE TRIGGER `after_recovery_insert` AFTER INSERT ON `case_recovery_transactions` FOR EACH ROW BEGIN

    -- Update case recovered amount

    UPDATE cases 

    SET recovered_amount = (

        SELECT SUM(amount) 

        FROM case_recovery_transactions 

        WHERE case_id = NEW.case_id

    )

    WHERE id = NEW.case_id;

    

    -- Update user balance

    UPDATE users u

    JOIN cases c ON u.id = c.user_id

    SET u.balance = u.balance + NEW.amount

    WHERE c.id = NEW.case_id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `case_status_history`
--

CREATE TABLE `case_status_history` (
  `id` int NOT NULL,
  `case_id` int NOT NULL,
  `old_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_by` int DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `case_status_history`
--

INSERT INTO `case_status_history` (`id`, `case_id`, `old_status`, `new_status`, `changed_by`, `notes`, `action`, `created_at`) VALUES
(79, 46, NULL, 'open', 1, 'Case created', NULL, '2025-11-05 23:53:55'),
(80, 47, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:29:43'),
(81, 48, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:37:00'),
(82, 49, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:40:42'),
(83, 49, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:40:42'),
(84, 50, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:42:39'),
(85, 50, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:42:39'),
(86, 51, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:45:10'),
(87, 51, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:45:10'),
(88, 52, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:45:56'),
(89, 52, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:45:56'),
(90, 53, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:46:25'),
(91, 53, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:46:25'),
(92, 54, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:47:09'),
(93, 54, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:47:09'),
(94, 55, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:48:00'),
(95, 55, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:48:00'),
(96, 56, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:49:05'),
(97, 56, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:49:05'),
(98, 57, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:49:35'),
(99, 57, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:49:35'),
(100, 58, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:50:19'),
(101, 58, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:50:19'),
(102, 59, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:50:41'),
(103, 59, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:50:41'),
(104, 60, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:51:27'),
(105, 60, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:51:27'),
(106, 61, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:52:09'),
(107, 61, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:52:09'),
(108, 62, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:52:26'),
(109, 62, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:52:26'),
(110, 63, NULL, 'open', 1, 'Case created', NULL, '2025-11-10 21:53:46'),
(111, 63, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-10 21:53:46'),
(116, 66, NULL, 'open', 1, 'Case created', NULL, '2025-11-11 00:56:12'),
(117, 66, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-11 00:56:12'),
(118, 67, NULL, 'open', 1, 'Case created', NULL, '2025-11-11 00:57:16'),
(119, 67, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-11 00:57:16'),
(120, 68, NULL, 'open', 1, 'Case created', NULL, '2025-11-13 14:53:16'),
(121, 68, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-13 14:53:16'),
(122, 69, NULL, 'open', 1, 'Case created', NULL, '2025-11-19 20:24:12'),
(123, 69, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-19 20:24:12'),
(124, 70, NULL, 'open', 1, 'Case created', NULL, '2025-11-22 18:22:51'),
(125, 70, NULL, 'open', 1, 'Case assigned to admin ID: 5', NULL, '2025-11-22 18:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method_code` varchar(50) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `proof_path` varchar(255) NOT NULL,
  `payment_details` text,
  `admin_notes` text,
  `processed_by` int DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `status` enum('pending','completed','failed','approved','rejected') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `user_id`, `amount`, `method_code`, `reference`, `proof_path`, `payment_details`, `admin_notes`, `processed_by`, `processed_at`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '200.00', 'bitcoin', '', '', NULL, NULL, NULL, NULL, 'failed', '2025-07-21 20:51:44', '2025-08-02 04:27:12'),
(2, 1, '200.00', 'bank_transfer', '', '', NULL, NULL, NULL, NULL, 'failed', '2025-07-21 20:51:54', '2025-08-02 04:39:27'),
(3, 5, '333.00', 'bank_transfer', '', '', NULL, NULL, NULL, NULL, 'failed', '2025-07-31 03:53:11', '2025-07-31 03:54:30'),
(4, 3, '144.00', 'BANK_TRANSFER', 'DEP-1755145450-AB75EA', '../uploads/proofs/deposit_689d64eab75c4.jpg', NULL, NULL, NULL, NULL, 'pending', '2025-08-14 04:24:10', NULL),
(5, 3, '144.00', 'BANK_TRANSFER', 'DEP-1755145529-90F886', '../uploads/proofs/deposit_689d65390f85a.jpg', NULL, NULL, NULL, NULL, 'pending', '2025-08-14 04:25:29', NULL),
(6, 3, '999.00', 'BANK_TRANSFER', 'DEP-1755195199-F31D36', '../uploads/proofs/deposit_689e273f31c0d.png', NULL, NULL, NULL, NULL, 'pending', '2025-08-14 18:13:19', NULL),
(8, 3, '999.00', 'BANK_TRANSFER', 'DEP-1755212247-732DCC', '../uploads/proofs/deposit_689e69d732da9.png', NULL, NULL, NULL, NULL, 'pending', '2025-08-14 22:57:27', NULL),
(9, 3, '1934.99', 'BITCOIN', 'DEP-1755212512-088228', '../uploads/proofs/deposit_689e6ae088208.png', NULL, NULL, NULL, NULL, 'pending', '2025-08-14 23:01:52', NULL),
(10, 1, '9993.00', 'BANK_TRANSFER', 'DEP-1755221639-778B34', '../uploads/proofs/deposit_689e8e87789bc.png', NULL, NULL, NULL, NULL, 'pending', '2025-08-15 01:33:59', NULL),
(11, 2, '443.00', 'BANK_TRANSFER', 'DEP-1755566723-37C9A4', '../uploads/proofs/deposit_68a3d2837c5a6.png', NULL, NULL, NULL, NULL, 'pending', '2025-08-19 01:25:23', NULL),
(12, 20, '443.00', 'BANK_TRANSFER', 'DEP-1755572829-D05A27', '../uploads/proofs/deposit_68a3ea5d056d9.png', NULL, NULL, 1, '2025-11-01 06:05:45', 'completed', '2025-08-19 03:07:09', '2025-11-01 06:05:45'),
(13, 39, '1200.00', 'ETHEREUM', 'DEP-1761862854-660186', '../uploads/proofs/deposit_6903e4c65ff80.PNG', NULL, NULL, NULL, NULL, 'pending', '2025-10-30 22:20:54', NULL),
(14, 39, '1200.00', 'ETHEREUM', 'DEP-1761862970-AAD01E', '../uploads/proofs/deposit_6903e53aacfef.PNG', NULL, NULL, NULL, NULL, 'pending', '2025-10-30 22:22:50', NULL),
(15, 36, '588.00', 'BITCOIN', 'DEP-1761968320-02713C', '../uploads/proofs/deposit_690580c026e29.png', NULL, NULL, NULL, NULL, 'completed', '2025-11-01 04:38:40', '2025-11-01 04:39:17'),
(16, 36, '123.00', 'ETHEREUM', 'DEP-1761968457-9E09E2', '../uploads/proofs/deposit_69058149e09ad.png', NULL, NULL, NULL, NULL, 'completed', '2025-11-01 04:40:57', '2025-11-01 04:42:58'),
(17, 36, '7777.00', 'BITCOIN', 'DEP-1761969406-EEA205', '../uploads/proofs/deposit_690584feea1e8.png', NULL, NULL, NULL, NULL, 'approved', '2025-11-01 04:56:46', '2025-11-01 05:05:56'),
(18, 36, '664.00', 'BANK_TRANSFER', 'DEP-1761970060-C566EF', '../uploads/proofs/deposit_6905878c566ce.jpeg', NULL, NULL, NULL, NULL, 'pending', '2025-11-01 05:07:40', NULL),
(19, 36, '1111.00', 'BANK_TRANSFER', 'DEP-1761970686-E1CA4D', '../uploads/proofs/deposit_690589fe1ca22.png', NULL, NULL, 1, '2025-11-01 05:19:07', 'completed', '2025-11-01 05:18:06', '2025-11-01 05:19:07'),
(20, 36, '222.00', 'BANK_TRANSFER', 'DEP-1761971020-CC2DE8', '../uploads/proofs/deposit_69058b4cc2dca.png', NULL, NULL, 1, '2025-11-01 05:29:33', 'completed', '2025-11-01 05:23:40', '2025-11-01 05:29:33'),
(21, 36, '2121.00', 'BANK_TRANSFER', 'DEP-1761971491-39E491', '../uploads/proofs/deposit_69058d239e46d.png', NULL, NULL, 1, '2025-11-01 05:34:35', 'completed', '2025-11-01 05:31:31', '2025-11-01 05:34:35'),
(22, 36, '5555.00', 'BITCOIN', 'DEP-1761972197-5766A7', '../uploads/proofs/deposit_69058fe576680.png', NULL, NULL, 1, '2025-11-01 05:43:40', 'completed', '2025-11-01 05:43:17', '2025-11-01 05:43:40'),
(23, 36, '9999.00', 'BANK_TRANSFER', 'DEP-1761972384-0D2095', '../uploads/proofs/deposit_690590a0d206a.png', NULL, NULL, 1, '2025-11-01 05:52:36', 'completed', '2025-11-01 05:46:24', '2025-11-01 05:52:36'),
(24, 36, '3333.00', 'BITCOIN', 'DEP-1761972783-F2525A', '../uploads/proofs/deposit_6905922f25192.png', NULL, NULL, 1, '2025-11-01 06:12:01', 'completed', '2025-11-01 05:53:03', '2025-11-01 06:12:01'),
(25, 36, '7571.00', 'BITCOIN', 'DEP-1761974329-95BF0C', '../uploads/proofs/deposit_690598395beee.png', NULL, NULL, 1, '2025-11-01 06:19:31', 'completed', '2025-11-01 06:18:49', '2025-11-01 06:19:31'),
(26, 36, '323232.00', 'BITCOIN', 'DEP-1761974514-20F368', '../uploads/proofs/deposit_690598f20f33b.png', NULL, NULL, 1, '2025-11-01 06:22:14', 'completed', '2025-11-01 06:21:54', '2025-11-01 06:22:14'),
(27, 36, '666.00', 'BANK_TRANSFER', 'DEP-1761975629-D833F5', '../uploads/proofs/deposit_69059d4d833bd.jpeg', NULL, NULL, NULL, NULL, 'pending', '2025-11-01 06:40:29', NULL),
(28, 36, '555.00', 'BANK_TRANSFER', 'DEP-1761975692-CAA759', '../uploads/proofs/deposit_69059d8caa733.jpeg', NULL, NULL, NULL, NULL, 'pending', '2025-11-01 06:41:32', NULL),
(29, 36, '200.00', 'BANK_TRANSFER', 'DEP-1762060129-171566', '../uploads/proofs/deposit_6906e761711da.jpg', NULL, NULL, 1, '2025-11-03 09:24:30', 'completed', '2025-11-02 06:08:49', '2025-11-03 09:24:30'),
(30, 36, '4999.00', 'BANK_TRANSFER', 'DEP-1762817715-33CC9B', '../uploads/proofs/deposit_691276b33c96a.jpeg', NULL, NULL, 1, '2025-11-11 00:37:26', 'completed', '2025-11-11 00:35:15', '2025-11-11 00:37:26'),
(31, 36, '443.00', 'BANK_TRANSFER', 'DEP-1762818675-334057', '../uploads/proofs/deposit_69127a7334031.jpeg', NULL, NULL, 1, '2025-11-11 00:59:20', 'completed', '2025-11-11 00:51:15', '2025-11-11 00:59:20');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `case_id` int DEFAULT NULL,
  `document_name` varchar(255) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_logs`
--

CREATE TABLE `email_logs` (
  `id` int NOT NULL,
  `template_id` int DEFAULT NULL,
  `recipient` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sent_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('sent','failed','delivered','opened') DEFAULT 'sent',
  `tracking_token` varchar(255) DEFAULT NULL,
  `error_message` text,
  `opened_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int NOT NULL,
  `template_key` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `variables` text COMMENT 'JSON array of available variables',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `template_key`, `subject`, `content`, `variables`, `created_at`) VALUES
(1, 'user_registration', 'Willkommen bei ScamRecovery - Ihr Konto wurde erstellt', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Willkommen bei ScamRecovery</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n<p>vielen Dank für Ihre Registrierung bei ScamRecovery. Ihr Konto wurde erfolgreich erstellt.</p>\r\n\r\n<p>Ihre Anmeldedaten:</p>\r\n\r\n<ul>\r\n\r\n<li>E-Mail: {email}</li>\r\n\r\n<li>Passwort: Das von Ihnen gewählte Passwort</li>\r\n\r\n</ul>\r\n\r\n<p style=\"text-align: center; margin: 30px 0;\">\r\n\r\n<a href=\"{verification_link}\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; display: inline-block; padding: 10px 18px; color: #ffffff; background-color: #1a202c; border-radius: 3px; text-decoration: none;\">E-Mail bestätigen</a>\r\n\r\n</p>\r\n\r\n<p>Falls Sie sich nicht registriert haben, ignorieren Sie bitte diese E-Mail.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>Ihr ScamRecovery Team</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 ScamRecovery. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"first_name\", \"last_name\", \"email\", \"verification_link\"]', '2025-08-02 06:52:21'),
(2, 'case_created1', 'Neuer Fall erstellt - Fallnummer: {case_number}', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Neuer Fall erstellt</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n<p>vielen Dank für die Einreichung Ihres Falls bei ScamRecovery. Wir haben Ihren Fall erhalten und werden uns so schnell wie möglich bei Ihnen melden.</p>\r\n\r\n<div style=\"background-color: #fff; border: 1px solid #ddd; padding: 15px; margin: 15px 0; border-radius: 5px;\">\r\n\r\n<h3>Falldetails:</h3>\r\n\r\n<p><strong>Fallnummer:</strong> {case_number}</p>\r\n\r\n<p><strong>Plattform:</strong> {platform_name}</p>\r\n\r\n<p><strong>Gemeldeter Betrag:</strong> {reported_amount} €</p>\r\n\r\n<p><strong>Beschreibung:</strong> {case_description}</p>\r\n\r\n<p><strong>Status:</strong> {case_status}</p>\r\n\r\n</div>\r\n\r\n<p>Bitte stellen Sie alle relevanten Dokumente über Ihr Kundenportal bereit, um den Prozess zu beschleunigen.</p>\r\n\r\n<p>Sie können den Fortschritt Ihres Falls jederzeit in Ihrem Konto einsehen.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>Ihr ScamRecovery Team</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 ScamRecovery. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"first_name\", \"last_name\", \"case_number\", \"platform_name\", \"reported_amount\", \"case_description\", \"case_status\"]', '2025-08-02 06:52:21'),
(3, 'case_status_updated', 'Fallstatus aktualisiert - Fallnummer: {case_number}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Fallstatus aktualisiert – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #007bff;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Fallstatus aktualisiert – {case_number}</h1>\r\n      <p>Aktuelle Informationen zu Ihrem Fall</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Der Status Ihres Falls wurde erfolgreich aktualisiert.  \r\n        Nachfolgend finden Sie die neuesten Informationen:\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>📄 Aktualisierte Falldetails</h3>\r\n        <p><strong>Fallnummer:</strong> {case_number}</p>\r\n        <p><strong>Vorheriger Status:</strong> {old_status}</p>\r\n        <p><strong>Neuer Status:</strong> {new_status}</p>\r\n        <p><strong>Grund / Notizen:</strong> {status_notes}</p>\r\n        <p><strong>Datum der Änderung:</strong> {update_date}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Sie können den aktuellen Stand Ihres Falls jederzeit in Ihrem\r\n        <strong>Kundenportal</strong> einsehen und relevante Unterlagen hochladen.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Fallmanagement-Team</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"case_number\", \"old_status\", \"new_status\",\"site_url\", \"status_notes\", \"update_date\"]', '2025-08-02 06:52:21'),
(4, 'documents_required', 'Dokumente erforderlich für Fallnummer: {case_number}', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Dokumente erforderlich</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n<p>um Ihren Fall ({case_number}) weiter bearbeiten zu können, benötigen wir folgende Dokumente von Ihnen:</p>\r\n\r\n<div style=\"background-color: #fff; border: 1px solid #ddd; padding: 15px; margin: 15px 0; border-radius: 5px;\">\r\n\r\n<h3>Erforderliche Dokumente:</h3>\r\n\r\n<ul>\r\n\r\n{#each required_documents}\r\n\r\n<li>{this}</li>\r\n\r\n{/each}\r\n\r\n</ul>\r\n\r\n<p><strong>Hinweise:</strong> {additional_notes}</p>\r\n\r\n</div>\r\n\r\n<p style=\"text-align: center; margin: 30px 0;\">\r\n\r\n<a href=\"{upload_link}\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; display: inline-block; padding: 10px 18px; color: #ffffff; background-color: #1a202c; border-radius: 3px; text-decoration: none;\">Dokumente hochladen</a>\r\n\r\n</p>\r\n\r\n<p>Bitte laden Sie die Dokumente so bald wie möglich hoch, um Verzögerungen in der Bearbeitung zu vermeiden.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>Ihr ScamRecovery Team</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 ScamRecovery. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"first_name\", \"last_name\", \"case_number\", \"required_documents\", \"additional_notes\", \"upload_link\"]', '2025-08-02 06:52:21'),
(5, 'recovery_amount_updated', 'Erstattungsbetrag aktualisiert - Fallnummer: {case_number}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Erstattungsbetrag aktualisiert – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #007bff;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Erstattungsbetrag aktualisiert – {case_number}</h1>\r\n      <p>Neue Rückerstattungsinformationen verfügbar</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir freuen uns, Ihnen mitteilen zu können, dass für Ihren Fall  \r\n        <strong>{case_number}</strong> ein neuer Rückerstattungsbetrag verbucht wurde.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>💰 Erstattungsdetails</h3>\r\n        <p><strong>Fallnummer:</strong> {case_number}</p>\r\n        <p><strong>Ursprünglicher Betrag:</strong> {reported_amount} €</p>\r\n        <p><strong>Neuer Rückerstattungsbetrag:</strong> {recovered_amount} €</p>\r\n        <p><strong>Gesamtrückerstattung bisher:</strong> {total_recovered} €</p>\r\n        <p><strong>Datum der Erstattung:</strong> {recovery_date}</p>\r\n        <p><strong>Notizen:</strong> {recovery_notes}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Der Betrag wurde Ihrem internen Konto gutgeschrieben und steht Ihnen  \r\n        ab sofort zur Auszahlung im <strong>Kundenportal</strong> zur Verfügung.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Rückerstattungsabteilung</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"case_number\", \"reported_amount\",\"site_url\", \"recovered_amount\", \"total_recovered\", \"recovery_date\", \"recovery_notes\"]', '2025-08-02 06:52:21'),
(6, 'kyc_approved', 'Ihre KYC-Verifizierung wurde genehmigt', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>KYC-Verifizierung erfolgreich – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #28a74510 0%, #28a74505 100%);\r\n      border-left: 5px solid #28a745;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #28a745;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>KYC-Verifizierung erfolgreich</h1>\r\n      <p>Ihr Konto ist jetzt vollständig verifiziert</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir freuen uns, Ihnen mitteilen zu können, dass Ihre  \r\n        <strong>KYC-Verifizierung (Know Your Customer)</strong> erfolgreich abgeschlossen wurde.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>✅ Verifizierungsdetails</h3>\r\n        <p><strong>Verifiziertes Konto:</strong> {email}</p>\r\n        <p><strong>Datum der Verifizierung:</strong> {kyc_date}</p>\r\n        <p><strong>Status:</strong> Erfolgreich abgeschlossen</p>\r\n      </div>\r\n\r\n      <p>\r\n        Ihr Konto ist nun vollständig freigeschaltet und Sie können alle Funktionen  \r\n        unserer Plattform uneingeschränkt nutzen – inklusive Auszahlungen, Fallmanagement  \r\n        und Transaktionsverfolgung in Echtzeit.\r\n      </p>\r\n\r\n      <p>\r\n        Sollten Sie Fragen haben oder weitere Unterstützung benötigen, steht Ihnen  \r\n        unser <strong>Support-Team</strong> jederzeit zur Verfügung.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Verifizierungsteam</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\",\"site_url\"]', '2025-08-02 06:52:21'),
(7, 'kyc_rejected', 'Ihre KYC-Verifizierung erfordert weitere Schritte', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>KYC-Verifizierung nicht erfolgreich – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #a83232 0%, #d64545 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #ff000010 0%, #ff000005 100%);\r\n      border-left: 5px solid #d93025;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #d93025;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #d93025;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .btn:hover {\r\n      background: #b1271f;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>KYC-Verifizierung nicht erfolgreich</h1>\r\n      <p>Überprüfung Ihrer Unterlagen fehlgeschlagen</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Leider konnten wir Ihre <strong>KYC-Verifizierung (Know Your Customer)</strong>  \r\n        nicht erfolgreich abschließen. Bitte beachten Sie die unten aufgeführten Hinweise.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>❗ Gründe für die Ablehnung</h3>\r\n        <p>{rejection_reason}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Um den Prozess fortzusetzen, reichen Sie bitte die fehlenden oder korrigierten  \r\n        Dokumente über unser sicheres <strong>Kundenportal</strong> erneut ein.\r\n      </p>\r\n\r\n      <p style=\"text-align:center;\">\r\n        <a href=\"{resubmit_link}\" class=\"btn\">Dokumente erneut einreichen</a>\r\n      </p>\r\n\r\n      <p>\r\n        Nach erfolgreicher Überprüfung werden Sie automatisch per E-Mail informiert.  \r\n        Sollten Sie Fragen zur Ablehnung oder zu den nächsten Schritten haben,  \r\n        steht Ihnen unser Support-Team gerne zur Verfügung.\r\n      </p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Verifizierungsteam</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"rejection_reason\", \"resubmit_link\",\"site_url\"]', '2025-08-02 06:52:21'),
(8, 'deposit_received', 'Einzahlung erhalten - Betrag: {amount}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Einzahlung erhalten – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #007bff;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .btn:hover {\r\n      background: #005dc1;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Einzahlung erhalten</h1>\r\n      <p>Ihre Transaktion wurde erfolgreich verbucht</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir bestätigen den erfolgreichen Eingang Ihrer <strong>Einzahlung</strong>.  \r\n        Der Betrag wurde Ihrem Kontoguthaben gutgeschrieben und steht Ihnen ab sofort zur Verfügung.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>💳 Transaktionsdetails</h3>\r\n        <p><strong>Betrag:</strong> {amount} </p>\r\n        <p><strong>Zahlungsmethode:</strong> {payment_method}</p>\r\n        <p><strong>Transaktions-ID:</strong> {transaction_id}</p>\r\n        <p><strong>Datum:</strong> {transaction_date}</p>\r\n        <p><strong>Status:</strong> {transaction_status}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Sie können Ihre vollständige Transaktionshistorie sowie Ihr aktuelles Guthaben  \r\n        jederzeit in Ihrem <strong>Kundenportal</strong> einsehen.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Finanzabteilung</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"amount\", \"payment_method\", \"transaction_id\", \"transaction_date\", \"transaction_status\",\"site_url\"]', '2025-08-02 06:52:21');
INSERT INTO `email_templates` (`id`, `template_key`, `subject`, `content`, `variables`, `created_at`) VALUES
(9, 'withdrawal_requested', 'Auszahlungsanfrage erhalten - Betrag: {amount}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Auszahlungsanfrage erhalten – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #007bff;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .btn:hover {\r\n      background: #005dc1;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Auszahlungsanfrage erhalten</h1>\r\n      <p>Ihre Anfrage wird derzeit geprüft</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir bestätigen den Eingang Ihrer <strong>Auszahlungsanfrage</strong>.  \r\n        Unser Team hat die Bearbeitung eingeleitet. Die Details Ihrer Anfrage finden Sie unten:\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>💸 Transaktionsdetails</h3>\r\n        <p><strong>Betrag:</strong> {amount} €</p>\r\n        <p><strong>Zahlungsmethode:</strong> {payment_method}</p>\r\n        <p><strong>Zahlungsdetails:</strong> {payment_details}</p>\r\n        <p><strong>Transaktions-ID:</strong> {transaction_id}</p>\r\n        <p><strong>Datum der Anfrage:</strong> {transaction_date}</p>\r\n        <p><strong>Status:</strong> {transaction_status}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Die Bearbeitung Ihrer Auszahlung kann bis zu <strong>3 Werktage</strong> in Anspruch nehmen.  \r\n        Sie werden automatisch benachrichtigt, sobald die Transaktion abgeschlossen ist.\r\n      </p>\r\n\r\n      <p>\r\n        Den aktuellen Fortschritt Ihrer Auszahlung können Sie jederzeit  \r\n        in Ihrem <strong>Kundenportal</strong> einsehen.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Finanzabteilung</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"amount\", \"payment_method\", \"payment_details\", \"transaction_id\", \"transaction_date\", \"transaction_status\",\"site_url\"]', '2025-08-02 06:52:21'),
(10, 'withdrawal_completed', 'Auszahlung abgeschlossen - Betrag: {amount}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Auszahlung abgeschlossen – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 12px 20px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .btn:hover {\r\n      background: #005dc1;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Auszahlung abgeschlossen</h1>\r\n      <p>Ihre Auszahlungsanfrage wurde erfolgreich bearbeitet</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Ihre Auszahlungsanfrage wurde erfolgreich bearbeitet.  \r\n        Der Betrag wurde an Sie überwiesen.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>💳 Transaktionsdetails</h3>\r\n        <p><strong>Betrag:</strong> {amount} €</p>\r\n        <p><strong>Zahlungsmethode:</strong> {payment_method}</p>\r\n        <p><strong>Zahlungsdetails:</strong> {payment_details}</p>\r\n        <p><strong>Transaktions-ID:</strong> {transaction_id}</p>\r\n        <p><strong>Datum der Auszahlung:</strong> {transaction_date}</p>\r\n        <p><strong>Status:</strong> {transaction_status}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Bitte beachten Sie, dass es je nach Zahlungsmethode einige Tage dauern kann,  \r\n        bis der Betrag auf Ihrem Konto erscheint.\r\n      </p>\r\n\r\n      <p style=\"text-align:center;\">\r\n        <a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a>\r\n      </p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          Sitz der Gesellschaft: Frankfurt am Main – Registergericht: Frankfurt am Main – HRB: 10162132<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"amount\", \"payment_method\", \"payment_details\", \"transaction_id\", \"transaction_date\", \"transaction_status\",\"site_url\"]', '2025-08-02 06:52:21'),
(11, 'password_reset', 'Passwort zurücksetzen - ScamRecovery', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Passwort zurücksetzen – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 12px 20px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .btn:hover {\r\n      background: #005dc1;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Passwort zurücksetzen</h1>\r\n      <p>Sichere Wiederherstellung Ihres Kontozugangs</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir haben eine Anfrage zum <strong>Zurücksetzen Ihres Passworts</strong> erhalten.  \r\n        Um ein neues Passwort festzulegen, klicken Sie bitte auf den folgenden Button:\r\n      </p>\r\n\r\n      <p style=\"text-align:center;\">\r\n        <a href=\"{reset_link}\" class=\"btn\">Passwort jetzt zurücksetzen</a>\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <p>🔒 Aus Sicherheitsgründen ist dieser Link nur <strong>24 Stunden gültig</strong>.</p>\r\n        <p>Wenn Sie diese Anfrage <strong>nicht gestellt</strong> haben, ignorieren Sie bitte diese E-Mail oder wenden Sie sich an unseren Support.</p>\r\n      </div>\r\n\r\n      <p>\r\n        Nach erfolgreichem Zurücksetzen können Sie sich mit Ihrem neuen Passwort im  \r\n        <strong>Kundenportal</strong> anmelden.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Login</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Sicherheitsteam</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"reset_link\",\"site_url\"]', '2025-08-02 06:52:21'),
(12, 'support_ticket_created', 'Support-Ticket erstellt - Ticketnummer: {ticket_number}', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Support-Ticket erstellt</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n<p>vielen Dank für die Kontaktaufnahme mit unserem Support-Team. Wir haben Ihr Ticket erhalten und werden uns so schnell wie möglich bei Ihnen melden.</p>\r\n\r\n<div style=\"background-color: #fff; border: 1px solid #ddd; padding: 15px; margin: 15px 0; border-radius: 5px;\">\r\n\r\n<h3>Ticketdetails:</h3>\r\n\r\n<p><strong>Ticketnummer:</strong> {ticket_number}</p>\r\n\r\n<p><strong>Betreff:</strong> {ticket_subject}</p>\r\n\r\n<p><strong>Kategorie:</strong> {ticket_category}</p>\r\n\r\n<p><strong>Priorität:</strong> {ticket_priority}</p>\r\n\r\n<p><strong>Status:</strong> {ticket_status}</p>\r\n\r\n<p><strong>Ihre Nachricht:</strong><br>{ticket_message}</p>\r\n\r\n</div>\r\n\r\n<p>Sie können den Status Ihres Tickets jederzeit in Ihrem Kundenportal einsehen.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>Ihr ScamRecovery Team</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 ScamRecovery. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"first_name\", \"last_name\", \"ticket_number\", \"ticket_subject\", \"ticket_category\", \"ticket_priority\", \"ticket_status\", \"ticket_message\"]', '2025-08-02 06:52:21'),
(13, 'support_ticket_updated', 'Aktualisierung zu Ihrem Support-Ticket - Ticketnummer: {ticket_number}', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Support-Ticket aktualisiert</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n<p>es gibt eine Aktualisierung zu Ihrem Support-Ticket ({ticket_number}). Hier sind die Details:</p>\r\n\r\n<div style=\"background-color: #fff; border: 1px solid #ddd; padding: 15px; margin: 15px 0; border-radius: 5px;\">\r\n\r\n<h3>Ticketaktualisierung:</h3>\r\n\r\n<p><strong>Ticketnummer:</strong> {ticket_number}</p>\r\n\r\n<p><strong>Status:</strong> {ticket_status}</p>\r\n\r\n<p><strong>Aktualisierung vom:</strong> {update_date}</p>\r\n\r\n<p><strong>Antwort von Support:</strong><br>{ticket_response}</p>\r\n\r\n</div>\r\n\r\n<p>Sie können auf diese E-Mail antworten oder das Ticket direkt in Ihrem Kundenportal aktualisieren.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>Ihr ScamRecovery Team</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 ScamRecovery. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"first_name\", \"last_name\", \"ticket_number\", \"ticket_status\", \"update_date\", \"ticket_response\"]', '2025-08-02 06:52:21'),
(14, 'admin_created_user', 'Your account has been created by an administrator', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Account Created</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Dear {first_name} {last_name},</p>\r\n\r\n<p>An administrator ({admin_name}) has created an account for you on our platform.</p>\r\n\r\n<p>Your login details:</p>\r\n\r\n<ul>\r\n\r\n<li>Email: {email}</li>\r\n\r\n<li>Password: The one provided by the administrator</li>\r\n\r\n</ul>\r\n\r\n<p style=\"text-align: center; margin: 30px 0;\">\r\n\r\n<a href=\"{login_link}\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; display: inline-block; padding: 10px 18px; color: #ffffff; background-color: #1a202c; border-radius: 3px; text-decoration: none;\">Login</a>\r\n\r\n</p>\r\n\r\n<p>Please change your password after your first login.</p>\r\n\r\n<p>If you did not request this account, please contact our support team immediately.</p>\r\n\r\n<p>Best regards,<br>Your ScamRecovery Team</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 ScamRecovery. All rights reserved.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"first_name\",\"last_name\",\"email\",\"admin_name\",\"login_link\"]', '2025-08-02 07:15:59'),
(15, 'welcome_email1', 'Herzlich willkommen bei {sbrand}!', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Welcome to {sbrand}</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {last_name},</p>\r\n\r\n<p>Herzlich willkommen bei {sbrand}! Wir freuen uns, dass Sie sich für uns entschieden haben.</p>\r\n\r\n<p style=\"text-align: center; margin: 30px 0;\">\r\n\r\n<a href=\"{surl}/login.php\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; display: inline-block; padding: 10px 18px; color: #ffffff; background-color: #1a202c; border-radius: 3px; text-decoration: none;\">Zum Login</a>\r\n\r\n</p>\r\n\r\n<p>Hier sind Ihre Anmeldedaten:</p>\r\n\r\n<p><b>Benutzername:</b> {email}</p>\r\n\r\n<p><b>Passwort:</b> {pass}</p>\r\n\r\n<p>Bitte ändern Sie Ihr Passwort nach der ersten Anmeldung in Ihrem Profil unter \"Profil bearbeiten\" -> \"Passwort ändern\".</p>\r\n\r\n<p>Vielen Dank für Ihr Vertrauen. Sollten Sie Fragen haben, stehen wir Ihnen gerne zur Verfügung.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>{sbrand}</p>\r\n\r\n<p><b>E-Mail: {semail}</b></p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 {sbrand}. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"last_name\",\"email\",\"pass\",\"sbrand\",\"surl\",\"semail\"]', '2025-08-02 07:54:52');
INSERT INTO `email_templates` (`id`, `template_key`, `subject`, `content`, `variables`, `created_at`) VALUES
(16, 'welcome_email_text', 'Herzlich willkommen bei {sbrand}!', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n\r\n<head>\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n\r\n<meta name=\"color-scheme\" content=\"light\">\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\">\r\n\r\n<style>\r\n\r\n@media only screen and (max-width: 600px) {\r\n\r\n.inner-body {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n.footer {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n@media only screen and (max-width: 500px) {\r\n\r\n.button {\r\n\r\nwidth: 100% !important;\r\n\r\n}\r\n\r\n}\r\n\r\n</style>\r\n\r\n</head>\r\n\r\n<body style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -webkit-text-size-adjust: none; background-color: #ffffff; color: #718096; height: 100%; line-height: 1.4; margin: 0; padding: 0; width: 100% !important;\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<tr>\r\n\r\n<td class=\"header\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; padding: 25px 0; text-align: center;\">\r\n\r\n<h1>Welcome to {sbrand}</h1>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td class=\"body\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 100%; background-color: #edf2f7; border-bottom: 1px solid #edf2f7; border-top: 1px solid #edf2f7; margin: 0; padding: 0; width: 100%;\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; background-color: #ffffff; border-color: #e8e5ef; border-radius: 2px; border-width: 1px; box-shadow: 0 2px 0 rgba(0, 0, 150, 0.025), 2px 4px 0 rgba(0, 0, 150, 0.015); margin: 0 auto; padding: 0; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p>Sehr geehrte/r {{name}},</p>\r\n\r\n<p>Herzlich willkommen bei {{sbrand}}! Wir freuen uns, dass Sie sich für uns entschieden haben.</p>\r\n\r\n<p>Hier sind Ihre Anmeldedaten:</p>\r\n\r\n<p><b>Benutzername:</b> {{email}}</p>\r\n\r\n<p><b>Passwort:</b> {{pass}}</p>\r\n\r\n<p style=\"text-align: center; margin: 30px 0;\">\r\n\r\n<a href=\"{surl}/login.php\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; display: inline-block; padding: 10px 18px; color: #ffffff; background-color: #1a202c; border-radius: 3px; text-decoration: none;\">Zum Login</a>\r\n\r\n</p>\r\n\r\n<p>Bitte ändern Sie Ihr Passwort nach der ersten Anmeldung in Ihrem Profil unter \"Profil bearbeiten\" -> \"Passwort ändern\".</p>\r\n\r\n<p>Vielen Dank für Ihr Vertrauen. Sollten Sie Fragen haben, stehen wir Ihnen gerne zur Verfügung.</p>\r\n\r\n<p>Mit freundlichen Grüßen,<br>{{sbrand}}</p>\r\n\r\n<p><b>Tel: {{sphone}}</b></p>\r\n\r\n<p><b>E-Mail: {{semail}}</b></p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n<tr>\r\n\r\n<td style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative;\">\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; -premailer-cellpadding: 0; -premailer-cellspacing: 0; -premailer-width: 570px; margin: 0 auto; padding: 0; text-align: center; width: 570px;\">\r\n\r\n<tr>\r\n\r\n<td class=\"content-cell\" align=\"center\" style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; max-width: 100vw; padding: 32px;\">\r\n\r\n<p style=\"box-sizing: border-box; font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: relative; line-height: 1.5em; margin-top: 0; color: #b0adc5; font-size: 12px; text-align: center;\">© 2025 {{sbrand}}. Alle Rechte vorbehalten.</p>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</td>\r\n\r\n</tr>\r\n\r\n</table>\r\n\r\n</body>\r\n\r\n</html>', '[\"name\",\"email\",\"pass\",\"sbrand\",\"surl\",\"sphone\",\"semail\"]', '2025-08-02 07:54:52'),
(17, 'deposit_confirmation', 'Einzahlungsbestätigung - Referenz: {reference}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Auszahlung abgeschlossen – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 12px 20px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .btn:hover {\r\n      background: #005dc1;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Auszahlung abgeschlossen</h1>\r\n      <p>Ihre Auszahlungsanfrage wurde erfolgreich bearbeitet</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir freuen uns, Ihnen mitzuteilen, dass Ihre Auszahlungsanfrage  \r\n        erfolgreich abgeschlossen wurde. Der Betrag wurde an Ihr angegebenes  \r\n        Konto überwiesen.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>💳 Transaktionsdetails</h3>\r\n        <p><strong>Betrag:</strong> {amount} €</p>\r\n        <p><strong>Zahlungsmethode:</strong> {payment_method}</p>\r\n        <p><strong>Zahlungsdetails:</strong> {payment_details}</p>\r\n        <p><strong>Transaktions-ID:</strong> {transaction_id}</p>\r\n        <p><strong>Datum der Auszahlung:</strong> {transaction_date}</p>\r\n        <p><strong>Status:</strong> {transaction_status}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Bitte beachten Sie, dass es je nach Zahlungsanbieter bis zu  \r\n        <strong>3 Werktage</strong> dauern kann, bis der Betrag auf Ihrem  \r\n        Konto erscheint.\r\n      </p>\r\n\r\n      <p style=\"text-align:center;\">\r\n        <a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a>\r\n      </p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Finanzabteilung</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"username\", \"amount\", \"reference\", \"payment_method\", \"date\", \"current_year\", \"site_name\", \"site_url\", \"support_email\",\"site_url\"]', '2025-08-19 04:53:51'),
(18, 'kyc_pending', 'KYC-Verifizierung ausstehend - {kyc_id}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>KYC-Verifizierung ausstehend – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .info-box {\r\n      background: #e8f4f8;\r\n      border-left: 5px solid #2950a8;\r\n      border-radius: 6px;\r\n      padding: 18px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .info-box h3 {\r\n      margin-top: 0;\r\n      color: #2950a8;\r\n    }\r\n\r\n    .info-box table {\r\n      width: 100%;\r\n      border-collapse: collapse;\r\n      font-size: 14px;\r\n    }\r\n\r\n    .info-box td {\r\n      padding: 6px 4px;\r\n    }\r\n\r\n    .success-box {\r\n      background: #d4edda;\r\n      border-left: 5px solid #28a745;\r\n      border-radius: 6px;\r\n      padding: 18px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .success-box h3 {\r\n      color: #155724;\r\n      margin-top: 0;\r\n    }\r\n\r\n    .warning-box {\r\n      background: #fff3cd;\r\n      border-left: 5px solid #ffc107;\r\n      border-radius: 6px;\r\n      padding: 18px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .warning-box h3 {\r\n      color: #856404;\r\n      margin-top: 0;\r\n    }\r\n\r\n    .alert-box {\r\n      background: #f8d7da;\r\n      border-left: 5px solid #dc3545;\r\n      border-radius: 6px;\r\n      padding: 15px;\r\n      margin: 20px 0;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container { width: 94%; }\r\n      .header h1 { font-size: 22px; }\r\n      .signature img { height: 45px; }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>KYC-Verifizierung ausstehend</h1>\r\n      <p>Ihre Identitätsprüfung wird derzeit überprüft</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>vielen Dank für die Einreichung Ihrer KYC-Dokumente (<em>Know Your Customer</em>) bei KryptoX.</p>\r\n\r\n      <div class=\"info-box\">\r\n        <h3>📋 Verifizierungsdetails</h3>\r\n        <table>\r\n          <tr><td><strong>KYC-ID:</strong></td><td>{kyc_id}</td></tr>\r\n          <tr><td><strong>Dokumenttyp:</strong></td><td>{document_type}</td></tr>\r\n          <tr><td><strong>Datum & Uhrzeit:</strong></td><td>{date}</td></tr>\r\n          <tr><td><strong>Status:</strong></td><td><span style=\"background:#ffc107; color:#000; padding:2px 8px; border-radius:10px;\">⏳ In Bearbeitung</span></td></tr>\r\n        </table>\r\n      </div>\r\n\r\n      <div class=\"success-box\">\r\n        <h3>✅ Dokumente erfolgreich erhalten</h3>\r\n        <ul>\r\n          <li>Vorderseite des Ausweisdokuments</li>\r\n          <li>Rückseite des Ausweisdokuments (falls zutreffend)</li>\r\n          <li>Selfie mit Ausweisdokument</li>\r\n          <li>Adressnachweis</li>\r\n        </ul>\r\n      </div>\r\n\r\n      <div class=\"warning-box\">\r\n        <h3>🔄 Nächste Schritte</h3>\r\n        <ul>\r\n          <li><strong>Überprüfung:</strong> Unser Compliance-Team prüft Ihre Unterlagen innerhalb von 1–3 Werktagen</li>\r\n          <li><strong>Verifizierung:</strong> Wir bestätigen die Echtheit und Lesbarkeit der eingereichten Dokumente</li>\r\n          <li><strong>Kontofreischaltung:</strong> Nach erfolgreicher Prüfung wird Ihr Konto vollständig freigeschaltet</li>\r\n          <li><strong>Benachrichtigung:</strong> Sie erhalten automatisch eine E-Mail, sobald die Überprüfung abgeschlossen ist</li>\r\n        </ul>\r\n      </div>\r\n\r\n      <p>Sie können den Status Ihrer KYC-Verifizierung jederzeit in Ihrem Dashboard einsehen.</p>\r\n\r\n      <div class=\"alert-box\">\r\n        <p><strong>⚠️ Sicherheitshinweis:</strong> Falls Sie diese KYC-Einreichung nicht autorisiert haben, kontaktieren Sie bitte umgehend unseren Support unter <a href=\"mailto:{support_email}\">{support_email}</a> mit der KYC-ID <strong>{kyc_id}</strong>.</p>\r\n      </div>\r\n\r\n      <p>Unser Support-Team steht Ihnen 24/7 zur Verfügung, um Sie bei Fragen zu Ihrer KYC-Verifizierung oder Ihrem Konto zu unterstützen.</p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Compliance & Verification Team</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.  \r\n      <br>🔒 Diese Nachricht wurde automatisch generiert – bitte antworten Sie nicht direkt.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', 'first_name,last_name,kyc_id,document_type,date,support_email,current_year,site_name,site_url', '2025-08-20 16:16:28'),
(19, 'payout_confirmation_document_send1', 'Ihre Auszahlungsbestätigung & Rechnung – {invoice_no}', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\"><head>\r\n\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n\r\n<meta name=\"color-scheme\" content=\"light\" />\r\n\r\n<meta name=\"supported-color-schemes\" content=\"light\" />\r\n\r\n<style>@media only screen and (max-width:600px){.inner-body{width:100%!important}.footer{width:100%!important}}@media only screen and (max-width:500px){.button{width:100%!important}}</style>\r\n\r\n</head><body style=\"background-color:#ffffff;color:#718096;margin:0;padding:0;width:100%!important;font-family:-apple-system,BlinkMacSystemFont,\'Segoe UI\',Roboto,Helvetica,Arial,sans-serif\">\r\n\r\n<table class=\"wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"background-color:#edf2f7;margin:0;padding:0;width:100%\"><tr><td align=\"center\">\r\n\r\n<table class=\"content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\">\r\n\r\n<tr><td class=\"header\" style=\"padding:25px 0;text-align:center\"><h1 style=\"margin:0;color:#1a202c\">{brand_name}</h1></td></tr>\r\n\r\n<tr><td class=\"body\" width=\"100%\" style=\"background-color:#edf2f7;border-top:1px solid #edf2f7;border-bottom:1px solid #edf2f7\">\r\n\r\n<table class=\"inner-body\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"background-color:#ffffff;border:1px solid #e8e5ef;border-radius:2px;margin:0 auto;width:570px\">\r\n\r\n<tr><td class=\"content-cell\" style=\"padding:32px\">\r\n\r\n<p style=\"margin-top:0;color:#2d3748\">Guten Tag {full_name},</p>\r\n\r\n<p style=\"color:#2d3748\">anbei erhalten Sie Ihre <strong>Auszahlungsbestätigung</strong> und die dazugehörige <strong>Rechnung</strong>.</p>\r\n\r\n<table style=\"border-collapse:collapse;font-size:14px;color:#2d3748\">\r\n\r\n<tr><td style=\"padding:6px 8px;border-bottom:1px solid #edf2f7\">Rechnungsnummer:</td><td style=\"padding:6px 8px;border-bottom:1px solid #edf2f7\"><strong>{invoice_no}</strong></td></tr>\r\n\r\n<tr><td style=\"padding:6px 8px;border-bottom:1px solid #edf2f7\">Rechnungsdatum:</td><td style=\"padding:6px 8px;border-bottom:1px solid #edf2f7\">{invoice_date}</td></tr>\r\n\r\n<tr><td style=\"padding:6px 8px\">Servicegebühr:</td><td style=\"padding:6px 8px\">{service_fee} €</td></tr>\r\n\r\n</table>\r\n\r\n<p style=\"color:#2d3748\">Viele Grüße<br />{brand_name}</p>\r\n\r\n</td></tr></table>\r\n\r\n</td></tr>\r\n\r\n<tr><td>\r\n\r\n<table class=\"footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"text-align:center;margin:0 auto;width:570px\"><tr><td class=\"content-cell\" align=\"center\" style=\"padding:32px\">\r\n\r\n<p style=\"margin:0;color:#b0adc5;font-size:12px;text-align:center\">© 2025 {brand_name}. Alle Rechte vorbehalten.</p>\r\n\r\n</td></tr></table>\r\n\r\n</td></tr></table></td></tr></table></body></html>', '[\"full_name\", \"invoice_no\", \"invoice_date\", \"service_fee\", \"brand_name\"]', '2025-09-10 03:45:40'),
(20, 'payout_confirmation_document_send', 'Ihre Auszahlungsbestätigung & Rechnung – {invoice_no}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Auszahlungsbestätigung & Rechnung – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    table.details {\r\n      width: 100%;\r\n      border-collapse: collapse;\r\n      margin-top: 15px;\r\n      background: #fff;\r\n      border-radius: 6px;\r\n      overflow: hidden;\r\n      box-shadow: 0 2px 8px rgba(0,0,0,0.03);\r\n    }\r\n\r\n    table.details td {\r\n      padding: 10px 12px;\r\n      border-bottom: 1px solid #eee;\r\n      font-size: 14px;\r\n    }\r\n\r\n    table.details tr:last-child td {\r\n      border-bottom: none;\r\n    }\r\n\r\n    table.details td:first-child {\r\n      color: #555;\r\n      width: 50%;\r\n    }\r\n\r\n    table.details td:last-child {\r\n      text-align: right;\r\n      font-weight: bold;\r\n      color: #111;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 18px;\r\n      border-radius: 6px;\r\n      margin: 25px 0;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container { width: 94%; }\r\n      .header h1 { font-size: 22px; }\r\n      .signature img { height: 45px; }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Auszahlungsbestätigung</h1>\r\n      <p>Ihre Auszahlung wurde erfolgreich verarbeitet</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Guten Tag {full_name},</p>\r\n\r\n      <p>\r\n        anbei erhalten Sie die <strong>Bestätigung Ihrer Auszahlung</strong> sowie  \r\n        die zugehörige <strong>Rechnung</strong> für Ihre Unterlagen.\r\n      </p>\r\n\r\n      <table class=\"details\">\r\n        <tr>\r\n          <td>Rechnungsnummer:</td>\r\n          <td>{invoice_no}</td>\r\n        </tr>\r\n        <tr>\r\n          <td>Rechnungsdatum:</td>\r\n          <td>{invoice_date}</td>\r\n        </tr>\r\n        <tr>\r\n          <td>Erstattungsbetrag:</td>\r\n          <td>{lost_amount} €</td>\r\n        </tr>\r\n        <tr>\r\n          <td>Servicegebühr:</td>\r\n          <td>{service_fee} €</td>\r\n        </tr>\r\n      </table>\r\n\r\n      <div class=\"highlight-box\">\r\n        <p>\r\n          💡 Bitte beachten Sie, dass der ausgewiesene Betrag je nach Bank  \r\n          innerhalb von 1–3 Werktagen auf Ihrem Konto eingehen kann.\r\n        </p>\r\n      </div>\r\n\r\n      <p>\r\n        Falls Sie Rückfragen zu dieser Auszahlung oder Rechnung haben,  \r\n        steht Ihnen unser Support-Team gerne zur Verfügung.\r\n      </p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Finanzabteilung</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"full_name\", \"invoice_no\", \"invoice_date\", \"lost_amount\", \"service_fee\", \"brand_name\",\"site_url\"]', '2025-09-10 03:45:40'),
(21, 'welcome_email', 'Herzlich willkommen bei {sbrand}!', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n    <meta charset=\"utf-8\">\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n    <title>Welcome to {sbrand}</title>\r\n    <style>\r\n        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; background: #f8f9fa; margin: 0; padding: 0; }\r\n        .container { max-width: 600px; margin: 30px auto; background: #fff; border-radius: 10px; box-shadow: 0 3px 10px rgba(0,0,0,0.1); overflow: hidden; }\r\n        .header { background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%); color: white; text-align: center; padding: 30px 20px; }\r\n        .header h1 { margin: 0; font-size: 24px; }\r\n        .content { padding: 25px; background: #f9f9f9; }\r\n        .details { background: #fff; padding: 20px; border-left: 4px solid #007bff; border-radius: 6px; margin: 20px 0; }\r\n        .btn { display: inline-block; background: #007bff; color: white; padding: 10px 18px; border-radius: 5px; text-decoration: none; font-weight: bold; }\r\n        .footer { text-align: center; font-size: 12px; color: #666; padding: 20px; background: #f1f1f1; }\r\n        .highlight { color: #007bff; font-weight: bold; }\r\n        .signature { margin-top: 30px; border-top: 1px solid #e0e0e0; padding-top: 20px; font-size: 14px; color: #555; }\r\n        .signature img { height: 45px; margin-bottom: 10px; }\r\n        .signature p { margin: 4px 0; }\r\n        @media only screen and (max-width: 600px) {\r\n            .container { width: 95%; }\r\n            .content { padding: 15px; }\r\n        }\r\n    </style>\r\n</head>\r\n<body>\r\n    <div class=\"container\">\r\n        <div class=\"header\">\r\n            <h1>Willkommen bei {sbrand}</h1>\r\n            <p>Ihr Zugang ist erfolgreich eingerichtet!</p>\r\n        </div>\r\n\r\n        <div class=\"content\">\r\n            <p>Sehr geehrte/r {last_name},</p>\r\n            <p>Herzlich willkommen bei <strong>{sbrand}</strong>! Wir freuen uns, dass Sie sich für uns entschieden haben.</p>\r\n\r\n            <div class=\"details\">\r\n                <h4>🔐 Ihre Zugangsdaten</h4>\r\n                <p><strong>Benutzername:</strong> {email}<br>\r\n                <strong>Passwort:</strong> {pass}</p>\r\n                <p style=\"margin-top: 10px;\">\r\n                    <a href=\"{surl}/login.php\" class=\"btn\">Zum Login</a>\r\n                </p>\r\n            </div>\r\n\r\n            <div style=\"background: #fff3cd; border: 1px solid #ffc107; padding: 15px; border-radius: 6px;\">\r\n                <p style=\"margin: 0;\"><strong>⚠️ Sicherheitshinweis:</strong> Bitte ändern Sie Ihr Passwort nach der ersten Anmeldung unter <em>„Profil bearbeiten → Passwort ändern“</em>.</p>\r\n            </div>\r\n\r\n            <p style=\"margin-top: 20px;\">Vielen Dank für Ihr Vertrauen. Sollten Sie Fragen haben, stehen wir Ihnen jederzeit gerne zur Verfügung.</p>\r\n\r\n            <p>Mit freundlichen Grüßen,</p>\r\n\r\n            <div class=\"signature\">\r\n                <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n                <strong>{sbrand}</strong><br>\r\n                </strong><br>\r\n                Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n                E: <a href=\"mailto:info@kryptox.co.uk\" style=\"color:#007bff;\">info@kryptox.co.uk</a><br>\r\n                W: <a href=\"https://kryptox.co.uk\" style=\"color:#007bff;\">kryptox.co.uk</a>\r\n                <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n                    <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten. Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n                </p>\r\n            </div>\r\n        </div>\r\n    </div>\r\n</body>\r\n</html>', '[\"last_name\",\"email\",\"pass\",\"sbrand\",\"surl\",\"semail\"]', '2025-10-29 23:57:17'),
(22, 'case_created', 'Neuer Fall erstellt - Fallnummer: {case_number}', '<!DOCTYPE html>\r\n<html>\r\n<head>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title>Fall automatisch erstellt – KryptoX</title>\r\n  <style>\r\n    body {\r\n      font-family: Arial, sans-serif;\r\n      line-height: 1.6;\r\n      color: #333;\r\n      background: #f4f6f8;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    .container {\r\n      max-width: 640px;\r\n      margin: 30px auto;\r\n      background: #fff;\r\n      border-radius: 10px;\r\n      box-shadow: 0 4px 16px rgba(0,0,0,0.08);\r\n      overflow: hidden;\r\n    }\r\n\r\n    .header {\r\n      background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%);\r\n      color: #fff;\r\n      text-align: center;\r\n      padding: 30px 20px;\r\n    }\r\n    .header h1 {\r\n      margin: 0;\r\n      font-size: 26px;\r\n      font-weight: 600;\r\n    }\r\n    .header p {\r\n      margin-top: 8px;\r\n      font-size: 15px;\r\n      opacity: 0.9;\r\n    }\r\n\r\n    .content {\r\n      padding: 25px;\r\n      background: #f9f9f9;\r\n    }\r\n\r\n    .highlight-box {\r\n      background: linear-gradient(90deg, #007bff10 0%, #007bff05 100%);\r\n      border-left: 5px solid #007bff;\r\n      padding: 20px;\r\n      border-radius: 6px;\r\n      margin: 20px 0;\r\n    }\r\n    .highlight-box h3 {\r\n      margin-top: 0;\r\n      color: #007bff;\r\n    }\r\n    .highlight-box p {\r\n      margin: 6px 0;\r\n    }\r\n\r\n    .btn {\r\n      display: inline-block;\r\n      background: #007bff;\r\n      color: white;\r\n      padding: 10px 18px;\r\n      border-radius: 5px;\r\n      text-decoration: none;\r\n      font-weight: bold;\r\n      margin-top: 15px;\r\n    }\r\n\r\n    .signature {\r\n      margin-top: 40px;\r\n      border-top: 1px solid #e0e0e0;\r\n      padding-top: 25px;\r\n      font-size: 14px;\r\n      color: #555;\r\n      text-align: center;\r\n    }\r\n\r\n    .signature img {\r\n      height: 50px;\r\n      margin: 0 auto 12px;\r\n      display: block;\r\n    }\r\n\r\n    .signature strong {\r\n      color: #111;\r\n      font-size: 15px;\r\n    }\r\n\r\n    .signature a {\r\n      color: #007bff;\r\n      text-decoration: none;\r\n    }\r\n\r\n    .signature p {\r\n      font-size: 12px;\r\n      color: #777;\r\n      line-height: 1.5;\r\n      margin-top: 8px;\r\n    }\r\n\r\n    .footer {\r\n      text-align: center;\r\n      font-size: 12px;\r\n      color: #777;\r\n      padding: 15px;\r\n      background: #f1f3f5;\r\n    }\r\n\r\n    @media only screen and (max-width: 600px) {\r\n      .container {\r\n        width: 94%;\r\n      }\r\n      .header h1 {\r\n        font-size: 22px;\r\n      }\r\n      .signature img {\r\n        height: 45px;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <div class=\"container\">\r\n    <div class=\"header\">\r\n      <h1>Fall automatisch erstellt – {case_number}</h1>\r\n      <p>Ihr Fall wurde erfolgreich registriert</p>\r\n    </div>\r\n\r\n    <div class=\"content\">\r\n      <p>Sehr geehrte/r {first_name} {last_name},</p>\r\n\r\n      <p>\r\n        Wir freuen uns, Ihnen mitzuteilen, dass unser \r\n        <strong>KI-Algorithmus</strong> bei der Durchsuchung der Transaktionsdaten\r\n        erfolgreich einen <strong>Fall für Sie erstellt</strong> hat.\r\n      </p>\r\n\r\n      <p>\r\n        Der Algorithmus arbeitet nun aktiv daran, die relevanten\r\n        Zahlungs- und Blockchain-Bewegungen zu analysieren,\r\n        um die <strong>Rückerstattung Ihrer Gelder</strong> einzuleiten.\r\n      </p>\r\n\r\n      <p>\r\n        Sie werden über jeden weiteren Prozessschritt automatisch informiert,\r\n        sobald neue Ergebnisse oder Statusänderungen vorliegen.\r\n      </p>\r\n\r\n      <div class=\"highlight-box\">\r\n        <h3>📄 Falldetails</h3>\r\n        <p><strong>Fallnummer:</strong> {case_number}</p>\r\n        <p><strong>Plattform:</strong> {platform_name}</p>\r\n        <p><strong>Ermittelter Betrag:</strong> {reported_amount} €</p>\r\n        <p><strong>Beschreibung:</strong> {case_description}</p>\r\n        <p><strong>Status:</strong> {case_status}</p>\r\n      </div>\r\n\r\n      <p>\r\n        Sie können den Fortschritt jederzeit in Ihrem <strong>Kundenportal</strong> verfolgen\r\n        und dort relevante Dokumente zur Unterstützung hochladen.\r\n      </p>\r\n\r\n      <p><a href=\"{site_url}/login.php\" class=\"btn\">Zum Kundenportal</a></p>\r\n\r\n      <p>Mit freundlichen Grüßen,</p>\r\n\r\n      <div class=\"signature\">\r\n        <img src=\"https://kryptox.co.uk/assets/img/logo.png\" alt=\"KryptoX Logo\"><br>\r\n        <strong>KryptoX – Fallmanagement-Team</strong><br>\r\n        Davidson House Forbury Square, Reading, RG1 3EUR G 1 3 E U, UNITED KINGDOM<br>\r\n        E: <a href=\"mailto:info@kryptox.co.uk\">info@kryptox.co.uk</a> | \r\n        W: <a href=\"https://kryptox.co.uk\">kryptox.co.uk</a>\r\n        <p>\r\n          FCA Referenc Nr: 910584<br>\r\n          <br>\r\n          <em>Hinweis:</em> Diese E-Mail kann vertrauliche oder rechtlich geschützte Informationen enthalten.  \r\n          Wenn Sie nicht der richtige Adressat sind, informieren Sie uns bitte und löschen Sie diese Nachricht.\r\n        </p>\r\n      </div>\r\n    </div>\r\n\r\n    <div class=\"footer\">\r\n      © 2025 KryptoX. Alle Rechte vorbehalten.\r\n    </div>\r\n  </div>\r\n</body>\r\n</html>\r\n', '[\"first_name\", \"last_name\", \"case_number\", \"platform_name\", \"reported_amount\", \"case_description\",\"site_url\",\"case_status\"]', '2025-10-30 00:20:19');

-- --------------------------------------------------------

--
-- Table structure for table `email_templates_backup`
--

CREATE TABLE `email_templates_backup` (
  `id` int NOT NULL DEFAULT '0',
  `template_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `variables` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'JSON array of available variables',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_templates_backup1`
--

CREATE TABLE `email_templates_backup1` (
  `id` int NOT NULL DEFAULT '0',
  `template_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `variables` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'JSON array of available variables',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_tracking`
--

CREATE TABLE `email_tracking` (
  `id` int NOT NULL,
  `tracking_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `referrer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opened_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_verifications`
--

CREATE TABLE `kyc_verifications` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `document_type` enum('passport','id_card','driving_license','other') NOT NULL,
  `document_number` varchar(100) DEFAULT NULL,
  `document_front` varchar(255) DEFAULT NULL,
  `document_back` varchar(255) DEFAULT NULL,
  `selfie` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `rejection_reason` text,
  `verified_by` int DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_verification_requests`
--

CREATE TABLE `kyc_verification_requests` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `document_type` enum('passport','id_card','driving_license','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_front` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_back` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selfie_with_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_proof` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `rejection_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `verified_by` int DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL COMMENT 'NULL if login failed',
  `email` varchar(255) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` text,
  `success` tinyint(1) NOT NULL,
  `attempted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_users`
--

CREATE TABLE `online_users` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `session_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` datetime NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp_logs`
--

CREATE TABLE `otp_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `otp_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` enum('withdrawal','login','password_reset') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'withdrawal',
  `is_verified` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `features` text COMMENT 'JSON array of features',
  `recovery_speed` varchar(50) DEFAULT NULL,
  `support_level` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `duration_days` int DEFAULT '30'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `description`, `price`, `features`, `recovery_speed`, `support_level`, `created_at`, `duration_days`) VALUES
(1, 'Basic Recovery', 'Essential recovery services for small cases', '399.00', '[\"Case assessment\",\"Basic document review\",\"Email support\"]', '4-6 weeks', 'Email (48h response)', '2025-07-24 00:33:39', 2),
(2, 'Standard Recovery', 'Comprehensive recovery package', '779.00', '[\"Priority case handling\",\"Full document review\",\"Dedicated case manager\",\"Phone & email support\"]', '2-4 weeks', 'Business hours phone support', '2025-07-24 00:33:39', 30),
(3, 'Premium Recovery', 'Advanced recovery with legal support', '1880.00', '[\"Expedited processing\",\"Legal document preparation\",\"Direct attorney access\",\"24/7 support\"]', '1-2 weeks', '24/7 priority support', '2025-07-24 00:33:39', 30),
(4, 'VIP Recovery', 'Complete recovery solution for large cases', '2730.00', '[\"Immediate case assignment\",\"Senior recovery specialist\",\"Legal team engagement\",\"Personal account manager\"]', '3-7 days', 'Dedicated account manager', '2025-07-24 00:33:39', 30),
(5, '48H Test Access', 'Free 48-hour trial access to basic recovery dashboard', '0.00', '[\"Limited dashboard access\",\"Basic case tracking\",\"Email-only support (trial)\"]', 'Instant Access', 'Trial Support', '2025-10-30 03:01:03', 30);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `user_id`, `token`, `expires_at`) VALUES
(4, 29, '2412086e976c4c382903570e5f33cf8e1431cb07ed135c2a9ac2230a29a9f0fb', '2025-10-30 03:21:16'),
(10, 38, 'ae9f2b8116f3483892b223293f7ec0931446892a7b825f8009466e95a28839f8', '2025-11-01 15:39:47');

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` int NOT NULL,
  `method_code` varchar(50) NOT NULL,
  `method_name` varchar(100) NOT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `routing_number` varchar(50) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `instructions` text,
  `min_amount` decimal(15,2) DEFAULT '10.00',
  `max_amount` decimal(15,2) DEFAULT NULL,
  `allows_deposit` tinyint(1) DEFAULT '1',
  `payment_details` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `allows_withdrawal` tinyint(1) NOT NULL DEFAULT '1',
  `is_crypto` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `method_code`, `method_name`, `bank_name`, `account_number`, `routing_number`, `wallet_address`, `instructions`, `min_amount`, `max_amount`, `allows_deposit`, `payment_details`, `is_active`, `allows_withdrawal`, `is_crypto`) VALUES
(14, 'BANK_TRANSFER', 'Bank Transfer', 'CFV Projekt EK', 'DE11 3701 9000 1011 3066 79', 'BUNQDE82', NULL, 'Please create a support ticket to request the bank payment details.', '0.00', NULL, 1, 'Bank Name: Bunq\r\n\r\nAccount Owner: Max Mustermann\r\n\r\nIBAN: DE12 3456 7890 1234 5678 90\r\n\r\nBIC: DE12345\r\n\r\nAddress: Dummy Street 1, Berlin, Germany', 1, 1, 0),
(15, 'BITCOIN', 'Bitcoin', NULL, NULL, NULL, 'bc1qg2x7s46cl2vaqjax2sd5t02qe5xhkgflemyaa4', 'Send only Bitcoin to this address. Do not send other cryptocurrencies. Minimum deposit: 0.001 BTC', '10.00', NULL, 1, 'Currency Name: Bitcoin\r\n\r\nNetwork: BTC\r\n\r\nAddress: 3FZbgi29cpjq2GjdwV8eyHuJJnkLtktZc5', 1, 1, 0),
(16, 'ETHEREUM', 'Ethereum', NULL, NULL, NULL, '0x8e689eD8224B8cffbEb34B56eEe03a34f1E5120A', 'Send only Ethereum to this address. Minimum deposit: 0.01 ETH', '10.00', NULL, 1, 'Currency Name: Ethereum\r\n\r\nNetwork: ERC20\r\n\r\nAddress: 0x71C7656EC7ab88b098defB751B7401B5f6d8976F', 1, 1, 0),
(17, 'WISE', 'Wise Transfer', 'Wise Payments', 'US987654321', '026073150', NULL, 'Send USD only. Include your reference number in the payment details.', '10.00', NULL, 1, 'Bank Name: Wise Payments\r\n\r\nAccount Owner: Max Mustermann\r\n\r\nIBAN: GB00 WISE 1234 5678 90\r\n\r\nBIC: WISEGB2L\r\n\r\nAddress: 56 Shoreditch, London, UK', 1, 0, 0),
(18, 'PAYPAL', 'PayPal', NULL, NULL, NULL, NULL, 'Send to payments@scamrecovery.com. Include your reference number in the payment note.', '10.00', NULL, 1, NULL, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `payout_confirmation_logs`
--

CREATE TABLE `payout_confirmation_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `withdrawal_id` int DEFAULT NULL,
  `admin_id` int NOT NULL,
  `email_to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('queued','sent','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'queued',
  `tracking_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sent_at` datetime DEFAULT NULL,
  `opened_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payout_confirmation_logs`
--

INSERT INTO `payout_confirmation_logs` (`id`, `user_id`, `withdrawal_id`, `admin_id`, `email_to`, `subject`, `pdf_path`, `status`, `tracking_token`, `error_message`, `created_at`, `sent_at`, `opened_at`) VALUES
(7, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_012407_U20_W13.pdf', 'sent', '868c0ca8f3506cc43757be2d71d15c8a', NULL, '2025-09-10 01:24:07', '2025-09-10 01:24:07', NULL),
(8, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_014936_U20_W13.pdf', 'sent', '623ae7697912e50ed063f825e4abb91b', NULL, '2025-09-10 01:49:36', '2025-09-10 01:49:36', NULL),
(9, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_015551_U20_W13.pdf', 'sent', 'edf335c024d621c3c5e8046e8ab80942', NULL, '2025-09-10 01:55:51', '2025-09-10 01:55:51', NULL),
(10, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_020139_U20_W13.pdf', 'sent', '404746d6f87439d6964f14dfe1c1d712', NULL, '2025-09-10 02:01:39', '2025-09-10 02:01:41', NULL),
(11, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_020552_U20_W13.pdf', 'sent', '8941ab6928d2094d41aa9a395c77127e', NULL, '2025-09-10 02:05:52', '2025-09-10 02:05:53', NULL),
(12, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_021124_U20_W13.pdf', 'sent', '9b77c673afa07b5940c08b3aac3cdf19', NULL, '2025-09-10 02:11:24', '2025-09-10 02:11:26', NULL),
(13, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_021906_U20_W13.pdf', 'sent', 'dd6611a92397ad589774d6367ef5450e', NULL, '2025-09-10 02:19:06', '2025-09-10 02:19:06', NULL),
(14, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_022147_U20_W13.pdf', 'sent', '67c6651082fed2e0622bd1ec3f9aaf80', NULL, '2025-09-10 02:21:47', '2025-09-10 02:21:47', NULL),
(15, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_022254_U20_W13.pdf', 'sent', '67ba79d8937523b0a71bb48da044d635', NULL, '2025-09-10 02:22:54', '2025-09-10 02:22:54', NULL),
(16, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_022733_U20_W13.pdf', 'sent', '655eeca366137ebbbfa3e251c38cef75', NULL, '2025-09-10 02:27:33', '2025-09-10 02:27:34', NULL),
(17, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_022928_U20_W13.pdf', 'sent', 'f43aded21e330da0e4ef518d38ccfee0', NULL, '2025-09-10 02:29:28', '2025-09-10 02:29:29', NULL),
(18, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_022957_U20_W13.pdf', 'sent', 'eeb91bfaa228ddc3cad7322f023a0ca4', NULL, '2025-09-10 02:29:57', '2025-09-10 02:29:57', NULL),
(19, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_023840_U20_W13.pdf', 'sent', 'dba36a3f01d9c4b6c80f49351f89567f', NULL, '2025-09-10 02:38:40', '2025-09-10 02:38:41', NULL),
(20, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_024019_U20_W13.pdf', 'sent', 'f7763e46403b987c4b88aae509fc387c', NULL, '2025-09-10 02:40:19', '2025-09-10 02:40:20', NULL),
(21, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_024035_U20_W13.pdf', 'sent', '0d7424e55fb6f2873255e6f1523e566c', NULL, '2025-09-10 02:40:35', '2025-09-10 02:40:35', NULL),
(22, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_024215_U20_W13.pdf', 'sent', '0e0647f09f5f5fc7f17bf48c8fccd8a4', NULL, '2025-09-10 02:42:15', '2025-09-10 02:42:15', NULL),
(23, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_024344_U20_W13.pdf', 'sent', '821ad7b5d429dfb6254cd500f3ec730e', NULL, '2025-09-10 02:43:44', '2025-09-10 02:43:44', NULL),
(24, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_025506_U20_W13.pdf', 'sent', '8024a9ff0374c45b47c8b0c041bc9ad1', NULL, '2025-09-10 02:55:06', '2025-09-10 02:55:06', NULL),
(25, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_025547_U20_W13.pdf', 'sent', 'f48bbdc9a3bc85308c6283fa14b8c216', NULL, '2025-09-10 02:55:47', '2025-09-10 02:55:47', NULL),
(26, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_025852_U20_W13.pdf', 'sent', '62d39313f47aa39f0c8d57b8dc24bf37', NULL, '2025-09-10 02:58:52', '2025-09-10 02:58:52', NULL),
(27, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_030637_U20_W13.pdf', 'sent', 'b15968416e0c3173f1380240052789ba', NULL, '2025-09-10 03:06:37', '2025-09-10 03:06:37', NULL),
(28, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_032450_U20_W13.pdf', 'sent', '258cec607816236ece78ea1ff3a02624', NULL, '2025-09-10 03:24:50', '2025-09-10 03:24:50', NULL),
(29, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_032848_U20_W13.pdf', 'sent', '6f3afb2c5f9afedd7022a28e99c110f7', NULL, '2025-09-10 03:28:48', '2025-09-10 03:28:48', NULL),
(30, 3, 12, 1, 'user3@example.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_033342_U3_W12.pdf', 'sent', '49539abada9b24131238fa0269c9f463', NULL, '2025-09-10 03:33:42', '2025-09-10 03:33:42', NULL),
(31, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250910_210232_U20_W13.pdf', 'sent', '02263df0a18fa7ad34729e373237e4c6', NULL, '2025-09-10 21:02:32', '2025-09-10 21:02:32', NULL),
(32, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250911_033434_U20_W13.pdf', 'sent', '8039b0557a793a631d2476855719a046', NULL, '2025-09-11 03:34:34', '2025-09-11 03:34:35', NULL),
(33, 20, 13, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250911_034052_U20_W13.pdf', 'sent', '0f14fcff10d9b9f2c8a6f02d55f642e1', NULL, '2025-09-11 03:40:52', '2025-09-11 03:40:52', NULL),
(34, 20, 15, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250911_034159_U20_W15.pdf', 'sent', '987d6a4a9af97a82127006b0bb816f60', NULL, '2025-09-11 03:41:59', '2025-09-11 03:41:59', NULL),
(35, 20, 15, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250911_034610_U20_W15.pdf', 'sent', '60ee1c13bb88a5e1d45099160b8e1a1d', NULL, '2025-09-11 03:46:10', '2025-09-11 03:46:10', NULL),
(36, 20, 15, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250911_035213_U20_W15.pdf', 'sent', '99f323e96a33eb81edf937baca82e324', NULL, '2025-09-11 03:52:13', '2025-09-11 03:52:13', NULL),
(37, 20, 16, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250911_042707_U20_W16.pdf', 'sent', 'b3d7be2672931351910b2426e4a957b3', NULL, '2025-09-11 04:27:07', '2025-09-11 04:27:08', NULL),
(38, 21, 14, 1, 'thomasklank76@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20250926_221345_U21_W14.pdf', 'sent', 'be32d4ce442feb7070ca5ea3592af5d5', NULL, '2025-09-26 22:13:45', '2025-09-26 22:13:46', NULL),
(39, 20, 16, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251003_175147_U20_W16.pdf', 'sent', 'ef554fd6056b8635ad982970b83d1635', NULL, '2025-10-03 17:51:47', '2025-10-03 17:51:48', NULL),
(40, 20, 17, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251010_220252_U20_W17.pdf', 'sent', '415332370cfed712239c4b1778afa4b0', NULL, '2025-10-10 22:02:52', '2025-10-10 22:02:53', NULL),
(41, 20, 18, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251020_234148_U20_W18.pdf', 'failed', '309dc2ed2f4bae0cfb7c5b3de6e49ad2', 'SMTP Error: Could not authenticate.', '2025-10-20 23:41:48', NULL, NULL),
(42, 22, 19, 1, 'ciccica04@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251026_224817_U22_W19.pdf', 'sent', '99fd887a128ba7e6e2a2da167a4ef0b8', NULL, '2025-10-26 22:48:17', '2025-10-26 22:48:18', NULL),
(43, 20, 18, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251027_200454_U20_W18.pdf', 'sent', 'ce299cf127fb4bb3e3bba682767f2be2', NULL, '2025-10-27 20:04:54', '2025-10-27 20:04:55', NULL),
(44, 20, 18, 1, 'iload1731@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251027_201007_U20_W18.pdf', 'sent', '2e233b6801074d6f4299b594819f912a', NULL, '2025-10-27 20:10:07', '2025-10-27 20:10:07', NULL),
(45, 28, 21, 1, 'ciccica04@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251027_234212_U28_W21.pdf', 'sent', '1958feb422f96e75c04a195d00c7ff9f', NULL, '2025-10-27 23:42:12', '2025-10-27 23:42:13', NULL),
(46, 30, 22, 1, 'aqoaqo038@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251028_235451_U30_W22.pdf', 'sent', '0757272876d5c9f176de8a5548dac9a4', NULL, '2025-10-28 23:54:51', '2025-10-28 23:54:52', NULL),
(47, 35, 23, 1, 'marklember99@proton.me', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251029_173057_U35_W23.pdf', 'sent', '06f4cbfc7eca86564029b0f1376e52e0', NULL, '2025-10-29 17:30:57', '2025-10-29 17:30:57', NULL),
(48, 29, 24, 1, 'Illyrianc@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251029_231124_U29_W24.pdf', 'sent', '439a55e14faffb91ca54aa379ebb2cf3', NULL, '2025-10-29 23:11:24', '2025-10-29 23:11:26', NULL),
(49, 36, 25, 1, 'Illyrianc@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251030_014500_U36_W25.pdf', 'sent', '6c27a3377f848ae957296e57f14c5cbd', NULL, '2025-10-30 01:45:00', '2025-10-30 01:45:00', NULL),
(50, 36, 26, 1, 'Illyrianc@gmail.com', 'Ihre Auszahlungsbestätigung & Rechnung', '../uploads/payouts/Auszahlungsbestaetigung_20251101_043544_U36_W26.pdf', 'sent', '990be11eca4ec1998f93e0e5ca7f2e12', NULL, '2025-11-01 04:35:44', '2025-11-01 04:35:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `remember_tokens`
--

CREATE TABLE `remember_tokens` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scam_platforms`
--

CREATE TABLE `scam_platforms` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` enum('crypto','forex','investment','dating','tax','other') NOT NULL,
  `description` text,
  `logo` varchar(255) DEFAULT NULL,
  `total_reported_loss` decimal(15,2) DEFAULT '0.00',
  `total_recovered` decimal(15,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `scam_platforms`
--

INSERT INTO `scam_platforms` (`id`, `name`, `url`, `type`, `description`, `logo`, `total_reported_loss`, `total_recovered`, `is_active`, `created_by`, `created_at`) VALUES
(1, 'Fake Crypto Investment', 'https://fakecrypto.com', 'crypto', 'Fake cryptocurrency investment platform promising high returns', NULL, '5000000.00', '1250000.00', 1, 1, '2025-07-18 22:19:13'),
(2, 'Forex Scam Ltd', 'https://forex-scam.com', 'forex', 'Fake forex trading platform with manipulated results', NULL, '3200000.00', '800000.00', 1, 1, '2025-07-18 22:19:13'),
(3, 'Romance Scam Network', 'https://dating-scam.org', 'dating', 'Dating platform used to scam people out of money', NULL, '1800000.00', '450000.00', 1, 1, '2025-07-18 22:19:13'),
(4, 'Option888', 'https://option888.com', 'crypto', 'A scam Platform where a lot of money is stolen', '', '0.00', '0.00', 1, 1, '2025-08-20 19:26:42'),
(5, 'FXCFX', 'https://fxfcx.com', 'forex', 'Scam,', '', '0.00', '0.00', 1, 1, '2025-08-20 19:41:33'),
(6, 'TrustWallet', 'https://trustwallet.com/', 'crypto', 'Cryptocurrency Wallet', '', '0.00', '0.00', 1, 1, '2025-10-30 21:32:44'),
(8, 'Binance', 'https://www.binance.com/', 'crypto', 'Crypto Currency Trading Platform', '', '0.00', '0.00', 1, 1, '2025-11-03 22:00:55'),
(9, 'Coinbase', 'https://www.coinbase.com/', 'crypto', 'Crypto Trading Platform', '', '0.00', '0.00', 1, 1, '2025-11-03 22:02:44'),
(10, 'Blockchain', 'https://www.blockchain.com/', 'crypto', 'Buy, sell, and swap crypto in minutes.', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:03:04'),
(11, 'Exodus', 'https://www.exodus.com', 'crypto', 'Buy and swap cryptocurrencies with the best Crypto Wallet & Bitcoin Wallet. Secure crypto, access all of Web3 with the multichain Exodus Web3 Wallet.', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:04:32'),
(12, 'Bitpanda', 'https://www.bitpanda.com', 'crypto', 'Bitpanda provides a cryptocurrency broker, commodities and securities trading', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:07:01'),
(13, 'FxMarkets', NULL, 'forex', 'FX markets coverage provides detailed analysis, independent forecasts, and outlooks for global currency markets.', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:08:29'),
(14, 'Plus500', NULL, 'forex', 'Fake forex trading platform with manipulated results', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:12:49'),
(15, 'Bloom Bex', 'https://bloombex.net/', 'crypto', 'Invest in Forex, Crypto & Gold Trading', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:14:33'),
(16, 'CapitalXP', NULL, 'investment', 'Fake cryptocurrency investment platform promising high returns', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:28:49'),
(17, 'Coinbase Pro', 'https://www.coinbase.com', 'crypto', 'Crypto Trading Platform', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:30:44'),
(18, 'FxCrypto', NULL, 'crypto', 'Crypto Currency Trading Platform', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:31:28'),
(19, 'kucoin', 'https://www.kucoin.com', 'crypto', 'Crypto Currency Trading Platform', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:32:35'),
(20, 'BtcMarkets', NULL, 'crypto', 'Fake cryptocurrency investment platform promising high returns', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:33:10'),
(21, 'Kraken', NULL, 'crypto', 'Crypto Currency Trading Platform', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:33:32'),
(22, 'Huobi Global', NULL, 'crypto', 'Crypto Currency Trading Platform', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:33:51'),
(23, 'DigiFinex', NULL, 'investment', 'Fake forex trading platform with manipulated results', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:34:26'),
(24, 'Clear Junction Limited', NULL, 'other', 'Banking Service', NULL, '0.00', '0.00', 1, 1, '2025-11-10 21:35:03');

-- --------------------------------------------------------

--
-- Table structure for table `smtp_settings`
--

CREATE TABLE `smtp_settings` (
  `id` int NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` int NOT NULL DEFAULT '587',
  `encryption` enum('tls','ssl','none') NOT NULL DEFAULT 'tls',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `from_email` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `smtp_settings`
--

INSERT INTO `smtp_settings` (`id`, `host`, `port`, `encryption`, `username`, `password`, `from_email`, `from_name`, `is_active`, `created_at`) VALUES
(1, 'smtp.hostinger.com', 587, 'tls', 'no-reply@blockchainfahndung.com', 'BXTrpD5Dk5@@?', 'no-reply@blockchainfahndung.com', 'KryptoX', 1, '2025-08-02 07:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `ticket_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','in_progress','resolved','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'open',
  `priority` enum('low','medium','high','critical') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'medium',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_reply_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `ticket_number`, `subject`, `message`, `status`, `priority`, `category`, `last_reply_at`, `created_at`) VALUES
(1, 1, 'TICKET-6886D82B4E9CE', 'Hilfe bei Betrugs-Investitionen', 'Jsjsjsj', 'open', 'medium', 'Technical Problem', '2025-10-28 01:36:20', '2025-07-28 01:53:47'),
(2, 5, 'TICKET-688AE9384F7F0', 'DDDDDDDDDDDDDD', 'DDDDDDDDDDDDD', 'in_progress', 'medium', 'Case Inquiry', '2025-08-20 22:06:16', '2025-07-31 03:55:36'),
(3, 21, 'TICKET-68A64733E639B', 'not workin', 'not workin', 'closed', 'medium', 'Document Submission', '2025-08-20 22:21:17', '2025-08-20 22:07:47'),
(4, 20, 'TICKET-68E983F32862E', 'Problem', 'Hshshshshshs', 'in_progress', 'critical', 'Payment Issue', '2025-10-10 22:09:37', '2025-10-10 22:08:51'),
(5, 22, 'TICKET-68FEA5A685581', 'Verify Your Mobile Number', 'ihoHioho[ihio[Z|H{Ih\r\nHIZ|H[\r\nZiop}5646+465+', 'resolved', 'medium', 'Payment Issue', '2025-10-26 22:52:48', '2025-10-26 22:50:14'),
(6, 30, 'TICKET-690157471D792', 'brauche', 'hjbhjhjjhhihhiuhiuhiu', 'open', 'critical', 'Payment Issue', '2025-10-28 23:53:44', '2025-10-28 23:52:39'),
(7, 39, 'TICKET-6903DAE12531C', 'Paketdeckung', 'ich habe 1.200,00 € vor einigen Tagen bezahlt, werde Mo9rgen nochmals 1.530,00 € einbezahlen. Bitte beginnen Sie mit der Übertragung', 'in_progress', 'medium', 'Payment Issue', '2025-11-17 14:01:29', '2025-10-30 21:38:41'),
(8, 1, 'TICKET-6903E204C3BF8', 'sss', 'asdasd', 'open', 'critical', 'Case Inquiry', '2025-10-30 22:09:23', '2025-10-30 22:09:08'),
(9, 36, 'TICKET-690571930B6B5', '1152', '155', 'in_progress', 'high', 'Case Inquiry', '2025-11-17 14:02:40', '2025-11-01 02:33:55'),
(10, 42, 'TICKET-69125498DD5D6', 'Auszahliung', '2.574.923,00 USD   Wie kommen wir zu einer Auszahlung', 'open', 'medium', 'Payment Issue', '2025-11-10 22:36:39', '2025-11-10 22:09:44'),
(11, 44, 'TICKET-691B30C726D47', 'Zahlung', 'Hallo, bitte um Ihre Bankverbindung.', 'resolved', 'medium', 'Payment Issue', '2025-11-19 20:28:03', '2025-11-17 15:27:19');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text,
  `description` varchar(255) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `smtp_host` varchar(255) DEFAULT NULL,
  `smtp_port` int DEFAULT '587',
  `smtp_encryption` enum('tls','ssl','none') DEFAULT 'tls',
  `smtp_username` varchar(255) DEFAULT NULL,
  `smtp_password` varchar(255) DEFAULT NULL,
  `smtp_from_email` varchar(255) DEFAULT NULL,
  `smtp_from_name` varchar(255) DEFAULT NULL,
  `site_url` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `brand_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `description`, `is_public`, `created_at`, `smtp_host`, `smtp_port`, `smtp_encryption`, `smtp_username`, `smtp_password`, `smtp_from_email`, `smtp_from_name`, `site_url`, `contact_email`, `contact_phone`, `brand_name`) VALUES
(1, 'system_config', '{}', 'Main system configuration', 1, '2025-08-02 07:53:43', NULL, 587, 'tls', NULL, NULL, NULL, NULL, 'https://kryptox.co.uk/app', 'no-reply@blockchainfahndung.com', '', 'KryptoX');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_replies`
--

CREATE TABLE `ticket_replies` (
  `id` int NOT NULL,
  `ticket_id` int NOT NULL,
  `user_id` int DEFAULT NULL COMMENT 'NULL if admin reply',
  `admin_id` int DEFAULT NULL COMMENT 'NULL if user reply',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'JSON array of file paths',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket_replies`
--

INSERT INTO `ticket_replies` (`id`, `ticket_id`, `user_id`, `admin_id`, `message`, `attachments`, `created_at`) VALUES
(1, 2, NULL, 1, 'fdgdfgfdgfdgdfg\r\ngdfg\r\nfd\r\ngdf\r\ngdf\r\ng\r\ndf', NULL, '2025-08-20 22:06:16'),
(2, 3, NULL, 1, 'try now', NULL, '2025-08-20 22:08:09'),
(3, 3, 21, NULL, 'same error', NULL, '2025-08-20 22:20:02'),
(4, 3, NULL, 1, 'try relogin', NULL, '2025-08-20 22:20:37'),
(5, 3, 21, NULL, 'okay its working check', '[\"68a64a5de26c9_1755728477.jpg\"]', '2025-08-20 22:21:17'),
(6, 4, NULL, 1, 'Send dokuments', NULL, '2025-10-10 22:09:37'),
(7, 5, NULL, 1, 'suck my dick', NULL, '2025-10-26 22:50:48'),
(8, 5, 22, NULL, 'ta  ha turrshin e mamit', '[\"68fea61067bae_1761519120.jpg\"]', '2025-10-26 22:52:00'),
(9, 5, NULL, 1, 'bye', NULL, '2025-10-26 22:52:48'),
(10, 1, 1, NULL, '1', '[\"69001e143c5ad_1761615380.png\"]', '2025-10-28 01:36:20'),
(11, 6, NULL, 1, 'i call you leatrer', NULL, '2025-10-28 23:53:44'),
(12, 7, NULL, 1, 'wir möchten Sie informieren, dass Ihr Paket derzeit aktiv ist und für 48 Stunden läuft. Unser System wurde bereits gestartet, und in Kürze sollten die ersten Ergebnisse sichtbar sein.\r\n\r\nIhre Einzahlung in Höhe von 1.200 € in Ethereum aus der letzten Woche ist erfolgreich eingegangen. Unser System wartet nun auf die abschließende Zahlung. Sobald diese morgen eingeht, wird Ihr Paket automatisch auf das VIP-Paket aktualisiert.\r\n\r\nDamit Ihre erste Einzahlung korrekt im System angezeigt wird, gehen Sie bitte auf Ihr Dashboard, klicken Sie auf „Deposit“ und laden Sie dort ein Bild der Transaktion hoch. Danach erscheint die Zahlung automatisch in Ihrem Kundenportal.\r\n\r\nBei Fragen stehen wir Ihnen selbstverständlich jederzeit zur Verfügung.', NULL, '2025-10-30 22:07:53'),
(13, 8, NULL, 1, 'wir möchten Sie informieren, dass Ihr Paket derzeit aktiv ist und für 48 Stunden läuft. Unser System wurde bereits gestartet, und in Kürze sollten die ersten Ergebnisse sichtbar sein.\r\n\r\nIhre Einzahlung in Höhe von 1.200 € in Ethereum aus der letzten Woche ist erfolgreich eingegangen. Unser System wartet nun auf die abschließende Zahlung. Sobald diese morgen eingeht, wird Ihr Paket automatisch auf das VIP-Paket aktualisiert.\r\n\r\nDamit Ihre erste Einzahlung korrekt im System angezeigt wird, gehen Sie bitte auf Ihr Dashboard, klicken Sie auf „Deposit“ und laden Sie dort ein Bild der Transaktion hoch. Danach erscheint die Zahlung automatisch in Ihrem Kundenportal.\r\n\r\nBei Fragen stehen wir Ihnen selbstverständlich jederzeit zur Verfügung.', NULL, '2025-10-30 22:09:23'),
(14, 7, 39, NULL, 'entschuldigen Sie bitte. \r\nIch musste wegen einem dringenden geschäftlichen Termin überraschend ins Ausland und komme erst am Montag 03.11.2025 wieder zurück.\r\n\r\nSomit kann ich die zweite abschliessende Überweisung in Höhe von 1.530,00 € erst am Montag ausführen. Ist es möglich, das Paket bis Montag 03.11.2025 zu verlängern.\r\nWerde dann die Überweisung sofort am Montag als Echtzeitüberweisunf durchführen.', NULL, '2025-10-31 16:04:01'),
(15, 7, NULL, 1, 'wir möchten Sie informieren, dass Ihr Paket derzeit aktiv ist und für 48 Stunden läuft. Unser System wurde bereits gestartet, und in Kürze sollten die ersten Ergebnisse sichtbar sein.\r\nDamit Ihre erste Einzahlung korrekt im System angezeigt wird, gehen Sie bitte auf Ihr Dashboard, klicken Sie auf „Deposit“ und laden Sie dort ein Bild der Transaktion hoch. Danach erscheint die Zahlung automatisch in Ihrem Kundenportal.\r\n\r\nBei Fragen stehen wir Ihnen selbstverständlich jederzeit zur Verfügung.', NULL, '2025-10-31 17:07:18'),
(16, 9, NULL, 1, '2587945', NULL, '2025-11-01 02:34:19'),
(17, 9, NULL, 1, '123456', NULL, '2025-11-01 02:37:31'),
(18, 9, NULL, 1, '7410', NULL, '2025-11-01 02:38:27'),
(19, 9, 36, NULL, '4742', NULL, '2025-11-01 02:39:21'),
(20, 9, NULL, 1, '1582', NULL, '2025-11-01 02:43:50'),
(21, 10, NULL, 1, 'Dear Mr. Suter,\r\n\r\nTo proceed with your withdrawal, we first require your withdrawal address.\r\nWe cooperate with several well-known payment service providers, including:\r\n\r\n* Binance\r\n* Coinbase\r\n* Kraken\r\n* Exodus\r\n* Bitstamp\r\n* Uphold\r\n* Crypto.com\r\n* Bitpanda\r\n* Gemini\r\n* Trust Wallet\r\n\r\nPlease let us know through which provider you would like to receive your payout and provide the corresponding receiving (wallet) address.\r\n\r\nOnce your address is received, we will prepare your withdrawal.\r\nPlease ensure that your wallet has sufficient Ethereum (ETH) balance to cover the following fees amounting to 0.7% of the withdrawal amount:\r\n\r\n* Transaction fees\r\n* Swap fees\r\n* Service fees\r\n* Administration \r\n\r\nAfter the required balance has been confirmed, your withdrawal will be processed promptly.', NULL, '2025-11-10 22:36:39'),
(22, 7, NULL, 1, 'Sehr geehrter Herr Kösler,\r\n\r\nwir möchten Sie darauf aufmerksam machen, dass Ihr Konto zur Schließung vorbereitet wird, da die zweite Einzahlung für Ihr Paket bisher nicht von Ihnen vorgenommen wurde.\r\n\r\nUm eine Schließung zu vermeiden, bitten wir Sie, die ausstehende Zahlung im Laufe des heutigen Tages zu tätigen.\r\n\r\nBei Fragen oder Unklarheiten stehen wir Ihnen selbstverständlich gerne zur Verfügung.', NULL, '2025-11-17 14:01:29'),
(23, 9, NULL, 1, '1234', NULL, '2025-11-17 14:02:40'),
(24, 11, NULL, 1, 'Bank Transfer Details\r\n\r\nAccount Name: CFV Projekt EK\r\n\r\nIban Number: DE11 3701 9000 1011 3066 79\r\n\r\nBic/Swift Number: BUNQDE82\r\n\r\nReferenc: Paxful', NULL, '2025-11-17 15:30:41'),
(25, 11, 44, NULL, 'Hallo, hier der Beleg meiner Überweisung.', '[\"691c269c753c1_1763452572.png\"]', '2025-11-18 08:56:12'),
(26, 11, NULL, 1, 'KI Algorithmus Wurde gestarted Viel Erfolg', NULL, '2025-11-19 20:28:03');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `case_id` int DEFAULT NULL,
  `type` enum('deposit','withdrawal','refund','fee','transfer') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_method_id` int DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `transaction_hash` varchar(255) DEFAULT NULL,
  `bank_details` text,
  `proof_path` varchar(255) DEFAULT NULL,
  `payment_details` text,
  `status` enum('pending','completed','failed','approved','cancelled') NOT NULL DEFAULT 'pending',
  `reference` varchar(100) DEFAULT NULL,
  `otp_code` varchar(10) DEFAULT NULL,
  `otp_expires` datetime DEFAULT NULL,
  `otp_verified` tinyint(1) DEFAULT '0',
  `admin_notes` text,
  `processed_by` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `case_id`, `type`, `amount`, `payment_method_id`, `wallet_address`, `transaction_hash`, `bank_details`, `proof_path`, `payment_details`, `status`, `reference`, `otp_code`, `otp_expires`, `otp_verified`, `admin_notes`, `processed_by`, `created_at`) VALUES
(9, 3, NULL, 'deposit', '999.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_689e69d732da9.png', NULL, 'pending', 'DEP-1755212247-732DCC', NULL, NULL, 0, NULL, NULL, '2025-08-14 22:57:27'),
(10, 3, NULL, 'deposit', '1934.99', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_689e6ae088208.png', NULL, 'pending', 'DEP-1755212512-088228', NULL, NULL, 0, NULL, NULL, '2025-08-14 23:01:52'),
(11, 3, NULL, 'withdrawal', '999.00', 14, NULL, NULL, NULL, NULL, 'hhh', 'pending', 'WDR-1755214223-FC536F', NULL, NULL, 0, NULL, NULL, '2025-08-14 23:30:23'),
(12, 1, NULL, 'deposit', '9993.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_689e8e87789bc.png', NULL, 'pending', 'DEP-1755221639-778B34', NULL, NULL, 0, NULL, NULL, '2025-08-15 01:33:59'),
(13, 2, NULL, 'deposit', '443.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_68a3d2837c5a6.png', NULL, 'pending', 'DEP-1755566723-37C9A4', NULL, NULL, 0, NULL, NULL, '2025-08-19 01:25:23'),
(14, 20, NULL, 'deposit', '443.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_68a3ea5d056d9.png', NULL, 'pending', 'DEP-1755572829-D05A27', NULL, NULL, 0, NULL, NULL, '2025-08-19 03:07:09'),
(15, 20, NULL, 'withdrawal', '22.00', 14, NULL, NULL, NULL, NULL, 'Iban test\r\nHolter admi ', 'pending', 'WDR-1755573414-6C8A91', NULL, NULL, 0, NULL, NULL, '2025-08-19 03:16:54'),
(16, 21, NULL, 'deposit', '499.00', 14, NULL, NULL, NULL, '21_1755707774_address_1_1753677870.jpg', NULL, 'pending', 'PKG-9A3031B69FB5', NULL, NULL, 0, NULL, NULL, '2025-08-20 16:36:14'),
(17, 21, NULL, 'withdrawal', '1827.00', 14, NULL, NULL, NULL, NULL, 'sdasdas', 'pending', 'WDR-1755708543-F2A567', NULL, NULL, 0, NULL, NULL, '2025-08-20 16:49:03'),
(18, 20, NULL, 'deposit', '499.00', 16, NULL, NULL, NULL, '20_1755709934_64abe35a53fa01688986458.png', NULL, 'pending', 'PKG-2DFF4BAEDC55', NULL, NULL, 0, NULL, NULL, '2025-08-20 17:12:14'),
(19, 1, NULL, 'deposit', '499.00', 15, NULL, NULL, NULL, '1_1756752595_thumb-1.jpg', NULL, 'pending', 'PKG-FA2E83B3F595', NULL, NULL, 0, NULL, NULL, '2025-09-01 18:49:55'),
(20, 20, NULL, 'withdrawal', '9999.10', 14, NULL, NULL, NULL, NULL, 'Hdjsk\r\nHdjdj', 'completed', 'WDR-1757562098-23E4F5', NULL, NULL, 0, NULL, 1, '2025-09-11 03:41:38'),
(21, 20, NULL, 'withdrawal', '500.00', 14, NULL, NULL, NULL, NULL, 'thomasstephan Klank\r\nSparkasse\r\nIBAN: DE75356500000001085612\r\nBIC: GBCLJU', 'completed', 'WDR-1757564768-0499FA', NULL, NULL, 0, NULL, 1, '2025-09-11 04:26:08'),
(22, 20, NULL, 'withdrawal', '22.00', 14, NULL, NULL, NULL, NULL, NULL, 'completed', 'WDR-1755573414-6C8A91', NULL, NULL, 0, NULL, NULL, '2025-09-11 04:33:13'),
(23, 21, NULL, 'withdrawal', '1827.00', 14, NULL, NULL, NULL, NULL, NULL, 'completed', 'WDR-1755708543-F2A567', NULL, NULL, 0, NULL, NULL, '2025-09-11 04:40:58'),
(24, 20, NULL, 'deposit', '443.00', 14, NULL, NULL, NULL, NULL, NULL, 'completed', 'DEP-1755572829-D05A27', NULL, NULL, 0, NULL, 1, '2025-09-11 04:42:17'),
(25, 20, NULL, 'withdrawal', '20000.00', 14, NULL, NULL, NULL, NULL, 'thomasstephan Klank\r\nSparkasse\r\nIBAN: DE75356500000001085612\r\nBIC: GBCLJU', 'pending', 'WDR-1760133692-CCD239', NULL, NULL, 0, NULL, NULL, '2025-10-10 22:01:32'),
(26, 20, NULL, 'withdrawal', '880.00', 14, NULL, NULL, NULL, NULL, 'thomasstephan Klank\r\nSparkasse\r\nIBAN: DE75356500000001085612\r\nBIC: GBCLJU', 'pending', 'WDR-1761003632-0A10E6', NULL, NULL, 0, NULL, NULL, '2025-10-20 23:40:32'),
(27, 22, NULL, 'withdrawal', '20.00', 14, NULL, NULL, NULL, NULL, 'fvvsdfv\r\nfvdsvfvd\r\nIBAN: IT03T0306912711100000018774\r\nBIC: FDVFDVDF', 'pending', 'WDR-1761518845-D241EF', NULL, NULL, 0, NULL, NULL, '2025-10-26 22:47:25'),
(28, 22, NULL, 'deposit', '499.00', 14, NULL, NULL, NULL, '22_1761519518_sex1111.PNG', NULL, 'pending', 'PKG-8F8EFEF08B79', NULL, NULL, 0, NULL, NULL, '2025-10-26 22:58:38'),
(29, 22, NULL, 'withdrawal', '200.00', 14, NULL, NULL, NULL, NULL, 'fvvsdfv\r\nfvdsvfvd\r\nIBAN: IT03T0306912711100000018774\r\nBIC: FDVFDVDF', 'pending', 'WDR-1761519937-1DC6CD', NULL, NULL, 0, NULL, NULL, '2025-10-26 23:05:37'),
(30, 22, NULL, 'withdrawal', '200.00', 14, NULL, NULL, NULL, NULL, NULL, 'completed', 'WDR-1761519937-1DC6CD', NULL, NULL, 0, NULL, NULL, '2025-10-26 23:07:40'),
(34, 27, NULL, 'deposit', '1999.00', 15, NULL, 'Bitcoin', NULL, NULL, NULL, 'pending', 'PKG-378E7B0B5919', NULL, NULL, 0, NULL, NULL, '2025-10-27 22:46:23'),
(35, 28, NULL, 'deposit', '1999.00', 15, NULL, 'Bitcoin', NULL, NULL, NULL, 'pending', 'PKG-419907097A9B', NULL, NULL, 0, NULL, NULL, '2025-10-27 23:36:01'),
(36, 28, NULL, 'withdrawal', '2543.12', 14, NULL, NULL, NULL, NULL, 'fvvsdfv\r\nfvdsvfvd\r\nIBAN: DE83370190001010231690\r\nBIC: FDVFDVDF', 'pending', 'WDR-1761608515-352977', NULL, NULL, 0, NULL, NULL, '2025-10-27 23:41:55'),
(37, 29, NULL, 'deposit', '860.00', 14, NULL, NULL, NULL, 'uploads/payments/29_1761614990.jpg', NULL, 'pending', 'PKG-BC53465D431A', NULL, NULL, 0, NULL, NULL, '2025-10-28 01:29:50'),
(38, 30, NULL, 'deposit', '2730.00', 15, NULL, 'Bitcoin', NULL, NULL, NULL, 'pending', 'PKG-DB7E7A049B53', NULL, NULL, 0, NULL, NULL, '2025-10-28 23:45:08'),
(39, 30, NULL, 'withdrawal', '30000.00', 14, NULL, NULL, NULL, NULL, 'aa aa\r\nsparkasse\r\nIBAN: DE12345678901234\r\nBIC: DE12345', 'pending', 'WDR-1761695662-E463B1', NULL, NULL, 0, NULL, NULL, '2025-10-28 23:54:22'),
(40, 31, NULL, 'deposit', '399.00', 14, NULL, NULL, NULL, 'uploads/payments/31_1761737269.jpg', NULL, 'pending', 'PKG-D0B4D73222D3', NULL, NULL, 0, NULL, NULL, '2025-10-29 11:27:49'),
(41, 34, NULL, 'deposit', '399.00', 14, NULL, NULL, NULL, 'uploads/payments/34_1761739920.jpg', NULL, 'pending', 'PKG-56E3601E063E', NULL, NULL, 0, NULL, NULL, '2025-10-29 12:12:00'),
(42, 35, NULL, 'deposit', '1999.00', 14, NULL, NULL, NULL, 'uploads/payments/35_1761756525.jpg', NULL, 'pending', 'PKG-8CF694F316B2', NULL, NULL, 0, NULL, NULL, '2025-10-29 16:48:45'),
(43, 35, NULL, 'withdrawal', '34876.00', 14, NULL, NULL, NULL, NULL, 'parbbdd\r\nsparkasse\r\nIBAN: DE1263367373733\r\nBIC: DE12663', 'pending', 'WDR-1761758925-DADAD0', NULL, NULL, 0, NULL, NULL, '2025-10-29 17:28:45'),
(44, 29, NULL, 'withdrawal', '3600.00', 14, NULL, NULL, NULL, NULL, 'Jane Smith\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1761779460-479FDE', NULL, NULL, 0, NULL, NULL, '2025-10-29 23:11:00'),
(45, 36, NULL, 'deposit', '1999.00', 15, NULL, 'Bbb', NULL, NULL, NULL, 'pending', 'PKG-255E01D1E36E', NULL, NULL, 0, NULL, NULL, '2025-10-30 01:40:48'),
(46, 36, NULL, 'withdrawal', '599.00', 14, NULL, NULL, NULL, NULL, 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1761788628-4EF301', NULL, NULL, 0, NULL, NULL, '2025-10-30 01:43:48'),
(47, 36, NULL, 'deposit', '999.00', 15, NULL, NULL, NULL, 'uploads/payments/36_1761791618.jpg', NULL, 'pending', 'SUB-CA8B21A4', NULL, NULL, 0, NULL, NULL, '2025-10-30 02:33:38'),
(48, 36, NULL, 'deposit', '1999.00', 14, NULL, NULL, NULL, 'uploads/payments/36_1761792379.jpg', NULL, 'failed', 'SUB-CD4F3369', NULL, NULL, 0, NULL, 1, '2025-10-30 02:46:19'),
(49, 39, NULL, 'deposit', '1200.00', 16, NULL, NULL, NULL, '../uploads/proofs/deposit_6903e4c65ff80.PNG', NULL, 'pending', 'DEP-1761862854-660186', NULL, NULL, 0, NULL, NULL, '2025-10-30 22:20:54'),
(50, 39, NULL, 'deposit', '1200.00', 16, NULL, NULL, NULL, '../uploads/proofs/deposit_6903e53aacfef.PNG', NULL, 'pending', 'DEP-1761862970-AAD01E', NULL, NULL, 0, NULL, NULL, '2025-10-30 22:22:50'),
(51, 36, NULL, 'withdrawal', '44.00', 14, NULL, NULL, NULL, NULL, 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1761864478-E8141A', NULL, NULL, 0, NULL, NULL, '2025-10-30 22:47:58'),
(52, 36, NULL, 'withdrawal', '20.00', 14, NULL, NULL, NULL, NULL, 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'failed', 'WDR-1761962204-CDCC6B', NULL, NULL, 0, NULL, 1, '2025-11-01 01:56:44'),
(53, 36, NULL, 'withdrawal', '15.00', 14, NULL, NULL, NULL, NULL, 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'completed', 'WDR-1761962914-26850A', NULL, NULL, 0, NULL, 1, '2025-11-01 02:08:34'),
(54, 36, NULL, 'withdrawal', '15.00', 14, NULL, NULL, NULL, NULL, NULL, 'completed', 'WDR-1761962914-26850A', NULL, NULL, 0, NULL, NULL, '2025-11-01 04:32:02'),
(55, 36, NULL, 'deposit', '588.00', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_690580c026e29.png', NULL, 'pending', 'DEP-1761968320-02713C', NULL, NULL, 0, NULL, NULL, '2025-11-01 04:38:40'),
(56, 36, NULL, 'deposit', '588.00', 15, NULL, NULL, NULL, NULL, NULL, 'completed', 'DEP-1761968320-02713C', NULL, NULL, 0, NULL, NULL, '2025-11-01 04:39:17'),
(57, 36, NULL, 'deposit', '123.00', 16, NULL, NULL, NULL, '../uploads/proofs/deposit_69058149e09ad.png', NULL, 'pending', 'DEP-1761968457-9E09E2', NULL, NULL, 0, NULL, NULL, '2025-11-01 04:40:57'),
(58, 36, NULL, 'deposit', '123.00', 16, NULL, NULL, NULL, NULL, NULL, 'completed', 'DEP-1761968457-9E09E2', NULL, NULL, 0, NULL, NULL, '2025-11-01 04:42:58'),
(59, 36, NULL, 'deposit', '7777.00', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_690584feea1e8.png', NULL, 'pending', 'DEP-1761969406-EEA205', NULL, NULL, 0, NULL, NULL, '2025-11-01 04:56:46'),
(60, 36, NULL, 'deposit', '7777.00', 15, NULL, NULL, NULL, NULL, NULL, 'completed', 'DEP-1761969406-EEA205', NULL, NULL, 0, NULL, NULL, '2025-11-01 05:05:56'),
(61, 36, NULL, 'deposit', '664.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_6905878c566ce.jpeg', NULL, 'completed', 'DEP-1761970060-C566EF', NULL, NULL, 0, NULL, 1, '2025-11-01 05:07:40'),
(62, 36, NULL, 'deposit', '1111.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_690589fe1ca22.png', NULL, 'completed', 'DEP-1761970686-E1CA4D', NULL, NULL, 0, NULL, 1, '2025-11-01 05:18:06'),
(63, 36, NULL, 'deposit', '222.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_69058b4cc2dca.png', NULL, 'completed', 'DEP-1761971020-CC2DE8', NULL, NULL, 0, NULL, 1, '2025-11-01 05:23:40'),
(64, 36, NULL, 'deposit', '2121.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_69058d239e46d.png', NULL, 'completed', 'DEP-1761971491-39E491', NULL, NULL, 0, NULL, 1, '2025-11-01 05:31:31'),
(65, 36, NULL, 'deposit', '5555.00', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_69058fe576680.png', NULL, 'completed', 'DEP-1761972197-5766A7', NULL, NULL, 0, NULL, 1, '2025-11-01 05:43:17'),
(66, 36, NULL, 'deposit', '9999.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_690590a0d206a.png', NULL, 'completed', 'DEP-1761972384-0D2095', NULL, NULL, 0, NULL, 1, '2025-11-01 05:46:24'),
(67, 36, NULL, 'deposit', '3333.00', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_6905922f25192.png', NULL, 'completed', 'DEP-1761972783-F2525A', NULL, NULL, 0, NULL, 1, '2025-11-01 05:53:03'),
(68, 36, NULL, 'deposit', '7571.00', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_690598395beee.png', NULL, 'completed', 'DEP-1761974329-95BF0C', NULL, NULL, 0, NULL, 1, '2025-11-01 06:18:49'),
(69, 36, NULL, 'deposit', '323232.00', 15, NULL, NULL, NULL, '../uploads/proofs/deposit_690598f20f33b.png', NULL, 'completed', 'DEP-1761974514-20F368', NULL, NULL, 0, NULL, 1, '2025-11-01 06:21:54'),
(70, 36, NULL, 'withdrawal', '65.00', 14, NULL, NULL, NULL, NULL, 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'failed', 'WDR-1761975438-E2934D', NULL, NULL, 0, NULL, 1, '2025-11-01 06:37:18'),
(71, 36, NULL, 'deposit', '666.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_69059d4d833bd.jpeg', NULL, 'failed', 'DEP-1761975629-D833F5', NULL, NULL, 0, NULL, 1, '2025-11-01 06:40:29'),
(72, 36, NULL, 'deposit', '555.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_69059d8caa733.jpeg', NULL, 'failed', 'DEP-1761975692-CAA759', NULL, NULL, 0, NULL, 1, '2025-11-01 06:41:32'),
(73, 36, NULL, 'deposit', '200.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_6906e761711da.jpg', NULL, 'completed', 'DEP-1762060129-171566', NULL, NULL, 0, NULL, 1, '2025-11-02 06:08:49'),
(74, 36, NULL, 'deposit', '4999.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_691276b33c96a.jpeg', NULL, 'completed', 'DEP-1762817715-33CC9B', NULL, NULL, 0, NULL, 1, '2025-11-11 00:35:15'),
(75, 36, NULL, 'deposit', '443.00', 14, NULL, NULL, NULL, '../uploads/proofs/deposit_69127a7334031.jpeg', NULL, 'completed', 'DEP-1762818675-334057', NULL, NULL, 0, NULL, 1, '2025-11-11 00:51:15'),
(76, 36, NULL, 'withdrawal', '14.00', 14, NULL, NULL, NULL, NULL, 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1763152341-58E1F0', NULL, NULL, 0, NULL, NULL, '2025-11-14 21:32:21');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_attachments`
--

CREATE TABLE `transaction_attachments` (
  `id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transaction_attachments`
--

INSERT INTO `transaction_attachments` (`id`, `transaction_id`, `file_path`, `file_type`, `created_at`) VALUES
(1, 9, '../uploads/proofs/deposit_689e69d732da9.png', 'image/png', '2025-08-14 22:57:27'),
(2, 10, '../uploads/proofs/deposit_689e6ae088208.png', 'image/png', '2025-08-14 23:01:52'),
(3, 12, '../uploads/proofs/deposit_689e8e87789bc.png', 'image/png', '2025-08-15 01:33:59'),
(4, 13, '../uploads/proofs/deposit_68a3d2837c5a6.png', 'image/png', '2025-08-19 01:25:23'),
(5, 14, '../uploads/proofs/deposit_68a3ea5d056d9.png', 'image/png', '2025-08-19 03:07:09'),
(6, 49, '../uploads/proofs/deposit_6903e4c65ff80.PNG', 'image/png', '2025-10-30 22:20:54'),
(7, 50, '../uploads/proofs/deposit_6903e53aacfef.PNG', 'image/png', '2025-10-30 22:22:50'),
(8, 55, '../uploads/proofs/deposit_690580c026e29.png', 'image/png', '2025-11-01 04:38:40'),
(9, 57, '../uploads/proofs/deposit_69058149e09ad.png', 'image/png', '2025-11-01 04:40:57'),
(10, 59, '../uploads/proofs/deposit_690584feea1e8.png', 'image/png', '2025-11-01 04:56:46'),
(11, 61, '../uploads/proofs/deposit_6905878c566ce.jpeg', 'image/jpeg', '2025-11-01 05:07:40'),
(12, 62, '../uploads/proofs/deposit_690589fe1ca22.png', 'image/png', '2025-11-01 05:18:06'),
(13, 63, '../uploads/proofs/deposit_69058b4cc2dca.png', 'image/png', '2025-11-01 05:23:40'),
(14, 64, '../uploads/proofs/deposit_69058d239e46d.png', 'image/png', '2025-11-01 05:31:31'),
(15, 65, '../uploads/proofs/deposit_69058fe576680.png', 'image/png', '2025-11-01 05:43:17'),
(16, 66, '../uploads/proofs/deposit_690590a0d206a.png', 'image/png', '2025-11-01 05:46:24'),
(17, 67, '../uploads/proofs/deposit_6905922f25192.png', 'image/png', '2025-11-01 05:53:03'),
(18, 68, '../uploads/proofs/deposit_690598395beee.png', 'image/png', '2025-11-01 06:18:49'),
(19, 69, '../uploads/proofs/deposit_690598f20f33b.png', 'image/png', '2025-11-01 06:21:54'),
(20, 71, '../uploads/proofs/deposit_69059d4d833bd.jpeg', 'image/jpeg', '2025-11-01 06:40:29'),
(21, 72, '../uploads/proofs/deposit_69059d8caa733.jpeg', 'image/jpeg', '2025-11-01 06:41:32'),
(22, 73, '../uploads/proofs/deposit_6906e761711da.jpg', 'image/jpeg', '2025-11-02 06:08:49'),
(23, 74, '../uploads/proofs/deposit_691276b33c96a.jpeg', 'image/jpeg', '2025-11-11 00:35:15'),
(24, 75, '../uploads/proofs/deposit_69127a7334031.jpeg', 'image/jpeg', '2025-11-11 00:51:15');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_logs`
--

CREATE TABLE `transaction_logs` (
  `id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `status` enum('pending','processing','completed','failed','cancelled') NOT NULL DEFAULT 'pending',
  `action` varchar(100) NOT NULL,
  `performed_by` int DEFAULT NULL COMMENT 'Admin ID if processed by admin',
  `notes` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `phone_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(64) DEFAULT NULL,
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('active','suspended','banned') DEFAULT 'active',
  `account_status` enum('active','suspended') DEFAULT 'active',
  `balance` decimal(15,2) DEFAULT '0.00',
  `payment_method` varchar(50) DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `force_password_change` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uuid`, `email`, `password_hash`, `first_name`, `last_name`, `phone`, `country`, `is_verified`, `phone_verified`, `verification_token`, `reset_token`, `reset_expires`, `last_login`, `created_at`, `status`, `account_status`, `balance`, `payment_method`, `admin_id`, `force_password_change`) VALUES
(1, '78cf6533-6414-11f0-a488-8ab22d73d1f0', 'user1@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John', 'Doe', '+1234567890', 'United States', 1, 1, NULL, NULL, NULL, '2025-11-12 18:03:49', '2025-07-18 22:19:13', 'active', 'active', '10859.00', 'Bitcoin', 1, 0),
(2, '78cf702d-6414-11f0-a488-8ab22d73d1f0', 'user2@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane', 'Smith', '+1987654321', 'Canada', 1, 0, NULL, NULL, NULL, '2025-08-19 02:18:59', '2025-07-18 22:19:13', 'active', 'active', '1042.00', NULL, 1, 0),
(3, '78cf7711-6414-11f0-a488-8ab22d73d1f0', 'user3@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Robert', 'Johnson', '+1122334455', 'United Kingdom', 1, 0, NULL, NULL, NULL, '2025-10-29 04:28:50', '2025-07-18 22:19:13', 'active', 'active', '1934.99', NULL, 1, 0),
(4, '9ccc0970-c7ff-4a1d-9ced-f759288ef336', 'user7@example.com', '$2y$10$45I8ulWbSD6IiBtnAfRLc.WPaqx/agtyd6xt8xHdZfqKhTSYLOI6q', 'Maria', 'Weight', '49152526632', 'Germany', 0, 0, NULL, NULL, NULL, NULL, '2025-07-29 23:37:34', 'active', 'active', '77.00', NULL, 1, 0),
(5, '4d5939742d4abbe87cf20b9e7d448f01', 'user4@example.com', '$2y$10$82eLfVuoGEsUhX4t8Wy0ze71KzatJvhNYEnikGM4fGdkjVgcpEyGC', 'Maria', 'Weight', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-07-31 02:22:53', '2025-07-30 22:38:49', 'active', 'active', '-919.58', 'Bank Transfer', 1, 0),
(20, 'd6c18be1bd6db415099b1229b331fec8', 'iload1731@gmail.com', '$2y$10$J2TkY38ZxnjHX8PZ6S54QO8E3SXA.Fd.Jgmz45PO8AdcmfNOv6vQK', 'thomasstephan', 'Klank', '+49187263727', NULL, 1, 0, NULL, NULL, NULL, '2025-10-28 00:47:17', '2025-08-02 06:43:49', 'active', 'active', '87319.32', NULL, NULL, 0),
(21, '69d6dfb49c6f7daece54853abc6bd0cb', 'thomasklank76@gmail.com', '$2y$10$rVsBGfu/9Fdvtig255kW5.rqPbn63azG7.IxvBpfjIerL0KlP4awy', 'Maria', 'Weight', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-08-20 22:06:30', '2025-08-20 16:28:22', 'active', 'active', '2884.21', NULL, NULL, 0),
(22, 'ab8793d8a8a52b02a4a7b613d980e913', 'cicc77ica04@gmail.com', '$2y$10$5g85ho3SwEEHcFk8K9mzW.hr4MBc.QuvMYmg8M4AbU/MoT/OicP92', 'Armin', 'Sutter', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-10-26 22:56:45', '2025-10-26 22:33:05', 'active', 'active', '99101.22', NULL, NULL, 0),
(23, 'd7fd4c7a12abd89615645e6d8a2080ca', 'peterwick420@gmail.com', '$2y$10$VNn4CUztWTx867poWIEcg.D4yO67IKfUxMuxzlyWlVCQAqmsRuaH.', 'Peter', 'Wick', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-27 20:22:09', 'active', 'active', '0.00', NULL, NULL, 1),
(24, '482c5cc5d16547bc75ec8072ab9b87e7', 'illyri33anc@gmail.com', '$2y$10$gNWLV29QwlynZg1.dUiSmecrJ2jd9Lf1WD0CAbGQh4kHtx202/rPu', 'ill', 'yrianc', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-10-27 20:38:27', '2025-10-27 20:37:22', 'active', 'active', '0.00', NULL, NULL, 1),
(25, '802f69de03221bf990573e7cff15aa89', 'illyri77777anc@gmail.com', '$2y$10$FjGuc82K5Djbpfy3Lb5R3eNKJrv2UVR0h12GDnVhB.tEolzvvotPe', 'ill', 'yrianc', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-27 20:39:21', 'active', 'active', '0.00', NULL, NULL, 1),
(26, '3b7bc30e276d584fb09d8db64d531c3b', 'illyrjjhiianc@gmail.com', '$2y$10$l2kD9egwPDBTBUIDXqzIl.tGjc84Z4118i2wKAe6mNF0V7huVHlG2', 'ill', 'yrianc', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-27 20:40:54', 'active', 'active', '0.00', NULL, NULL, 1),
(27, '8792818222c823c6af422b8aaf106943', 'illyruuuujianc@gmail.com', '$2y$10$nF0WaFe9jo9oOyVnjKAc3.iDt.O0N5SKXG6H7oJ3tES6l9tjTJc1m', 'ill', 'yrianc', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-10-27 23:07:12', '2025-10-27 20:43:42', 'active', 'active', '5231.00', NULL, NULL, 0),
(28, '89e18f2362d3933931226a84ca881434', 'ciccnnica04@gmail.com', '$2y$10$V3neRK/pH26jd2WJXMYqFOWbZSe8DmGTV5JT4npcEjoy8nWlJwKwe', 'Kari', 'Pidhi', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-10-27 23:58:42', '2025-10-27 23:32:49', 'active', 'active', '0.00', NULL, NULL, 0),
(29, '12f66cdada45b1abd96c6e4096bb4186', 'Illyria555nc@gmail.com', '$2y$10$PgOLDqrTVt3Hlupo9glqCOlYXcfEbLT0fUNGHAY2Cr4SYUtqOQbP2', 'Beno', 'Mashke', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-10-29 23:08:28', '2025-10-28 01:27:36', 'active', 'active', '30049.00', NULL, NULL, 0),
(30, 'f15aedf52c985b55f0b9a03c7f860b53', 'aqoaqo038@gmail.com', '$2y$10$FgeHL4uTuI0g8ranHA98dOgxLMW2/8cP2i8h2eQioC0mf36sBJISS', 'aqo', 'aqo', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-10-28 23:40:51', '2025-10-28 23:33:18', 'active', 'active', '2000.00', NULL, NULL, 0),
(31, '951e2028ec68e49d33d6ac521bb508c5', 'diar.kurtiii@gmail.com', '$2y$10$51EkfBkID9uCX92ooRMr2eN5bnmTdRuKKwFyuGts3bSQClv3PtfQ2', 'frank', 'guler', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-10-29 11:31:46', '2025-10-29 11:24:45', 'active', 'active', '243033.00', NULL, NULL, 0),
(32, 'c5169a066571b1df21bcecd0aa9ceffe', 'frankschmid99@proton.me', '$2y$10$m/ZyqP8FW4u1tAJkjFuPxOd1qyblRaAUeQ8ZFLeO1bzWA/7/XNgSy', 'frank', 'schmid', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-29 12:01:11', 'active', 'active', '0.00', NULL, NULL, 1),
(33, 'c3e159ffc04fdea4dfc764f19a9bdf2c', 'felixfrank99@proton.me', '$2y$10$GP.P3tQnKYjsl0oD2NpZWeRn95Xd6nkQbJyKmwJ3zQVC3ikooeRTO', 'filix', 'frank', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-29 12:05:43', 'active', 'active', '0.00', NULL, NULL, 1),
(34, '94eef874714ed1d4f1e7241928e8393f', 'patron172@icloud.com', '$2y$10$IWt61dn94jepIZx1KOtnPeR9pK5PlCFqosYjeoXGxmvu8ve4SFB..', 'kevin', 'kevin', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-10-29 12:09:15', '2025-10-29 12:07:54', 'active', 'active', '32000.00', NULL, NULL, 0),
(35, '6fe722deeb8d4c73c8d1e52a021ba95d', 'marklember99@proton.me', '$2y$10$6U8otUWMDAjU7g63RNc/.ujdEL17h8Org1cT4RjSt5WSnJ.Ih0ZwC', 'mark', 'lember', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-10-29 18:12:16', '2025-10-29 16:44:22', 'active', 'active', '7824.00', NULL, NULL, 0),
(36, 'ff01fe90e20ef5e6ddcc5fa4eb08f97e', 'Illyrianc@gmail.com', '$2y$10$ncPgB0FtEvYyXBhFMjnkKOhqRkjbZ51H5l0f3Zp7V7Nn1PXB8AFP.', 'Beno', 'Mashke', '4915252002093', NULL, 0, 0, NULL, NULL, NULL, '2025-11-19 06:08:02', '2025-10-29 23:58:15', 'active', 'suspended', '1.00', NULL, NULL, 0),
(37, '9878a109935206615b7963eba779d411', 'ciccicdddddda04@gmail.com', '$2y$10$pl8dq6.crTVvsR4OGmgof..z4q9zDdPLz0A9M/M3xZiLqd9AabRuq', 'dggsddg', 'dgdgdg', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-30 21:00:13', 'active', 'active', '0.00', NULL, NULL, 1),
(38, '4377bd35b4f036058979a0f40b3d7e8d', 'ciccica04@gmail.com', '$2y$10$HdCV1JwoZGTUuY8.YWyIiOdH9vQEuWv50Ztt1Fhihmm6wMw4R92FG', 'ftrf', 'ff', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-10-30 21:09:58', 'active', 'active', '0.00', NULL, NULL, 1),
(39, 'c5b5f98906da85d32a70d1b3136e8a93', 'nimik@gmx.net', '$2y$10$A45y0GqfugRRV9UM829.VOJHwmxeHmR2jW9CWrhhksazaf3peeYA2', 'Nikolaus-Michael Walter', 'Kösler', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-11-18 18:33:56', '2025-10-30 21:11:45', 'active', 'active', '0.00', NULL, NULL, 0),
(40, '706a8ecd5d9bd61fdd46e60a05a5c7da', 'dcarlucci143@gmail.com', '$2y$10$2Mxy7sNX3TuHNPqSZBQLUOxF9zD72527QjEJnTE4HTQOHQNFFiS7e', 'Domenico', 'Carlucci', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-11-03 09:00:16', '2025-10-30 22:43:56', 'active', 'active', '0.00', NULL, NULL, 1),
(41, '3e32767098b49255234b21df1b2b0319', 'harald.hueber@web.de', '$2y$10$OadSVFBgEZjiRpTanCWHnusl9LMvIfMvUU.azIz4dcoe0kgti2YKm', 'Harald', 'Hueber', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-11-13 10:49:27', '2025-11-01 19:09:43', 'active', 'suspended', '0.00', NULL, NULL, 0),
(42, '3e3394b15da6f6b927f5c69ca998af1a', 'armin.suter@asurag.ch', '$2y$10$FaK9okMQMqF4geQ7sHr0RuQ2cT8ZgjfPP/p2cdXg8Ve2xTkzyRNU6', 'Armin', 'Suter', NULL, NULL, 1, 0, NULL, NULL, NULL, '2025-11-11 21:02:51', '2025-11-03 14:20:11', 'active', 'active', '0.00', NULL, NULL, 0),
(43, '143f164c336c0fa584b6f3719d9af2a4', 'ottoalexo71@gmail.com', '$2y$10$y4WXAAac.Uz6guMr0mGJNeac/lSp.o6Rcafr4YiowKfU2wWo30vda', 'Alexo', 'Otto', NULL, NULL, 0, 0, '2cbf945232d21140cbac147b74397d285929c8918b806216ac912097951d18f4', NULL, '2025-11-12 23:54:41', '2025-11-12 22:51:44', '2025-11-05 23:18:53', 'active', 'active', '0.00', NULL, NULL, 0),
(44, 'e22bfe3af4377d3af43e326c660d1567', 'griem@multilighting.de', '$2y$10$0E20y0SaeBWsLTjj.6l6ueoJu6oVHppH/i.JoF4nlcMpdbp9vp9xS', 'Hans-Joachim', 'Griem', NULL, NULL, 0, 0, 'b4f079cf7956cb0047f8d6ba5ced3b7b5412fcd1760366fbb0f5cc5a5a26c78b', NULL, '2025-11-17 23:27:18', '2025-11-18 08:53:43', '2025-11-12 16:10:35', 'active', 'active', '0.00', NULL, NULL, 1),
(45, '434f8d34c4451c530e030d63f673cde2', 'schwoellenbach33@gmail.com', '$2y$10$SpH91.XfeMcqSVjkQouXJuk6/kYluL55BTGroXrmPPs8bvGdIURB2', 'Hertha', 'Schwoellenbach', NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2025-11-12 21:13:01', 'active', 'active', '0.00', NULL, NULL, 1),
(46, '8ad61b968e5d1fb7cd90f668ee849186', 'hertrud.07091963@gmail.com', '$2y$10$0ROaqsS.W2AwMT2IB9Vst.ojDMg8QZ/sbbMKVtFMAK5hymnNzZAPe', 'Hertha', 'Schwoellenbach', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-11-12 21:16:59', '2025-11-12 21:16:02', 'active', 'active', '0.00', NULL, NULL, 1),
(47, 'e8d9805b81af520d9418b0926b6bb57d', 'maekele.w@yahoo.com', '$2y$10$/agy1BZc0mttx3W5TzOlAOeZvI8.T2aja/oYceGLFyFlMfGcErsx.', 'Maekele', 'Weldu', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-11-17 16:15:53', '2025-11-15 19:16:43', 'active', 'active', '0.00', NULL, NULL, 0),
(48, '27953b75a8d8a631b76370d1753e8c95', 'h.treffer@tretax.de', '$2y$10$u67iutJgPd0q.6jObbzI9O4mQytsRc6OliixIU.PKnTyABKfVSfO.', 'Herbert', 'Treffer', NULL, NULL, 0, 0, NULL, NULL, NULL, '2025-11-19 18:44:18', '2025-11-19 18:41:34', 'active', 'active', '0.00', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_activity_logs`
--

CREATE TABLE `user_activity_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `http_method` varchar(10) DEFAULT 'GET',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `referrer` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_activity_logs`
--

INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(1, 3, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-08-20 17:32:52'),
(2, 3, '/app/transactions.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-20 17:33:57'),
(3, 3, '/app/kyc.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-08-20 17:34:44'),
(4, 21, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-08-20 17:38:26'),
(5, 3, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-08-20 17:39:38'),
(6, 3, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-08-20 17:40:48'),
(7, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-08-20 18:22:30'),
(8, 21, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-08-20 18:47:26'),
(9, 21, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-08-20 22:06:30'),
(10, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-20 22:06:36'),
(11, 21, '/app/support.php', 'POST', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:07:47'),
(12, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:07:48'),
(13, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:08:13'),
(14, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:08:21'),
(15, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-08-20 22:11:43'),
(16, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:15:20'),
(17, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:17:32'),
(18, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:18:17'),
(19, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:19:44'),
(20, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:20:02'),
(21, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:20:42'),
(22, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:21:18'),
(23, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:22:47'),
(24, 21, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:22:53'),
(25, 21, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 22:41:14'),
(26, 21, '/app/transactions.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-20 22:41:26'),
(27, 21, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-08-20 22:41:30'),
(28, 21, '/app/transactions.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-20 22:41:57'),
(29, 21, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-08-20 22:49:44'),
(30, 21, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-20 22:50:46'),
(31, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-08-20 23:58:02'),
(32, 20, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-20 23:58:48'),
(33, 20, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-08-20 23:59:11'),
(34, 20, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 23:59:14'),
(35, 20, '/app/settings.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-20 23:59:44'),
(36, 20, '/app/settings.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-08-21 00:00:54'),
(37, 20, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-08-21 00:01:14'),
(38, 20, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-08-21 00:01:52'),
(39, 20, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-08-21 00:02:00'),
(40, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-08-21 00:02:04'),
(41, 20, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-21 00:02:14'),
(42, 20, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-21 00:02:41'),
(43, 20, '/app/kyc.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:02:46'),
(44, 20, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-21 00:02:57'),
(45, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-08-21 00:03:14'),
(46, 20, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-21 00:03:17'),
(47, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:27'),
(48, 20, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-21 00:03:39'),
(49, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:45'),
(50, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:49'),
(51, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:51'),
(52, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:54'),
(53, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:56'),
(54, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:58'),
(55, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:03:59'),
(56, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:04:01'),
(57, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:04:02'),
(58, 20, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-08-21 00:04:13'),
(59, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:04:23'),
(60, 20, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-08-21 00:04:47'),
(61, 1, '/app/onboarding.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:49:02'),
(62, 1, '/app/onboarding.php?step=2', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-09-01 18:49:18'),
(63, 1, '/app/onboarding.php?step=3', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-09-01 18:49:23'),
(64, 1, '/app/onboarding.php?step=4', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-09-01 18:49:29'),
(65, 1, '/app/onboarding.php?step=5', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-09-01 18:49:38'),
(66, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-09-01 18:49:55'),
(67, 1, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:50:20'),
(68, 1, '/app/kyc.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-09-01 18:50:31'),
(69, 1, '/app/documents.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-01 18:50:50'),
(70, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/documents.php', '2025-09-01 18:50:53'),
(71, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:50:57'),
(72, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:51:39'),
(73, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 18:51:45'),
(74, 1, '/app/settings.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:52:59'),
(75, 1, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-09-01 18:53:10'),
(76, 1, '/app/transactions.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-09-01 18:53:31'),
(77, 1, '/app/kyc.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-01 18:53:44'),
(78, 1, '/app/payment-methods.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-01 18:53:51'),
(79, 1, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/payment-methods.php', '2025-09-01 18:54:04'),
(80, 1, '/app/withdrawal.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-09-01 18:54:29'),
(81, 1, '/app/payment-methods.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-01 18:54:37'),
(82, 1, '/app/transactions.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/payment-methods.php', '2025-09-01 18:54:42'),
(83, 1, '/app/deposit.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-01 18:55:09'),
(84, 1, '/app/withdrawal.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-09-01 18:55:17'),
(85, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-01 18:55:23'),
(86, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-01 18:56:00'),
(87, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 18:56:06'),
(88, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:56:30'),
(89, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 18:56:32'),
(90, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:57:01'),
(91, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 18:57:08'),
(92, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 18:58:36'),
(93, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 18:59:39'),
(94, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 19:00:06'),
(95, 1, '/app/cases.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-01 19:08:51'),
(96, 1, '/app/transactions.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-01 19:09:52'),
(97, 1, '/app/deposit.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-01 19:10:02'),
(98, 1, '/app/withdrawal.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-09-01 19:10:07'),
(99, 1, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-01 19:10:35'),
(100, 1, '/app/kyc.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-09-01 19:10:57'),
(101, 1, '/app/profile.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-01 19:11:16'),
(102, 1, '/app/settings.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-09-01 19:11:26'),
(103, 1, '/app/support.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-09-01 19:11:39'),
(104, 1, '/app/index.php', 'GET', '185.67.177.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-09-01 19:12:13'),
(105, 20, '/app/index.php', 'GET', '46.99.79.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-09-10 03:44:00'),
(106, 20, '/app/cases.php', 'GET', '46.99.79.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-10 03:49:10'),
(107, 20, '/app/cases.php', 'GET', '46.99.79.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-10 03:59:29'),
(108, 20, '/app/cases.php', 'GET', '46.99.79.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-10 03:59:32'),
(109, 20, '/app/index.php', 'GET', '46.99.79.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-10 03:59:43'),
(110, 20, '/app/cases.php', 'GET', '46.99.79.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-10 03:59:49'),
(111, 20, '/app/index.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-09-10 23:27:13'),
(112, 20, '/app/withdrawal.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-10 23:27:26'),
(113, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-10 23:28:05'),
(114, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-10 23:28:21'),
(115, 20, '/app/transactions.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-10 23:28:28'),
(116, 20, '/app/kyc.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-10 23:29:28'),
(117, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:29:38'),
(118, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:34:51'),
(119, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:37:55'),
(120, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:38:20'),
(121, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:39:27'),
(122, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:39:30'),
(123, 20, '/app/cases.php', 'GET', '46.99.102.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-10 23:43:51'),
(124, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-09-11 03:31:03'),
(125, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 03:41:40'),
(126, 20, '/app/withdrawal.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 03:53:17'),
(127, 20, '/app/withdrawal.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 03:53:48'),
(128, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-11 03:53:51'),
(129, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-11 03:54:11'),
(130, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 03:54:15'),
(131, 20, '/app/onboarding.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:01:39'),
(132, 20, '/app/onboarding.php?step=2', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-09-11 04:01:43'),
(133, 20, '/app/onboarding.php?step=3', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-09-11 04:01:46'),
(134, 20, '/app/onboarding.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:02:45'),
(135, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-09-11 04:02:51'),
(136, 20, '/app/onboarding.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:02:58'),
(137, 20, '/app/onboarding.php?step=2', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-09-11 04:03:01'),
(138, 20, '/app/onboarding.php?step=3', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-09-11 04:03:03'),
(139, 20, '/app/onboarding_complete.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-09-11 04:03:05'),
(140, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', NULL, '2025-09-11 04:03:20'),
(141, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', NULL, '2025-09-11 04:04:03'),
(142, 20, '/app/change_password.php', 'POST', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:05:04'),
(143, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', NULL, '2025-09-11 04:05:17'),
(144, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-09-11 04:05:36'),
(145, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-09-11 04:09:35'),
(146, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:09:56'),
(147, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-09-11 04:10:08'),
(148, 20, '/app/settings.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:10:43'),
(149, 20, '/app/kyc.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-09-11 04:10:53'),
(150, 20, '/app/documents.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-09-11 04:10:56'),
(151, 20, '/app/transactions.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/documents.php', '2025-09-11 04:11:00'),
(152, 20, '/app/transactions.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/documents.php', '2025-09-11 04:17:24'),
(153, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:17:26'),
(154, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:17:28'),
(155, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:18:39'),
(156, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:23:05'),
(157, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:25:40'),
(158, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:25:42'),
(159, 20, '/app/index.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:26:10'),
(160, 20, '/app/deposit.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-09-11 04:31:13'),
(161, 20, '/app/withdrawal.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-09-11 04:31:20'),
(162, 20, '/app/withdrawal.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-11 04:31:35'),
(163, 20, '/app/cases.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-11 04:31:44'),
(164, 20, '/app/transactions.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-11 04:33:38'),
(165, 20, '/app/transactions.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-11 04:33:46'),
(166, 20, '/app/transactions.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-09-11 04:34:07'),
(167, 20, '/app/withdrawal.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-09-11 04:34:18'),
(168, 20, '/app/withdrawal.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-11 04:34:34'),
(169, 20, '/app/transactions.php', 'GET', '2a03:4b80:b70a:48e0:ef14:d668:6a97:1074', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-09-11 04:34:40'),
(170, 20, '/app/index.php', 'GET', '2a03:4b80:b704:23ff:712e:2f7f:a2bf:6bff', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-03 18:00:02'),
(171, 20, '/app/cases.php', 'GET', '2a03:4b80:b704:23ff:712e:2f7f:a2bf:6bff', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-03 18:01:48'),
(172, 3, '/app/onboarding.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-10 21:52:11'),
(173, 3, '/app/onboarding.php?step=2', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-10 21:52:35'),
(174, 3, '/app/onboarding.php?step=3', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-10 21:52:40'),
(175, 3, '/app/onboarding_complete.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-10 21:52:46'),
(176, 3, '/app/index.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding_complete.php', '2025-10-10 21:52:52'),
(177, 20, '/app/index.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-10 21:58:30'),
(178, 20, '/app/index.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-10 22:01:05'),
(179, 20, '/app/index.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-10 22:01:34'),
(180, 20, '/app/kyc.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-10 22:06:34'),
(181, 20, '/app/cases.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-10 22:06:58'),
(182, 20, '/app/transactions.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-10 22:07:38'),
(183, 20, '/app/withdrawal.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-10 22:07:55'),
(184, 20, '/app/deposit.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-10-10 22:08:15'),
(185, 20, '/app/withdrawal.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-10 22:08:22'),
(186, 20, '/app/support.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-10-10 22:08:27'),
(187, 20, '/app/support.php', 'POST', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-10 22:08:51'),
(188, 20, '/app/support.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-10 22:08:51'),
(189, 20, '/app/support.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-10 22:09:44'),
(190, 20, '/app/settings.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-10 22:10:17'),
(191, 20, '/app/profile.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-10-10 22:10:24'),
(192, 20, '/app/index.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-10 22:12:20'),
(193, 20, '/app/cases.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-10 22:13:04'),
(194, 20, '/app/settings.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-10 22:26:16'),
(195, 20, '/app/support.php', 'GET', '46.99.95.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-10-10 22:26:19'),
(196, 20, '/app/index.php', 'GET', '46.99.95.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-16 13:27:39'),
(197, 20, '/app/cases.php', 'GET', '46.99.95.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-16 13:28:16'),
(198, 20, '/app/support.php', 'GET', '46.99.95.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-16 13:28:26'),
(199, 20, '/app/index.php', 'GET', '46.99.95.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-16 13:28:47'),
(200, 20, '/app/index.php', 'GET', '46.99.38.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-20 23:39:25'),
(201, 20, '/app/index.php', 'GET', '46.99.38.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-20 23:40:37'),
(202, 20, '/app/index.php', 'GET', '46.99.58.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-21 03:19:24'),
(203, 20, '/app/cases.php', 'GET', '46.99.58.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-21 03:20:04'),
(204, 20, '/app/index.php', 'GET', '46.99.58.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-21 03:22:58'),
(205, 20, '/app/index.php', 'GET', '46.99.4.20', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-23 14:24:33');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(206, 1, '/app/index.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-26 22:23:20'),
(207, 1, '/app/cases.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:25:02'),
(208, 1, '/app/index.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 22:25:47'),
(209, 1, '/app/cases.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:27:07'),
(210, 1, '/app/deposit.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 22:27:12'),
(211, 1, '/app/support.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-26 22:27:52'),
(212, 1, '/app/support.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:27:55'),
(213, 1, '/app/index.php', 'GET', '46.99.104.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:28:31'),
(214, 22, '/app/onboarding.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:34:58'),
(215, 22, '/app/onboarding.php', 'GET', '212.30.36.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:35:38'),
(216, 22, '/app/onboarding.php?step=2', 'GET', '212.30.36.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-26 22:36:16'),
(217, 22, '/app/onboarding.php?step=3', 'GET', '212.30.36.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-26 22:36:24'),
(218, 22, '/app/onboarding_complete.php', 'GET', '212.30.36.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-26 22:36:39'),
(219, 22, '/app/index.php', 'GET', '212.30.36.116', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding_complete.php', '2025-10-26 22:36:42'),
(220, 22, '/app/index.php', 'GET', '212.30.36.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding_complete.php', '2025-10-26 22:37:22'),
(221, 22, '/app/index.php', 'GET', '212.30.36.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-26 22:37:31'),
(222, 22, '/app/index.php', 'GET', '212.30.36.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-26 22:38:10'),
(223, 22, '/app/index.php', 'GET', '212.30.36.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:38:37'),
(224, 22, '/app/kyc.php', 'GET', '212.30.36.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:38:51'),
(225, 22, '/app/kyc.php', 'GET', '212.30.36.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-26 22:40:20'),
(226, 22, '/app/index.php', 'GET', '212.30.36.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-26 22:42:08'),
(227, 22, '/app/index.php', 'GET', '212.30.36.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-26 22:42:39'),
(228, 22, '/app/index.php', 'GET', '212.30.36.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-26 22:43:27'),
(229, 22, '/app/index.php', 'GET', '212.30.36.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-26 22:43:53'),
(230, 22, '/app/cases.php', 'GET', '212.30.36.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:44:41'),
(231, 22, '/app/index.php', 'GET', '212.30.36.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 22:45:01'),
(232, 22, '/app/index.php', 'GET', '212.30.36.145', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 22:46:58'),
(233, 22, '/app/index.php', 'GET', '212.30.36.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:47:27'),
(234, 22, '/app/support.php', 'GET', '212.30.36.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:49:44'),
(235, 22, '/app/support.php', 'GET', '212.30.36.158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:49:53'),
(236, 22, '/app/support.php', 'POST', '212.30.36.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:50:14'),
(237, 22, '/app/support.php', 'GET', '212.30.36.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:50:14'),
(238, 22, '/app/support.php', 'GET', '212.30.36.107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:51:19'),
(239, 22, '/app/support.php', 'GET', '212.30.36.111', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:52:00'),
(240, 22, '/app/support.php', 'GET', '212.30.36.141', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:52:09'),
(241, 22, '/app/support.php', 'GET', '212.30.36.123', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:52:20'),
(242, 22, '/app/support.php', 'GET', '212.30.36.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:52:54'),
(243, 22, '/app/index.php', 'GET', '212.30.36.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:53:10'),
(244, 22, '/app/index.php', 'GET', '212.30.36.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:53:10'),
(245, 22, '/app/index.php', 'GET', '212.30.36.144', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 22:54:00'),
(246, 22, '/app/onboarding.php', 'GET', '212.30.36.162', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:56:45'),
(247, 22, '/app/index.php', 'GET', '212.30.36.123', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-26 22:56:50'),
(248, 22, '/app/onboarding.php', 'GET', '212.30.36.115', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:56:56'),
(249, 22, '/app/onboarding.php?step=2', 'GET', '212.30.36.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-26 22:57:05'),
(250, 22, '/app/onboarding.php?step=3', 'GET', '212.30.36.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-26 22:57:07'),
(251, 22, '/app/onboarding.php?step=4', 'GET', '212.30.36.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-26 22:57:09'),
(252, 22, '/app/onboarding.php?step=5', 'GET', '212.30.36.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-26 22:57:51'),
(253, 22, '/app/index.php', 'GET', '212.30.36.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-26 22:58:38'),
(254, 22, '/app/transactions.php', 'GET', '212.30.36.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 22:59:19'),
(255, 22, '/app/index.php', 'GET', '212.30.36.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-26 22:59:47'),
(256, 22, '/app/index.php', 'GET', '212.30.36.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-26 23:02:01'),
(257, 22, '/app/cases.php', 'GET', '212.30.36.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:02:08'),
(258, 22, '/app/index.php', 'GET', '212.30.36.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:02:12'),
(259, 22, '/app/index.php', 'GET', '212.30.36.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:02:20'),
(260, 22, '/app/index.php', 'GET', '212.30.36.143', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:02:53'),
(261, 22, '/app/index.php', 'GET', '212.30.36.160', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:03:01'),
(262, 22, '/app/index.php', 'GET', '212.30.36.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:03:33'),
(263, 22, '/app/index.php', 'GET', '212.30.36.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:04:37'),
(264, 22, '/app/index.php', 'GET', '212.30.36.115', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:05:39'),
(265, 22, '/app/index.php', 'GET', '212.30.36.161', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:06:44'),
(266, 22, '/app/cases.php', 'GET', '212.30.36.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:07:00'),
(267, 22, '/app/cases.php', 'GET', '212.30.36.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:07:27'),
(268, 22, '/app/cases.php', 'GET', '212.30.36.120', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:07:39'),
(269, 22, '/app/transactions.php', 'GET', '212.30.36.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:08:15'),
(270, 22, '/app/withdrawal.php', 'GET', '212.30.36.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-26 23:08:29'),
(271, 22, '/app/withdrawal.php', 'GET', '212.30.36.110', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-26 23:09:08'),
(272, 22, '/app/index.php', 'GET', '212.30.36.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-10-26 23:09:31'),
(273, 22, '/app/profile.php', 'GET', '212.30.36.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:10:20'),
(274, 22, '/app/settings.php', 'GET', '212.30.36.119', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-10-26 23:10:26'),
(275, 22, '/app/index.php', 'GET', '212.30.36.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-10-26 23:10:36'),
(276, 22, '/app/index.php', 'GET', '212.30.36.158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-10-26 23:12:31'),
(277, 22, '/app/index.php', 'GET', '212.30.36.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-10-26 23:12:45'),
(278, 22, '/app/cases.php', 'GET', '212.30.36.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:12:50'),
(279, 22, '/app/settings.php', 'GET', '212.30.36.116', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-26 23:13:17'),
(280, 22, '/app/index.php', 'GET', '212.30.36.141', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/settings.php', '2025-10-26 23:13:38'),
(281, 3, '/app/index.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-26 23:14:30'),
(282, 20, '/app/index.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-26 23:15:16'),
(283, 22, '/app/support.php', 'GET', '212.30.36.143', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:18:13'),
(284, 22, '/app/index.php', 'GET', '212.30.36.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 23:18:21'),
(285, 3, '/app/index.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-26 23:22:38'),
(286, 3, '/app/support.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-26 23:23:08'),
(287, 3, '/app/documents.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/support.php', '2025-10-26 23:23:12'),
(288, 3, '/app/index.php', 'GET', '84.22.38.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/documents.php', '2025-10-26 23:23:16'),
(289, 24, '/app/onboarding.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 20:38:27'),
(290, 27, '/app/onboarding.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 20:49:32'),
(291, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 20:50:03'),
(292, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 20:57:59'),
(293, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 20:58:04'),
(294, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 21:04:22'),
(295, 27, '/app/onboarding.php?step=2', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 21:04:41'),
(296, 27, '/app/onboarding.php?step=3', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-27 21:05:05'),
(297, 27, '/app/onboarding.php?step=4', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-27 21:05:33'),
(298, 27, '/app/onboarding.php?step=2', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 21:06:43'),
(299, 27, '/app/onboarding.php?step=3', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-27 21:07:11'),
(300, 27, '/app/onboarding.php?step=4', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-27 21:07:41'),
(301, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:08:37'),
(302, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:09:02'),
(303, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', NULL, '2025-10-27 21:23:17'),
(304, 27, '/app/onboarding.php?step=2', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 21:23:28'),
(305, 27, '/app/onboarding.php?step=3', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-27 21:23:33'),
(306, 27, '/app/onboarding.php?step=4', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-27 21:23:35'),
(307, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:24:09'),
(308, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:34:21'),
(309, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:38:37'),
(310, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:39:14'),
(311, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 21:39:21'),
(312, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 21:40:35'),
(313, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 21:41:17'),
(314, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 21:41:23'),
(315, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 21:59:05'),
(316, 27, '/app/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 21:59:09'),
(317, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 22:00:49'),
(318, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 22:00:55'),
(319, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 22:16:48'),
(320, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 22:17:44'),
(321, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 22:17:48'),
(322, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 22:29:20'),
(323, 27, '/app/onboarding.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 22:29:36'),
(324, 27, '/app/onboarding.php?step=2', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 22:29:40'),
(325, 27, '/app/onboarding.php?step=3', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-27 22:29:42'),
(326, 27, '/app/onboarding.php?step=4', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-27 22:29:44'),
(327, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 22:30:13'),
(328, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:30:26'),
(329, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:32:02'),
(330, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:32:05'),
(331, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:38:04'),
(332, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:38:08'),
(333, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:38:26'),
(334, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:40:27'),
(335, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:40:36'),
(336, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:41:39'),
(337, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:41:50'),
(338, 27, '/app/onboarding.php?step=5', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:46:13'),
(339, 27, '/app/onboarding_complete.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 22:46:23'),
(340, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding_complete.php', '2025-10-27 22:46:26'),
(341, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 22:46:41'),
(342, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 22:54:46'),
(343, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 22:54:51'),
(344, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 22:54:52'),
(345, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 22:54:55'),
(346, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 22:55:01'),
(347, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 22:55:38'),
(348, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 22:57:22'),
(349, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 22:58:36'),
(350, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:01:22'),
(351, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:06:36'),
(352, 27, '/app/documents.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:06:59'),
(353, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 23:07:12'),
(354, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 23:08:18'),
(355, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 23:09:45'),
(356, 27, '/app/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:11:56'),
(357, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:12:00'),
(358, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:12:53'),
(359, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:14:31'),
(360, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:14:47'),
(361, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:15:27'),
(362, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:16:00'),
(363, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:16:29'),
(364, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:16:32'),
(365, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:18:45'),
(366, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:18:49'),
(367, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:18:54'),
(368, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:19:12'),
(369, 27, '/app/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:19:17'),
(370, 27, '/app/payment-methods.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:19:23'),
(371, 27, '/app/deposit.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/payment-methods.php', '2025-10-27 23:19:27'),
(372, 27, '/app/deposit.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/payment-methods.php', '2025-10-27 23:19:42'),
(373, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-27 23:20:05'),
(374, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-27 23:21:15'),
(375, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:21:18'),
(376, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:21:23'),
(377, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:21:45'),
(378, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:21:54'),
(379, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:21:56'),
(380, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:21:59'),
(381, 27, '/app/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:22:10'),
(382, 27, '/app/deposit.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:22:17'),
(383, 27, '/app/deposit.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-27 23:22:20'),
(384, 27, '/app/withdrawal.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-27 23:22:23'),
(385, 27, '/app/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-10-27 23:22:29'),
(386, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-27 23:24:39'),
(387, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-27 23:25:11'),
(388, 27, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:25:26'),
(389, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:25:29'),
(390, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:26:48'),
(391, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:30:48'),
(392, 27, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-27 23:31:12'),
(393, 28, '/app/onboarding.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:34:12'),
(394, 28, '/app/onboarding.php?step=2', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php', '2025-10-27 23:34:37'),
(395, 28, '/app/onboarding.php?step=3', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=2', '2025-10-27 23:34:46'),
(396, 28, '/app/onboarding.php?step=4', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=3', '2025-10-27 23:35:00'),
(397, 28, '/app/onboarding.php?step=5', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=4', '2025-10-27 23:35:35'),
(398, 28, '/app/onboarding_complete.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding.php?step=5', '2025-10-27 23:36:01'),
(399, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/onboarding_complete.php', '2025-10-27 23:36:08'),
(400, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:37:05'),
(401, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:37:57'),
(402, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:38:03'),
(403, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:38:40'),
(404, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:39:00'),
(405, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:40:04'),
(406, 28, '/app/kyc.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:40:16'),
(407, 28, '/app/kyc.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-27 23:40:53'),
(408, 28, '/app/kyc.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-27 23:41:21'),
(409, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-27 23:41:30');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(410, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:41:56'),
(411, 28, '/app/index.php', 'GET', '91.217.249.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:47:11'),
(412, 28, '/app/index.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:49:30'),
(413, 28, '/app/index.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:51:59'),
(414, 28, '/app/transactions.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:53:53'),
(415, 28, '/app/transactions.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:54:02'),
(416, 28, '/app/transactions.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:54:40'),
(417, 28, '/app/deposit.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:54:46'),
(418, 28, '/app/withdrawal.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-27 23:54:51'),
(419, 28, '/app/payment-methods.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-10-27 23:54:56'),
(420, 28, '/app/deposit.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/payment-methods.php', '2025-10-27 23:55:01'),
(421, 28, '/app/withdrawal.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/deposit.php', '2025-10-27 23:55:05'),
(422, 28, '/app/profile.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/withdrawal.php', '2025-10-27 23:55:09'),
(423, 28, '/app/settings.php', 'GET', '91.217.249.222', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/profile.php', '2025-10-27 23:55:11'),
(424, 28, '/app/index.php', 'GET', '91.217.249.191', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-27 23:58:42'),
(425, 28, '/app/kyc.php', 'GET', '91.217.249.191', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:59:13'),
(426, 28, '/app/index.php', 'GET', '91.217.249.191', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/kyc.php', '2025-10-27 23:59:45'),
(427, 28, '/app/transactions.php', 'GET', '91.217.249.191', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:59:48'),
(428, 28, '/app/index.php', 'GET', '91.217.249.191', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-27 23:59:52'),
(429, 28, '/app/transactions.php', 'GET', '91.217.249.191', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-27 23:59:55'),
(430, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:05:13'),
(431, 20, '/app/transactions.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-28 00:05:21'),
(432, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/transactions.php', '2025-10-28 00:05:29'),
(433, 20, '/app/cases.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-28 00:05:32'),
(434, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-28 00:05:48'),
(435, 20, '/app/support.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-28 00:06:16'),
(436, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-28 00:06:20'),
(437, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/cases.php', '2025-10-28 00:06:56'),
(438, 28, '/app/transactions.php', 'GET', '91.217.249.207', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-28 00:08:09'),
(439, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:46:39'),
(440, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:47:10'),
(441, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:47:18'),
(442, 20, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:47:29'),
(443, 1, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:49:24'),
(444, 1, '/app/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/index.php', '2025-10-28 00:49:52'),
(445, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:57:57'),
(446, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 00:59:39'),
(447, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://blockchainfahndung.com/app/login.php', '2025-10-28 01:06:11'),
(448, 29, '/onboarding.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:28:20'),
(449, 29, '/onboarding.php?step=2', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/onboarding.php', '2025-10-28 01:28:36'),
(450, 29, '/onboarding.php?step=3', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/onboarding.php?step=2', '2025-10-28 01:28:45'),
(451, 29, '/onboarding.php?step=4', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/onboarding.php?step=3', '2025-10-28 01:28:57'),
(452, 29, '/onboarding.php?step=5', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/onboarding.php?step=4', '2025-10-28 01:29:29'),
(453, 29, '/onboarding_complete.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/onboarding.php?step=5', '2025-10-28 01:29:50'),
(454, 29, '/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/onboarding_complete.php', '2025-10-28 01:29:52'),
(455, 29, '/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:30:29'),
(456, 29, '/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:31:34'),
(457, 29, '/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:31:36'),
(458, 29, '/index.php', 'GET', '46.99.21.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:33:14'),
(459, 1, '/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/login.php', '2025-10-28 01:34:56'),
(460, 1, '/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:35:20'),
(461, 1, '/documents.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/transactions.php', '2025-10-28 01:35:35'),
(462, 1, '/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/documents.php', '2025-10-28 01:35:36'),
(463, 1, '/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/kyc.php', '2025-10-28 01:35:59'),
(464, 1, '/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/support.php', '2025-10-28 01:36:20'),
(465, 1, '/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/support.php', '2025-10-28 01:36:39'),
(466, 1, '/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/transactions.php', '2025-10-28 01:36:41'),
(467, 1, '/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/transactions.php', '2025-10-28 01:37:10'),
(468, 1, '/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/transactions.php', '2025-10-28 01:37:11'),
(469, 1, '/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/transactions.php', '2025-10-28 01:38:08'),
(470, 1, '/profile.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/cases.php', '2025-10-28 01:42:11'),
(471, 1, '/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/profile.php', '2025-10-28 01:42:26'),
(472, 1, '/profile.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/kyc.php', '2025-10-28 01:42:33'),
(473, 1, '/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/profile.php', '2025-10-28 01:42:43'),
(474, 1, '/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'https://kryptox.co.uk/index.php', '2025-10-28 01:43:10'),
(475, 30, '/app/onboarding.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:35:15'),
(476, 30, '/app/onboarding.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:41:14'),
(477, 30, '/app/onboarding.php?step=2', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-28 23:42:10'),
(478, 30, '/app/onboarding.php?step=3', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-28 23:42:30'),
(479, 30, '/app/onboarding.php?step=3', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-28 23:42:51'),
(480, 30, '/app/onboarding.php?step=4', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-28 23:43:38'),
(481, 30, '/app/onboarding.php?step=5', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-28 23:44:46'),
(482, 30, '/app/onboarding_complete.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=5', '2025-10-28 23:45:08'),
(483, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php', '2025-10-28 23:45:11'),
(484, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-28 23:46:48'),
(485, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:47:39'),
(486, 30, '/app/kyc.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:48:02'),
(487, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-28 23:48:16'),
(488, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-28 23:49:49'),
(489, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-28 23:51:08'),
(490, 30, '/app/cases.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:51:56'),
(491, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/cases.php', '2025-10-28 23:52:10'),
(492, 30, '/app/support.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:52:16'),
(493, 30, '/app/support.php', 'POST', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/support.php', '2025-10-28 23:52:39'),
(494, 30, '/app/support.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/support.php', '2025-10-28 23:52:39'),
(495, 30, '/app/support.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/support.php', '2025-10-28 23:53:49'),
(496, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/support.php', '2025-10-28 23:54:03'),
(497, 30, '/app/index.php', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-28 23:54:23'),
(498, 30, '/app/', 'GET', '185.173.204.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/', '2025-10-28 23:57:59'),
(499, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 02:53:51'),
(500, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 02:53:58'),
(501, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 02:55:07'),
(502, 29, '/app/transactions.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 02:55:13'),
(503, 29, '/app/transactions.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 02:55:55'),
(504, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/transactions.php', '2025-10-29 02:55:59'),
(505, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 03:24:42'),
(506, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 03:47:40'),
(507, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 03:47:41'),
(508, 3, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 03:48:42'),
(509, 3, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 03:55:57'),
(510, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 03:56:36'),
(511, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 04:00:29'),
(512, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 04:01:34'),
(513, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:06:06'),
(514, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:06:10'),
(515, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:10:07'),
(516, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:11:30'),
(517, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:11:32'),
(518, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:13:26'),
(519, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:13:28'),
(520, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:17:19'),
(521, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:17:21'),
(522, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:25:21'),
(523, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:26:54'),
(524, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 04:26:57'),
(525, 3, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 04:28:51'),
(526, 3, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 04:36:20'),
(527, 29, '/app/index.php', 'GET', '46.99.70.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 04:37:03'),
(528, 31, '/app/onboarding.php', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 11:25:35'),
(529, 31, '/app/onboarding.php?step=2', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-29 11:26:03'),
(530, 31, '/app/onboarding.php?step=3', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-29 11:26:19'),
(531, 31, '/app/onboarding.php?step=4', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-29 11:26:55'),
(532, 31, '/app/onboarding.php?step=5', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-29 11:27:30'),
(533, 31, '/app/onboarding_complete.php', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/onboarding.php?step=5', '2025-10-29 11:27:49'),
(534, 31, '/app/index.php', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/onboarding_complete.php', '2025-10-29 11:27:51'),
(535, 31, '/app/index.php', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 11:29:03'),
(536, 31, '/app/index.php', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 11:31:46'),
(537, 31, '/app/index.php', 'GET', '46.99.57.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_2_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.2 Mobile/15E148 Safari/604.1', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 11:32:58'),
(538, 34, '/app/onboarding.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 12:09:15'),
(539, 34, '/app/onboarding.php?step=2', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-29 12:10:09'),
(540, 34, '/app/onboarding.php?step=3', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-29 12:10:22'),
(541, 34, '/app/onboarding.php?step=4', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-29 12:11:00'),
(542, 34, '/app/onboarding.php?step=5', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-29 12:11:32'),
(543, 34, '/app/onboarding_complete.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=5', '2025-10-29 12:12:00'),
(544, 34, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php', '2025-10-29 12:12:05'),
(545, 34, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 12:13:13'),
(546, 34, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 12:16:53'),
(547, 34, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 12:20:39'),
(548, 34, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 13:07:06'),
(549, 34, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:f515:30c5:822:4453', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 13:07:07'),
(550, 35, '/app/onboarding.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 16:45:40'),
(551, 35, '/app/onboarding.php?step=2', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-29 16:46:25'),
(552, 35, '/app/onboarding.php?step=3', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-29 16:46:34'),
(553, 35, '/app/onboarding.php?step=4', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-29 16:47:06'),
(554, 35, '/app/onboarding.php?step=5', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-29 16:47:33'),
(555, 35, '/app/onboarding.php?step=5', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-29 16:48:04'),
(556, 35, '/app/onboarding_complete.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=5', '2025-10-29 16:48:45'),
(557, 35, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php', '2025-10-29 16:48:47'),
(558, 35, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 16:50:03'),
(559, 35, '/app/index.php', 'GET', '46.99.29.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 16:53:32'),
(560, 35, '/app/kyc.php', 'GET', '46.99.29.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 16:54:22'),
(561, 35, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-29 16:55:05'),
(562, 35, '/app/', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/ueber-uns.php', '2025-10-29 16:57:50'),
(563, 35, '/app/kyc.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/', '2025-10-29 16:58:01'),
(564, 35, '/app/kyc.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-29 16:58:32'),
(565, 35, '/app/kyc.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 17:01:16'),
(566, 35, '/app/kyc.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-29 17:01:43'),
(567, 35, '/app/kyc.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-29 17:02:33'),
(568, 35, '/app/profile.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-29 17:02:54'),
(569, 35, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/profile.php', '2025-10-29 17:03:45'),
(570, 35, '/app/kyc.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-29 17:08:05'),
(571, 35, '/app/index.php', 'GET', '46.99.29.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/profile.php', '2025-10-29 17:27:13'),
(572, 35, '/app/index.php', 'GET', '46.99.29.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 17:28:47'),
(573, 35, '/app/transactions.php', 'GET', '46.99.29.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 17:30:11'),
(574, 35, '/app/index.php', 'GET', '46.99.29.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/transactions.php', '2025-10-29 17:38:48'),
(575, 35, '/app/index.php', 'GET', '2a03:4b80:cc13:be0:ccbe:ae2b:d79c:1401', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 18:12:16'),
(576, 29, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 23:08:28'),
(577, 29, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/login.php', '2025-10-29 23:10:18'),
(578, 29, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-29 23:11:02'),
(579, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 01:39:41'),
(580, 36, '/app/onboarding.php?step=2', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-30 01:39:56'),
(581, 36, '/app/onboarding.php?step=3', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-30 01:40:00'),
(582, 36, '/app/onboarding.php?step=4', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-30 01:40:10'),
(583, 36, '/app/onboarding.php?step=5', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-30 01:40:36'),
(584, 36, '/app/onboarding_complete.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=5', '2025-10-30 01:40:48'),
(585, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php', '2025-10-30 01:40:49'),
(586, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 01:41:15'),
(587, 36, '/app/kyc.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 01:41:23'),
(588, 36, '/app/kyc.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-30 01:42:10'),
(589, 36, '/app/kyc.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-30 01:43:03'),
(590, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/kyc.php', '2025-10-30 01:43:05'),
(591, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 01:43:50'),
(592, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:08:03'),
(593, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:09:21'),
(594, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:09:22'),
(595, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:09:23'),
(596, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:09:25'),
(597, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:09:27'),
(598, 36, '/app/onboarding.php?step=2', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-30 02:09:28'),
(599, 36, '/app/onboarding.php?step=3', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-30 02:09:30'),
(600, 36, '/app/onboarding.php?step=4', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-30 02:09:32'),
(601, 36, '/app/onboarding_complete.php?trial=1', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-30 02:10:02'),
(602, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php?trial=1', '2025-10-30 02:10:05'),
(603, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php?trial=1', '2025-10-30 02:16:40'),
(604, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php?trial=1', '2025-10-30 02:22:49'),
(605, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:22:52'),
(606, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:25:11'),
(607, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:29:29'),
(608, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:30:24'),
(609, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:30:33'),
(610, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:30:58'),
(611, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:31:03'),
(612, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:31:12'),
(613, 36, '/app/onboarding.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:32:15'),
(614, 36, '/app/onboarding.php?step=2', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php', '2025-10-30 02:32:17'),
(615, 36, '/app/onboarding.php?step=3', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=2', '2025-10-30 02:32:18'),
(616, 36, '/app/onboarding.php?step=4', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=3', '2025-10-30 02:32:20'),
(617, 36, '/app/onboarding_complete.php?trial=1', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding.php?step=4', '2025-10-30 02:32:56'),
(618, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/onboarding_complete.php?trial=1', '2025-10-30 02:32:58'),
(619, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:33:03');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(620, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:33:13'),
(621, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:33:14'),
(622, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:33:18'),
(623, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:33:39'),
(624, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:33:50'),
(625, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:33:52'),
(626, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:39:34'),
(627, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:40:01'),
(628, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:40:02'),
(629, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:40:03'),
(630, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:40:07'),
(631, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:41:53'),
(632, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:41:55'),
(633, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:41:57'),
(634, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:42:30'),
(635, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:42:32'),
(636, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:43:01'),
(637, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:43:02'),
(638, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:43:51'),
(639, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:43:59'),
(640, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:44:44'),
(641, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:46:04'),
(642, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/index.php', '2025-10-30 02:46:06'),
(643, 36, '/app/packages.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:46:20'),
(644, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:46:22'),
(645, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://tradevestcrypto.de/app/packages.php', '2025-10-30 02:46:23'),
(646, 36, '/app/index.php', 'GET', '46.99.104.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 03:21:22'),
(647, 39, '/app/onboarding.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-30 21:14:00'),
(648, 39, '/app/onboarding.php?step=2', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/onboarding.php', '2025-10-30 21:15:18'),
(649, 39, '/app/onboarding.php?step=3', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-10-30 21:15:48'),
(650, 39, '/app/onboarding.php?step=4', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-10-30 21:18:38'),
(651, 39, '/app/onboarding_complete.php?trial=1', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-10-30 21:19:18'),
(652, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/onboarding_complete.php?trial=1', '2025-10-30 21:19:21'),
(653, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/onboarding_complete.php?trial=1', '2025-10-30 21:20:19'),
(654, 39, '/app/kyc.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-30 21:21:29'),
(655, 39, '/app/kyc.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-30 21:23:16'),
(656, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 21:34:43'),
(657, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 21:34:46'),
(658, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 21:34:52'),
(659, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 21:34:59'),
(660, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 21:35:52'),
(661, 39, '/app/cases.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-30 21:36:08'),
(662, 39, '/app/cases.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-30 21:36:20'),
(663, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/cases.php', '2025-10-30 21:36:28'),
(664, 39, '/app/support.php', 'POST', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-30 21:38:41'),
(665, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-30 21:38:41'),
(666, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-30 21:40:48'),
(667, 39, '/app/profile.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-10-30 21:41:54'),
(668, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/profile.php', '2025-10-30 21:42:12'),
(669, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 21:54:05'),
(670, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 22:07:08'),
(671, 1, '/app/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:09:01'),
(672, 1, '/app/support.php', 'POST', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:09:08'),
(673, 1, '/app/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:09:08'),
(674, 1, '/app/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:09:59'),
(675, 1, '/app/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:12:13'),
(676, 1, '/app/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:12:48'),
(677, 1, '/app/packages.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 22:12:55'),
(678, 1, '/app/profile.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-10-30 22:13:07'),
(679, 1, '/app/settings.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-10-30 22:13:15'),
(680, 1, '/app/support.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-10-30 22:13:18'),
(681, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:13:27'),
(682, 1, '/app/packages.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:13:36'),
(683, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-10-30 22:13:38'),
(684, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:14:22'),
(685, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:14:38'),
(686, 1, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:14:38'),
(687, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 22:14:54'),
(688, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 22:16:04'),
(689, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-10-30 22:16:10'),
(690, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:16:16'),
(691, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-30 22:18:14'),
(692, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-10-30 22:18:22'),
(693, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-10-30 22:20:56'),
(694, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:a863:b646:fa0e:42d8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-10-30 22:22:52'),
(695, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 22:32:49'),
(696, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 22:34:40'),
(697, 36, '/app/transactions.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:34:41'),
(698, 36, '/app/cases.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-10-30 22:34:55'),
(699, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-10-30 22:34:56'),
(700, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-10-30 22:41:25'),
(701, 40, '/app/onboarding.php', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:45:01'),
(702, 40, '/app/onboarding.php?step=2', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-10-30 22:47:03'),
(703, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-10-30 22:47:20'),
(704, 40, '/app/onboarding.php?step=3', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-10-30 22:47:27'),
(705, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:48:00'),
(706, 40, '/app/onboarding.php', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 22:55:21'),
(707, 40, '/app/onboarding.php?step=2', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-10-30 22:55:28'),
(708, 40, '/app/onboarding.php?step=3', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-10-30 22:55:33'),
(709, 40, '/app/onboarding.php?step=4', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-10-30 22:58:42'),
(710, 40, '/app/onboarding.php?step=5', 'GET', '2003:c8:6f0b:700:7855:7e2f:6994:759d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-10-30 22:59:22'),
(711, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-10-30 23:40:20'),
(712, 36, '/app/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 23:40:23'),
(713, 36, '/app/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 23:41:08'),
(714, 36, '/app/kyc.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-10-30 23:41:10'),
(715, 36, '/app/index.php', 'GET', '85.195.78.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-10-30 23:57:12'),
(716, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-10-31 15:55:46'),
(717, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 15:56:06'),
(718, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 15:57:29'),
(719, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 16:04:01'),
(720, 39, '/app/packages.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-31 16:27:58'),
(721, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/packages.php', '2025-10-31 16:28:44'),
(722, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/packages.php', '2025-10-31 16:28:49'),
(723, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-10-31 20:33:00'),
(724, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 20:33:14'),
(725, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-31 20:38:48'),
(726, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-31 20:40:21'),
(727, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 20:40:38'),
(728, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-10-31 20:42:33'),
(729, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 20:43:33'),
(730, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-10-31 21:29:55'),
(731, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 21:30:05'),
(732, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 21:30:09'),
(733, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-10-31 21:33:42'),
(734, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-10-31 21:33:49'),
(735, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-10-31 21:34:15'),
(736, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 01:17:24'),
(737, 36, '/app/kyc.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:21:37'),
(738, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-01 01:21:41'),
(739, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:22:24'),
(740, 36, '/app/profile.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:23:10'),
(741, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-01 01:24:37'),
(742, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-01 01:27:40'),
(743, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-01 01:28:25'),
(744, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:29:53'),
(745, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:33:11'),
(746, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:33:12'),
(747, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:33:13'),
(748, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:33:19'),
(749, 36, '/app/support.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:33:27'),
(750, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 01:33:36'),
(751, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 01:35:24'),
(752, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 01:36:56'),
(753, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:37:10'),
(754, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:37:18'),
(755, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:37:46'),
(756, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:37:47'),
(757, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:37:48'),
(758, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:37:50'),
(759, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 01:37:51'),
(760, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 01:38:02'),
(761, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 01:38:35'),
(762, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 01:55:12'),
(763, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 01:56:46'),
(764, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 02:04:24'),
(765, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 02:04:58'),
(766, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 02:07:55'),
(767, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 02:07:58'),
(768, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:08:36'),
(769, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:09:14'),
(770, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:10:56'),
(771, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:11:09'),
(772, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:11:37'),
(773, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:11:38'),
(774, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:11:39'),
(775, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:13:14'),
(776, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:13:20'),
(777, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:19:02'),
(778, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:19:04'),
(779, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 02:19:18'),
(780, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-01 02:27:46'),
(781, 36, '/app/support.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 02:33:42'),
(782, 36, '/app/support.php', 'POST', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 02:33:55'),
(783, 36, '/app/support.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 02:33:55'),
(784, 36, '/app/support.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 02:39:21'),
(785, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 02:54:52'),
(786, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:55:28'),
(787, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:56:07'),
(788, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 02:56:10'),
(789, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 02:59:08'),
(790, 36, '/app/', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/', '2025-11-01 03:04:32'),
(791, 36, '/app/', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/', '2025-11-01 03:04:34'),
(792, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 03:05:11'),
(793, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 03:07:10'),
(794, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:15:31'),
(795, 36, '/app/cases.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:17:04'),
(796, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:18:58'),
(797, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:19:37'),
(798, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:22:17'),
(799, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:22:19'),
(800, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:31:22'),
(801, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:35:16'),
(802, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:35:31'),
(803, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:36:19'),
(804, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:36:21'),
(805, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:36:27'),
(806, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:37:51'),
(807, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:38:18'),
(808, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:38:41'),
(809, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:38:58'),
(810, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:39:36'),
(811, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:39:58'),
(812, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:39:59'),
(813, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:40:42'),
(814, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:40:59'),
(815, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:41:02'),
(816, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:43:07'),
(817, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-01 04:43:20'),
(818, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:43:23'),
(819, 36, '/app/deposit.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-11-01 04:47:28'),
(820, 36, '/app/withdrawal.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-11-01 04:47:46'),
(821, 36, '/app/deposit.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-11-01 04:48:30'),
(822, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:48:31'),
(823, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:48:47'),
(824, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 04:48:48'),
(825, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:48:49'),
(826, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 04:56:33'),
(827, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 04:56:48'),
(828, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:06:14'),
(829, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:07:17'),
(830, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:07:21'),
(831, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:07:42'),
(832, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:07:44'),
(833, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:10:30'),
(834, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:10:51'),
(835, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-01 05:10:52'),
(836, 36, '/app/packages.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:10:53'),
(837, 36, '/app/deposit.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-11-01 05:11:04'),
(838, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/deposit.php', '2025-11-01 05:17:51');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(839, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:18:07'),
(840, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:18:10'),
(841, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:19:44'),
(842, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-11-01 05:20:40'),
(843, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:20:46'),
(844, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:20:49'),
(845, 39, '/app/support.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:20:52'),
(846, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-11-01 05:21:35'),
(847, 39, '/app/cases.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:22:41'),
(848, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/support.php', '2025-11-01 05:22:50'),
(849, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:23:30'),
(850, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:23:34'),
(851, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:23:42'),
(852, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:25:23'),
(853, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:25:24'),
(854, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', NULL, '2025-11-01 05:26:38'),
(855, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:d566:2a96:2eec:c9e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:28:09'),
(856, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:31:33'),
(857, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:34:42'),
(858, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:43:01'),
(859, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:43:04'),
(860, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:43:19'),
(861, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:43:22'),
(862, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:44:04'),
(863, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:46:11'),
(864, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:46:13'),
(865, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:46:26'),
(866, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:48:21'),
(867, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:52:43'),
(868, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 05:52:44'),
(869, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:53:04'),
(870, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 05:53:18'),
(871, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:04:16'),
(872, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:04:17'),
(873, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:18:32'),
(874, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:18:51'),
(875, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:18:53'),
(876, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:19:37'),
(877, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:19:41'),
(878, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:19:43'),
(879, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:21:55'),
(880, 36, '/app/index.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:21:55'),
(881, 36, '/app/transactions.php', 'GET', '46.99.12.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:21:57'),
(882, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:36:37'),
(883, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:36:39'),
(884, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:37:19'),
(885, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:37:59'),
(886, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:38:58'),
(887, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:39:00'),
(888, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:39:01'),
(889, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:39:27'),
(890, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:39:53'),
(891, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:40:09'),
(892, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:40:31'),
(893, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:40:33'),
(894, 36, '/app/transactions.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:40:49'),
(895, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-01 06:41:18'),
(896, 36, '/app/index.php', 'GET', '46.99.78.192', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 06:41:34'),
(897, 41, '/app/onboarding.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 19:12:33'),
(898, 41, '/app/onboarding.php?step=2', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-01 19:14:13'),
(899, 41, '/app/onboarding.php?step=3', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-01 19:15:12'),
(900, 41, '/app/onboarding.php?step=4', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-01 19:17:33'),
(901, 41, '/app/onboarding_complete.php?trial=1', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-01 19:20:24'),
(902, 41, '/app/index.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding_complete.php?trial=1', '2025-11-01 19:20:57'),
(903, 41, '/app/index.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 19:26:40'),
(904, 41, '/app/kyc.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-01 19:27:03'),
(905, 41, '/app/support.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-01 19:28:20'),
(906, 41, '/app/support.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 19:28:23'),
(907, 41, '/app/support.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-11-01 19:29:33'),
(908, 41, '/app/index.php', 'GET', '2a02:810d:d0b:9800:add9:4d6:cde9:50c7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-01 19:29:44'),
(909, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:55:47'),
(910, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:56:20'),
(911, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 04:56:47'),
(912, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:56:48'),
(913, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:56:55'),
(914, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:57:00'),
(915, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 04:57:02'),
(916, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:57:03'),
(917, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 04:57:35'),
(918, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:57:40'),
(919, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 04:57:44'),
(920, 36, '/app/support.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 04:57:49'),
(921, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-02 04:57:52'),
(922, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 04:58:02'),
(923, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 04:58:14'),
(924, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 04:58:17'),
(925, 36, '/app/support.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 04:59:20'),
(926, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 04:59:26'),
(927, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 04:59:48'),
(928, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 04:59:54'),
(929, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 05:00:22'),
(930, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:01:48'),
(931, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:02:39'),
(932, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:02:41'),
(933, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 05:08:13'),
(934, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 05:08:56'),
(935, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 05:19:32'),
(936, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 05:19:34'),
(937, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:19:59'),
(938, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 05:20:25'),
(939, 36, '/app/support.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:20:40'),
(940, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-02 05:20:57'),
(941, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:21:17'),
(942, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:21:21'),
(943, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:21:24'),
(944, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:21:33'),
(945, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:21:35'),
(946, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:21:41'),
(947, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 05:21:46'),
(948, 36, '/app/kyc.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:22:08'),
(949, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-02 05:22:15'),
(950, 36, '/app/profile.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:22:20'),
(951, 36, '/app/kyc.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-02 05:22:23'),
(952, 36, '/app/profile.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:22:24'),
(953, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-02 05:22:25'),
(954, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:22:47'),
(955, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-02 05:22:54'),
(956, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-02 05:22:58'),
(957, 36, '/app/packages.php', 'GET', '2a03:4b80:b711:d8f0:ae03:167a:d58d:965', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:26:11'),
(958, 36, '/app/packages.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:41:18'),
(959, 36, '/app/packages.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:41:20'),
(960, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:41:23'),
(961, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:41:25'),
(962, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:41:28'),
(963, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:42:10'),
(964, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:42:17'),
(965, 36, '/app/kyc.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-02 05:42:53'),
(966, 36, '/app/profile.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-02 05:43:03'),
(967, 36, '/app/settings.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-02 05:43:08'),
(968, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-02 05:43:27'),
(969, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:43:35'),
(970, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-02 05:43:41'),
(971, 36, '/app/support.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:43:44'),
(972, 36, '/app/packages.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-02 05:43:53'),
(973, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:44:03'),
(974, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:44:51'),
(975, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:44:52'),
(976, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:44:53'),
(977, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 05:45:05'),
(978, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:45:13'),
(979, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:47:24'),
(980, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 05:47:28'),
(981, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 06:00:28'),
(982, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:00:35'),
(983, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:00:48'),
(984, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 06:00:54'),
(985, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-02 06:01:15'),
(986, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:01:57'),
(987, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:02:14'),
(988, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:02:51'),
(989, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:03:46'),
(990, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:03:55'),
(991, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:04:10'),
(992, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:05:47'),
(993, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:06:09'),
(994, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:08:22'),
(995, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:08:51'),
(996, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:09:06'),
(997, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:14:34'),
(998, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:14:38'),
(999, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:14:48'),
(1000, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:17:08'),
(1001, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:17:30'),
(1002, 36, '/app/transactions.php', 'GET', '46.99.43.20', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:17:56'),
(1003, 36, '/app/transactions.php', 'GET', '46.99.43.20', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:17:59'),
(1004, 36, '/app/index.php', 'GET', '46.99.43.20', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:19:52'),
(1005, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:24:27'),
(1006, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:28:08'),
(1007, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:28:28'),
(1008, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:28:36'),
(1009, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:28:51'),
(1010, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:29:42'),
(1011, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:29:59'),
(1012, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:31:14'),
(1013, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:31:39'),
(1014, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:31:58'),
(1015, 36, '/app/index.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:32:40'),
(1016, 36, '/app/profile.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-02 06:40:57'),
(1017, 36, '/app/kyc.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-02 06:41:04'),
(1018, 36, '/app/transactions.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-02 06:41:13'),
(1019, 36, '/app/packages.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-02 06:41:19'),
(1020, 36, '/app/cases.php', 'GET', '2a03:4b80:b711:d8f0:efc4:c60d:16b4:5ab1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-02 06:41:23'),
(1021, 40, '/app/onboarding.php', 'GET', '2003:c8:6f0b:700:390a:e693:a35a:fca7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 09:00:16'),
(1022, 40, '/app/cases.php', 'GET', '2003:c8:6f0b:700:390a:e693:a35a:fca7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-03 09:08:03'),
(1023, 40, '/app/index.php', 'GET', '2003:c8:6f0b:700:390a:e693:a35a:fca7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 09:08:07'),
(1024, 41, '/app/index.php', 'GET', '2a02:810d:d0b:9800:b5a2:342e:1bc1:10b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/login.php', '2025-11-03 10:35:12'),
(1025, 41, '/app/kyc.php', 'GET', '2a02:810d:d0b:9800:b5a2:342e:1bc1:10b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/index.php', '2025-11-03 10:35:49'),
(1026, 41, '/app/kyc.php', 'GET', '2a02:810d:d0b:9800:b5a2:342e:1bc1:10b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/kyc.php', '2025-11-03 10:40:57'),
(1027, 41, '/app/kyc.php', 'GET', '2a02:810d:d0b:9800:b5a2:342e:1bc1:10b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/kyc.php', '2025-11-03 10:42:09'),
(1028, 41, '/app/kyc.php', 'GET', '2a02:810d:d0b:9800:b5a2:342e:1bc1:10b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/141.0.7390.96 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/kyc.php', '2025-11-03 10:42:12'),
(1029, 42, '/app/onboarding.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 14:20:59'),
(1030, 42, '/app/onboarding.php?step=2', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-03 14:22:06'),
(1031, 42, '/app/onboarding.php?step=3', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-03 14:23:39'),
(1032, 42, '/app/onboarding.php?step=4', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-03 14:26:37'),
(1033, 42, '/app/onboarding_complete.php?trial=1', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-03 14:28:08'),
(1034, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding_complete.php?trial=1', '2025-11-03 14:28:12'),
(1035, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 14:31:45'),
(1036, 42, '/app/kyc.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 14:31:51'),
(1037, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:915f:26be:833:6945', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-11-03 17:48:00'),
(1038, 39, '/app/transactions.php', 'GET', '2003:f1:2712:4100:915f:26be:833:6945', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/index.php', '2025-11-03 17:48:27'),
(1039, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-03 21:08:45'),
(1040, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:09:21'),
(1041, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:09:36'),
(1042, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:09:59'),
(1043, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:10:22');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(1044, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:10:22'),
(1045, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:23:52'),
(1046, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:23:56'),
(1047, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:23:57'),
(1048, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:24:19'),
(1049, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:24:19'),
(1050, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:34:36'),
(1051, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:44:09'),
(1052, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-03 21:44:32'),
(1053, 36, '/app/cases.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:44:34'),
(1054, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:44:56'),
(1055, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:45:39'),
(1056, 36, '/app/index.php', 'GET', '46.99.8.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:46:36'),
(1057, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:50:02'),
(1058, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 21:50:42'),
(1059, 36, '/app/packages.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-03 21:50:54'),
(1060, 36, '/app/support.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-03 21:50:59'),
(1061, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-03 21:51:07'),
(1062, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-03 21:53:54'),
(1063, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-03 21:53:59'),
(1064, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-03 21:54:53'),
(1065, 36, '/app/kyc.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:55:35'),
(1066, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-03 21:55:43'),
(1067, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 21:55:59'),
(1068, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:03:17'),
(1069, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:03:25'),
(1070, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:03:30'),
(1071, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:04:05'),
(1072, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:07:56'),
(1073, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:08:09'),
(1074, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-03 22:08:34'),
(1075, 36, '/app/packages.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:09:48'),
(1076, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-03 22:09:49'),
(1077, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-03 22:09:51'),
(1078, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:09:53'),
(1079, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-03 22:10:11'),
(1080, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:12:07'),
(1081, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:12:39'),
(1082, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:12:40'),
(1083, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:14:42'),
(1084, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:19:21'),
(1085, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:22:00'),
(1086, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-03 22:22:36'),
(1087, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-03 22:25:33'),
(1088, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:25:59'),
(1089, 36, '/app/profile.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:26:14'),
(1090, 36, '/app/settings.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-03 22:26:23'),
(1091, 36, '/app/settings.php', 'POST', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-03 22:28:03'),
(1092, 36, '/app/settings.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-03 22:28:03'),
(1093, 36, '/app/profile.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-03 22:28:09'),
(1094, 36, '/app/settings.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-03 22:28:27'),
(1095, 36, '/app/settings.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-03 22:28:51'),
(1096, 36, '/app/profile.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-03 22:28:57'),
(1097, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-03 22:29:33'),
(1098, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-03 22:31:42'),
(1099, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:35:34'),
(1100, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-03 22:47:55'),
(1101, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:48:38'),
(1102, 36, '/app/packages.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:49:05'),
(1103, 36, '/app/cases.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:49:34'),
(1104, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-03 22:49:45'),
(1105, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:51:08'),
(1106, 36, '/app/transactions.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-03 22:51:14'),
(1107, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-03 22:51:24'),
(1108, 36, '/app/index.php', 'GET', '46.99.12.136', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-04 01:14:08'),
(1109, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:255b:60b9:66cb:4b11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', 'https://kryptox.co.uk/app/login.php', '2025-11-04 16:54:05'),
(1110, 43, '/app/onboarding.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-05 23:33:11'),
(1111, 43, '/app/onboarding.php?step=2', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-05 23:35:34'),
(1112, 43, '/app/onboarding.php?step=3', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-05 23:36:28'),
(1113, 43, '/app/onboarding.php?step=3', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-05 23:37:17'),
(1114, 43, '/app/onboarding.php?step=3', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-05 23:38:01'),
(1115, 43, '/app/onboarding.php?step=4', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-05 23:41:13'),
(1116, 43, '/app/onboarding_complete.php?trial=1', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-05 23:41:50'),
(1117, 43, '/app/index.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/onboarding_complete.php?trial=1', '2025-11-05 23:41:57'),
(1118, 43, '/app/index.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-05 23:46:12'),
(1119, 43, '/app/settings.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-05 23:47:50'),
(1120, 43, '/app/index.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-05 23:49:14'),
(1121, 43, '/app/transactions.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-05 23:49:51'),
(1122, 43, '/app/index.php', 'GET', '176.223.172.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-05 23:50:18'),
(1123, 43, '/app/index.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/login.php', '2025-11-06 11:04:55'),
(1124, 43, '/app/cases.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-06 11:10:11'),
(1125, 43, '/app/index.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/cases.php', '2025-11-06 11:11:37'),
(1126, 43, '/app/cases.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-06 11:11:39'),
(1127, 43, '/app/transactions.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/cases.php', '2025-11-06 11:11:44'),
(1128, 43, '/app/transactions.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/transactions.php', '2025-11-06 11:11:50'),
(1129, 43, '/app/packages.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/transactions.php', '2025-11-06 11:11:51'),
(1130, 43, '/app/kyc.php', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/packages.php', '2025-11-06 11:11:52'),
(1131, 43, '/app/', 'GET', '176.223.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/', '2025-11-06 11:16:40'),
(1132, 41, '/app/index.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-06 17:54:23'),
(1133, 41, '/app/support.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-06 17:55:14'),
(1134, 41, '/app/index.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-06 17:58:04'),
(1135, 41, '/app/packages.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-06 17:58:29'),
(1136, 41, '/app/index.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-06 17:59:08'),
(1137, 41, '/app/packages.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-06 17:59:15'),
(1138, 41, '/app/packages.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-06 18:19:30'),
(1139, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:14:03'),
(1140, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:19:31'),
(1141, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:19:34'),
(1142, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:26:42'),
(1143, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:26:45'),
(1144, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:26:55'),
(1145, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:27:10'),
(1146, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:27:56'),
(1147, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:27:59'),
(1148, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:28:15'),
(1149, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:45:52'),
(1150, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:46:14'),
(1151, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:46:25'),
(1152, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:46:32'),
(1153, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:46:35'),
(1154, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:46:37'),
(1155, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:46:45'),
(1156, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:55:25'),
(1157, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:55:44'),
(1158, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-07 01:55:46'),
(1159, 36, '/app/cases.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-07 01:56:05'),
(1160, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-07 01:58:56'),
(1161, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-07 01:59:01'),
(1162, 36, '/app/index.php', 'GET', '46.19.224.198', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-07 01:59:09'),
(1163, 41, '/app/index.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-10 17:03:17'),
(1164, 41, '/app/support.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 17:03:27'),
(1165, 41, '/app/index.php', 'GET', '88.134.94.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 17:03:37'),
(1166, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-10 20:30:19'),
(1167, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 20:30:32'),
(1168, 36, '/app/index.php', 'GET', '46.99.9.122', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-10 20:31:56'),
(1169, 36, '/app/index.php', 'GET', '46.99.9.122', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-10 20:32:55'),
(1170, 36, '/app/index.php', 'GET', '46.99.9.122', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-10 20:33:09'),
(1171, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 20:39:29'),
(1172, 42, '/app/kyc.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 20:40:15'),
(1173, 42, '/app/kyc.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-10 20:47:18'),
(1174, 42, '/app/kyc.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-10 21:07:16'),
(1175, 42, '/app/kyc.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-10 22:05:54'),
(1176, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-10 22:06:13'),
(1177, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-10 22:07:20'),
(1178, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 22:07:35'),
(1179, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:08:26'),
(1180, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 22:08:43'),
(1181, 42, '/app/support.php', 'POST', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:09:44'),
(1182, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:09:44'),
(1183, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:09:51'),
(1184, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:10:45'),
(1185, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:10:58'),
(1186, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:13:50'),
(1187, 36, '/app/index.php', 'GET', '46.99.9.122', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-10 22:18:17'),
(1188, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 22:48:09'),
(1189, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-10 23:15:34'),
(1190, 42, '/app/cases.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 23:15:46'),
(1191, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-10 23:15:49'),
(1192, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-10 23:20:23'),
(1193, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:16:53'),
(1194, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:17:16'),
(1195, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:17:29'),
(1196, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:17:32'),
(1197, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:19:47'),
(1198, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:19:56'),
(1199, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:19:59'),
(1200, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:20:10'),
(1201, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 00:24:01'),
(1202, 36, '/app/cases.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:24:10'),
(1203, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-11 00:24:16'),
(1204, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-11 00:28:52'),
(1205, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-11 00:34:52'),
(1206, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:35:16'),
(1207, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:35:20'),
(1208, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:35:24'),
(1209, 36, '/app/transactions.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:35:26'),
(1210, 36, '/app/transactions.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:37:56'),
(1211, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-11 00:38:00'),
(1212, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-11 00:49:16'),
(1213, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:51:16'),
(1214, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:56:52'),
(1215, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:56:57'),
(1216, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:59:37'),
(1217, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 00:59:43'),
(1218, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 01:00:17'),
(1219, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 01:02:09'),
(1220, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 01:02:51'),
(1221, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 01:03:13'),
(1222, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 01:04:13'),
(1223, 36, '/app/index.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 02:57:30'),
(1224, 36, '/app/transactions.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 02:57:34'),
(1225, 36, '/app/index.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-11 02:57:41'),
(1226, 36, '/app/index.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-11 02:58:13'),
(1227, 36, '/app/cases.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 02:58:23'),
(1228, 36, '/app/profile.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-11 02:58:35'),
(1229, 36, '/app/support.php', 'GET', '84.22.38.63', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-11 02:58:40'),
(1230, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:44:18'),
(1231, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:44:29'),
(1232, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:45:42'),
(1233, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:47:33'),
(1234, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:47:35'),
(1235, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:48:05'),
(1236, 36, '/app/transactions.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:48:57'),
(1237, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:49:01'),
(1238, 36, '/app/profile.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:49:04'),
(1239, 36, '/app/profile.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:49:06'),
(1240, 36, '/app/settings.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-11 03:49:10'),
(1241, 36, '/app/profile.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:49:14'),
(1242, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:49:15'),
(1243, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:55:39'),
(1244, 36, '/app/transactions.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:56:33'),
(1245, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:56:34'),
(1246, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:57:05'),
(1247, 36, '/app/settings.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:57:09'),
(1248, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 03:57:12'),
(1249, 36, '/app/cases.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 03:57:34'),
(1250, 36, '/app/kyc.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-11 03:57:43'),
(1251, 36, '/app/packages.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-11 03:57:54'),
(1252, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 03:57:57'),
(1253, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 03:59:19'),
(1254, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 04:00:39'),
(1255, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 04:08:45'),
(1256, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 04:10:02'),
(1257, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 04:10:06'),
(1258, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 04:10:10'),
(1259, 36, '/app/index.php', 'GET', '46.99.32.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-11 04:12:49'),
(1260, 43, '/app/index.php', 'GET', '176.223.173.98', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 18:03:31'),
(1261, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 21:02:51');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(1262, 42, '/app/support.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-11 21:06:40'),
(1263, 36, '/app/index.php', 'GET', '46.99.15.147', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 21:10:36'),
(1264, 36, '/app/index.php', 'GET', '46.99.15.147', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-11 21:13:51'),
(1265, 42, '/app/index.php', 'GET', '178.82.42.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-11 21:22:12'),
(1266, 44, '/app/onboarding.php', 'GET', '2a02:8108:9629:7500:d05a:4f94:2773:4ec3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/index.php', '2025-11-12 16:19:54'),
(1267, 44, '/app/onboarding.php?step=2', 'GET', '2a02:8108:9629:7500:d05a:4f94:2773:4ec3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-12 16:22:03'),
(1268, 44, '/app/onboarding.php?step=3', 'GET', '2a02:8108:9629:7500:d05a:4f94:2773:4ec3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-12 16:22:49'),
(1269, 44, '/app/onboarding.php?step=4', 'GET', '2a02:8108:9629:7500:d05a:4f94:2773:4ec3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-12 16:24:34'),
(1270, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:d05a:4f94:2773:4ec3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/login.php', '2025-11-12 16:30:35'),
(1271, 1, '/app/index.php', 'GET', '45.95.243.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-12 18:03:49'),
(1272, 1, '/app/packages.php', 'GET', '45.95.243.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-12 18:04:00'),
(1273, 1, '/app/packages.php', 'GET', '45.95.243.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-12 18:11:25'),
(1274, 1, '/app/index.php', 'GET', '45.95.243.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-12 18:11:28'),
(1275, 36, '/app/index.php', 'GET', '46.99.5.75', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-12 18:17:02'),
(1276, 43, '/app/index.php', 'GET', '194.15.111.135', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-12 18:39:18'),
(1277, 46, '/app/onboarding.php', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-12 21:16:59'),
(1278, 46, '/app/onboarding.php?step=2', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-12 21:18:09'),
(1279, 46, '/app/onboarding.php?step=3', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-12 21:19:37'),
(1280, 46, '/app/onboarding.php?step=4', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-12 22:03:49'),
(1281, 46, '/app/onboarding.php?step=4', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-12 22:42:05'),
(1282, 46, '/app/onboarding.php?step=5', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-12 22:42:30'),
(1283, 46, '/app/onboarding.php?step=4', 'GET', '178.191.144.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-12 22:43:21'),
(1284, 43, '/app/index.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-12 22:51:44'),
(1285, 43, '/app/profile.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-12 22:52:11'),
(1286, 43, '/app/profile.php', 'POST', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-12 22:54:41'),
(1287, 43, '/app/profile.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-12 22:54:41'),
(1288, 43, '/app/settings.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-12 22:54:44'),
(1289, 43, '/app/transactions.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-12 22:55:29'),
(1290, 43, '/app/packages.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-12 22:55:34'),
(1291, 43, '/app/kyc.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-12 22:57:08'),
(1292, 43, '/app/cases.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-12 22:57:46'),
(1293, 43, '/app/index.php', 'GET', '185.255.128.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-12 22:58:17'),
(1294, 41, '/app/index.php', 'GET', '2a02:810d:d0b:9800:11db:7be0:1097:1579', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-13 10:49:27'),
(1295, 36, '/app/index.php', 'GET', '46.99.16.224', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-13 11:18:00'),
(1296, 36, '/app/profile.php', 'GET', '46.99.16.224', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-13 11:18:05'),
(1297, 36, '/app/settings.php', 'GET', '46.99.16.224', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-13 11:18:12'),
(1298, 36, '/app/index.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-13 20:25:56'),
(1299, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/login.php', '2025-11-13 21:34:25'),
(1300, 39, '/app/profile.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/index.php', '2025-11-13 21:34:46'),
(1301, 39, '/app/settings.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/profile.php', '2025-11-13 21:35:06'),
(1302, 39, '/app/settings.php', 'POST', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:35:18'),
(1303, 39, '/app/settings.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:35:18'),
(1304, 39, '/app/settings.php', 'POST', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:35:50'),
(1305, 39, '/app/settings.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:35:50'),
(1306, 39, '/app/settings.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:35:56'),
(1307, 39, '/app/profile.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:36:02'),
(1308, 39, '/app/settings.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/profile.php', '2025-11-13 21:36:19'),
(1309, 39, '/app/settings.php', 'POST', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:36:40'),
(1310, 39, '/app/settings.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:36:40'),
(1311, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:1ce8:3a70:7900:8349', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/settings.php', '2025-11-13 21:37:23'),
(1312, 36, '/app/index.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-13 23:28:51'),
(1313, 36, '/app/index.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 01:56:47'),
(1314, 36, '/app/index.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 01:57:02'),
(1315, 36, '/app/cases.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 01:57:11'),
(1316, 36, '/app/packages.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 01:57:16'),
(1317, 36, '/app/kyc.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-14 01:57:29'),
(1318, 36, '/app/profile.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-14 01:57:31'),
(1319, 36, '/app/index.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-14 01:57:34'),
(1320, 36, '/app/index.php', 'GET', '46.99.33.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-14 01:59:09'),
(1321, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 20:27:27'),
(1322, 36, '/app/support.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 20:27:48'),
(1323, 36, '/app/profile.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/support.php', '2025-11-14 20:28:10'),
(1324, 36, '/app/settings.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-14 20:28:16'),
(1325, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-14 20:28:24'),
(1326, 36, '/app/kyc.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 20:29:18'),
(1327, 36, '/app/cases.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-14 20:29:24'),
(1328, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 20:29:36'),
(1329, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 20:57:15'),
(1330, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 20:59:56'),
(1331, 36, '/app/transactions.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 21:00:19'),
(1332, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 21:00:20'),
(1333, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:00:25'),
(1334, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:04:09'),
(1335, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:12:16'),
(1336, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 21:13:26'),
(1337, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:14:59'),
(1338, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:15:02'),
(1339, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:15:22'),
(1340, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:16:59'),
(1341, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-14 21:22:05'),
(1342, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:25:30'),
(1343, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:26:57'),
(1344, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:27:37'),
(1345, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-14 21:30:57'),
(1346, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 21:32:23'),
(1347, 36, '/app/transactions.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-14 21:32:30'),
(1348, 36, '/app/index.php', 'GET', '46.99.8.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-14 21:44:03'),
(1349, 47, '/app/onboarding.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-17 10:02:47'),
(1350, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/login.php', '2025-11-17 10:03:45'),
(1351, 47, '/app/onboarding.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-17 12:09:00'),
(1352, 47, '/app/onboarding.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-17 12:47:25'),
(1353, 47, '/app/onboarding.php?step=2', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-17 12:48:02'),
(1354, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-17 12:48:36'),
(1355, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 13:15:25'),
(1356, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:01:32'),
(1357, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:03:32'),
(1358, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 14:13:22'),
(1359, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 14:13:30'),
(1360, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 14:13:44'),
(1361, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 14:14:05'),
(1362, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:14:24'),
(1363, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:23:28'),
(1364, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:24:50'),
(1365, 47, '/app/onboarding.php?step=4', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:26:07'),
(1366, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:26:12'),
(1367, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:28:20'),
(1368, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:28:33'),
(1369, 47, '/app/onboarding.php?step=3', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:29:00'),
(1370, 47, '/app/onboarding.php?step=4', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 14:52:26'),
(1371, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 15:00:35'),
(1372, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 15:01:33'),
(1373, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 15:02:07'),
(1374, 44, '/app/onboarding.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/index.php', '2025-11-17 15:11:07'),
(1375, 44, '/app/onboarding.php?step=2', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-17 15:11:15'),
(1376, 44, '/app/onboarding.php?step=3', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-17 15:11:18'),
(1377, 44, '/app/onboarding.php?step=4', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:11:33'),
(1378, 44, '/app/onboarding.php?step=5', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-17 15:12:02'),
(1379, 47, '/app/onboarding_complete.php?trial=1', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-17 15:18:00'),
(1380, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding_complete.php?trial=1', '2025-11-17 15:18:10'),
(1381, 47, '/app/onboarding_complete.php?trial=1', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-17 15:18:12'),
(1382, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:13'),
(1383, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:15'),
(1384, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:16'),
(1385, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:18'),
(1386, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:19'),
(1387, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:23'),
(1388, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:23'),
(1389, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 15:18:26'),
(1390, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-17 15:18:28'),
(1391, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-17 15:18:29'),
(1392, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-17 15:18:31'),
(1393, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-17 15:18:32'),
(1394, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 15:18:49'),
(1395, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-17 15:19:12'),
(1396, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/login.php', '2025-11-17 15:19:18'),
(1397, 44, '/app/profile.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=5', '2025-11-17 15:19:38'),
(1398, 44, '/app/profile.php', 'POST', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 15:20:24'),
(1399, 44, '/app/profile.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 15:20:24'),
(1400, 36, '/app/packages.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-17 15:21:41'),
(1401, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 15:21:44'),
(1402, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-17 15:21:50'),
(1403, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:22:10'),
(1404, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 15:22:24'),
(1405, 36, '/app/packages.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-17 15:22:30'),
(1406, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:22:34'),
(1407, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:23:22'),
(1408, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 15:24:45'),
(1409, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:25:14'),
(1410, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 15:26:11'),
(1411, 44, '/app/support.php', 'POST', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:27:19'),
(1412, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:27:19'),
(1413, 36, '/app/index.php', 'GET', '46.99.62.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 15:27:38'),
(1414, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-17 15:49:47'),
(1415, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/login.php', '2025-11-17 16:03:55'),
(1416, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-17 16:09:13'),
(1417, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/login.php', '2025-11-17 16:15:54'),
(1418, 47, '/app/index.php', 'GET', '213.55.184.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36 EdgA/142.0.0.0', 'https://kryptox.co.uk/app/login.php', '2025-11-17 16:16:48'),
(1419, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:ac75:56dc:776c:aad3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-17 18:35:00'),
(1420, 44, '/app/onboarding.php', 'GET', '2a02:8108:9629:7500:a103:bcbb:7a7e:20b9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/index.php', '2025-11-17 19:36:01'),
(1421, 44, '/app/onboarding.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/index.php', '2025-11-17 22:25:49'),
(1422, 44, '/app/onboarding.php?step=2', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-17 22:25:59'),
(1423, 44, '/app/onboarding.php?step=3', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-17 22:26:09'),
(1424, 44, '/app/onboarding.php?step=4', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 22:26:12'),
(1425, 44, '/app/onboarding.php?step=4', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-17 22:27:06'),
(1426, 44, '/app/profile.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-17 22:27:10'),
(1427, 44, '/app/profile.php', 'POST', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 22:27:18'),
(1428, 44, '/app/profile.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 22:27:18'),
(1429, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/profile.php', '2025-11-17 22:27:31'),
(1430, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/login.php', '2025-11-17 22:28:56'),
(1431, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/login.php', '2025-11-17 22:34:41'),
(1432, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/login.php', '2025-11-17 22:34:59'),
(1433, 44, '/app/index.php', 'GET', '2a02:8108:9629:7500:977:4a19:ba9f:9572', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/login.php', '2025-11-17 22:36:26'),
(1434, 44, '/app/onboarding.php', 'GET', '2a02:8108:9629:7500:f176:9b96:37db:ac64', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/index.php', '2025-11-18 08:53:43'),
(1435, 44, '/app/onboarding.php?step=2', 'GET', '2a02:8108:9629:7500:f176:9b96:37db:ac64', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-18 08:53:50'),
(1436, 44, '/app/settings.php', 'GET', '2a02:8108:9629:7500:f176:9b96:37db:ac64', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-18 08:54:01'),
(1437, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:f176:9b96:37db:ac64', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/settings.php', '2025-11-18 08:54:33'),
(1438, 44, '/app/support.php', 'GET', '2a02:8108:9629:7500:f176:9b96:37db:ac64', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'https://kryptox.co.uk/app/support.php', '2025-11-18 08:56:12'),
(1439, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:cd95:2cce:63f4:383b', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/login.php', '2025-11-18 16:18:03'),
(1440, 39, '/app/index.php', 'GET', '2003:f1:2712:4100:8c7d:e1ac:e17e:db3d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:145.0) Gecko/20100101 Firefox/145.0', 'https://kryptox.co.uk/app/login.php', '2025-11-18 18:33:56'),
(1441, 36, '/app/index.php', 'GET', '46.99.105.33', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-19 03:45:44'),
(1442, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-19 04:39:36'),
(1443, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:39:51'),
(1444, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:53:32'),
(1445, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:55:20'),
(1446, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:55:24'),
(1447, 36, '/app/transactions.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:55:51'),
(1448, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:55:53'),
(1449, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:56:12'),
(1450, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:56:14'),
(1451, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:56:32'),
(1452, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:56:33'),
(1453, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:56:40'),
(1454, 36, '/app/transactions.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:59:23'),
(1455, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 04:59:24'),
(1456, 36, '/app/index.php?csrf_token=9040bbb00c99cf283a2b882438760d28ab06f49f4511aa21d9dece8ef25d13ee&amount=443&payment_method=BANK_TRANSFER&proof_of_payment=', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:59:30'),
(1457, 36, '/app/index.php?csrf_token=9040bbb00c99cf283a2b882438760d28ab06f49f4511aa21d9dece8ef25d13ee&amount=443&payment_method=BANK_TRANSFER&proof_of_payment=', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 04:59:40'),
(1458, 36, '/app/kyc.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php?csrf_token=9040bbb00c99cf283a2b882438760d28ab06f49f4511aa21d9dece8ef25d13ee&amount=443&payment_method=BANK_TRANSFER&proof_of_payment=', '2025-11-19 05:27:16');
INSERT INTO `user_activity_logs` (`id`, `user_id`, `page_url`, `http_method`, `ip_address`, `user_agent`, `referrer`, `created_at`) VALUES
(1459, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'https://kryptox.co.uk/app/index.php?csrf_token=9040bbb00c99cf283a2b882438760d28ab06f49f4511aa21d9dece8ef25d13ee&amount=443&payment_method=BANK_TRANSFER&proof_of_payment=', '2025-11-19 05:27:22'),
(1460, 36, '/app/', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-19 05:33:54'),
(1461, 36, '/app/', 'GET', '2a03:4b80:b70e:6450:c446:1a2f:ec09:d8ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-19 05:34:26'),
(1462, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-19 06:08:02'),
(1463, 36, '/app/support.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 06:08:12'),
(1464, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-19 06:08:15'),
(1465, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-19 06:08:31'),
(1466, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/login.php', '2025-11-19 06:09:00'),
(1467, 36, '/app/profile.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 06:09:07'),
(1468, 36, '/app/settings.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/profile.php', '2025-11-19 06:09:13'),
(1469, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/settings.php', '2025-11-19 06:09:23'),
(1470, 36, '/app/kyc.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 06:09:36'),
(1471, 36, '/app/packages.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-19 06:09:38'),
(1472, 36, '/app/transactions.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-19 06:09:42'),
(1473, 36, '/app/packages.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/kyc.php', '2025-11-19 06:09:45'),
(1474, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/packages.php', '2025-11-19 06:09:52'),
(1475, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 06:10:01'),
(1476, 36, '/app/transactions.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/index.php', '2025-11-19 06:10:15'),
(1477, 36, '/app/cases.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/transactions.php', '2025-11-19 06:10:38'),
(1478, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 06:10:45'),
(1479, 36, '/app/index.php', 'GET', '2a03:4b80:b70e:6450:b028:ebda:f054:a50f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'https://kryptox.co.uk/app/cases.php', '2025-11-19 06:10:52'),
(1480, 48, '/app/onboarding.php', 'GET', '79.199.165.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/index.php', '2025-11-19 18:44:18'),
(1481, 48, '/app/onboarding.php?step=2', 'GET', '79.199.165.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php', '2025-11-19 18:46:31'),
(1482, 48, '/app/onboarding.php?step=3', 'GET', '79.199.165.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=2', '2025-11-19 18:46:48'),
(1483, 48, '/app/onboarding.php?step=4', 'GET', '79.199.165.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=3', '2025-11-19 18:51:15'),
(1484, 48, '/app/onboarding.php?step=5', 'GET', '79.199.165.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'https://kryptox.co.uk/app/onboarding.php?step=4', '2025-11-19 18:52:03');

-- --------------------------------------------------------

--
-- Table structure for table `user_balances`
--

CREATE TABLE `user_balances` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_balances`
--

INSERT INTO `user_balances` (`id`, `user_id`, `balance`) VALUES
(1, 1, '27161.12'),
(2, 2, '0.00'),
(3, 3, '0.00'),
(4, 4, '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `user_documents`
--

CREATE TABLE `user_documents` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_type` varchar(100) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `description` text,
  `uploaded_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('info','success','warning','error') COLLATE utf8mb4_unicode_ci DEFAULT 'info',
  `is_read` tinyint(1) DEFAULT '0',
  `related_entity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_notifications`
--

INSERT INTO `user_notifications` (`id`, `user_id`, `title`, `message`, `type`, `is_read`, `related_entity`, `related_id`, `created_at`) VALUES
(1, 36, 'Withdrawal Request Submitted', 'Your withdrawal of $20.00 via Bank Transfer has been received and is now processing. Reference: WDR-1761962204-CDCC6B.', 'success', 1, 'withdrawal', 'WDR-1761962204-CDCC6B', '2025-11-01 01:56:44'),
(2, 36, 'Withdrawal Request Submitted', 'Your withdrawal of $15.00 via Bank Transfer has been received and is now processing. Reference: WDR-1761962914-26850A.', 'success', 1, 'withdrawal', 'WDR-1761962914-26850A', '2025-11-01 02:08:34'),
(3, 36, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1509</strong> über <strong>$22,532.00</strong>.', 'info', 1, 'case', 'SCM-2025-1509', '2025-11-01 02:28:07'),
(4, 36, 'Rückerstattungs-Update für Ihren Fall', 'Ein Betrag von <strong>$2,531.00</strong> wurde erfolgreich zu Ihrem Fall <strong>SCM-2025-1509</strong> hinzugefügt.', 'success', 1, 'case', 'SCM-2025-1509', '2025-11-01 02:31:12'),
(5, 36, 'Neue Antwort vom Support-Team', 'Ihr Support-Ticket <strong>#TICKET-690571930B6B5</strong> hat eine neue Antwort erhalten.', 'info', 1, 'support_ticket', '9', '2025-11-01 02:43:50'),
(6, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>1,111.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1761970686-E1CA4D</strong>.', 'success', 1, 'transaction', '62', '2025-11-01 05:19:07'),
(7, 20, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>9,999.10 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>WDR-1757562098-23E4F5</strong>.', 'success', 0, 'transaction', '20', '2025-11-01 05:24:56'),
(8, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>222.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1761971020-CC2DE8</strong>.', 'success', 1, 'transaction', '63', '2025-11-01 05:29:34'),
(9, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>2,121.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1761971491-39E491</strong>.', 'success', 1, 'transaction', '64', '2025-11-01 05:34:36'),
(10, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>5,555.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1761972197-5766A7</strong>.', 'success', 1, 'transaction', '65', '2025-11-01 05:43:40'),
(11, 21, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>1,827.00 €</strong> wurde erfolgreich bearbeitet. Referenz: <strong>WDR-1755708543-F2A567</strong>.', 'success', 0, 'transaction', '23', '2025-11-01 05:46:53'),
(12, 21, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>1,827.00 €</strong> wurde erfolgreich bearbeitet. Referenz: <strong>WDR-1755708543-F2A567</strong>.', 'success', 0, 'transaction', '23', '2025-11-01 05:48:56'),
(13, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>9,999.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1761972384-0D2095</strong>.', 'success', 1, 'transaction', '66', '2025-11-01 05:52:36'),
(14, 20, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>443.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1755572829-D05A27</strong>.', 'success', 0, 'transaction', '24', '2025-11-01 06:00:34'),
(15, 20, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>443.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1755572829-D05A27</strong>.', 'success', 0, 'transaction', '24', '2025-11-01 06:03:55'),
(16, 20, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>443.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1755572829-D05A27</strong>.', 'success', 0, 'transaction', '24', '2025-11-01 06:04:49'),
(17, 20, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>443.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1755572829-D05A27</strong>.', 'success', 0, 'transaction', '24', '2025-11-01 06:05:45'),
(18, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>3,333.00 €</strong> mit Referenz <strong>DEP-1761972783-F2525A</strong> wurde erfolgreich bestätigt.', 'success', 1, 'transaction', 'DEP-1761972783-F2525A', '2025-11-01 06:12:01'),
(19, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>7,571.00 €</strong> mit Referenz <strong>DEP-1761974329-95BF0C</strong> wurde erfolgreich bestätigt.', 'success', 1, 'transaction', 'DEP-1761974329-95BF0C', '2025-11-01 06:19:31'),
(20, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>323,232.00 €</strong> mit Referenz <strong>DEP-1761974514-20F368</strong> wurde erfolgreich bestätigt.', 'success', 1, 'transaction', 'DEP-1761974514-20F368', '2025-11-01 06:22:14'),
(21, 36, 'Withdrawal Request Submitted', 'Your withdrawal of $65.00 via Bank Transfer has been received and is now processing. Reference: WDR-1761975438-E2934D.', 'success', 1, 'withdrawal', 'WDR-1761975438-E2934D', '2025-11-01 06:37:18'),
(22, 39, 'Support-Ticket-Update', 'Der Status Ihres Support-Tickets <strong>#7</strong> wurde auf <strong>Closed</strong> geändert.', 'success', 0, 'support_ticket', '7', '2025-11-01 17:06:17'),
(23, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>200.00 €</strong> wurde erfolgreich bestätigt. Referenz: <strong>DEP-1762060129-171566</strong>.', 'success', 1, 'transaction', '73', '2025-11-03 09:24:31'),
(24, 36, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-0413</strong> über <strong>$446,352.00</strong>.', 'info', 1, 'case', 'SCM-2025-0413', '2025-11-03 22:03:13'),
(25, 36, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-2281</strong> über <strong>$77,454.00</strong>.', 'info', 1, 'case', 'SCM-2025-2281', '2025-11-03 22:04:00'),
(26, 43, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-4392</strong> über <strong>$152,364.00</strong>.', 'info', 1, 'case', 'SCM-2025-4392', '2025-11-05 23:53:55'),
(27, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1146</strong> über <strong>$509,713.00</strong>.', 'info', 0, 'case', 'SCM-2025-1146', '2025-11-10 21:29:44'),
(28, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1437</strong> über <strong>$27,851.00</strong>.', 'info', 0, 'case', 'SCM-2025-1437', '2025-11-10 21:37:01'),
(29, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-0550</strong> über <strong>$35,401.00</strong>.', 'info', 0, 'case', 'SCM-2025-0550', '2025-11-10 21:40:43'),
(30, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-5992</strong> über <strong>$27,480.00</strong>.', 'info', 0, 'case', 'SCM-2025-5992', '2025-11-10 21:42:40'),
(31, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-8490</strong> über <strong>$37,370.00</strong>.', 'info', 0, 'case', 'SCM-2025-8490', '2025-11-10 21:45:11'),
(32, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1957</strong> über <strong>$11,750.00</strong>.', 'info', 0, 'case', 'SCM-2025-1957', '2025-11-10 21:45:57'),
(33, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-3342</strong> über <strong>$27,450.00</strong>.', 'info', 0, 'case', 'SCM-2025-3342', '2025-11-10 21:46:26'),
(34, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-0415</strong> über <strong>$21,850.00</strong>.', 'info', 0, 'case', 'SCM-2025-0415', '2025-11-10 21:47:09'),
(35, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-2154</strong> über <strong>$132,202.00</strong>.', 'info', 0, 'case', 'SCM-2025-2154', '2025-11-10 21:48:01'),
(36, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-5656</strong> über <strong>$49,850.00</strong>.', 'info', 0, 'case', 'SCM-2025-5656', '2025-11-10 21:49:12'),
(37, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1121</strong> über <strong>$31,500.00</strong>.', 'info', 0, 'case', 'SCM-2025-1121', '2025-11-10 21:49:35'),
(38, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-3042</strong> über <strong>$72,740.00</strong>.', 'info', 0, 'case', 'SCM-2025-3042', '2025-11-10 21:50:19'),
(39, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-4314</strong> über <strong>$24,500.00</strong>.', 'info', 0, 'case', 'SCM-2025-4314', '2025-11-10 21:50:41'),
(40, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-9070</strong> über <strong>$461,720.00</strong>.', 'info', 0, 'case', 'SCM-2025-9070', '2025-11-10 21:51:29'),
(41, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-6819</strong> über <strong>$17,500.00</strong>.', 'info', 0, 'case', 'SCM-2025-6819', '2025-11-10 21:52:09'),
(42, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-8226</strong> über <strong>$17,000.00</strong>.', 'info', 0, 'case', 'SCM-2025-8226', '2025-11-10 21:52:26'),
(43, 42, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-7527</strong> über <strong>$1,069,046.00</strong>.', 'info', 0, 'case', 'SCM-2025-7527', '2025-11-10 21:53:46'),
(44, 42, 'Neue Antwort vom Support-Team', 'Ihr Support-Ticket <strong>#TICKET-69125498DD5D6</strong> hat eine neue Antwort erhalten.', 'info', 0, 'support_ticket', '10', '2025-11-10 22:36:39'),
(45, 22, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-7918</strong> über <strong>$123,546.00</strong>.', 'info', 0, 'case', 'SCM-2025-7918', '2025-11-11 00:03:46'),
(46, 38, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1725</strong> über <strong>$1,475.00</strong>.', 'info', 0, 'case', 'SCM-2025-1725', '2025-11-11 00:05:37'),
(47, 36, 'Rückerstattungs-Update für Ihren Fall', 'Ein Betrag von <strong>$25,000.00</strong> wurde erfolgreich zu Ihrem Fall <strong>SCM-2025-5484</strong> hinzugefügt.', 'success', 1, 'case', 'SCM-2025-5484', '2025-11-11 00:19:45'),
(48, 36, 'Rückerstattungs-Update für Ihren Fall', 'Ein Betrag von <strong>$600.00</strong> wurde erfolgreich zu Ihrem Fall <strong>SCM-2025-5867</strong> hinzugefügt.', 'success', 1, 'case', 'SCM-2025-5867', '2025-11-11 00:22:24'),
(49, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>4,999.00 €</strong> mit Referenz <strong>DEP-1762817715-33CC9B</strong> wurde erfolgreich bestätigt.', 'success', 1, 'transaction', 'DEP-1762817715-33CC9B', '2025-11-11 00:37:26'),
(50, 29, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-1614</strong> über <strong>$123,456.00</strong>.', 'info', 0, 'case', 'SCM-2025-1614', '2025-11-11 00:56:13'),
(51, 36, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-5493</strong> über <strong>$132.00</strong>.', 'info', 1, 'case', 'SCM-2025-5493', '2025-11-11 00:57:16'),
(52, 36, 'Einzahlung bestätigt', 'Ihre Einzahlung über <strong>443.00 €</strong> mit Referenz <strong>DEP-1762818675-334057</strong> wurde erfolgreich bestätigt.', 'success', 1, 'transaction', 'DEP-1762818675-334057', '2025-11-11 00:59:20'),
(53, 36, 'Rückerstattungs-Update für Ihren Fall', 'Ein Betrag von <strong>$15.00</strong> wurde erfolgreich zu Ihrem Fall <strong>SCM-2025-5493</strong> hinzugefügt.', 'success', 1, 'case', 'SCM-2025-5493', '2025-11-11 01:03:10'),
(54, 39, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-5276</strong> über <strong>$1,492,221.00</strong>.', 'info', 1, 'case', 'SCM-2025-5276', '2025-11-13 14:53:17'),
(55, 36, 'Withdrawal Request Submitted', 'Your withdrawal of $14.00 via Bank Transfer has been received and is now processing. Reference: WDR-1763152341-58E1F0.', 'success', 0, 'withdrawal', 'WDR-1763152341-58E1F0', '2025-11-14 21:32:21'),
(56, 39, 'Neue Antwort vom Support-Team', 'Ihr Support-Ticket <strong>#TICKET-6903DAE12531C</strong> hat eine neue Antwort erhalten.', 'info', 1, 'support_ticket', '7', '2025-11-17 14:01:29'),
(57, 36, 'Neue Antwort vom Support-Team', 'Ihr Support-Ticket <strong>#TICKET-690571930B6B5</strong> hat eine neue Antwort erhalten.', 'info', 1, 'support_ticket', '9', '2025-11-17 14:02:40'),
(58, 44, 'Neue Antwort vom Support-Team', 'Ihr Support-Ticket <strong>#TICKET-691B30C726D47</strong> hat eine neue Antwort erhalten.', 'info', 1, 'support_ticket', '11', '2025-11-17 15:30:41'),
(59, 44, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-2069</strong> über <strong>$2,500.00</strong>.', 'info', 0, 'case', 'SCM-2025-2069', '2025-11-19 20:24:21'),
(60, 44, 'Neue Antwort vom Support-Team', 'Ihr Support-Ticket <strong>#TICKET-691B30C726D47</strong> hat eine neue Antwort erhalten.', 'info', 0, 'support_ticket', '11', '2025-11-19 20:28:03'),
(61, 44, 'Neuer Fall eröffnet', 'Unser KI-Algorithmus hat einen neuen Fall für Sie erstellt: <strong>SCM-2025-7381</strong> über <strong>$56,137.00</strong>.', 'info', 0, 'case', 'SCM-2025-7381', '2025-11-22 18:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_onboarding`
--

CREATE TABLE `user_onboarding` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `lost_amount` decimal(15,2) DEFAULT NULL,
  `platforms` text COMMENT 'JSON array of platform IDs',
  `year_lost` year DEFAULT NULL,
  `case_description` text,
  `country` varchar(100) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_holder` varchar(255) DEFAULT NULL,
  `iban` varchar(50) DEFAULT NULL,
  `bic` varchar(20) DEFAULT NULL,
  `completed` tinyint(1) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_onboarding`
--

INSERT INTO `user_onboarding` (`id`, `user_id`, `lost_amount`, `platforms`, `year_lost`, `case_description`, `country`, `street`, `postal_code`, `state`, `bank_name`, `account_holder`, `iban`, `bic`, `completed`, `created_at`) VALUES
(3, 2, '50000.00', '[1,3]', 2020, 'Bshhhs', 'Germany', 'Hauptstrasse 22', '02727', 'Berlin', 'Sparkasse', 'Jane Smith', 'GB48CLJU04130768116322', 'GBCLJU', 0, '2025-07-23 23:18:59'),
(4, 1, '100000.00', '[1,2,3]', 2019, 'Hhhh', 'Germany', '3813 Manchester St', '80907', 'MI', 'Raiffaisenbank', 'John Doe', 'CH8800777004165860924', 'CH8800', 1, '2025-07-23 23:31:21'),
(7, 3, '250000.00', '[1,3]', 2019, 'Hhh', 'Germany', '3813 Manchester St', '80907', 'MI', 'Sparkasse', 'Robert Johnson', 'FR7629833000010000002902463', 'GBCLJU', 1, '2025-07-24 00:31:10'),
(14, 21, '25000.00', '[1,2]', 2017, 'Help', 'Germany', 'Banhofstrasse 2', '12123', 'Berlin', 'Raiffaisenbanlk', 'Maria Weight', 'DE78888899996666666622', 'DE78SWID', 1, '2025-08-20 16:29:20'),
(15, 20, '100000.00', '[2]', 2017, 'Jjjjj', 'Germany', '3813 Manchester St', '80907', 'CO', 'Sparkasse', 'thomasstephan Klank', 'DE75356500000001085612', 'GBCLJU', 1, '2025-08-20 17:11:33'),
(20, 22, '500000.00', '[1,2,3,4]', 2009, 'zvsfvfvfv', 'United Kingdom', 'Hanfelde 42 a', '48282', 'N/W', 'fvdsvfvd', 'fvvsdfv', 'IT03T0306912711100000018774', 'FDVFDVDF', 1, '2025-10-26 22:36:16'),
(22, 27, '250000.00', '[2,3,4]', 2018, 'kk', 'Deutschland', 'Banhofstrasse 2', '12311', 'Berlin', 'Sparkasse', 'Illyrianc cccc', 'DE1234567891234567', 'DE123456789', 1, '2025-10-27 21:04:41'),
(26, 28, '250000.00', '[2,3,4]', 2017, '333', 'Germany', 'Friedrichstraße 191', '42551', 'N/W', 'fvdsvfvd', 'fvvsdfv', 'DE83370190001010231690', 'FDVFDVDF', 1, '2025-10-27 23:34:37'),
(27, 29, '50000.00', '[4,5]', 2022, 'Jj', 'Germany', 'Hauptstrasse 22', '02727', 'Berlin', 'Sparkasse', 'Jane Smith', 'GB48CLJU04130768116322', 'GBCLJU', 1, '2025-10-28 01:28:36'),
(28, 30, '50000.00', '[2,3,4]', 2018, 'i loss my money', 'Switzerland', '7910 Chesshire Ln N', '55311', 'ws', 'sparkasse', 'aa aa', 'DE12345678901234', 'DE12345', 1, '2025-10-28 23:42:10'),
(29, 31, '25000.00', '[1,2,3,4,5]', 2018, 'I loss my money', 'Germany', 'Germany', '10000', 'Germany', 'Agaha', 'Nanaa', 'DE12562993626262622', 'DE12345', 1, '2025-10-29 11:26:03'),
(30, 34, '5000.00', '[1,2,3,4,5]', 2018, 'i loss mymoney', 'germany', 'germany', '10000', 'sx', 'sparkasse', 'parbbdd', 'DE17276377383763', 'DE12663', 1, '2025-10-29 12:10:08'),
(31, 35, '10000.00', '[1,2,3,4,5]', 2018, 'dsdsadasdasds', 'germany', 'germany', '10000', 'sx', 'sparkasse', 'parbbdd', 'DE1263367373733', 'DE12663', 1, '2025-10-29 16:46:25'),
(32, 36, '100000.00', '[3,4,5]', 2017, 'Hshs', 'United States', '1255 S Biscay St', '80017', 'CO', 'Sparkasse', 'Robert Johnson', 'GB48CLJU04130768116322', 'GBCLJU', 1, '2025-10-30 01:39:56'),
(35, 39, '250000.00', '[1,2,3,4,5]', 2019, 'info', 'DE', 'Hafenbad 27', '89073', 'Baden-Württemberg', 'Revolut Bank', 'Nikoloaus-Michael Walter Köseler', 'DE71100101780300030569', 'REVODEB2', 1, '2025-10-30 21:15:18'),
(36, 40, '250000.00', '[1,2,3,4,5]', 2010, 'Forx', 'Deutschland', 'Struvestraße 8, ', '02826', 'SACHSEN', 'Sparkassen', 'Domenico Carlucci', 'DE45850501000502931493', 'WELADED1GRL', 0, '2025-10-30 22:47:03'),
(38, 41, '250000.00', '[3,4,5,6]', 2019, 'Forx  crypto brocker', 'Deutschland', 'Radspielerstr, 26', '81927', 'Bayern ', 'Stadtsparkasse München', 'Harald Hueber', 'DE85701500001002883385', 'SSKMDEMMXXX', 1, '2025-11-01 19:14:13'),
(39, 42, '500000.00', '[1,2,3,4,5,6]', 2014, 'forex broker', 'Switzerland', 'Oberblattstt. 23', '8832', 'Wollerau / Schwyz', 'Schwyzer Kantonalbank', 'Armin Suter ', 'CH8800777004165860924', 'KBSZCH22XXX ', 1, '2025-11-03 14:22:05'),
(41, 43, '100000.00', '[6]', 2020, 'Alles jaaaa', 'Germany', ' Brunnenstr 78', '71067', 'Böblingen', 'Reifeisenbank', 'Oto alex', 'DE1234567890123456', 'DE12345', 1, '2025-11-05 23:35:34'),
(42, 44, '10000.00', '[1]', 2022, 'Bin betrogen worden mit Kreditversprechen, Grld wurde wahrscheinlich in Krypto angelegt.', 'Deutschland', 'Am Leinkamp 8c', '30880', 'Laatzen ', 'Sparkasse Hannover', 'Griem ', 'DE92250501801915762316', 'SPKHDE2HXXX', 1, '2025-11-12 16:22:03'),
(43, 46, '250000.00', '[2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]', 2020, 'forx', 'Austria', 'Ladestraße 38', '6300', 'Wörgl', 'Raiffeisen Beezirkksbank Kufsteinn eGen', 'Hertha Schwoellenbach', 'AT733635800000296012', 'RZTIAT22358', 0, '2025-11-12 21:18:09'),
(46, 47, '10000.00', '[5]', 2025, 'Krypto ehtereum', 'Schweiz', 'Unterdorfstrasse 9', '5722', 'Gränichen ', 'PostFinance AG', 'Mingerstrasse 20,3030 Bern ', 'CH2209000000152209240', ' POFICHBEXXX', 1, '2025-11-17 12:48:02'),
(50, 48, '500000.00', '[24]', 2024, 'Einzahlungen in Euro für angebliche Auszahlungen durch KSM London  3,551 MIo. Euro', 'Deutschland', 'Pöckinger Str., 19a', '81475', 'Bayern', 'Clear Junction', 'Amin Dlyar', 'GB86CLJU04130737513108', 'CLJUGB21XXX', 0, '2025-11-19 18:46:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_packages`
--

CREATE TABLE `user_packages` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` enum('pending','active','expired','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_packages`
--

INSERT INTO `user_packages` (`id`, `user_id`, `package_id`, `start_date`, `end_date`, `status`, `created_at`) VALUES
(2, 27, 4, '2025-10-27 22:46:23', '2026-10-27 22:46:23', 'pending', '2025-10-27 22:46:23'),
(3, 28, 4, '2025-10-27 23:36:01', '2026-10-27 23:36:01', 'pending', '2025-10-27 23:36:01'),
(4, 29, 2, '2025-10-28 01:29:50', '2026-10-28 01:29:50', 'pending', '2025-10-28 01:29:50'),
(5, 30, 4, '2025-10-28 23:45:08', '2026-10-28 23:45:08', 'pending', '2025-10-28 23:45:08'),
(6, 31, 1, '2025-10-29 11:27:49', '2026-10-29 11:27:49', 'pending', '2025-10-29 11:27:49'),
(7, 34, 1, '2025-10-29 12:12:00', '2026-10-29 12:12:00', 'pending', '2025-10-29 12:12:00'),
(8, 35, 4, '2025-10-29 16:48:45', '2026-10-29 16:48:45', 'pending', '2025-10-29 16:48:45'),
(9, 36, 4, '2025-10-30 01:40:48', '2026-10-30 01:40:48', 'pending', '2025-10-30 01:40:48'),
(10, 36, 5, '2025-10-30 02:10:02', '2025-11-01 02:10:02', 'expired', '2025-10-30 02:10:02'),
(11, 36, 1, '2025-10-30 02:25:23', '1970-01-01 00:00:00', 'expired', '2025-10-30 02:25:23'),
(12, 36, 5, '2025-10-30 02:32:56', '2025-11-01 02:32:56', 'expired', '2025-10-30 02:32:56'),
(13, 36, 3, '2025-10-30 02:33:38', '2025-11-29 02:33:38', 'pending', '2025-10-30 02:33:38'),
(14, 36, 4, '2025-10-30 02:46:19', '2025-11-29 02:46:19', 'active', '2025-10-30 02:46:19'),
(15, 39, 5, '2025-10-30 21:19:18', '2025-11-01 21:19:18', 'active', '2025-10-30 21:19:18'),
(16, 41, 4, '2025-11-01 19:20:24', '2026-01-01 19:20:24', 'active', '2025-11-01 19:20:24'),
(17, 42, 4, '2025-11-03 14:28:08', '2026-01-01 14:28:08', 'active', '2025-11-03 14:28:08'),
(18, 43, 5, '2025-11-05 23:41:50', '2025-11-07 23:41:50', 'active', '2025-11-05 23:41:50'),
(19, 47, 5, '2025-11-17 15:18:00', '2025-11-19 15:18:00', 'active', '2025-11-17 15:18:00'),
(20, 44, 2, '2025-11-17 15:18:00', '2026-02-12 15:18:00', 'active', '2025-11-17 15:18:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_payment_methods`
--

CREATE TABLE `user_payment_methods` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_payment_methods`
--

INSERT INTO `user_payment_methods` (`id`, `user_id`, `payment_method`, `is_default`, `created_at`) VALUES
(2, 1, 'Bitcoin', 1, '2025-07-28 00:43:58'),
(3, 5, 'Bank Transfer', 1, '2025-07-31 03:25:02');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method_code` varchar(50) NOT NULL,
  `payment_details` text NOT NULL,
  `status` enum('pending','processing','completed','failed','cancelled') NOT NULL DEFAULT 'pending',
  `reference` varchar(100) NOT NULL,
  `admin_notes` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `withdrawals`
--

INSERT INTO `withdrawals` (`id`, `user_id`, `amount`, `method_code`, `payment_details`, `status`, `reference`, `admin_notes`, `created_at`, `updated_at`) VALUES
(4, 1, '200.00', 'bank_transfer', 'Ggg', 'failed', 'WDR-687EB6CC7F2A2', 'confin4', '2025-07-21 21:53:16', '2025-07-31 04:16:33'),
(11, 5, '1111.00', 'bank_transfer', 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 'completed', 'WDR-688AE73F630F8', NULL, '2025-07-31 03:47:11', '2025-07-31 03:51:10'),
(12, 3, '999.00', 'BANK_TRANSFER', 'hhh', 'pending', 'WDR-1755214223-FC536F', NULL, '2025-08-14 23:30:23', NULL),
(13, 20, '22.00', 'BANK_TRANSFER', 'Iban test\r\nHolter admi ', 'completed', 'WDR-1755573414-6C8A91', NULL, '2025-08-19 03:16:54', '2025-09-11 04:33:13'),
(14, 21, '1827.00', 'BANK_TRANSFER', 'sdasdas', 'completed', 'WDR-1755708543-F2A567', NULL, '2025-08-20 16:49:03', '2025-09-11 04:40:58'),
(15, 20, '9999.10', 'BANK_TRANSFER', 'Hdjsk\r\nHdjdj', 'failed', 'WDR-1757562098-23E4F5', 'b', '2025-09-11 03:41:38', '2025-09-11 04:40:43'),
(16, 20, '500.00', 'BANK_TRANSFER', 'thomasstephan Klank\r\nSparkasse\r\nIBAN: DE75356500000001085612\r\nBIC: GBCLJU', 'failed', 'WDR-1757564768-0499FA', 'expired', '2025-09-11 04:26:08', '2025-09-11 04:32:22'),
(17, 20, '20000.00', 'BANK_TRANSFER', 'thomasstephan Klank\r\nSparkasse\r\nIBAN: DE75356500000001085612\r\nBIC: GBCLJU', 'pending', 'WDR-1760133692-CCD239', NULL, '2025-10-10 22:01:32', NULL),
(18, 20, '880.00', 'BANK_TRANSFER', 'thomasstephan Klank\r\nSparkasse\r\nIBAN: DE75356500000001085612\r\nBIC: GBCLJU', 'pending', 'WDR-1761003632-0A10E6', NULL, '2025-10-20 23:40:32', NULL),
(19, 22, '20.00', 'BANK_TRANSFER', 'fvvsdfv\r\nfvdsvfvd\r\nIBAN: IT03T0306912711100000018774\r\nBIC: FDVFDVDF', 'failed', 'WDR-1761518845-D241EF', 'Missin fee', '2025-10-26 22:47:25', '2025-10-26 23:09:04'),
(20, 22, '200.00', 'BANK_TRANSFER', 'fvvsdfv\r\nfvdsvfvd\r\nIBAN: IT03T0306912711100000018774\r\nBIC: FDVFDVDF', 'completed', 'WDR-1761519937-1DC6CD', NULL, '2025-10-26 23:05:37', '2025-10-26 23:07:40'),
(21, 28, '2543.12', 'BANK_TRANSFER', 'fvvsdfv\r\nfvdsvfvd\r\nIBAN: DE83370190001010231690\r\nBIC: FDVFDVDF', 'pending', 'WDR-1761608515-352977', NULL, '2025-10-27 23:41:55', NULL),
(22, 30, '30000.00', 'BANK_TRANSFER', 'aa aa\r\nsparkasse\r\nIBAN: DE12345678901234\r\nBIC: DE12345', 'pending', 'WDR-1761695662-E463B1', NULL, '2025-10-28 23:54:22', NULL),
(23, 35, '34876.00', 'BANK_TRANSFER', 'parbbdd\r\nsparkasse\r\nIBAN: DE1263367373733\r\nBIC: DE12663', 'pending', 'WDR-1761758925-DADAD0', NULL, '2025-10-29 17:28:45', NULL),
(24, 29, '3600.00', 'BANK_TRANSFER', 'Jane Smith\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1761779460-479FDE', NULL, '2025-10-29 23:11:00', NULL),
(25, 36, '599.00', 'BANK_TRANSFER', 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1761788628-4EF301', NULL, '2025-10-30 01:43:48', NULL),
(26, 36, '44.00', 'BANK_TRANSFER', 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'failed', 'WDR-1761864478-E8141A', '1234', '2025-10-30 22:47:58', '2025-11-01 04:36:03'),
(27, 36, '20.00', 'BANK_TRANSFER', 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'failed', 'WDR-1761962204-CDCC6B', '123456', '2025-11-01 01:56:44', '2025-11-01 04:33:17'),
(28, 36, '15.00', 'BANK_TRANSFER', 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'completed', 'WDR-1761962914-26850A', NULL, '2025-11-01 02:08:34', '2025-11-01 04:32:02'),
(29, 36, '65.00', 'BANK_TRANSFER', 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'failed', 'WDR-1761975438-E2934D', 'fehler', '2025-11-01 06:37:18', '2025-11-01 06:38:52'),
(30, 36, '14.00', 'BANK_TRANSFER', 'Robert Johnson\r\nSparkasse\r\nIBAN: GB48CLJU04130768116322\r\nBIC: GBCLJU', 'pending', 'WDR-1763152341-58E1F0', NULL, '2025-11-14 21:32:21', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `admin_login_logs`
--
ALTER TABLE `admin_login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `admin_remember_tokens`
--
ALTER TABLE `admin_remember_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `case_number` (`case_number`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `platform_id` (`platform_id`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `last_updated_by` (`last_updated_by`),
  ADD KEY `fk_case_admin` (`admin_id`),
  ADD KEY `idx_cases_user_status` (`user_id`,`status`);

--
-- Indexes for table `case_documents`
--
ALTER TABLE `case_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `case_recovery_transactions`
--
ALTER TABLE `case_recovery_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `processed_by` (`processed_by`);

--
-- Indexes for table `case_status_history`
--
ALTER TABLE `case_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_status_case` (`case_id`),
  ADD KEY `fk_status_admin` (`changed_by`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `method_code` (`method_code`),
  ADD KEY `idx_deposits_user_status` (`user_id`,`status`),
  ADD KEY `fk_deposit_admin` (`processed_by`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `case_id` (`case_id`);

--
-- Indexes for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `template_id` (`template_id`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_key` (`template_key`);

--
-- Indexes for table `email_tracking`
--
ALTER TABLE `email_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tracking_token` (`tracking_token`),
  ADD KEY `idx_opened_at` (`opened_at`);

--
-- Indexes for table `kyc_verifications`
--
ALTER TABLE `kyc_verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `verified_by` (`verified_by`);

--
-- Indexes for table `kyc_verification_requests`
--
ALTER TABLE `kyc_verification_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verified_by` (`verified_by`),
  ADD KEY `idx_kyc_user_status` (`user_id`,`status`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `online_users`
--
ALTER TABLE `online_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_session` (`user_id`,`session_id`);

--
-- Indexes for table `otp_logs`
--
ALTER TABLE `otp_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_otp` (`user_id`,`otp_code`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `method_code_unique` (`method_code`),
  ADD UNIQUE KEY `method_code` (`method_code`);

--
-- Indexes for table `payout_confirmation_logs`
--
ALTER TABLE `payout_confirmation_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_track` (`tracking_token`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_wdr` (`withdrawal_id`),
  ADD KEY `idx_admin` (`admin_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `scam_platforms`
--
ALTER TABLE `scam_platforms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `smtp_settings`
--
ALTER TABLE `smtp_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `case_id` (`case_id`),
  ADD KEY `payment_method_id` (`payment_method_id`),
  ADD KEY `processed_by` (`processed_by`),
  ADD KEY `idx_transactions_user_status` (`user_id`,`status`);

--
-- Indexes for table `transaction_attachments`
--
ALTER TABLE `transaction_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `transaction_logs`
--
ALTER TABLE `transaction_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `performed_by` (`performed_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uuid` (`uuid`);

--
-- Indexes for table `user_activity_logs`
--
ALTER TABLE `user_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `user_balances`
--
ALTER TABLE `user_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_documents`
--
ALTER TABLE `user_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_packages`
--
ALTER TABLE `user_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `package_id` (`package_id`);

--
-- Indexes for table `user_payment_methods`
--
ALTER TABLE `user_payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `method_code` (`method_code`),
  ADD KEY `status` (`status`),
  ADD KEY `idx_withdrawals_user_status` (`user_id`,`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `admin_login_logs`
--
ALTER TABLE `admin_login_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_remember_tokens`
--
ALTER TABLE `admin_remember_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cases`
--
ALTER TABLE `cases`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `case_documents`
--
ALTER TABLE `case_documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `case_recovery_transactions`
--
ALTER TABLE `case_recovery_transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `case_status_history`
--
ALTER TABLE `case_status_history`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_logs`
--
ALTER TABLE `email_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `email_tracking`
--
ALTER TABLE `email_tracking`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kyc_verifications`
--
ALTER TABLE `kyc_verifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kyc_verification_requests`
--
ALTER TABLE `kyc_verification_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_users`
--
ALTER TABLE `online_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `otp_logs`
--
ALTER TABLE `otp_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `payout_confirmation_logs`
--
ALTER TABLE `payout_confirmation_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scam_platforms`
--
ALTER TABLE `scam_platforms`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `smtp_settings`
--
ALTER TABLE `smtp_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `transaction_attachments`
--
ALTER TABLE `transaction_attachments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `transaction_logs`
--
ALTER TABLE `transaction_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `user_activity_logs`
--
ALTER TABLE `user_activity_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1485;

--
-- AUTO_INCREMENT for table `user_balances`
--
ALTER TABLE `user_balances`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_documents`
--
ALTER TABLE `user_documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `user_packages`
--
ALTER TABLE `user_packages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user_payment_methods`
--
ALTER TABLE `user_payment_methods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_login_logs`
--
ALTER TABLE `admin_login_logs`
  ADD CONSTRAINT `admin_login_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD CONSTRAINT `admin_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD CONSTRAINT `fk_notification_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_remember_tokens`
--
ALTER TABLE `admin_remember_tokens`
  ADD CONSTRAINT `admin_remember_tokens_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `audit_logs_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`);

--
-- Constraints for table `cases`
--
ALTER TABLE `cases`
  ADD CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `scam_platforms` (`id`),
  ADD CONSTRAINT `cases_ibfk_3` FOREIGN KEY (`assigned_to`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `cases_ibfk_4` FOREIGN KEY (`last_updated_by`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `fk_case_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `case_documents`
--
ALTER TABLE `case_documents`
  ADD CONSTRAINT `case_documents_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`),
  ADD CONSTRAINT `case_documents_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `case_documents_ibfk_3` FOREIGN KEY (`verified_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `case_recovery_transactions`
--
ALTER TABLE `case_recovery_transactions`
  ADD CONSTRAINT `case_recovery_transactions_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_recovery_transactions_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_recovery_admin` FOREIGN KEY (`processed_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_recovery_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `case_status_history`
--
ALTER TABLE `case_status_history`
  ADD CONSTRAINT `case_status_history_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `case_status_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_status_admin` FOREIGN KEY (`changed_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_status_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `fk_deposit_admin` FOREIGN KEY (`processed_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD CONSTRAINT `email_logs_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `email_templates` (`id`);

--
-- Constraints for table `kyc_verifications`
--
ALTER TABLE `kyc_verifications`
  ADD CONSTRAINT `kyc_verifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `kyc_verifications_ibfk_2` FOREIGN KEY (`verified_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `kyc_verification_requests`
--
ALTER TABLE `kyc_verification_requests`
  ADD CONSTRAINT `kyc_verification_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `kyc_verification_requests_ibfk_2` FOREIGN KEY (`verified_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `online_users`
--
ALTER TABLE `online_users`
  ADD CONSTRAINT `online_users_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `otp_logs`
--
ALTER TABLE `otp_logs`
  ADD CONSTRAINT `fk_otp_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
  ADD CONSTRAINT `remember_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `scam_platforms`
--
ALTER TABLE `scam_platforms`
  ADD CONSTRAINT `scam_platforms_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD CONSTRAINT `support_tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `ticket_replies`
--
ALTER TABLE `ticket_replies`
  ADD CONSTRAINT `ticket_replies_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`id`),
  ADD CONSTRAINT `ticket_replies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ticket_replies_ibfk_3` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`),
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`processed_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `transaction_attachments`
--
ALTER TABLE `transaction_attachments`
  ADD CONSTRAINT `fk_transaction_attachment` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_logs`
--
ALTER TABLE `transaction_logs`
  ADD CONSTRAINT `fk_transaction_admin` FOREIGN KEY (`performed_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transaction_log` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_balances`
--
ALTER TABLE `user_balances`
  ADD CONSTRAINT `fk_user_balances_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD CONSTRAINT `fk_user_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  ADD CONSTRAINT `user_onboarding_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_packages`
--
ALTER TABLE `user_packages`
  ADD CONSTRAINT `user_packages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_packages_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`);

--
-- Constraints for table `user_payment_methods`
--
ALTER TABLE `user_payment_methods`
  ADD CONSTRAINT `user_payment_methods_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
