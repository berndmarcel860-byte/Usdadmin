<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized: Admin not logged in']);
    exit();
}

/**
 * Fetch real-time cryptocurrency prices from Kraken Free API
 * Kraken API Documentation: https://docs.kraken.com/rest/
 */
function fetchKrakenPrices($symbols) {
    $krakenPairs = [];
    $symbolMapping = [];
    
    // Map cryptocurrency symbols to Kraken pair notation
    $krakenSymbolMap = [
        'BTC' => 'XXBTZUSD',
        'ETH' => 'XETHZUSD',
        'USDT' => 'USDTZUSD',
        'USDC' => 'USDCUSD',
        'XRP' => 'XXRPZUSD',
        'ADA' => 'ADAUSD',
        'DOGE' => 'XDGUSD',
        'SOL' => 'SOLUSD',
        'DOT' => 'DOTUSD',
        'MATIC' => 'MATICUSD',
        'LTC' => 'XLTCZUSD',
        'LINK' => 'LINKUSD',
        'UNI' => 'UNIUSD',
        'ATOM' => 'ATOMUSD',
        'XLM' => 'XXLMZUSD',
        'ALGO' => 'ALGOUSD',
        'AAVE' => 'AAVEUSD',
        'FIL' => 'FILUSD',
        'GRT' => 'GRTUSD',
        'SAND' => 'SANDUSD',
        'MANA' => 'MANAUSD',
        'AXS' => 'AXSUSD'
    ];
    
    foreach ($symbols as $symbol) {
        if (isset($krakenSymbolMap[$symbol])) {
            $krakenPairs[] = $krakenSymbolMap[$symbol];
            $symbolMapping[$krakenSymbolMap[$symbol]] = $symbol;
        }
    }
    
    if (empty($krakenPairs)) {
        return [];
    }
    
    // Kraken API endpoint for ticker information
    $url = 'https://api.kraken.com/0/public/Ticker?pair=' . implode(',', $krakenPairs);
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_USERAGENT, 'ScamRecovery-Admin/1.0');
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    if ($httpCode !== 200 || !$response) {
        error_log("Kraken API request failed: HTTP $httpCode");
        return [];
    }
    
    $data = json_decode($response, true);
    
    if (!isset($data['result']) || !empty($data['error'])) {
        error_log("Kraken API error: " . json_encode($data['error'] ?? 'Unknown error'));
        return [];
    }
    
    $prices = [];
    foreach ($data['result'] as $pair => $info) {
        if (isset($symbolMapping[$pair]) && isset($info['c'][0])) {
            $symbol = $symbolMapping[$pair];
            $prices[$symbol] = floatval($info['c'][0]); // Current price
        }
    }
    
    return $prices;
}

try {
    // Fetch all active cryptocurrencies from database
    $stmt = $pdo->query("
        SELECT id, symbol, name 
        FROM cryptocurrencies 
        WHERE is_active = 1
        ORDER BY `rank` ASC
    ");
    $cryptos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($cryptos)) {
        echo json_encode([
            'success' => false,
            'message' => 'No active cryptocurrencies found'
        ]);
        exit();
    }
    
    // Extract symbols
    $symbols = array_column($cryptos, 'symbol');
    
    // Fetch prices from Kraken
    $prices = fetchKrakenPrices($symbols);
    
    if (empty($prices)) {
        echo json_encode([
            'success' => false,
            'message' => 'Failed to fetch prices from Kraken API. Some cryptocurrencies may not be supported by Kraken.'
        ]);
        exit();
    }
    
    // Update prices in database
    $updateStmt = $pdo->prepare("
        INSERT INTO crypto_exchange_rates (crypto_currency_id, usd_rate, updated_at)
        VALUES (:crypto_id, :price, NOW())
        ON DUPLICATE KEY UPDATE 
            usd_rate = :price,
            updated_at = NOW()
    ");
    
    $updated = 0;
    foreach ($cryptos as $crypto) {
        if (isset($prices[$crypto['symbol']])) {
            $updateStmt->execute([
                ':crypto_id' => $crypto['id'],
                ':price' => $prices[$crypto['symbol']]
            ]);
            $updated++;
        }
    }
    
    // Log the price update
    $logStmt = $pdo->prepare("
        INSERT INTO admin_logs (admin_id, action, details, ip_address, created_at)
        VALUES (:admin_id, 'crypto_price_update', :details, :ip, NOW())
    ");
    $logStmt->execute([
        ':admin_id' => $_SESSION['admin_id'],
        ':details' => "Updated $updated cryptocurrency prices from Kraken API",
        ':ip' => $_SERVER['REMOTE_ADDR']
    ]);
    
    echo json_encode([
        'success' => true,
        'message' => "Successfully updated $updated cryptocurrency prices",
        'updated_count' => $updated,
        'total_cryptos' => count($cryptos),
        'prices' => $prices
    ]);
    
} catch (PDOException $e) {
    error_log("DB Error in update_crypto_prices.php: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'message' => 'Database error while updating prices. Please contact system administrator.'
    ]);
} catch (Exception $e) {
    error_log("Error in update_crypto_prices.php: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'message' => 'Failed to update cryptocurrency prices. Please try again later.'
    ]);
}
?>
