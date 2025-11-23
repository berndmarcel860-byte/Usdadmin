<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid withdrawal ID']);
    exit();
}

$withdrawalId = (int)$_POST['id'];

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
        throw new Exception('Withdrawal cannot be approved in its current state');
    }
    
    // Update withdrawal status
    $stmt = $pdo->prepare("UPDATE withdrawals SET status = 'completed', updated_at = NOW() WHERE id = ?");
    $stmt->execute([$withdrawalId]);
    
    // Create transaction record
    $stmt = $pdo->prepare("
        INSERT INTO transactions (
            user_id,
            type,
            amount,
            payment_method_id,
            status,
            reference,
            created_at,
            updated_at
        ) VALUES (
            :user_id,
            'withdrawal',
            :amount,
            (SELECT id FROM payment_methods WHERE method_code = :method_code),
            'completed',
            :reference,
            NOW(),
            NOW()
        )
    ");
    $stmt->execute([
        ':user_id' => $withdrawal['user_id'],
        ':amount' => $withdrawal['amount'],
        ':method_code' => $withdrawal['method_code'],
        ':reference' => $withdrawal['reference']
    ]);
    
    $pdo->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'Withdrawal approved successfully'
    ]);
} catch (Exception $e) {
    $pdo->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Failed to approve withdrawal',
        'error' => $e->getMessage()
    ]);
}
?>