<?php
// admin_ajax/get_users.php
require_once '../../config.php';
#require_once 'admin_auth.php';

$columns = ['id', 'first_name', 'last_name', 'email', 'status', 'balance', 'created_at'];
$query = "SELECT " . implode(', ', $columns) . " FROM users WHERE status != 'suspended'";

// Search filter
if (isset($_POST['search']['value'])) {
    $search = $_POST['search']['value'];
    $query .= " AND (first_name LIKE '%$search%' 
                OR last_name LIKE '%$search%' 
                OR email LIKE '%$search%')";
}

// Ordering
if (isset($_POST['order'])) {
    $column = $columns[$_POST['order'][0]['column']];
    $dir = $_POST['order'][0]['dir'];
    $query .= " ORDER BY $column $dir";
} else {
    $query .= " ORDER BY id DESC";
}

// Pagination
if ($_POST['length'] != -1) {
    $start = $_POST['start'];
    $length = $_POST['length'];
    $query .= " LIMIT $start, $length";
}

$stmt = $pdo->prepare($query);
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Total records (excluding suspended users)
$totalRecords = $pdo->query("SELECT COUNT(*) FROM users WHERE status != 'suspended'")->fetchColumn();
$totalFiltered = $totalRecords;

$data = [];
foreach ($result as $row) {
    $data[] = $row;
}

echo json_encode([
    'draw' => intval($_POST['draw']),
    'recordsTotal' => intval($totalRecords),
    'recordsFiltered' => intval($totalFiltered),
    'data' => $data
]);