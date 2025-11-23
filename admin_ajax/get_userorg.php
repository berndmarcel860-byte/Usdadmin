<?php
require_once '../../config.php';
#require_once '../admin_session.php';

header('Content-Type: application/json');

// Validate input
if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid user ID']);
    exit();
}

$userId = (int)$_GET['id'];

try {
    // Get basic user info
    $stmt = $pdo->prepare("
        SELECT 
            id, uuid, first_name, last_name, email, 
            phone, country, status, balance, 
            DATE_FORMAT(created_at, '%Y-%m-%d %H:%i') as created_at,
            DATE_FORMAT(last_login, '%Y-%m-%d %H:%i') as last_login
        FROM users 
        WHERE id = ?
    ");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        echo json_encode(['success' => false, 'message' => 'User not found']);
        exit();
    }
    
    // Get document count
    $docStmt = $pdo->prepare("SELECT COUNT(*) FROM user_documents WHERE user_id = ?");
    $docStmt->execute([$userId]);
    $documentCount = $docStmt->fetchColumn();
    
    // Get case count
    $caseStmt = $pdo->prepare("SELECT COUNT(*) FROM cases WHERE user_id = ?");
    $caseStmt->execute([$userId]);
    $caseCount = $caseStmt->fetchColumn();
    
    echo json_encode([
        'success' => true,
        'user' => [
            'basic' => $user,
            'stats' => [
                'documents' => $documentCount,
                'cases' => $caseCount
            ]
        ]
    ]);
} catch (PDOException $e) {
    error_log("Get User Error: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'message' => 'Failed to get user data',
        'error' => $e->getMessage()
    ]);
}
?>