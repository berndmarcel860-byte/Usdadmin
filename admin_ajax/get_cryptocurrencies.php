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
    $draw = isset($_POST['draw']) ? (int)$_POST['draw'] : 1;
    $start = isset($_POST['start']) ? (int)$_POST['start'] : 0;
    $length = isset($_POST['length']) ? (int)$_POST['length'] : 10;
    $search = isset($_POST['search']['value']) ? $_POST['search']['value'] : '';
    $filter = isset($_POST['filter']) ? $_POST['filter'] : 'all';
    
    // Base query
    $query = "
        SELECT 
            c.*,
            er.usd_rate,
            (SELECT COUNT(*) FROM cases WHERE crypto_currency_id = c.id) as case_count,
            (SELECT COUNT(*) FROM withdrawals WHERE crypto_currency_id = c.id) as withdrawal_count
        FROM cryptocurrencies c
        LEFT JOIN crypto_exchange_rates er ON c.id = er.crypto_currency_id
        WHERE 1=1
    ";
    
    $params = [];
    $countParams = [];
    
    // Apply filter
    if ($filter === 'active') {
        $query .= " AND c.is_active = 1";
    } elseif ($filter === 'inactive') {
        $query .= " AND c.is_active = 0";
    }
    
    // Search filter
    if ($search) {
        $query .= " AND (c.symbol LIKE ? OR c.name LIKE ?)";
        $searchTerm = "%$search%";
        $params = array_merge($params, [$searchTerm, $searchTerm]);
        $countParams = array_merge($countParams, [$searchTerm, $searchTerm]);
    }
    
    // Get total count
    $countQuery = "SELECT COUNT(*) FROM cryptocurrencies c WHERE 1=1";
    if ($filter === 'active') {
        $countQuery .= " AND c.is_active = 1";
    } elseif ($filter === 'inactive') {
        $countQuery .= " AND c.is_active = 0";
    }
    if ($search) {
        $countQuery .= " AND (c.symbol LIKE ? OR c.name LIKE ?)";
    }
    
    $stmt = $pdo->prepare($countQuery);
    $stmt->execute($countParams);
    $totalRecords = $stmt->fetchColumn();
    
    // Add sorting
    $orderColumn = isset($_POST['order'][0]['column']) ? (int)$_POST['order'][0]['column'] : 0;
    $orderDirection = isset($_POST['order'][0]['dir']) && strtoupper($_POST['order'][0]['dir']) === 'DESC' ? 'DESC' : 'ASC';
    
    $columns = ['c.`rank`', 'c.symbol', 'c.name', 'er.usd_rate'];
    
    if (isset($columns[$orderColumn])) {
        $query .= " ORDER BY {$columns[$orderColumn]} $orderDirection";
    } else {
        $query .= " ORDER BY c.`rank` ASC";
    }
    
    // Pagination
    $query .= " LIMIT ?, ?";
    $params[] = $start;
    $params[] = $length;
    
    // Execute query
    $stmt = $pdo->prepare($query);
    
    $paramCount = count($params);
    foreach ($params as $i => $param) {
        if ($i >= $paramCount - 2) {
            $stmt->bindValue($i + 1, $param, PDO::PARAM_INT);
        } else {
            $stmt->bindValue($i + 1, $param, PDO::PARAM_STR);
        }
    }
    
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'draw' => $draw,
        'recordsTotal' => $totalRecords,
        'recordsFiltered' => $totalRecords,
        'data' => $data
    ]);
    
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>
