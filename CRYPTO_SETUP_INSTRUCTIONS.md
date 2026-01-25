# Cryptocurrency Support Setup Instructions

## Overview
This guide will help you enable cryptocurrency support for cases and withdrawals in the admin panel.

## Prerequisites
- MySQL/MariaDB database access
- Admin access to the application

## Setup Steps

### 1. Run the Database Migration

The cryptocurrency support requires new database tables and schema updates. Run the migration SQL file:

```bash
# Option 1: Using mysql command line
mysql -u your_username -p your_database_name < migration_add_crypto_support.sql

# Option 2: Using source command in MySQL
mysql -u your_username -p your_database_name
> source /path/to/migration_add_crypto_support.sql
> exit;

# Option 3: Using phpMyAdmin
# - Open phpMyAdmin
# - Select your database
# - Click on "Import" tab
# - Choose the migration_add_crypto_support.sql file
# - Click "Go"
```

### 2. Verify Installation

After running the migration, verify that the tables were created:

```sql
-- Check if cryptocurrencies table exists and has data
SELECT COUNT(*) FROM cryptocurrencies;
-- Should return 50

-- Check if crypto_exchange_rates table exists
SELECT COUNT(*) FROM crypto_exchange_rates;
-- Should return 50

-- Verify active cryptocurrencies
SELECT symbol, name, rank FROM cryptocurrencies WHERE is_active = 1 ORDER BY rank LIMIT 10;
```

### 3. Using Cryptocurrency Features

#### Adding a Crypto Case:
1. Go to Admin Panel → Cases
2. Click "Add Case" button
3. Select "Cryptocurrency" from Currency Type dropdown
4. Choose a cryptocurrency from the dropdown (50 options available)
5. Enter the crypto amount (supports up to 8 decimal places)
6. Fill in other required fields
7. Click "Add Case"

#### Managing Cryptocurrencies:
1. Go to Admin Panel → Cryptocurrency Management
2. View all 50 cryptocurrencies with statistics
3. Add/Edit/Activate/Deactivate cryptocurrencies
4. Set USD exchange rates
5. View usage statistics per crypto

#### Dashboard Statistics:
- The dashboard now shows cryptocurrency statistics including:
  - Total crypto cases
  - Pending crypto withdrawals
  - Active cryptocurrencies count
  - Top cryptocurrency by usage

## Troubleshooting

### Issue: "No cryptocurrencies available" message when selecting crypto
**Solution**: The database migration hasn't been run yet. Follow Step 1 above.

### Issue: Cryptocurrency dropdown is empty
**Possible causes**:
1. Migration not run - Run migration_add_crypto_support.sql
2. All cryptocurrencies are inactive - Check `is_active` field in cryptocurrencies table
3. Database connection issue - Check error logs

**Check with SQL**:
```sql
SELECT id, symbol, name, is_active FROM cryptocurrencies WHERE is_active = 1;
```

### Issue: Can't see crypto statistics on dashboard
**Solution**: 
1. Ensure migration is run
2. Clear browser cache
3. Check that cryptocurrencies table has data

## Supported Cryptocurrencies (Top 50)

1. BTC - Bitcoin
2. ETH - Ethereum
3. USDT - Tether
4. BNB - BNB
5. SOL - Solana
6. USDC - USD Coin
7. XRP - XRP
8. STETH - Lido Staked Ether
9. DOGE - Dogecoin
10. ADA - Cardano
11. TRX - TRON
12. AVAX - Avalanche
13. WBTC - Wrapped Bitcoin
14. SHIB - Shiba Inu
15. TON - Toncoin
16. LINK - Chainlink
17. DOT - Polkadot
18. BCH - Bitcoin Cash
19. MATIC - Polygon
20. DAI - Dai
21. LTC - Litecoin
22. UNI - Uniswap
23. ICP - Internet Computer
24. NEAR - NEAR Protocol
25. LEO - LEO Token
26. ETC - Ethereum Classic
27. APT - Aptos
28. XLM - Stellar
29. OKB - OKB
30. XMR - Monero
31. ATOM - Cosmos
32. HBAR - Hedera
33. FIL - Filecoin
34. ARB - Arbitrum
35. VET - VeChain
36. OP - Optimism
37. IMX - Immutable
38. MKR - Maker
39. INJ - Injective
40. GRT - The Graph
41. ALGO - Algorand
42. RUNE - THORChain
43. AAVE - Aave
44. QNT - Quant
45. STX - Stacks
46. FTM - Fantom
47. SAND - The Sandbox
48. MANA - Decentraland
49. THETA - Theta Network
50. AXS - Axie Infinity

## Updating Cryptocurrency Prices

The system integrates with **Kraken's free public API** to fetch real-time cryptocurrency prices:

1. Go to **Cryptocurrency Management** page in admin panel
2. Click the **"Update Prices"** button
3. Prices for supported cryptocurrencies will be fetched from Kraken and stored in the database
4. These prices are used to display USD equivalents for crypto cases

**Supported by Kraken API:** BTC, ETH, USDT, USDC, XRP, ADA, DOGE, SOL, DOT, MATIC, LTC, LINK, UNI, ATOM, XLM, ALGO, AAVE, FIL, GRT, SAND, MANA, AXS

**Note:** Not all cryptocurrencies in the database may be available on Kraken. For unsupported coins, you can manually set exchange rates in the crypto management interface or they will show without USD equivalent.

## Support

If you encounter any issues not covered in this guide, please check:
1. Application error logs
2. Database error logs
3. Browser console for JavaScript errors

For additional help, contact your system administrator.
