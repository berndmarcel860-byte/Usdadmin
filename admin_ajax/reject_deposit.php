<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid deposit ID']);
    exit();
}

$depositId = (int)$_POST['id'];

try {
    $pdo->beginTransaction();
    
    // Get deposit details
    $stmt = $pdo->prepare("SELECT * FROM deposits WHERE id = ?");
    $stmt->execute([$depositId]);
    $deposit = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$deposit) {
        throw new Exception('Deposit not found');
    }
    
    if ($deposit['status'] !== 'pending') {
        throw new Exception('Deposit is not pending');
    }
    
    // Update deposit status
    $stmt = $pdo->prepare("UPDATE deposits SET status = 'failed', updated_at = NOW() WHERE id = ?");
    $stmt->execute([$depositId]);
    
    $pdo->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'Deposit rejected successfully'
    ]);
} catch (Exception $e) {
    $pdo->rollBack();
    echo json_encode([
        'success' => false,
        'message' => 'Failed to reject deposit',
        'error' => $e->getMessage()
    ]);
}
?>