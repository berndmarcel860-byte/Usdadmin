<?php
require_once '../../config.php';

// Verify admin is logged in
if (!isset($_SESSION['admin_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Unauthorized']);
    exit;
}

header('Content-Type: application/json');

try {
    $cryptoId = isset($_POST['crypto_id']) ? (int)$_POST['crypto_id'] : 0;
    $symbol = isset($_POST['symbol']) ? strtoupper(trim($_POST['symbol'])) : '';
    $name = isset($_POST['name']) ? trim($_POST['name']) : '';
    $rank = isset($_POST['rank']) ? (int)$_POST['rank'] : 0;
    $iconUrl = isset($_POST['icon_url']) ? trim($_POST['icon_url']) : null;
    $isActive = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 1;
    $usdRate = isset($_POST['usd_rate']) && !empty($_POST['usd_rate']) ? (float)$_POST['usd_rate'] : null;
    
    if ($cryptoId <= 0 || empty($symbol) || empty($name) || $rank <= 0) {
        echo json_encode(['success' => false, 'message' => 'Invalid input']);
        exit;
    }
    
    // Check if symbol exists for another cryptocurrency
    $stmt = $pdo->prepare("SELECT id FROM cryptocurrencies WHERE symbol = ? AND id != ?");
    $stmt->execute([$symbol, $cryptoId]);
    if ($stmt->fetch()) {
        echo json_encode(['success' => false, 'message' => 'Cryptocurrency symbol already exists']);
        exit;
    }
    
    // Update cryptocurrency
    $stmt = $pdo->prepare("
        UPDATE cryptocurrencies 
        SET symbol = ?, name = ?, rank = ?, icon_url = ?, is_active = ?
        WHERE id = ?
    ");
    $stmt->execute([$symbol, $name, $rank, $iconUrl, $isActive, $cryptoId]);
    
    // Update exchange rate if provided
    if ($usdRate !== null) {
        $stmt = $pdo->prepare("
            INSERT INTO crypto_exchange_rates (crypto_currency_id, usd_rate, updated_at)
            VALUES (?, ?, NOW())
            ON DUPLICATE KEY UPDATE usd_rate = ?, updated_at = NOW()
        ");
        $stmt->execute([$cryptoId, $usdRate, $usdRate]);
    }
    
    echo json_encode([
        'success' => true,
        'message' => 'Cryptocurrency updated successfully'
    ]);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
