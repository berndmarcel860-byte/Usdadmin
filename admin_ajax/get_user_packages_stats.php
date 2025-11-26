<?php
// admin_ajax/get_user_packages_stats.php
// Get statistics for user packages dashboard

require_once '../admin_session.php';
header('Content-Type: application/json');

if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

try {
    // Get counts by status
    $stmt = $pdo->query("
        SELECT 
            COUNT(*) as total,
            SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) as active,
            SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending,
            SUM(CASE WHEN status = 'expired' THEN 1 ELSE 0 END) as expired,
            SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) as cancelled
        FROM user_packages
    ");
    $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'data' => [
            'total' => (int)$stats['total'],
            'active' => (int)$stats['active'],
            'pending' => (int)$stats['pending'],
            'expired' => (int)$stats['expired'],
            'cancelled' => (int)$stats['cancelled']
        ]
    ]);
    
} catch (PDOException $e) {
    error_log("Get user packages stats error: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Database error']);
}
