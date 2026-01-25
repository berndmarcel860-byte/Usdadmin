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
    $cryptoId = isset($_POST['id']) ? (int)$_POST['id'] : 0;
    $isActive = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 0;
    
    if ($cryptoId <= 0) {
        echo json_encode(['success' => false, 'message' => 'Invalid cryptocurrency ID']);
        exit;
    }
    
    $stmt = $pdo->prepare("UPDATE cryptocurrencies SET is_active = ? WHERE id = ?");
    $stmt->execute([$isActive, $cryptoId]);
    
    echo json_encode([
        'success' => true,
        'message' => $isActive == 1 ? 'Cryptocurrency activated' : 'Cryptocurrency deactivated'
    ]);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
