<?php
/**
 * Cryptocurrency Connection Test
 * This page helps diagnose issues with cryptocurrency dropdown
 */
require_once 'admin_session.php';

// Test 1: Check if cryptocurrencies table exists
echo "<h2>Cryptocurrency Dropdown Diagnostic</h2>";
echo "<hr>";

echo "<h3>Test 1: Database Connection</h3>";
try {
    $test = $pdo->query("SELECT 1")->fetchColumn();
    echo "✅ Database connection: <strong style='color:green'>SUCCESS</strong><br>";
} catch (PDOException $e) {
    echo "❌ Database connection: <strong style='color:red'>FAILED</strong><br>";
    echo "Error: " . $e->getMessage() . "<br>";
    exit;
}

echo "<hr>";
echo "<h3>Test 2: Cryptocurrencies Table Exists</h3>";
try {
    $tableExists = $pdo->query("SHOW TABLES LIKE 'cryptocurrencies'")->fetch();
    if ($tableExists) {
        echo "✅ Table 'cryptocurrencies': <strong style='color:green'>EXISTS</strong><br>";
    } else {
        echo "❌ Table 'cryptocurrencies': <strong style='color:red'>DOES NOT EXIST</strong><br>";
        echo "<p style='color:red'>Please run migration_add_crypto_support.sql or import rectest.sql</p>";
        exit;
    }
} catch (PDOException $e) {
    echo "❌ Table check: <strong style='color:red'>FAILED</strong><br>";
    echo "Error: " . $e->getMessage() . "<br>";
    exit;
}

echo "<hr>";
echo "<h3>Test 3: Cryptocurrency Records Count</h3>";
try {
    $totalCount = $pdo->query("SELECT COUNT(*) FROM cryptocurrencies")->fetchColumn();
    $activeCount = $pdo->query("SELECT COUNT(*) FROM cryptocurrencies WHERE is_active = 1")->fetchColumn();
    
    echo "Total cryptocurrencies: <strong>{$totalCount}</strong><br>";
    echo "Active cryptocurrencies: <strong style='color:" . ($activeCount > 0 ? 'green' : 'red') . "'>{$activeCount}</strong><br>";
    
    if ($activeCount == 0) {
        echo "<p style='color:red'>⚠️ WARNING: No active cryptocurrencies found!</p>";
        echo "<p>Run this SQL to activate all cryptocurrencies:</p>";
        echo "<code>UPDATE cryptocurrencies SET is_active = 1;</code>";
    } else {
        echo "✅ Active cryptocurrencies: <strong style='color:green'>OK</strong><br>";
    }
} catch (PDOException $e) {
    echo "❌ Count query: <strong style='color:red'>FAILED</strong><br>";
    echo "Error: " . $e->getMessage() . "<br>";
    exit;
}

echo "<hr>";
echo "<h3>Test 4: Sample Cryptocurrency Data</h3>";
try {
    $cryptos = $pdo->query("SELECT id, symbol, name, rank, is_active FROM cryptocurrencies WHERE is_active = 1 ORDER BY rank ASC LIMIT 10")->fetchAll(PDO::FETCH_ASSOC);
    
    if (count($cryptos) > 0) {
        echo "✅ Sample data (first 10 active cryptocurrencies):<br><br>";
        echo "<table border='1' cellpadding='5' cellspacing='0' style='border-collapse:collapse;'>";
        echo "<tr><th>ID</th><th>Symbol</th><th>Name</th><th>Rank</th><th>Active</th></tr>";
        foreach ($cryptos as $crypto) {
            echo "<tr>";
            echo "<td>{$crypto['id']}</td>";
            echo "<td><strong>{$crypto['symbol']}</strong></td>";
            echo "<td>{$crypto['name']}</td>";
            echo "<td>{$crypto['rank']}</td>";
            echo "<td>" . ($crypto['is_active'] ? '✅' : '❌') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "❌ No active cryptocurrencies found<br>";
    }
} catch (PDOException $e) {
    echo "❌ Sample data query: <strong style='color:red'>FAILED</strong><br>";
    echo "Error: " . $e->getMessage() . "<br>";
    exit;
}

echo "<hr>";
echo "<h3>Test 5: Dropdown HTML Generation Test</h3>";
try {
    $cryptos = $pdo->query("SELECT id, symbol, name FROM cryptocurrencies WHERE is_active = 1 ORDER BY rank ASC")->fetchAll();
    echo "Number of options that would be generated: <strong>" . count($cryptos) . "</strong><br>";
    
    if (count($cryptos) > 0) {
        echo "✅ Dropdown generation: <strong style='color:green'>WOULD WORK</strong><br>";
        echo "<p>Preview of generated options (first 5):</p>";
        echo "<select style='width:300px;padding:5px;'>";
        echo "<option value=''>Select Cryptocurrency</option>";
        $count = 0;
        foreach ($cryptos as $crypto) {
            if ($count++ >= 5) break;
            echo "<option value='" . htmlspecialchars($crypto['id']) . "'>";
            echo htmlspecialchars($crypto['symbol']) . " - " . htmlspecialchars($crypto['name']);
            echo "</option>";
        }
        echo "</select>";
    } else {
        echo "❌ Dropdown generation: <strong style='color:red'>WOULD FAIL - NO DATA</strong><br>";
    }
} catch (PDOException $e) {
    echo "❌ Dropdown test: <strong style='color:red'>FAILED</strong><br>";
    echo "Error: " . $e->getMessage() . "<br>";
}

echo "<hr>";
echo "<h3>Conclusion</h3>";
if ($activeCount > 0) {
    echo "<p style='color:green;font-size:18px;'><strong>✅ ALL TESTS PASSED!</strong></p>";
    echo "<p>The cryptocurrency dropdown should work correctly. If it's still not showing:</p>";
    echo "<ol>";
    echo "<li>Clear your browser cache and reload the page</li>";
    echo "<li>Open browser console (F12) and check for JavaScript errors</li>";
    echo "<li>Check the console.log messages when selecting 'Cryptocurrency'</li>";
    echo "<li>Make sure you're selecting 'Cryptocurrency' from the Currency Type dropdown</li>";
    echo "</ol>";
    echo "<p><a href='admin_cases.php'>Go to Cases Page</a></p>";
} else {
    echo "<p style='color:red;font-size:18px;'><strong>⚠️ ISSUES FOUND!</strong></p>";
    echo "<p>Please fix the issues above before the dropdown will work.</p>";
}
?>
