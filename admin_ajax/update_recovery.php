<?php 
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

ini_set('display_errors', 0);
error_reporting(E_ALL);

$phpMailerAvailable = false;
if (file_exists(__DIR__ . '/../../vendor/autoload.php')) {
    require_once __DIR__ . '/../../vendor/autoload.php';
    $phpMailerAvailable = true;
}

require_once '../admin_session.php';
require_once '../mail_functions.php';
header('Content-Type: application/json');

if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'Admin not logged in']);
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);
if (empty($data['case_id']) || !is_numeric($data['case_id']) || empty($data['amount']) || !is_numeric($data['amount'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid case ID or amount']);
    exit();
}

// Determine currency type from the request or default to 'fiat'
$currencyType = $data['currency_type'] ?? 'fiat';
$cryptoCurrencyId = $data['crypto_currency_id'] ?? null;

try {
    $pdo->beginTransaction();

    // === 1️⃣ Get case & user ===
    $stmt = $pdo->prepare("
        SELECT c.id, c.user_id, c.reported_amount, c.case_number, c.status, c.currency_type,
               c.crypto_reported_amount, c.crypto_recovered_amount, c.crypto_currency_id,
               cr.symbol AS crypto_symbol, cr.code AS crypto_code, cr.name AS crypto_name,
               u.email, u.first_name, u.last_name
        FROM cases c
        JOIN users u ON c.user_id = u.id
        LEFT JOIN cryptocurrencies cr ON c.crypto_currency_id = cr.id
        WHERE c.id = ?
    ");
    $stmt->execute([$data['case_id']]);
    $case = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$case) throw new Exception('Case not found');

    // === 2️⃣ Get admin info ===
    $stmt = $pdo->prepare("SELECT first_name, last_name FROM admins WHERE id = ?");
    $stmt->execute([$_SESSION['admin_id']]);
    $admin = $stmt->fetch(PDO::FETCH_ASSOC);

    // === 3️⃣ Validation: not exceeding amount ===
    $newAmount = (float)$data['amount'];
    
    if ($case['currency_type'] === 'crypto' && $case['crypto_reported_amount']) {
        // For crypto cases
        $stmt = $pdo->prepare("SELECT SUM(crypto_amount) FROM case_recovery_transactions WHERE case_id = ? AND currency_type = 'crypto'");
        $stmt->execute([$data['case_id']]);
        $alreadyRecovered = (float)$stmt->fetchColumn();
        $reportedAmount = (float)$case['crypto_reported_amount'];
        $totalAfter = $alreadyRecovered + $newAmount;
        
        if ($totalAfter > $reportedAmount) {
            throw new Exception('Total recovered cannot exceed reported amount');
        }
    } else {
        // For fiat cases
        $stmt = $pdo->prepare("SELECT SUM(amount) FROM case_recovery_transactions WHERE case_id = ? AND (currency_type = 'fiat' OR currency_type IS NULL)");
        $stmt->execute([$data['case_id']]);
        $alreadyRecovered = (float)$stmt->fetchColumn();
        $reportedAmount = (float)$case['reported_amount'];
        $totalAfter = $alreadyRecovered + $newAmount;
        
        if ($totalAfter > $reportedAmount) {
            throw new Exception('Total recovered cannot exceed reported amount');
        }
    }

    // === 4️⃣ Record recovery transaction ===
    if ($case['currency_type'] === 'crypto' && $case['crypto_reported_amount']) {
        // Insert crypto recovery
        $stmt = $pdo->prepare("
            INSERT INTO case_recovery_transactions (case_id, amount, crypto_amount, crypto_currency_id, currency_type, processed_by, notes)
            VALUES (:case_id, 0, :crypto_amount, :crypto_currency_id, 'crypto', :admin_id, :notes)
        ");
        $stmt->execute([
            ':case_id' => $data['case_id'],
            ':crypto_amount' => $newAmount,
            ':crypto_currency_id' => $case['crypto_currency_id'],
            ':admin_id' => $_SESSION['admin_id'],
            ':notes' => $data['notes'] ?? null
        ]);
        
        // Update case crypto_recovered_amount
        $stmt = $pdo->prepare("UPDATE cases SET crypto_recovered_amount = :recovered WHERE id = :id");
        $stmt->execute([':recovered' => $totalAfter, ':id' => $data['case_id']]);
    } else {
        // Insert fiat recovery
        $stmt = $pdo->prepare("
            INSERT INTO case_recovery_transactions (case_id, amount, currency_type, processed_by, notes)
            VALUES (:case_id, :amount, 'fiat', :admin_id, :notes)
        ");
        $stmt->execute([
            ':case_id' => $data['case_id'],
            ':amount' => $newAmount,
            ':admin_id' => $_SESSION['admin_id'],
            ':notes' => $data['notes'] ?? null
        ]);
    }

    // === 5️⃣ Send recovery update email ===
    $emailSent = sendRecoveryUpdateEmail(
        $pdo, $case, $data['case_id'], $newAmount, $totalAfter,
        $reportedAmount, $data, $admin
    );

    // === 6️⃣ Audit log ===
    $stmt = $pdo->prepare("
        INSERT INTO audit_logs (admin_id, action, entity_type, entity_id, new_value, ip_address, user_agent)
        VALUES (:admin_id, :action, :entity_type, :entity_id, :new_value, :ip_address, :user_agent)
    ");
    $stmt->execute([
        ':admin_id' => $_SESSION['admin_id'],
        ':action' => 'recovery_added',
        ':entity_type' => 'case',
        ':entity_id' => $data['case_id'],
        ':new_value' => json_encode([
            'amount' => $newAmount,
            'email_sent' => $emailSent,
            'template_used' => 'recovery_amount_updated'
        ]),
        ':ip_address' => $_SERVER['REMOTE_ADDR'],
        ':user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? ''
    ]);

    $pdo->commit();

    // === 7️⃣ 🔔 Create user notification ===
    try {
        $amountDisplay = '';
        if ($case['currency_type'] === 'crypto' && $case['crypto_reported_amount']) {
            $cryptoSymbol = $case['crypto_symbol'] ?? $case['crypto_code'] ?? 'CRYPTO';
            $amountDisplay = number_format($newAmount, 8) . ' ' . $cryptoSymbol;
        } else {
            $amountDisplay = '$' . number_format($newAmount, 2);
        }
        
        $stmt = $pdo->prepare("
            INSERT INTO user_notifications (user_id, title, message, type, related_entity, related_id, created_at)
            VALUES (:user_id, :title, :message, :type, :entity, :rel_id, NOW())
        ");
        $stmt->execute([
            ':user_id' => (int)$case['user_id'],
            ':title' => 'Rückerstattungs-Update für Ihren Fall',
            ':message' => 'Ein Betrag von <strong>' . $amountDisplay .
                '</strong> wurde erfolgreich zu Ihrem Fall <strong>' . htmlspecialchars($case['case_number']) . '</strong> hinzugefügt.',
            ':type' => 'success',
            ':entity' => 'case',
            ':rel_id' => $case['case_number']
        ]);
    } catch (Exception $e) {
        error_log("User notification failed: " . $e->getMessage());
    }

    // === 8️⃣ 🧭 Create admin notification ===
    try {
        $amountDisplay = '';
        if ($case['currency_type'] === 'crypto' && $case['crypto_reported_amount']) {
            $cryptoSymbol = $case['crypto_symbol'] ?? $case['crypto_code'] ?? 'CRYPTO';
            $amountDisplay = number_format($newAmount, 8) . ' ' . $cryptoSymbol;
        } else {
            $amountDisplay = '$' . number_format($newAmount, 2);
        }
        
        $stmt = $pdo->prepare("
            INSERT INTO admin_notifications (admin_id, title, message, type, is_read, created_at)
            VALUES (:admin_id, :title, :message, :type, 0, NOW())
        ");
        $stmt->execute([
            ':admin_id' => (int)$_SESSION['admin_id'],
            ':title' => 'Neue Rückerstattung registriert',
            ':message' => 'Eine Rückerstattung von <strong>' . $amountDisplay .
                '</strong> wurde dem Fall <strong>' . htmlspecialchars($case['case_number']) . '</strong> hinzugefügt.',
            ':type' => 'success'
        ]);
    } catch (Exception $e) {
        error_log("Admin notification failed: " . $e->getMessage());
    }

    // === 9️⃣ Response ===
    echo json_encode([
        'success' => true,
        'message' => 'Recovery amount updated successfully',
        'data' => [
            'case_id' => $data['case_id'],
            'case_number' => $case['case_number'],
            'new_amount' => $newAmount,
            'total_recovered' => $totalAfter,
            'remaining_amount' => $reportedAmount - $totalAfter,
            'email_sent' => $emailSent,
            'currency_type' => $case['currency_type']
        ]
    ]);

} catch (Exception $e) {
    $pdo->rollBack();
    error_log('Recovery update error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Failed to update recovery amount', 'error' => $e->getMessage()]);
}

/**
 * 📧 Send recovery update email notification
 */
function sendRecoveryUpdateEmail($pdo, $userData, $caseId, $newAmount, $totalAfter, $reportedAmount, $updateData, $adminData) {
    global $phpMailerAvailable;
    try {
        $trackingToken = bin2hex(random_bytes(16));
        $templateStmt = $pdo->prepare("SELECT * FROM email_templates WHERE template_key = 'recovery_amount_updated' LIMIT 1");
        $templateStmt->execute();
        $template = $templateStmt->fetch(PDO::FETCH_ASSOC);
        if (!$template) throw new Exception("Email template not found");

        $smtpStmt = $pdo->prepare("SELECT * FROM smtp_settings WHERE is_active = 1 LIMIT 1");
        $smtpStmt->execute();
        $smtp = $smtpStmt->fetch(PDO::FETCH_ASSOC);
        if (!$smtp) throw new Exception("No active SMTP config");

        $systemStmt = $pdo->prepare("SELECT * FROM system_settings WHERE id = 1");
        $systemStmt->execute();
        $system = $systemStmt->fetch(PDO::FETCH_ASSOC);

        // Format amounts based on currency type
        $currencySymbol = '';
        $amountPrecision = 2;
        if ($userData['currency_type'] === 'crypto' && isset($userData['crypto_symbol'])) {
            $currencySymbol = ' ' . $userData['crypto_symbol'];
            $amountPrecision = 8;
        } else {
            $currencySymbol = ' $';
        }
        
        $vars = [
            '{first_name}' => $userData['first_name'],
            '{last_name}' => $userData['last_name'],
            '{user_name}' => $userData['first_name'].' '.$userData['last_name'],
            '{case_number}' => $userData['case_number'],
            '{case_id}' => $caseId,
            '{reported_amount}' => number_format($reportedAmount, $amountPrecision, ',', '.') . $currencySymbol,
            '{recovered_amount}' => number_format($newAmount, $amountPrecision, ',', '.') . $currencySymbol,
            '{total_recovered}' => number_format($totalAfter, $amountPrecision, ',', '.') . $currencySymbol,
            '{remaining_amount}' => number_format($reportedAmount - $totalAfter, $amountPrecision, ',', '.') . $currencySymbol,
            '{recovery_notes}' => $updateData['notes'] ?? 'Keine zusätzlichen Anmerkungen',
            '{recovery_date}' => date('d.m.Y H:i:s'),
            '{processed_by}' => $adminData ? ($adminData['first_name'].' '.$adminData['last_name']) : 'System',
            '{current_year}' => date('Y'),
            '{site_name}' => $system['site_name'] ?? 'ScamRecovery',
            '{support_email}' => $system['contact_email'] ?? 'support@your-site.com'
        ];

        $subject = str_replace(array_keys($vars), array_values($vars), $template['subject']);
        $body = str_replace(array_keys($vars), array_values($vars), $template['content']);
        $pixel = '<img src="'.$system['site_url'].'/track.php?token='.$trackingToken.'" width="1" height="1" alt="" style="display:none;" />';
        $body = str_replace('</body>', $pixel.'</body>', $body);

        if ($phpMailerAvailable) {
            $mail = new PHPMailer(true);
            $mail->isSMTP();
            $mail->Host = $smtp['host'];
            $mail->SMTPAuth = true;
            $mail->Username = $smtp['username'];
            $mail->Password = $smtp['password'];
            $mail->SMTPSecure = $smtp['encryption'] === 'ssl' ? PHPMailer::ENCRYPTION_SMTPS : PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = $smtp['port'];
$mail->CharSet = 'UTF-8';
            $mail->Encoding = 'base64';
            $mail->setFrom($smtp['from_email'], $smtp['from_name']);
            $mail->addAddress($userData['email'], $userData['first_name'].' '.$userData['last_name']);
            $mail->isHTML(true);
            $mail->Subject = $subject;
            $mail->Body = $body;
            $mail->AltBody = strip_tags($body);
            $mail->send();
        }

        // Log success
        $log = $pdo->prepare("INSERT INTO email_logs (template_id, recipient, subject, content, sent_at, status, tracking_token) VALUES (?, ?, ?, ?, NOW(), 'sent', ?)");
        $log->execute([$template['id'], $userData['email'], $subject, $body, $trackingToken]);
        return true;

    } catch (Exception $e) {
        error_log("Recovery email failed: " . $e->getMessage());
        return false;
    }
}
?>
