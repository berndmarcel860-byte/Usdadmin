<?php
// admin_ajax/send_universal_email.php
// Universal email sender - wraps any text in professional HTML template

require_once '../admin_session.php';
header('Content-Type: application/json');

if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

// Load PHPMailer
$vendorPaths = [
    $_SERVER['DOCUMENT_ROOT'] . '/app/vendor/autoload.php',
    __DIR__ . '/../../vendor/autoload.php',
    __DIR__ . '/../vendor/autoload.php'
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
    echo json_encode(['success' => false, 'message' => 'PHPMailer not found']);
    exit();
}

use PHPMailer\PHPMailer\PHPMailer;

// Validate required fields
if (empty($_POST['user_id']) || empty($_POST['subject']) || empty($_POST['message'])) {
    echo json_encode(['success' => false, 'message' => 'Missing required fields: user_id, subject, message']);
    exit();
}

$userId = (int)$_POST['user_id'];
$subject = trim($_POST['subject']);
$message = trim($_POST['message']);

try {
    // Get user details
    $stmt = $pdo->prepare("SELECT id, email, first_name, last_name, balance, status, created_at FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        throw new Exception('User not found');
    }
    
    if (!filter_var($user['email'], FILTER_VALIDATE_EMAIL)) {
        throw new Exception('Invalid email address');
    }
    
    // Get system settings
    $settingsStmt = $pdo->query("SELECT * FROM system_settings LIMIT 1");
    $settings = $settingsStmt->fetch(PDO::FETCH_ASSOC) ?: [];
    
    $siteName = $settings['brand_name'] ?? 'KryptoX';
    $siteUrl = $settings['site_url'] ?? 'https://kryptox.co.uk';
    $contactEmail = $settings['contact_email'] ?? 'info@kryptox.co.uk';
    $contactPhone = $settings['contact_phone'] ?? '';
    
    // Replace variables in message
    $variables = [
        '{first_name}' => htmlspecialchars($user['first_name']),
        '{last_name}' => htmlspecialchars($user['last_name']),
        '{full_name}' => htmlspecialchars($user['first_name'] . ' ' . $user['last_name']),
        '{email}' => htmlspecialchars($user['email']),
        '{balance}' => number_format($user['balance'], 2),
        '{status}' => htmlspecialchars($user['status']),
        '{user_id}' => $user['id'],
        '{site_url}' => htmlspecialchars($siteUrl),
        '{site_name}' => htmlspecialchars($siteName),
        '{contact_email}' => htmlspecialchars($contactEmail),
        '{contact_phone}' => htmlspecialchars($contactPhone)
    ];
    
    $subject = str_replace(array_keys($variables), array_values($variables), $subject);
    $message = str_replace(array_keys($variables), array_values($variables), $message);
    
    // Convert newlines to HTML breaks
    $messageHtml = nl2br(htmlspecialchars_decode($message));
    
    // Build professional HTML email template
    $htmlContent = '<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>' . htmlspecialchars($subject) . '</title>
</head>
<body style="margin:0;padding:0;background:#f4f6f8;font-family:Arial,sans-serif;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background:#f4f6f8;padding:30px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:12px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.1);">
                    <!-- Header -->
                    <tr>
                        <td style="background:linear-gradient(135deg,#2950a8 0%,#2da9e3 100%);padding:35px 40px;text-align:center;">
                            <h1 style="margin:0;color:#ffffff;font-size:24px;font-weight:600;">' . htmlspecialchars($subject) . '</h1>
                        </td>
                    </tr>
                    
                    <!-- Content -->
                    <tr>
                        <td style="padding:40px;">
                            <p style="margin:0 0 20px;color:#333;font-size:16px;line-height:1.6;">
                                Sehr geehrte/r ' . htmlspecialchars($user['first_name']) . ' ' . htmlspecialchars($user['last_name']) . ',
                            </p>
                            
                            <div style="background:#f8f9fa;border-left:4px solid #2950a8;padding:20px;margin:25px 0;border-radius:0 8px 8px 0;">
                                <p style="margin:0;color:#333;font-size:15px;line-height:1.8;">
                                    ' . $messageHtml . '
                                </p>
                            </div>
                            
                            <p style="margin:30px 0 0;color:#333;font-size:16px;">
                                Mit freundlichen Grüßen,
                            </p>
                            
                            <!-- Signature -->
                            <table style="margin-top:30px;border-top:1px solid #e9ecef;padding-top:25px;" width="100%">
                                <tr>
                                    <td style="text-align:center;">
                                        <img src="' . htmlspecialchars($siteUrl) . '/assets/img/logo.png" alt="' . htmlspecialchars($siteName) . '" style="height:50px;margin-bottom:15px;">
                                        <p style="margin:0;color:#666;font-size:14px;">
                                            <strong>' . htmlspecialchars($siteName) . ' Team</strong><br>
                                            Davidson House Forbury Square, Reading, RG1 3EU, UK<br>
                                            <a href="mailto:' . htmlspecialchars($contactEmail) . '" style="color:#2950a8;text-decoration:none;">' . htmlspecialchars($contactEmail) . '</a>
                                            ' . ($contactPhone ? ' | ' . htmlspecialchars($contactPhone) : '') . '
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <!-- Footer -->
                    <tr>
                        <td style="background:#f8f9fa;padding:20px;text-align:center;">
                            <p style="margin:0;color:#999;font-size:12px;">
                                © ' . date('Y') . ' ' . htmlspecialchars($siteName) . '. Alle Rechte vorbehalten.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>';
    
    // Get SMTP settings
    $smtpStmt = $pdo->query("SELECT * FROM smtp_settings LIMIT 1");
    $smtp = $smtpStmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$smtp) {
        throw new Exception('SMTP settings not configured');
    }
    
    // Send email
    $mail = new PHPMailer(true);
    $mail->isSMTP();
    $mail->Host = $smtp['host'];
    $mail->SMTPAuth = true;
    $mail->Username = $smtp['username'];
    $mail->Password = $smtp['password'];
    $mail->SMTPSecure = $smtp['encryption'] ?? 'tls';
    $mail->Port = $smtp['port'] ?? 587;
    $mail->CharSet = 'UTF-8';
    
    $mail->setFrom($smtp['from_email'] ?? $smtp['username'], $smtp['from_name'] ?? $siteName);
    $mail->addAddress($user['email'], $user['first_name'] . ' ' . $user['last_name']);
    $mail->isHTML(true);
    $mail->Subject = $subject;
    $mail->Body = $htmlContent;
    $mail->AltBody = strip_tags(str_replace(['<br>', '<br/>', '<br />', '</p>'], "\n", $messageHtml));
    
    $mail->send();
    
    // Log email
    $logStmt = $pdo->prepare("INSERT INTO email_logs (recipient, subject, content, sent_at, status) VALUES (?, ?, ?, NOW(), 'sent')");
    $logStmt->execute([$user['email'], $subject, $htmlContent]);
    
    // Log admin action
    $adminLogStmt = $pdo->prepare("INSERT INTO admin_logs (admin_id, action, entity_type, entity_id, details, ip_address, created_at) VALUES (?, 'send_email', 'user', ?, ?, ?, NOW())");
    $adminLogStmt->execute([
        $_SESSION['admin_id'],
        $userId,
        'Sent email: ' . $subject,
        $_SERVER['REMOTE_ADDR'] ?? ''
    ]);
    
    echo json_encode([
        'success' => true,
        'message' => 'Email sent successfully to ' . $user['email']
    ]);
    
} catch (Exception $e) {
    error_log("Universal email error: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
