<?php
// =======================================================
// PHPMailer imports
// =======================================================
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

// =======================================================
// Error reporting (disable in production)
// =======================================================
ini_set('display_errors', 0);
error_reporting(E_ALL);

// =======================================================
// PHPMailer availability check
// =======================================================
$phpMailerAvailable = false;
if (file_exists(__DIR__ . '/../vendor/autoload.php')) {
    require_once __DIR__ . '/../vendor/autoload.php';
    $phpMailerAvailable = true;
}

require_once '../admin_session.php';

header('Content-Type: application/json');

if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid withdrawal ID']);
    exit();
}

if (empty($_POST['reason'])) {
    echo json_encode(['success' => false, 'message' => 'Rejection reason is required']);
    exit();
}

$withdrawalId = (int)$_POST['id'];
$reason = trim($_POST['reason']);

try {
    $pdo->beginTransaction();
    
    // Get withdrawal details
    $stmt = $pdo->prepare("SELECT * FROM withdrawals WHERE id = ?");
    $stmt->execute([$withdrawalId]);
    $withdrawal = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$withdrawal) {
        throw new Exception('Withdrawal not found');
    }
    
    if (!in_array($withdrawal['status'], ['pending', 'processing'])) {
        throw new Exception('Withdrawal cannot be rejected in its current state');
    }
    
    // Update withdrawal status (NO balance change - balance is NOT returned when withdrawal is rejected)
    // The balance was already deducted when the withdrawal was requested
    // If the admin rejects, the balance stays deducted as per user request
    $stmt = $pdo->prepare("
        UPDATE withdrawals 
        SET 
            status = 'failed',
            admin_notes = ?,
            processed_by = ?,
            processed_at = NOW(),
            updated_at = NOW()
        WHERE id = ?
    ");
    $stmt->execute([$reason, $_SESSION['admin_id'], $withdrawalId]);
    
    // Get user details
    $stmt = $pdo->prepare("SELECT id, email, first_name, last_name, balance FROM users WHERE id = ?");
    $stmt->execute([$withdrawal['user_id']]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($user) {
        // Send rejection email using template
        sendWithdrawalRejectionEmail($pdo, $user, 'withdrawal_rejected', $withdrawal, $reason);
        
        // Create user notification
        try {
            $notifUser = $pdo->prepare("
                INSERT INTO user_notifications (user_id, title, message, type, related_entity, related_id, created_at)
                VALUES (:user_id, :title, :message, :type, :entity, :rel_id, NOW())
            ");
            $notifUser->execute([
                ':user_id' => (int)$withdrawal['user_id'],
                ':title' => 'Auszahlung abgelehnt',
                ':message' => 'Ihre Auszahlung über <strong>' 
                    . number_format($withdrawal['amount'], 2) . ' €</strong> wurde leider abgelehnt. Grund: '
                    . htmlspecialchars($reason),
                ':type' => 'warning',
                ':entity' => 'withdrawal',
                ':rel_id' => $withdrawalId
            ]);
        } catch (Exception $e) {
            error_log("User notification failed: " . $e->getMessage());
        }
        
        // Create admin notification
        try {
            $notifAdmin = $pdo->prepare("
                INSERT INTO admin_notifications (admin_id, title, message, type, is_read, created_at)
                VALUES (:admin_id, :title, :message, :type, 0, NOW())
            ");
            $notifAdmin->execute([
                ':admin_id' => (int)$_SESSION['admin_id'],
                ':title' => 'Auszahlung abgelehnt',
                ':message' => 'Sie haben eine Auszahlung von Benutzer-ID <strong>'
                    . (int)$withdrawal['user_id'] . '</strong> über <strong>'
                    . number_format($withdrawal['amount'], 2) . ' €</strong> abgelehnt.',
                ':type' => 'warning'
            ]);
        } catch (Exception $e) {
            error_log("Admin notification failed: " . $e->getMessage());
        }
    }
    
    // Log admin action
    try {
        $logStmt = $pdo->prepare("
            INSERT INTO admin_logs (admin_id, action, description, entity_type, entity_id, created_at)
            VALUES (?, 'reject_withdrawal', ?, 'withdrawal', ?, NOW())
        ");
        $logStmt->execute([
            $_SESSION['admin_id'],
            'Rejected withdrawal of ' . number_format($withdrawal['amount'], 2) . ' € for user ID ' . $withdrawal['user_id'] . '. Reason: ' . $reason,
            $withdrawalId
        ]);
    } catch (Exception $e) {
        error_log("Admin log failed: " . $e->getMessage());
    }
    
    $pdo->commit();
    
    echo json_encode([
        'success' => true,
        'message' => 'Withdrawal rejected successfully'
    ]);
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    echo json_encode([
        'success' => false,
        'message' => 'Failed to reject withdrawal',
        'error' => $e->getMessage()
    ]);
}

/**
 * =======================================================
 * Send Withdrawal Rejection Email
 * =======================================================
 */
function sendWithdrawalRejectionEmail($pdo, $user, $templateKey, $withdrawal, $reason)
{
    global $phpMailerAvailable;
    
    try {
        // === Template
        $tpl = $pdo->prepare("SELECT * FROM email_templates WHERE template_key = ? LIMIT 1");
        $tpl->execute([$templateKey]);
        $template = $tpl->fetch(PDO::FETCH_ASSOC);
        
        // If template not found, use a fallback
        if (!$template) {
            error_log("Email template not found: " . $templateKey . " - using fallback");
            $template = [
                'id' => 0,
                'subject' => 'Auszahlung abgelehnt',
                'content' => '<p>Sehr geehrte/r {first_name} {last_name},</p><p>Ihre Auszahlung über {amount} wurde leider abgelehnt.</p><p>Grund: {reason}</p><p>Bei Fragen kontaktieren Sie uns bitte.</p><p>Mit freundlichen Grüßen</p>'
            ];
        }

        // === SMTP + System settings
        $smtp = $pdo->query("SELECT * FROM smtp_settings WHERE is_active = 1 LIMIT 1")->fetch(PDO::FETCH_ASSOC);
        if (!$smtp) {
            error_log("No active SMTP configuration found");
            return;
        }
        $sys = $pdo->query("SELECT * FROM system_settings WHERE id = 1")->fetch(PDO::FETCH_ASSOC);

        // === Lookup payment method name
        $methodName = 'Banküberweisung';
        if (!empty($withdrawal['method_code'])) {
            $methodStmt = $pdo->prepare("SELECT method_name FROM payment_methods WHERE method_code = ? LIMIT 1");
            $methodStmt->execute([$withdrawal['method_code']]);
            $method = $methodStmt->fetch(PDO::FETCH_ASSOC);
            if ($method && !empty($method['method_name'])) {
                $methodName = $method['method_name'];
            }
        }

        // === Template variables
        $vars = [
            '{first_name}'         => htmlspecialchars($user['first_name'] ?? '', ENT_QUOTES, 'UTF-8'),
            '{last_name}'          => htmlspecialchars($user['last_name'] ?? '', ENT_QUOTES, 'UTF-8'),
            '{amount}'             => number_format($withdrawal['amount'], 2) . ' €',
            '{reason}'             => htmlspecialchars($reason, ENT_QUOTES, 'UTF-8'),
            '{payment_method}'     => htmlspecialchars($methodName, ENT_QUOTES, 'UTF-8'),
            '{payment_details}'    => htmlspecialchars($withdrawal['payment_details'] ?? '', ENT_QUOTES, 'UTF-8'),
            '{reference}'          => htmlspecialchars($withdrawal['reference'] ?? 'WD-' . $withdrawal['id'], ENT_QUOTES, 'UTF-8'),
            '{transaction_id}'     => htmlspecialchars($withdrawal['reference'] ?? 'WD-' . $withdrawal['id'], ENT_QUOTES, 'UTF-8'),
            '{transaction_date}'   => date('Y-m-d H:i:s'),
            '{balance}'            => number_format($user['balance'] ?? 0, 2) . ' €',
            '{site_url}'           => $sys['site_url'] ?? 'https://kryptox.co.uk',
            '{site_name}'          => htmlspecialchars($sys['site_name'] ?? 'KryptoX', ENT_QUOTES, 'UTF-8'),
            '{surl}'               => $sys['site_url'] ?? 'https://kryptox.co.uk',
            '{sbrand}'             => htmlspecialchars($sys['site_name'] ?? 'KryptoX', ENT_QUOTES, 'UTF-8'),
            '{semail}'             => htmlspecialchars($sys['contact_email'] ?? 'info@kryptox.co.uk', ENT_QUOTES, 'UTF-8'),
            '{sphone}'             => htmlspecialchars($sys['contact_phone'] ?? '', ENT_QUOTES, 'UTF-8')
        ];

        $subject  = strtr($template['subject'], $vars);
        $htmlBody = strtr($template['content'], $vars);
        $textBody = strip_tags($htmlBody);

        // === Send email
        if ($phpMailerAvailable) {
            $mail = new PHPMailer(true);
            $mail->isSMTP();
            $mail->Host       = $smtp['host'];
            $mail->SMTPAuth   = true;
            $mail->Username   = $smtp['username'];
            $mail->Password   = $smtp['password'];
            $mail->SMTPSecure = ($smtp['encryption'] === 'ssl')
                ? PHPMailer::ENCRYPTION_SMTPS
                : PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port       = (int)$smtp['port'];
            $mail->CharSet    = 'UTF-8';
            $mail->Encoding   = 'base64';
            $mail->setFrom($smtp['from_email'], $smtp['from_name']);
            $mail->addAddress($user['email'], trim($user['first_name'] . ' ' . $user['last_name']));
            $mail->isHTML(true);
            $mail->Subject = $subject;
            $mail->Body    = $htmlBody;
            $mail->AltBody = $textBody;
            $mail->send();
        } else {
            $headers  = "MIME-Version: 1.0\r\n";
            $headers .= "Content-type:text/html;charset=UTF-8\r\n";
            $headers .= 'From: ' . $smtp['from_name'] . ' <' . $smtp['from_email'] . '>' . "\r\n";
            mail($user['email'], $subject, $htmlBody, $headers);
        }

        // === Log email
        $log = $pdo->prepare("
            INSERT INTO email_logs (template_id, recipient, subject, content, sent_at, status)
            VALUES (?, ?, ?, ?, NOW(), 'sent')
        ");
        $log->execute([$template['id'] ?? null, $user['email'], $subject, $htmlBody]);

    } catch (Exception $e) {
        error_log("Withdrawal rejection email failed: " . $e->getMessage());
    }
}
?>