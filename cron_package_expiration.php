<?php
/**
 * Cron Job: User Package Expiration Checker
 * 
 * This script should be run daily via cron to:
 * 1. Check all user packages for expiration
 * 2. Update status to 'expired' for packages past end_date
 * 3. Log all status changes
 * 
 * Setup cron: Run every hour or daily
 * 0 * * * * /usr/bin/php /path/to/cron_package_expiration.php
 * OR
 * 0 0 * * * /usr/bin/php /path/to/cron_package_expiration.php
 */

// Use absolute path for config based on server structure
$rootPath = $_SERVER['DOCUMENT_ROOT'] . '/app';
if (file_exists($rootPath . '/config.php')) {
    require_once $rootPath . '/config.php';
} else {
    require_once __DIR__ . '/../config.php';
}

// Log start
error_log("Package Expiration Cron: Starting at " . date('Y-m-d H:i:s'));

try {
    // Get current date
    $now = date('Y-m-d');
    
    // Find all user packages with 'active' or 'pending' status where end_date has passed
    $stmt = $pdo->prepare("
        SELECT 
            up.id as user_package_id,
            up.user_id,
            up.package_id,
            up.status,
            up.end_date,
            u.email,
            u.first_name,
            u.last_name,
            p.name as package_name
        FROM user_packages up
        JOIN users u ON up.user_id = u.id
        JOIN packages p ON up.package_id = p.id
        WHERE up.status IN ('active', 'pending')
        AND DATE(up.end_date) < DATE(:now)
    ");
    $stmt->execute([':now' => $now]);
    $expiredPackages = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $count = count($expiredPackages);
    error_log("Package Expiration Cron: Found {$count} expired packages to update");
    
    if ($count === 0) {
        error_log("Package Expiration Cron: No expired packages found. Exiting.");
        exit(0);
    }
    
    // Update each expired package
    $updatedCount = 0;
    $updateStmt = $pdo->prepare("
        UPDATE user_packages 
        SET status = 'expired', updated_at = NOW() 
        WHERE id = ?
    ");
    
    foreach ($expiredPackages as $package) {
        try {
            $updateStmt->execute([$package['user_package_id']]);
            $updatedCount++;
            
            error_log("Package Expiration Cron: Updated package ID {$package['user_package_id']} for user {$package['email']} (Package: {$package['package_name']}, End Date: {$package['end_date']})");
            
            // Log to admin_logs if table exists
            try {
                $logStmt = $pdo->prepare("
                    INSERT INTO admin_logs (admin_id, action, details, ip_address, created_at)
                    VALUES (0, 'package_expired', ?, '127.0.0.1', NOW())
                ");
                $logDetails = json_encode([
                    'user_package_id' => $package['user_package_id'],
                    'user_id' => $package['user_id'],
                    'user_email' => $package['email'],
                    'package_name' => $package['package_name'],
                    'end_date' => $package['end_date'],
                    'previous_status' => $package['status'],
                    'new_status' => 'expired',
                    'updated_by' => 'cron_package_expiration'
                ]);
                $logStmt->execute([$logDetails]);
            } catch (PDOException $logError) {
                // Log table might have different structure, continue anyway
                error_log("Package Expiration Cron: Could not log to admin_logs - " . $logError->getMessage());
            }
            
        } catch (PDOException $e) {
            error_log("Package Expiration Cron: Failed to update package ID {$package['user_package_id']} - " . $e->getMessage());
        }
    }
    
    error_log("Package Expiration Cron: Successfully updated {$updatedCount} of {$count} expired packages");
    error_log("Package Expiration Cron: Completed at " . date('Y-m-d H:i:s'));
    
    exit(0);
    
} catch (PDOException $e) {
    error_log("Package Expiration Cron Error: Database error - " . $e->getMessage());
    exit(1);
} catch (Exception $e) {
    error_log("Package Expiration Cron Error: " . $e->getMessage());
    exit(1);
}
