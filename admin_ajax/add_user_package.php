<?php
// admin_ajax/add_user_package.php
// Add new user package assignment

require_once '../admin_session.php';
header('Content-Type: application/json');

if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

// Validate required fields
$required = ['user_id', 'package_id', 'start_date', 'end_date', 'status'];
foreach ($required as $field) {
    if (empty($_POST[$field])) {
        echo json_encode(['success' => false, 'message' => "Missing required field: $field"]);
        exit();
    }
}

$userId = (int)$_POST['user_id'];
$packageId = (int)$_POST['package_id'];
$startDate = $_POST['start_date'];
$endDate = $_POST['end_date'];
$status = $_POST['status'];

// Validate status
$validStatuses = ['pending', 'active', 'expired', 'cancelled'];
if (!in_array($status, $validStatuses)) {
    echo json_encode(['success' => false, 'message' => 'Invalid status']);
    exit();
}

try {
    // Verify user exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    if (!$stmt->fetch()) {
        echo json_encode(['success' => false, 'message' => 'User not found']);
        exit();
    }
    
    // Verify package exists
    $stmt = $pdo->prepare("SELECT id FROM packages WHERE id = ?");
    $stmt->execute([$packageId]);
    if (!$stmt->fetch()) {
        echo json_encode(['success' => false, 'message' => 'Package not found']);
        exit();
    }
    
    // Insert new assignment
    $stmt = $pdo->prepare("
        INSERT INTO user_packages (user_id, package_id, start_date, end_date, status, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, NOW(), NOW())
    ");
    $stmt->execute([$userId, $packageId, $startDate, $endDate, $status]);
    $newId = $pdo->lastInsertId();
    
    // Log admin action
    $logStmt = $pdo->prepare("
        INSERT INTO admin_logs (admin_id, action, entity_type, entity_id, ip_address, user_agent, created_at)
        VALUES (?, 'create', 'user_package', ?, ?, ?, NOW())
    ");
    $logStmt->execute([
        $_SESSION['admin_id'],
        $newId,
        $_SERVER['REMOTE_ADDR'] ?? '',
        $_SERVER['HTTP_USER_AGENT'] ?? ''
    ]);
    
    echo json_encode([
        'success' => true,
        'message' => 'Package assignment created successfully',
        'id' => $newId
    ]);
    
} catch (PDOException $e) {
    error_log("Add user package error: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
