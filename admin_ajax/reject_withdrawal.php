<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid withdrawal ID']);
    exit();
}

if (empty($_POST['reason'])) {
    echo json_encode(['success' => false, 'message' => 'Rejection reason is required']);
    exit();
}

$withdrawalId = (int)$_POST['id'];
$reason = trim($_POST['reason']);

try {
    $pdo->beginTransaction();
    
    // Get withdrawal details
    $stmt = $pdo->prepare("SELECT * FROM withdrawals WHERE id = ?");
    $stmt->execute([$withdrawalId]);
    $withdrawal = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$withdrawal) {
        throw new Exception('Withdrawal not found');
    }
    
    if (!in_array($withdrawal['status'], ['pending', 'processing'])) {
        throw new Exception('Withdrawal cannot be rejected in its current state');
    }
    
    // Update withdrawal status
    $stmt = $pdo->prepare("
        UPDATE withdrawals 
        SET 
            status = 'failed',
            admin_notes = ?,
            updated_at = NOW()
        WHERE id = ?
    ");
    $stmt->execute([$reason, $withdrawalId]);
    
    // Return funds to user balance
    $stmt = $pdo->prepare("UPDATE users SET balance = balance + ? WHERE id = ?");
    $stmt->execute([$withdrawal['amount'], $withdrawal['user_id']]);
    
    $pdo->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'Withdrawal rejected successfully'
    ]);
} catch (Exception $e) {
    $pdo->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Failed to reject withdrawal',
        'error' => $e->getMessage()
    ]);
}
?>