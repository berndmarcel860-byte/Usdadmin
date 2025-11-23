<?php
require_once '../admin_session.php';
require_once '../mail_functions.php';

header('Content-Type: application/json');

try {
    // Validate required fields
    $requiredFields = ['user_id', 'subject', 'content'];
    $missingFields = [];
    
    foreach ($requiredFields as $field) {
        if (empty($_POST[$field])) {
            $missingFields[] = $field;
        }
    }
    
    if (!empty($missingFields)) {
        throw new Exception('Missing required fields: ' . implode(', ', $missingFields));
    }
    
    $userId = (int)$_POST['user_id'];
    $subject = trim($_POST['subject']);
    $content = $_POST['content'];
    $templateId = !empty($_POST['template_id']) ? (int)$_POST['template_id'] : null;
    
    // Get user details
    $stmt = $pdo->prepare("
        SELECT id, email, first_name, last_name, uuid, balance, status, created_at
        FROM users 
        WHERE id = ?
    ");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        throw new Exception('User not found');
    }
    
    // Validate email
    if (!filter_var($user['email'], FILTER_VALIDATE_EMAIL)) {
        throw new Exception('Invalid email address for user');
    }
    
    // Prepare variables for replacement
    $variables = [
        'user_id' => $user['id'],
        'uuid' => $user['uuid'],
        'email' => $user['email'],
        'first_name' => $user['first_name'],
        'last_name' => $user['last_name'],
        'full_name' => $user['first_name'] . ' ' . $user['last_name'],
        'balance' => number_format($user['balance'], 2),
        'status' => $user['status'],
        'registration_date' => date('Y-m-d', strtotime($user['created_at']))
    ];
    
    // Get site settings for additional variables
    $stmt = $pdo->query("SELECT * FROM system_settings LIMIT 1");
    $settings = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($settings) {
        $variables['site_url'] = $settings['site_url'] ?? 'https://kryptox.co.uk';
        $variables['site_name'] = $settings['brand_name'] ?? 'KryptoX';
        $variables['contact_email'] = $settings['contact_email'] ?? 'info@kryptox.co.uk';
        $variables['contact_phone'] = $settings['contact_phone'] ?? '';
    } else {
        $variables['site_url'] = 'https://kryptox.co.uk';
        $variables['site_name'] = 'KryptoX';
        $variables['contact_email'] = 'info@kryptox.co.uk';
        $variables['contact_phone'] = '';
    }
    
    // Replace variables in subject and content
    foreach ($variables as $key => $value) {
        $subject = str_replace(['{' . $key . '}', '{{' . $key . '}}'], $value, $subject);
        $content = str_replace(['{' . $key . '}', '{{' . $key . '}}'], $value, $content);
    }
    
    // Initialize mailer
    try {
        $mailer = new Mailer($pdo);
        
        // Use PHPMailer directly for custom content
        $mail = new PHPMailer\PHPMailer\PHPMailer(true);
        
        // Load SMTP settings
        $stmt = $pdo->query("SELECT * FROM smtp_settings LIMIT 1");
        $smtpSettings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$smtpSettings) {
            throw new Exception('SMTP settings not configured');
        }
        
        // Configure mailer
        $mail->isSMTP();
        $mail->Host = $smtpSettings['host'];
        $mail->SMTPAuth = true;
        $mail->Username = $smtpSettings['username'];
        $mail->Password = $smtpSettings['password'];
        $mail->SMTPSecure = $smtpSettings['encryption'] ?? 'tls';
        $mail->Port = $smtpSettings['port'] ?? 587;
        $mail->CharSet = 'UTF-8';
        
        $fromEmail = $smtpSettings['from_email'] ?? $smtpSettings['username'];
        $fromName = $smtpSettings['from_name'] ?? 'KryptoX Admin';
        
        $mail->setFrom($fromEmail, $fromName);
        $mail->addAddress($user['email'], $user['first_name'] . ' ' . $user['last_name']);
        $mail->isHTML(true);
        $mail->Subject = $subject;
        $mail->Body = $content;
        
        // Create text version
        $textContent = strip_tags(str_replace(
            ['<br>', '<br/>', '<br />', '</p>', '</div>'], 
            "\n", 
            $content
        ));
        $mail->AltBody = $textContent;
        
        // Send email
        if (!$mail->send()) {
            throw new Exception('Failed to send email: ' . $mail->ErrorInfo);
        }
        
        // Log email to database
        $stmt = $pdo->prepare("
            INSERT INTO email_logs (
                template_id,
                recipient,
                subject,
                content,
                sent_at,
                status
            ) VALUES (?, ?, ?, ?, NOW(), 'sent')
        ");
        
        $stmt->execute([
            $templateId,
            $user['email'],
            $subject,
            $content
        ]);
        
        // Log admin action
        $stmt = $pdo->prepare("
            INSERT INTO admin_logs (
                admin_id,
                action,
                entity_type,
                entity_id,
                details,
                ip_address,
                user_agent
            ) VALUES (?, 'send_email', 'user', ?, ?, ?, ?)
        ");
        
        $stmt->execute([
            $_SESSION['admin_id'],
            $userId,
            'Sent email: ' . $subject,
            $_SERVER['REMOTE_ADDR'] ?? '',
            $_SERVER['HTTP_USER_AGENT'] ?? ''
        ]);
        
        echo json_encode([
            'success' => true,
            'message' => 'Email sent successfully to ' . $user['email']
        ]);
        
    } catch (Exception $e) {
        error_log("Email sending error: " . $e->getMessage());
        throw new Exception('Failed to send email: ' . $e->getMessage());
    }
    
} catch (Exception $e) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>
