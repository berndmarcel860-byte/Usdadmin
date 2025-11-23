# Trial Period Notification System - Setup Guide

## Overview
Automated email notification system that monitors trial period packages and sends emails when:
1. Trial is expiring tomorrow (1-day warning)
2. Trial has expired (same day notification + account restriction)

## Features

### 1. Trial Expiring Soon Email (1 Day Before)
**When**: Sent 1 day before trial expires  
**Recipient**: Users with active trial packages  
**Content**:
- Warning that trial ends tomorrow
- Current balance information
- What happens after expiry
- Call-to-action to upgrade to paid package

### 2. Trial Expired Email (On Expiration)
**When**: Sent on the day trial expires  
**Recipient**: Users whose trial just expired  
**Actions**:
- Automatically updates package status from 'active' to 'expired'
- Restricts account access (users need to subscribe to continue)
- Sends detailed email with options

**Content**:
- Notification that trial has ended
- Account is now restricted
- User can still:
  - Access their balance
  - Withdraw funds
  - View recovery data
- To continue full access: Subscribe to a package
- Clear call-to-action buttons

## Installation

### Step 1: Upload the Cron Script
Upload `cron_trial_notifications.php` to your server:
```bash
/path/to/your/website/cron_trial_notifications.php
```

### Step 2: Set Up Cron Job

#### Option A: Using cPanel
1. Log into cPanel
2. Navigate to "Cron Jobs"
3. Add new cron job:
   - **Minute**: 0
   - **Hour**: 9 (9:00 AM)
   - **Day**: *
   - **Month**: *
   - **Weekday**: *
   - **Command**: `/usr/bin/php /home/username/public_html/cron_trial_notifications.php`
4. Save

#### Option B: Using Command Line (SSH)
```bash
crontab -e
```

Add this line:
```
0 9 * * * /usr/bin/php /path/to/your/website/cron_trial_notifications.php
```

Save and exit.

#### Option C: Using Plesk
1. Go to "Scheduled Tasks"
2. Click "Add Task"
3. Set schedule: Daily at 9:00 AM
4. Command: `/usr/bin/php /path/to/your/website/cron_trial_notifications.php`
5. Save

### Step 3: Verify PHP Path
Find your PHP binary path:
```bash
which php
```

Common paths:
- `/usr/bin/php`
- `/usr/local/bin/php`
- `/opt/cpanel/ea-php74/root/usr/bin/php` (cPanel)

Update the cron command with the correct path.

### Step 4: Test the Script

#### Manual Test Run
```bash
php /path/to/cron_trial_notifications.php
```

#### Check Logs
The script logs to PHP error log. Check:
```bash
tail -f /var/log/php_errors.log
```

Or your server's error log location.

Expected output:
```
Trial Notifications Cron: Starting at 2025-11-23 09:00:00
Trial Notifications Cron: Found 2 trials expiring tomorrow
Trial Notifications: Expiring email sent to user@example.com
Trial Notifications Cron: Found 1 expired trials
Trial Notifications: Expired email sent to user2@example.com
Trial Notifications Cron: Completed successfully
```

## Configuration

### Email Settings
The script uses settings from your database:
- **SMTP Settings**: `smtp_settings` table
- **System Settings**: `system_settings` table (for site URL, name, contact info)

Ensure these are configured in your admin panel.

### Schedule Customization
Change the cron schedule based on your needs:

**Every hour:**
```
0 * * * * /usr/bin/php /path/to/cron_trial_notifications.php
```

**Twice daily (9 AM and 5 PM):**
```
0 9,17 * * * /usr/bin/php /path/to/cron_trial_notifications.php
```

**Every 6 hours:**
```
0 */6 * * * /usr/bin/php /path/to/cron_trial_notifications.php
```

## How It Works

### Detection Logic

#### Trial Expiring Tomorrow:
```sql
SELECT users with trial packages
WHERE package status = 'active'
AND end_date = tomorrow
AND package price = 0 (free trial)
```

#### Trial Expired Today:
```sql
SELECT users with trial packages
WHERE package status = 'active'
AND end_date <= today
AND package price = 0 (free trial)
```

### Actions Performed

**For Expiring Trials:**
1. Query database for trials expiring in 24 hours
2. Send warning email to each user
3. Log email in `email_logs` table

**For Expired Trials:**
1. Query database for expired trials (status still 'active')
2. Update `user_packages` status to 'expired'
3. Send expiration notification email
4. Log email in `email_logs` table

## Email Templates

### Trial Expiring Email
**Subject**: Ihre Testphase endet bald - [Site Name]

**Key Points**:
- Trial ending date and time
- Current balance
- What happens after expiry
- Benefits of upgrading
- "Upgrade Now" button

### Trial Expired Email
**Subject**: Testphase beendet - Ihr Konto ist eingeschränkt - [Site Name]

