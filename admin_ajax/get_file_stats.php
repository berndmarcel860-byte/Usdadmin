<?php
require_once '../../config.php';

header('Content-Type: application/json');

try {
    // Get file statistics from user_documents table
    $stmt = $pdo->query("
        SELECT 
            COUNT(*) as total_files,
            SUM(CASE WHEN document_type IN ('pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt') THEN 1 ELSE 0 END) as total_docs,
            SUM(CASE WHEN document_type IN ('jpg', 'jpeg', 'png', 'gif', 'bmp', 'svg') THEN 1 ELSE 0 END) as total_images,
            SUM(file_size) as total_size
        FROM user_documents
    ");
    
    $stats = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // Ensure no null values
    $stats['total_files'] = (int)($stats['total_files'] ?? 0);
    $stats['total_docs'] = (int)($stats['total_docs'] ?? 0);
    $stats['total_images'] = (int)($stats['total_images'] ?? 0);
    $stats['total_size'] = (int)($stats['total_size'] ?? 0);
    
    echo json_encode([
        'success' => true,
        'stats' => $stats
    ]);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
