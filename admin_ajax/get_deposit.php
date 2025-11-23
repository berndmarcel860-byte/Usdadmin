<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid deposit ID']);
    exit();
}

$depositId = (int)$_GET['id'];

try {
    $stmt = $pdo->prepare("
        SELECT 
            d.*, 
            u.first_name AS user_first_name, 
            u.last_name AS user_last_name,
            pm.method_name
        FROM deposits d
        LEFT JOIN users u ON d.user_id = u.id
        LEFT JOIN payment_methods pm ON d.method_code = pm.method_code
        WHERE d.id = ?
    ");
    $stmt->execute([$depositId]);
    $deposit = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$deposit) {
        echo json_encode(['success' => false, 'message' => 'Deposit not found']);
        exit();
    }
    
    echo json_encode([
        'success' => true,
        'deposit' => $deposit
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Failed to get deposit details',
        'error' => $e->getMessage()
    ]);
}
?>