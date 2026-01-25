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
        echo json_encode(['success' => false, 'message' => 'Invalid log ID']);
        exit;
    }
    
    $stmt = $pdo->prepare("
        SELECT 
            al.*,
            CONCAT(a.first_name, ' ', a.last_name) as admin_name,
            a.email as admin_email
        FROM admin_logs al
        LEFT JOIN admins a ON al.admin_id = a.id
        WHERE al.id = ?
    ");
    $stmt->execute([$id]);
    $log = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($log) {
        echo json_encode([
            'success' => true,
            'log' => $log
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Log not found'
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
