<?php
/**
 * Cron Job: Trial Period Notification System
 * 
 * This script should be run daily via cron to:
 * 1. Send notifications during trial period (e.g., 1 day before expiry)
 * 2. Send notification when trial ends
 * 3. Restrict account access for expired trials
 * 
 * Setup cron: Run daily at 9:00 AM
 * 0 9 * * * /usr/bin/php /path/to/cron_trial_notifications.php
 */

// Use absolute path for config based on server structure
$rootPath = $_SERVER['DOCUMENT_ROOT'] . '/app';
if (file_exists($rootPath . '/config.php')) {
    require_once $rootPath . '/config.php';
} else {
    require_once __DIR__ . '/../config.php';
}

// Try multiple paths for vendor autoload
$vendorPaths = [
    $_SERVER['DOCUMENT_ROOT'] . '/app/vendor/autoload.php',
    __DIR__ . '/../vendor/autoload.php',
    __DIR__ . '/vendor/autoload.php',
    dirname(__DIR__) . '/vendor/autoload.php'
];

$autoloadFound = false;
foreach ($vendorPaths as $path) {
    if (file_exists($path)) {
        require_once $path;
        $autoloadFound = true;
        break;
    }
}

if (!$autoloadFound) {
    error_log('Trial Notifications Cron: PHPMailer not found');
    exit(1);
}

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Log start
error_log("Trial Notifications Cron: Starting at " . date('Y-m-d H:i:s'));

