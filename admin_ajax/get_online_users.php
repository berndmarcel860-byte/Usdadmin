<?php
require_once '../admin_session.php';
header('Content-Type: application/json');

try {
    // 🕒 Fetch all sessions active within last 5 minutes
    $stmt = $pdo->prepare("
        SELECT 
            ou.user_id,
            ou.session_id,
            ou.ip_address,
            ou.user_agent,
            ou.last_activity,
            u.first_name AS user_first_name,
            u.last_name AS user_last_name,
            u.email AS user_email
        FROM online_users ou
        JOIN users u ON ou.user_id = u.id
        WHERE ou.last_activity >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
        ORDER BY ou.last_activity DESC
    ");
    $stmt->execute();
    $sessions = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $data = [];

    foreach ($sessions as $s) {
        $last = new DateTime($s['last_activity']);
        $now  = new DateTime();
        $diff = $now->getTimestamp() - $last->getTimestamp();

        // Time ago
        if ($diff < 60) {
            $since = $diff . ' sec ago';
        } elseif ($diff < 3600) {
            $since = floor($diff / 60) . ' min ago';
        } elseif ($diff < 86400) {
            $since = floor($diff / 3600) . ' hr ago';
        } else {
            $since = floor($diff / 86400) . ' day(s) ago';
        }

        // Status levels
        if ($diff < 30) {
            $status = 'active'; // 🟢
        } elseif ($diff < 180) {
            $status = 'idle';   // 🟠
        } else {
            $status = 'offline'; // 🔴
        }

        // Device type
        $ua = strtolower($s['user_agent'] ?? '');
        if (!$ua) {
            $device = 'Unknown';
        } elseif (preg_match('/mobile|android|iphone|ipad/', $ua)) {
            $device = 'Mobile';
        } else {
            $device = 'Desktop';
        }

        $data[] = [
            'user_id' => $s['user_id'],
            'session_id' => $s['session_id'],
            'user_first_name' => $s['user_first_name'],
            'user_last_name' => $s['user_last_name'],
            'user_email' => $s['user_email'],
            'ip_address' => $s['ip_address'] ?? 'Unknown',
            'user_agent' => $s['user_agent'] ?? 'Unknown',
            'device_type' => $device,
            'last_activity' => $s['last_activity'],
            'online_since' => $since,
            'status' => $status
        ];
    }

    echo json_encode(['success' => true, 'data' => $data]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
?>

