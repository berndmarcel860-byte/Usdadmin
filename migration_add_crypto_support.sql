-- Migration: Add Cryptocurrency Support to Cases and Withdrawals
-- Date: 2025-12-04
-- Description: Adds support for 50 top-ranked cryptocurrencies to cases and withdrawal systems

-- Create cryptocurrencies table with top 50 coins
CREATE TABLE IF NOT EXISTS `cryptocurrencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `symbol` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `rank` int NOT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `symbol` (`symbol`),
  KEY `rank` (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert top 50 cryptocurrencies
INSERT INTO `cryptocurrencies` (`symbol`, `name`, `rank`, `is_active`) VALUES
('BTC', 'Bitcoin', 1, 1),
('ETH', 'Ethereum', 2, 1),
('USDT', 'Tether', 3, 1),
('BNB', 'BNB', 4, 1),
('SOL', 'Solana', 5, 1),
('USDC', 'USD Coin', 6, 1),
('XRP', 'XRP', 7, 1),
('STETH', 'Lido Staked Ether', 8, 1),
('DOGE', 'Dogecoin', 9, 1),
('ADA', 'Cardano', 10, 1),
('TRX', 'TRON', 11, 1),
('AVAX', 'Avalanche', 12, 1),
('WBTC', 'Wrapped Bitcoin', 13, 1),
('SHIB', 'Shiba Inu', 14, 1),
('TON', 'Toncoin', 15, 1),
('LINK', 'Chainlink', 16, 1),
('DOT', 'Polkadot', 17, 1),
('BCH', 'Bitcoin Cash', 18, 1),
('MATIC', 'Polygon', 19, 1),
('DAI', 'Dai', 20, 1),
('LTC', 'Litecoin', 21, 1),
('UNI', 'Uniswap', 22, 1),
('ICP', 'Internet Computer', 23, 1),
('NEAR', 'NEAR Protocol', 24, 1),
('LEO', 'LEO Token', 25, 1),
('ETC', 'Ethereum Classic', 26, 1),
('APT', 'Aptos', 27, 1),
('XLM', 'Stellar', 28, 1),
('OKB', 'OKB', 29, 1),
('XMR', 'Monero', 30, 1),
('ATOM', 'Cosmos', 31, 1),
('HBAR', 'Hedera', 32, 1),
('FIL', 'Filecoin', 33, 1),
('ARB', 'Arbitrum', 34, 1),
('VET', 'VeChain', 35, 1),
('OP', 'Optimism', 36, 1),
('IMX', 'Immutable', 37, 1),
('MKR', 'Maker', 38, 1),
('INJ', 'Injective', 39, 1),
('GRT', 'The Graph', 40, 1),
('ALGO', 'Algorand', 41, 1),
('RUNE', 'THORChain', 42, 1),
('AAVE', 'Aave', 43, 1),
('QNT', 'Quant', 44, 1),
('STX', 'Stacks', 45, 1),
('FTM', 'Fantom', 46, 1),
('SAND', 'The Sandbox', 47, 1),
('MANA', 'Decentraland', 48, 1),
('THETA', 'Theta Network', 49, 1),
('AXS', 'Axie Infinity', 50, 1);

-- Add cryptocurrency fields to cases table
ALTER TABLE `cases` 
ADD COLUMN `crypto_currency_id` int DEFAULT NULL AFTER `recovered_amount`,
ADD COLUMN `crypto_reported_amount` decimal(20,8) DEFAULT NULL AFTER `crypto_currency_id`,
ADD COLUMN `crypto_recovered_amount` decimal(20,8) DEFAULT NULL AFTER `crypto_reported_amount`,
ADD COLUMN `currency_type` enum('fiat','crypto') DEFAULT 'fiat' AFTER `crypto_recovered_amount`,
ADD KEY `crypto_currency_id` (`crypto_currency_id`),
ADD CONSTRAINT `fk_cases_crypto` FOREIGN KEY (`crypto_currency_id`) REFERENCES `cryptocurrencies` (`id`) ON DELETE SET NULL;

-- Add cryptocurrency fields to withdrawals table
ALTER TABLE `withdrawals` 
ADD COLUMN `crypto_currency_id` int DEFAULT NULL AFTER `amount`,
ADD COLUMN `crypto_amount` decimal(20,8) DEFAULT NULL AFTER `crypto_currency_id`,
ADD COLUMN `currency_type` enum('fiat','crypto') DEFAULT 'fiat' AFTER `crypto_amount`,
ADD COLUMN `crypto_wallet_address` varchar(255) DEFAULT NULL AFTER `currency_type`,
ADD COLUMN `crypto_tx_hash` varchar(255) DEFAULT NULL AFTER `crypto_wallet_address`,
ADD KEY `crypto_currency_id` (`crypto_currency_id`),
ADD CONSTRAINT `fk_withdrawals_crypto` FOREIGN KEY (`crypto_currency_id`) REFERENCES `cryptocurrencies` (`id`) ON DELETE SET NULL;

-- Create case_crypto_transactions table for detailed crypto transaction tracking
CREATE TABLE IF NOT EXISTS `case_crypto_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `crypto_currency_id` int NOT NULL,
  `transaction_type` enum('reported','recovered','fee') NOT NULL,
  `amount` decimal(20,8) NOT NULL,
  `usd_equivalent` decimal(15,2) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `tx_hash` varchar(255) DEFAULT NULL,
  `notes` text,
  `created_by` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `crypto_currency_id` (`crypto_currency_id`),
  CONSTRAINT `fk_case_crypto_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_case_crypto_currency` FOREIGN KEY (`crypto_currency_id`) REFERENCES `cryptocurrencies` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_case_crypto_admin` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Create crypto_exchange_rates table for rate tracking
CREATE TABLE IF NOT EXISTS `crypto_exchange_rates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `crypto_currency_id` int NOT NULL,
  `usd_rate` decimal(15,2) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_crypto_rate` (`crypto_currency_id`),
  CONSTRAINT `fk_exchange_rate_crypto` FOREIGN KEY (`crypto_currency_id`) REFERENCES `cryptocurrencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert initial exchange rates (NULL values indicate rates need to be updated)
-- Rates should be updated via API integration
INSERT INTO `crypto_exchange_rates` (`crypto_currency_id`, `usd_rate`) 
SELECT `id`, NULL FROM `cryptocurrencies`;
