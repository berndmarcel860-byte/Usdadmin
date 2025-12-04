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
    $symbol = isset($_POST['symbol']) ? strtoupper(trim($_POST['symbol'])) : '';
    $name = isset($_POST['name']) ? trim($_POST['name']) : '';
    $rank = isset($_POST['rank']) ? (int)$_POST['rank'] : 0;
    $iconUrl = isset($_POST['icon_url']) ? trim($_POST['icon_url']) : null;
    $isActive = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 1;
    
    if (empty($symbol) || empty($name) || $rank <= 0) {
        echo json_encode(['success' => false, 'message' => 'Symbol, name, and rank are required']);
        exit;
    }
    
    // Check if symbol already exists
    $stmt = $pdo->prepare("SELECT id FROM cryptocurrencies WHERE symbol = ?");
    $stmt->execute([$symbol]);
    if ($stmt->fetch()) {
        echo json_encode(['success' => false, 'message' => 'Cryptocurrency symbol already exists']);
        exit;
    }
    
    // Insert cryptocurrency
    $stmt = $pdo->prepare("
        INSERT INTO cryptocurrencies (symbol, name, `rank`, icon_url, is_active, created_at)
        VALUES (?, ?, ?, ?, ?, NOW())
    ");
    $stmt->execute([$symbol, $name, $rank, $iconUrl, $isActive]);
    $cryptoId = $pdo->lastInsertId();
    
    // Initialize exchange rate
    $stmt = $pdo->prepare("
        INSERT INTO crypto_exchange_rates (crypto_currency_id, usd_rate, updated_at)
        VALUES (?, 0.00, NOW())
    ");
    $stmt->execute([$cryptoId]);
    
    echo json_encode([
        'success' => true,
        'message' => 'Cryptocurrency added successfully',
        'id' => $cryptoId
    ]);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
