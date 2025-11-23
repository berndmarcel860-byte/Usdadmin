<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

try {
    // Total online (last 5 minutes)
    $stmt = $pdo->prepare("
        SELECT COUNT(DISTINCT user_id) as total_online
        FROM online_users 
        WHERE last_activity >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
    ");
    $stmt->execute();
    $totalOnline = $stmt->fetchColumn();
    
    // Active now (last 1 minute)
    $stmt = $pdo->prepare("
        SELECT COUNT(DISTINCT user_id) as active_now
        FROM online_users 
        WHERE last_activity >= DATE_SUB(NOW(), INTERVAL 1 MINUTE)
    ");
    $stmt->execute();
    $activeNow = $stmt->fetchColumn();
    
    // Mobile users
    $stmt = $pdo->prepare("
        SELECT COUNT(DISTINCT user_id) as mobile_users
        FROM online_users 
        WHERE last_activity >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
        AND user_agent LIKE '%Mobile%'
    ");
    $stmt->execute();
    $mobileUsers = $stmt->fetchColumn();
    
    // Desktop users
    $desktopUsers = $totalOnline - $mobileUsers;
    
    echo json_encode([
        'success' => true,
        'stats' => [
            'total_online' => $totalOnline,
            'active_now' => $activeNow,
            'mobile_users' => $mobileUsers,
            'desktop_users' => max(0, $desktopUsers)
        ]
    ]);
    
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
?>