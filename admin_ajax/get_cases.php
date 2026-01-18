<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

// Verify admin is logged in
if (!isset($_SESSION['admin_id'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Unauthorized',
        'data' => []
    ]);
    exit();
}

$currentAdminId = (int)$_SESSION['admin_id'];

try {
    $query = "
        SELECT 
            c.*, 
            u.first_name AS user_first_name, 
            u.last_name AS user_last_name,
            a.first_name AS admin_first_name,
            a.last_name AS admin_last_name,
            p.name AS platform_name,
            cr.symbol AS crypto_symbol,
            cr.name AS crypto_name,
            cer.usd_rate AS crypto_usd_price,
            (SELECT SUM(amount) FROM case_recovery_transactions WHERE case_id = c.id) AS recovered_amount
        FROM cases c
        LEFT JOIN users u ON c.user_id = u.id
        LEFT JOIN admins a ON c.assigned_to = a.id
        LEFT JOIN scam_platforms p ON c.platform_id = p.id
        LEFT JOIN cryptocurrencies cr ON c.crypto_currency_id = cr.id
        LEFT JOIN crypto_exchange_rates cer ON cr.id = cer.crypto_currency_id
        WHERE c.admin_id = :admin_id
        ORDER BY c.created_at DESC
    ";
    
    $stmt = $pdo->prepare($query);
    $stmt->execute(['admin_id' => $currentAdminId]);
    
    $cases = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Calculate USD equivalent for crypto cases
    foreach ($cases as &$case) {
        if ($case['currency_type'] === 'crypto' && $case['crypto_reported_amount'] && $case['crypto_usd_price']) {
            $case['usd_equivalent'] = $case['crypto_reported_amount'] * $case['crypto_usd_price'];
        }
    }
    
    echo json_encode([
        'success' => true,
        'data' => $cases
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Failed to fetch cases',
        'error' => $e->getMessage()
    ]);
}
?>