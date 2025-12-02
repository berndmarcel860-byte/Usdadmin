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
    $documentId = isset($_POST['id']) ? (int)$_POST['id'] : 0;
    
    if ($documentId <= 0) {
        echo json_encode(['success' => false, 'message' => 'Invalid document ID']);
        exit;
    }
    
    // Get file path before deleting
    $stmt = $pdo->prepare("SELECT file_path FROM user_documents WHERE id = ?");
    $stmt->execute([$documentId]);
    $document = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($document) {
        // Delete from database
        $deleteStmt = $pdo->prepare("DELETE FROM user_documents WHERE id = ?");
        $deleteStmt->execute([$documentId]);
        
        // Try to delete physical file with security checks
        if (!empty($document['file_path']) && file_exists($document['file_path'])) {
            // Validate file path is within uploads directory
            $uploadsDir = realpath(__DIR__ . '/../../uploads');
            $filePath = realpath($document['file_path']);
            
            // Only delete if file is within uploads directory
            if ($filePath && strpos($filePath, $uploadsDir) === 0) {
                if (!unlink($filePath)) {
                    error_log("Failed to delete file: " . $filePath);
                }
            } else {
                error_log("Attempted to delete file outside uploads directory: " . $document['file_path']);
            }
        }
        
        // Log the action
        if (isset($_SESSION['admin_id'])) {
            $logStmt = $pdo->prepare("
                INSERT INTO admin_logs 
                (admin_id, action, entity_type, entity_id, ip_address, user_agent) 
                VALUES (?, ?, ?, ?, ?, ?)
            ");
            $logStmt->execute([
                $_SESSION['admin_id'],
                'delete_document',
                'user_document',
                $documentId,
                $_SERVER['REMOTE_ADDR'],
                $_SERVER['HTTP_USER_AGENT'] ?? ''
            ]);
        }
        
        echo json_encode([
            'success' => true,
            'message' => 'Document deleted successfully'
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Document not found'
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