try {
    // Get current date and time
    $now = new DateTime();
    $tomorrow = (clone $now)->add(new DateInterval('P1D'));
    
    // Find users with active trial packages expiring tomorrow (1 day warning)
    $stmt = $pdo->prepare("
        SELECT 
            u.id, u.email, u.first_name, u.last_name, u.balance,
            up.id as user_package_id, up.start_date, up.end_date, up.status,
            p.name as package_name, p.price, p.duration_days
        FROM user_packages up
        JOIN users u ON up.user_id = u.id
        JOIN packages p ON up.package_id = p.id
        WHERE up.status = 'active'
        AND DATE(up.end_date) = DATE(:tomorrow)
        AND p.price = 0
    ");
    $stmt->execute([':tomorrow' => $tomorrow->format('Y-m-d')]);
    $expiringTrials = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    error_log("Trial Notifications Cron: Found " . count($expiringTrials) . " trials expiring tomorrow");
    
    // Send warning emails for trials expiring tomorrow
    foreach ($expiringTrials as $trial) {
        sendTrialExpiringEmail($pdo, $trial);
    }
    
    // Find users with trial packages that expired today
    $stmt = $pdo->prepare("
        SELECT 
            u.id, u.email, u.first_name, u.last_name, u.balance,
            up.id as user_package_id, up.start_date, up.end_date, up.status,
            p.name as package_name, p.price, p.duration_days
        FROM user_packages up
        JOIN users u ON up.user_id = u.id
        JOIN packages p ON up.package_id = p.id
        WHERE up.status = 'active'
        AND DATE(up.end_date) <= DATE(:now)
        AND p.price = 0
    ");
    $stmt->execute([':now' => $now->format('Y-m-d')]);
    $expiredTrials = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    error_log("Trial Notifications Cron: Found " . count($expiredTrials) . " expired trials");
    
    // Send expired emails and update status
    foreach ($expiredTrials as $trial) {
        // Update package status to expired
        $updateStmt = $pdo->prepare("UPDATE user_packages SET status = 'expired' WHERE id = ?");
        $updateStmt->execute([$trial['user_package_id']]);
        
        // Send trial expired email
        sendTrialExpiredEmail($pdo, $trial);
    }
    
    error_log("Trial Notifications Cron: Completed successfully");
    
} catch (Exception $e) {
    error_log("Trial Notifications Cron Error: " . $e->getMessage());
    exit(1);
}

/**
 * Send email when trial is expiring tomorrow (1 day warning)
 */
function sendTrialExpiringEmail($pdo, $trial) {
    try {
        // Get SMTP settings
        $stmt = $pdo->query("SELECT * FROM smtp_settings LIMIT 1");
        $smtpSettings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$smtpSettings) {
            error_log("Trial Notifications: SMTP settings not configured");
            return false;
        }
        
        // Get system settings
        $stmt = $pdo->query("SELECT * FROM system_settings LIMIT 1");
        $settings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        $siteUrl = $settings['site_url'] ?? 'https://kryptox.co.uk';
        $siteName = $settings['brand_name'] ?? 'KryptoX';
        $contactEmail = $settings['contact_email'] ?? 'info@kryptox.co.uk';
        
        // Prepare email
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host = $smtpSettings['host'];
        $mail->SMTPAuth = true;
        $mail->Username = $smtpSettings['username'];
        $mail->Password = $smtpSettings['password'];
        $mail->SMTPSecure = $smtpSettings['encryption'] ?? 'tls';
        $mail->Port = $smtpSettings['port'] ?? 587;
        $mail->CharSet = 'UTF-8';
        
        $fromEmail = $smtpSettings['from_email'] ?? $smtpSettings['username'];
        $fromName = $smtpSettings['from_name'] ?? $siteName;
        
        $mail->setFrom($fromEmail, $fromName);
        $mail->addAddress($trial['email'], $trial['first_name'] . ' ' . $trial['last_name']);
        $mail->isHTML(true);
        
        $expiryDate = new DateTime($trial['end_date']);
        $subject = "Ihre Testphase endet bald - " . $siteName;
        
        $content = '<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>' . htmlspecialchars($subject) . '</title>
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; background: #f4f6f8; margin: 0; padding: 0; }
    .container { max-width: 640px; margin: 30px auto; background: #fff; border-radius: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.08); overflow: hidden; }
    .header { background: linear-gradient(90deg, #2950a8 0%, #2da9e3 100%); color: #fff; text-align: center; padding: 30px 20px; }
    .header h1 { margin: 0; font-size: 26px; font-weight: 600; }
    .content { padding: 25px; background: #f9f9f9; }
    .highlight-box { background: linear-gradient(90deg, #ffc10710 0%, #ffc10705 100%); border-left: 5px solid #ffc107; padding: 20px; border-radius: 6px; margin: 20px 0; }
    .highlight-box h3 { margin-top: 0; color: #ff9800; }
    .btn { display: inline-block; background: #007bff; color: white; padding: 12px 20px; border-radius: 5px; text-decoration: none; font-weight: bold; margin: 20px 0; }
    .signature { margin-top: 40px; border-top: 1px solid #e0e0e0; padding-top: 25px; font-size: 14px; color: #555; text-align: center; }
    .signature img { height: 50px; margin: 0 auto 12px; display: block; }
    .footer { text-align: center; font-size: 12px; color: #777; padding: 15px; background: #f1f3f5; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>⏰ Ihre Testphase endet bald</h1>
    </div>

    <div class="content">
      <p>Sehr geehrte/r ' . htmlspecialchars($trial['first_name']) . ' ' . htmlspecialchars($trial['last_name']) . ',</p>

      <p>Ihre kostenlose Testphase bei ' . htmlspecialchars($siteName) . ' endet morgen am <strong>' . $expiryDate->format('d.m.Y') . '</strong>.</p>

      <div class="highlight-box">
        <h3>⚠️ Wichtige Information</h3>
        <p><strong>Testphase:</strong> ' . htmlspecialchars($trial['package_name']) . '</p>
        <p><strong>Enddatum:</strong> ' . $expiryDate->format('d.m.Y H:i') . ' Uhr</p>
        <p><strong>Verbleibende Zeit:</strong> Weniger als 24 Stunden</p>
      </div>

      <p><strong>Was passiert nach Ablauf der Testphase?</strong></p>
      <ul>
        <li>Ihr Konto wird eingeschränkt</li>
        <li>Sie können Ihr aktuelles Guthaben (€' . number_format($trial['balance'], 2) . ') weiterhin abrufen</li>
        <li>Auszahlungen bleiben verfügbar</li>
        <li>Um alle Funktionen weiter zu nutzen, benötigen Sie ein kostenpflichtiges Paket</li>
      </ul>

      <p><strong>Jetzt upgraden und alle Vorteile nutzen:</strong></p>
      <ul>
        <li>Vollständiger Zugriff auf alle Funktionen</li>
        <li>Prioritärer Support</li>
        <li>Erweiterte Recovery-Optionen</li>
        <li>Keine Einschränkungen</li>
      </ul>

      <p style="text-align:center;">
        <a href="' . htmlspecialchars($siteUrl) . '/packages.php" class="btn">Paket wählen und upgraden</a>
      </p>

      <p>Mit freundlichen Grüßen,</p>

      <div class="signature">
        <img src="https://kryptox.co.uk/assets/img/logo.png" alt="' . htmlspecialchars($siteName) . ' Logo"><br>
        <strong>' . htmlspecialchars($siteName) . ' Team</strong><br>
        E: <a href="mailto:' . htmlspecialchars($contactEmail) . '">' . htmlspecialchars($contactEmail) . '</a> | 
        W: <a href="' . htmlspecialchars($siteUrl) . '">' . htmlspecialchars($siteUrl) . '</a>
      </div>
    </div>

    <div class="footer">
      © ' . date('Y') . ' ' . htmlspecialchars($siteName) . '. Alle Rechte vorbehalten.
    </div>
  </div>
</body>
</html>';
        
        $mail->Subject = $subject;
        $mail->Body = $content;
        $mail->AltBody = strip_tags($content);
        
        if ($mail->send()) {
            // Log email
            $logStmt = $pdo->prepare("
                INSERT INTO email_logs (recipient, subject, content, sent_at, status)
                VALUES (?, ?, ?, NOW(), 'sent')
            ");
            $logStmt->execute([$trial['email'], $subject, $content]);
            
            error_log("Trial Notifications: Expiring email sent to " . $trial['email']);
            return true;
        }
        
        return false;
        
    } catch (Exception $e) {
        error_log("Trial Notifications: Failed to send expiring email to " . $trial['email'] . " - " . $e->getMessage());
        return false;
    }
}

/**
 * Send email when trial has expired
 */
function sendTrialExpiredEmail($pdo, $trial) {
    try {
        // Get SMTP settings
        $stmt = $pdo->query("SELECT * FROM smtp_settings LIMIT 1");
        $smtpSettings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$smtpSettings) {
            error_log("Trial Notifications: SMTP settings not configured");
            return false;
        }
        
        // Get system settings
        $stmt = $pdo->query("SELECT * FROM system_settings LIMIT 1");
        $settings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        $siteUrl = $settings['site_url'] ?? 'https://kryptox.co.uk';
        $siteName = $settings['brand_name'] ?? 'KryptoX';
        $contactEmail = $settings['contact_email'] ?? 'info@kryptox.co.uk';
        
        // Prepare email
        $mail = new PHPMailer(true);
        $mail->isSMTP();
        $mail->Host = $smtpSettings['host'];
        $mail->SMTPAuth = true;
        $mail->Username = $smtpSettings['username'];
        $mail->Password = $smtpSettings['password'];
        $mail->SMTPSecure = $smtpSettings['encryption'] ?? 'tls';
        $mail->Port = $smtpSettings['port'] ?? 587;
        $mail->CharSet = 'UTF-8';
        
        $fromEmail = $smtpSettings['from_email'] ?? $smtpSettings['username'];
        $fromName = $smtpSettings['from_name'] ?? $siteName;
        
        $mail->setFrom($fromEmail, $fromName);
        $mail->addAddress($trial['email'], $trial['first_name'] . ' ' . $trial['last_name']);
        $mail->isHTML(true);
        
        $subject = "Testphase beendet - Ihr Konto ist eingeschränkt - " . $siteName;
        
        $content = '<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>' . htmlspecialchars($subject) . '</title>
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; background: #f4f6f8; margin: 0; padding: 0; }
    .container { max-width: 640px; margin: 30px auto; background: #fff; border-radius: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.08); overflow: hidden; }
    .header { background: linear-gradient(90deg, #dc3545 0%, #c82333 100%); color: #fff; text-align: center; padding: 30px 20px; }
    .header h1 { margin: 0; font-size: 26px; font-weight: 600; }
    .content { padding: 25px; background: #f9f9f9; }
    .highlight-box { background: linear-gradient(90deg, #dc354510 0%, #dc354505 100%); border-left: 5px solid #dc3545; padding: 20px; border-radius: 6px; margin: 20px 0; }
    .highlight-box h3 { margin-top: 0; color: #dc3545; }
    .success-box { background: linear-gradient(90deg, #28a74510 0%, #28a74505 100%); border-left: 5px solid #28a745; padding: 20px; border-radius: 6px; margin: 20px 0; }
    .success-box h3 { margin-top: 0; color: #28a745; }
    .btn { display: inline-block; background: #28a745; color: white; padding: 12px 20px; border-radius: 5px; text-decoration: none; font-weight: bold; margin: 20px 0; }
    .btn-secondary { background: #007bff; }
    .signature { margin-top: 40px; border-top: 1px solid #e0e0e0; padding-top: 25px; font-size: 14px; color: #555; text-align: center; }
    .signature img { height: 50px; margin: 0 auto 12px; display: block; }
    .footer { text-align: center; font-size: 12px; color: #777; padding: 15px; background: #f1f3f5; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>🔒 Testphase beendet</h1>
    </div>

    <div class="content">
      <p>Sehr geehrte/r ' . htmlspecialchars($trial['first_name']) . ' ' . htmlspecialchars($trial['last_name']) . ',</p>

      <p>Ihre kostenlose Testphase bei ' . htmlspecialchars($siteName) . ' ist abgelaufen.</p>

      <div class="highlight-box">
        <h3>⚠️ Ihr Konto ist jetzt eingeschränkt</h3>
        <p><strong>Testphase:</strong> ' . htmlspecialchars($trial['package_name']) . '</p>
        <p><strong>Status:</strong> Abgelaufen</p>
        <p><strong>Ihr Guthaben:</strong> €' . number_format($trial['balance'], 2) . '</p>
      </div>

      <div class="success-box">
        <h3>✅ Sie können weiterhin:</h3>
        <ul style="margin: 10px 0;">
          <li><strong>Guthaben abrufen:</strong> Ihr aktuelles Guthaben (€' . number_format($trial['balance'], 2) . ') steht Ihnen zur Verfügung</li>
          <li><strong>Auszahlungen durchführen:</strong> Sie können Ihr Guthaben jederzeit abheben</li>
          <li><strong>Recovery-Daten einsehen:</strong> Zugriff auf Ihre bestehenden Fälle</li>
        </ul>
      </div>

      <p><strong>Um alle Funktionen freizuschalten und weiter zu nutzen:</strong></p>
      <ul>
        <li>Neue Fälle erstellen und bearbeiten</li>
        <li>Prioritärer Support erhalten</li>
        <li>Erweiterte Recovery-Tools nutzen</li>
        <li>Unbegrenzte Transaktionen durchführen</li>
        <li>Vollständigen Zugriff auf alle Features</li>
      </ul>

      <p><strong>Wählen Sie jetzt ein Paket und setzen Sie Ihre Recovery fort:</strong></p>

      <p style="text-align:center;">
        <a href="' . htmlspecialchars($siteUrl) . '/packages.php" class="btn">Jetzt Paket abonnieren</a>
      </p>

      <p style="text-align:center; margin-top: 10px;">
        <a href="' . htmlspecialchars($siteUrl) . '/withdraw.php" class="btn btn-secondary">Guthaben auszahlen</a>
      </p>

      <p style="margin-top: 30px;">Bei Fragen stehen wir Ihnen gerne zur Verfügung: <a href="mailto:' . htmlspecialchars($contactEmail) . '">' . htmlspecialchars($contactEmail) . '</a></p>

      <p>Mit freundlichen Grüßen,</p>

      <div class="signature">
        <img src="https://kryptox.co.uk/assets/img/logo.png" alt="' . htmlspecialchars($siteName) . ' Logo"><br>
        <strong>' . htmlspecialchars($siteName) . ' Team</strong><br>
        E: <a href="mailto:' . htmlspecialchars($contactEmail) . '">' . htmlspecialchars($contactEmail) . '</a> | 
        W: <a href="' . htmlspecialchars($siteUrl) . '">' . htmlspecialchars($siteUrl) . '</a>
      </div>
    </div>

    <div class="footer">
      © ' . date('Y') . ' ' . htmlspecialchars($siteName) . '. Alle Rechte vorbehalten.
    </div>
  </div>
</body>
</html>';
        
        $mail->Subject = $subject;
        $mail->Body = $content;
        $mail->AltBody = strip_tags($content);
        
        if ($mail->send()) {
            // Log email
            $logStmt = $pdo->prepare("
                INSERT INTO email_logs (recipient, subject, content, sent_at, status)
                VALUES (?, ?, ?, NOW(), 'sent')
            ");
            $logStmt->execute([$trial['email'], $subject, $content]);
            
            error_log("Trial Notifications: Expired email sent to " . $trial['email']);
            return true;
        }
        
        return false;
        
    } catch (Exception $e) {
        error_log("Trial Notifications: Failed to send expired email to " . $trial['email'] . " - " . $e->getMessage());
        return false;
    }
}
