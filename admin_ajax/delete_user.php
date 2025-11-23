<?php
require_once '../../config.php';

header('Content-Type: application/json');

// Verify admin role
if ($_SESSION['admin_role'] !== 'superadmin') {
    echo json_encode(['success' => false, 'message' => 'Unauthorized action']);
    exit();
}

// Validate input
if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid user ID']);
    exit();
}

$userId = (int)$_POST['id'];

try {
    // Begin transaction
    $pdo->beginTransaction();
    
    // Delete related records first (adjust based on your schema)
    $pdo->prepare("DELETE FROM remember_tokens WHERE user_id = ?")->execute([$userId]);
    $pdo->prepare("DELETE FROM login_logs WHERE user_id = ?")->execute([$userId]);
    $pdo->prepare("DELETE FROM user_documents WHERE user_id = ?")->execute([$userId]);
    
    // Then delete user
    $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    
    // Log this action
    $logStmt = $pdo->prepare("
        INSERT INTO admin_logs 
        (admin_id, action, entity_type, entity_id, ip_address, user_agent) 
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    $logStmt->execute([
        $_SESSION['admin_id'],
        'delete',
        'user',
        $userId,
        $_SERVER['REMOTE_ADDR'],
        $_SERVER['HTTP_USER_AGENT'] ?? ''
    ]);
    
    $pdo->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'User deleted successfully',
        'id' => $userId
    ]);
} catch (PDOException $e) {
    $pdo->rollBack();
    error_log("Delete User Error: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'message' => 'Failed to delete user',
        'error' => $e->getMessage()
    ]);
}
?>