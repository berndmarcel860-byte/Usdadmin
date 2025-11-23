<?php
require_once '../admin_session.php';

header('Content-Type: application/json');

try {
    $query = "
        SELECT 
            k.*, 
            u.first_name AS user_first_name, 
            u.last_name AS user_last_name
        FROM kyc_verification_requests k
        LEFT JOIN users u ON k.user_id = u.id
        WHERE 1=1
    ";
    
    $params = [];
    
    // Apply filters
    if (!empty($_GET['status'])) {
        $query .= " AND k.status = ?";
        $params[] = $_GET['status'];
    }
    
    if (!empty($_GET['document_type'])) {
        $query .= " AND k.document_type = ?";
        $params[] = $_GET['document_type'];
    }
    
    $query .= " ORDER BY k.created_at DESC";
    
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    
    $kycRequests = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'data' => $kycRequests
    ]);
} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Failed to fetch KYC requests',
        'error' => $e->getMessage()
    ]);
}
?>