**Key Points**:
- Trial has ended
- Account is restricted
- Can still: withdraw, access balance, view data
- To continue: subscribe to package
- "Subscribe Now" button
- "Withdraw Balance" button

## Database Tables Used

### `user_packages`
- **id**: Package assignment ID
- **user_id**: User ID
- **package_id**: Package ID
- **start_date**: When package started
- **end_date**: When package expires
- **status**: active, expired, pending, cancelled

### `packages`
- **id**: Package ID
- **name**: Package name
- **price**: Package price (0 = trial)
- **duration_days**: Duration in days

### `users`
- **id**: User ID
- **email**: Email address
- **first_name**: First name
- **last_name**: Last name
- **balance**: Account balance

### `email_logs`
- Logs all sent emails for tracking

## Monitoring

### Check Cron Execution
View cron log:
```bash
grep CRON /var/log/syslog
```

Or:
```bash
tail -f /var/log/cron
```

### Check Email Logs
Query database:
```sql
SELECT * FROM email_logs 
WHERE subject LIKE '%Testphase%' 
ORDER BY sent_at DESC 
LIMIT 10;
```

### Check Package Status Updates
```sql
SELECT u.email, up.status, up.end_date, p.name
FROM user_packages up
JOIN users u ON up.user_id = u.id
JOIN packages p ON up.package_id = p.id
WHERE p.price = 0
AND up.status = 'expired'
ORDER BY up.updated_at DESC;
```

## Troubleshooting

### Cron Not Running
**Problem**: Emails not being sent

**Solutions**:
1. Check cron is active: `service cron status`
2. Verify cron syntax: `crontab -l`
3. Check PHP path: `which php`
4. Test script manually: `php cron_trial_notifications.php`
5. Check file permissions: `chmod +x cron_trial_notifications.php`

### Emails Not Sending
**Problem**: Script runs but no emails

**Check**:
1. SMTP settings configured: Check `smtp_settings` table
2. PHPMailer installed: Check vendor directory
3. Error logs: Check PHP error log
4. Test SMTP manually from admin panel

### Wrong Email Content
**Problem**: Variables not replaced

**Check**:
1. System settings in database
2. User data complete (first_name, last_name, email)
3. Package data exists

### Emails Sent Multiple Times
**Problem**: Duplicate emails

**Solution**:
- Ensure cron runs only once per day
- Check crontab for duplicate entries: `crontab -l`
- Add locking mechanism if needed

## Variables Available in Emails

The script automatically replaces these variables:

**User Variables**:
- `{first_name}` - User's first name
- `{last_name}` - User's last name
- `{email}` - User's email
- `{balance}` - User's balance (formatted)

**System Variables**:
- `{site_url}` - Website URL
- `{site_name}` - Brand/site name
- `{contact_email}` - Support email

**Package Variables**:
- `{package_name}` - Trial package name
- `{end_date}` - Package expiry date

## Advanced Configuration

### Multiple Warning Emails
To send warnings at 3 days and 1 day before expiry, modify the query:

```php
// 3 days before
$threeDays = (clone $now)->add(new DateInterval('P3D'));
$stmt = $pdo->prepare("... WHERE DATE(up.end_date) = DATE(:three_days)");
$stmt->execute([':three_days' => $threeDays->format('Y-m-d')]);

// 1 day before (existing)
$tomorrow = (clone $now)->add(new DateInterval('P1D'));
// ... existing code
```

### Custom Email Templates
Store templates in `email_templates` table and load dynamically:

```php
$stmt = $pdo->prepare("SELECT content FROM email_templates WHERE template_key = 'trial_expiring'");
$stmt->execute();
$template = $stmt->fetch(PDO::FETCH_ASSOC);
```

### Notification Preferences
Add user preference field to control notifications:

```sql
ALTER TABLE users ADD COLUMN email_notifications TINYINT(1) DEFAULT 1;
```

Then in script:
```php
WHERE u.email_notifications = 1
```

## Security Considerations

1. **File Permissions**: Set appropriate permissions
   ```bash
   chmod 644 cron_trial_notifications.php
   ```

2. **Error Logging**: Don't log sensitive data
   - Email addresses in logs: OK
   - Passwords: Never
   - Full email content: Optional

3. **SMTP Credentials**: Stored securely in database
   - Not in cron script
   - Not in version control

4. **Rate Limiting**: Script naturally limited by cron schedule
   - Runs once per day
   - No risk of overwhelming mail server

## Support

For issues or questions:
1. Check logs first
2. Test script manually
3. Verify database records
4. Check SMTP settings
5. Contact support with error details

## Version History

**v1.0** - Initial Release
- Daily cron job
- Expiring warning (1 day)
- Expired notification
- Status update to 'expired'
- HTML email templates
- Error logging
