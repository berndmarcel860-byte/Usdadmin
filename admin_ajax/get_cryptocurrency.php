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
    $id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
    
    if ($id <= 0) {
        echo json_encode(['success' => false, 'message' => 'Invalid cryptocurrency ID']);
        exit;
    }
    
    $stmt = $pdo->prepare("
        SELECT c.*, er.usd_rate
        FROM cryptocurrencies c
        LEFT JOIN crypto_exchange_rates er ON c.id = er.crypto_currency_id
        WHERE c.id = ?
    ");
    $stmt->execute([$id]);
    $crypto = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($crypto) {
        echo json_encode([
            'success' => true,
            'data' => $crypto
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Cryptocurrency not found'
        ]);
    }
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
