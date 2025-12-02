# Complete Email System Overview

This document provides a comprehensive overview of all email functionality in the admin panel.

---

## 1. Manual Email Sending (Admin Panel)

### Location
Admin Panel → Users Management → Mail Icon (📧)

### Features
- Send emails to individual users from the users table
- Choose between templates or custom content
- Automatic HTML wrapping for custom emails
- 13 variables for personalization

### Files
- `admin_users.php` - UI interface
- `admin_ajax/send_user_email.php` - Backend processing
- `admin_ajax/get_email_templates.php` - Template loading

### How to Use
1. Click mail icon on any user row
2. Write your message (no HTML needed)
3. Use variables like `{first_name}`, `{balance}`
4. Click Send
5. System automatically wraps in professional HTML template

### Variables Available
**User**: `{first_name}`, `{last_name}`, `{email}`, `{user_id}`, `{balance}`, `{status}`, `{registration_date}`, `{uuid}`, `{full_name}`
**Site**: `{site_url}`, `{site_name}`, `{contact_email}`, `{contact_phone}`

### Documentation
- `SEND_MAIL_FEATURE.md` - Complete usage guide
- `CUSTOM_EMAIL_GUIDE.md` - Examples and tips
- `CHANGES_SUMMARY.md` - Technical details

---

## 2. Automated Trial Notifications (Cron Job)

### Purpose
Automatically notify users about trial period status

### Schedule
Runs daily at 9:00 AM (configurable)

### Notifications Sent

#### A. Trial Expiring Soon (1 Day Before)
**When**: 24 hours before trial expires  
**Recipients**: Users with active trial packages  
**Subject**: "Ihre Testphase endet bald"  
**Content**:
- Warning about upcoming expiration
- Current balance
- What happens after expiry
- Upgrade call-to-action

#### B. Trial Expired (On Expiration)
**When**: On the day trial expires  
**Recipients**: Users with just-expired trials  
**Subject**: "Testphase beendet - Ihr Konto ist eingeschränkt"  
**Actions**:
- Updates package status to 'expired'
- Restricts account access
**Content**:
- Account restriction notice
- Can still: withdraw, access balance, view data
- To continue: subscribe to package
- Two buttons: Subscribe + Withdraw

### Files
- `cron_trial_notifications.php` - Main cron script
- `TRIAL_NOTIFICATIONS_SETUP.md` - Setup guide

### Setup
```bash
# Add to crontab
0 9 * * * /usr/bin/php /path/to/cron_trial_notifications.php
```

### Monitoring
```sql
-- Check sent trial emails
SELECT * FROM email_logs 
WHERE subject LIKE '%Testphase%' 
ORDER BY sent_at DESC LIMIT 10;

-- Check expired packages
SELECT * FROM user_packages 
WHERE status = 'expired' 
ORDER BY updated_at DESC;
```

---

## 3. Email Templates System

### Location
Admin Panel → Email Templates

### Features
- Create reusable email templates
- Define variables for each template
- Use templates in manual emails
- HTML content support

### Files
- `admin_email_templates.php` - Template management UI
- `admin_ajax/add_email_template.php` - Create templates
- `admin_ajax/update_email_template.php` - Edit templates
- `admin_ajax/get_email_templates.php` - Load templates
- `admin_ajax/delete_email_template.php` - Remove templates

### Template Structure
- **template_key**: Unique identifier
- **subject**: Email subject line
- **content**: HTML email body
- **variables**: JSON array of available variables

### Creating Templates
1. Go to Email Templates page
2. Click "Add Template"
3. Enter template key, subject, content
4. Add variables (JSON format)
5. Save

### Using Templates
Templates are available in:
- Manual email sending (dropdown)
- Custom code (via template_key)

---

## 4. Email Infrastructure

### SMTP Configuration
**Location**: Admin Panel → Settings → SMTP Settings

**Required Settings**:
- Host (e.g., smtp.gmail.com)
- Port (587 for TLS, 465 for SSL)
- Username
- Password
- Encryption (TLS/SSL)
- From email
- From name

**Database Table**: `smtp_settings`

### System Settings
**Location**: Admin Panel → Settings → System Settings

**Email-Related Settings**:
- Site URL
- Brand name
- Contact email
- Contact phone

**Database Table**: `system_settings`

### Email Logging
All emails are logged for tracking and debugging.

**Database Table**: `email_logs`

**Fields**:
- recipient
- subject
- content
- sent_at
- status
- template_id (if template used)

**Query Recent Emails**:
```sql
SELECT recipient, subject, sent_at, status
FROM email_logs
ORDER BY sent_at DESC
LIMIT 20;
```

---

## 5. Email HTML Templates

### Standard Template Structure
All emails use professional HTML templates with:

**Header**:
- Gradient background
- White text
- Subject as H1

**Content Area**:
- White background
- Responsive container (max 640px)
- Formatted text with variables

**Highlight Boxes**:
- Colored borders (blue, yellow, red, green)
- For important information
- Gradient backgrounds

**Buttons**:
- Call-to-action buttons
- Colored backgrounds
- Rounded corners

**Signature**:
- Logo image
- Company name
- Contact information
- Links to email and website

**Footer**:
- Copyright notice
- Company name
- Year

### Mobile Responsive
All templates are mobile-friendly:
- Flexible container width
- Scalable fonts
- Touch-friendly buttons
- Readable on small screens

---

## 6. Email Types Summary

| Email Type | Trigger | Frequency | Automation | Template |
|------------|---------|-----------|------------|----------|
| Custom Email | Manual (admin) | On-demand | No | Optional |
| Template Email | Manual (admin) | On-demand | No | Yes |
| Trial Expiring | Cron (1 day before) | Daily check | Yes | Built-in |
| Trial Expired | Cron (on expiry) | Daily check | Yes | Built-in |

---

## 7. Variables Reference

### Universal Variables (All Emails)
```
{first_name}       - User's first name
{last_name}        - User's last name
{full_name}        - Full name (first + last)
{email}            - User's email address
{user_id}          - User's database ID
{uuid}             - User's unique identifier
{balance}          - Account balance (formatted)
{status}           - Account status
{registration_date} - Registration date
{site_url}         - Website URL
{site_name}        - Brand/company name
{contact_email}    - Support email
{contact_phone}    - Support phone
```

### Trial-Specific Variables
```
{package_name}     - Package/plan name
{end_date}         - Package expiration date
```

---

## 8. Database Schema

### Tables Used

**email_templates**
- Template definitions
- Reusable email content

**smtp_settings**
- SMTP server configuration
- Email sending credentials

**system_settings**
- Site branding and URLs
- Contact information

**email_logs**
- Sent email tracking
- Delivery status

**user_packages**
- Package assignments
- Trial status tracking

**users**
- User information
- Email addresses

---

## 9. Workflow Diagrams

### Manual Email Workflow
```
Admin clicks mail icon
    ↓
Modal opens
    ↓
Admin writes message
    ↓
System wraps in HTML template
    ↓
Variables replaced
    ↓
Email sent via SMTP
    ↓
Logged in database
```

### Automated Trial Workflow
```
Cron runs daily (9 AM)
    ↓
Query for expiring trials (tomorrow)
    ↓
Send warning emails
    ↓
Query for expired trials (today)
    ↓
Update status to 'expired'
    ↓
Send expiration emails
    ↓
Log all actions
```

---

## 10. Maintenance

### Daily Tasks
- ✅ Cron job runs automatically
- ✅ Emails sent automatically
- ✅ Status updated automatically

### Weekly Tasks
- Check email logs for failures
- Review expired trial count
- Monitor SMTP performance

### Monthly Tasks
- Clean old email logs (optional)
- Review email templates
- Update contact information if needed

### Monitoring Queries

**Check email activity**:
```sql
SELECT DATE(sent_at) as date, COUNT(*) as emails_sent
FROM email_logs
WHERE sent_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
GROUP BY DATE(sent_at)
ORDER BY date DESC;
```

**Check trial expirations**:
```sql
SELECT COUNT(*) as expiring_soon
FROM user_packages up
JOIN packages p ON up.package_id = p.id
WHERE up.status = 'active'
AND DATE(up.end_date) = DATE_ADD(CURDATE(), INTERVAL 1 DAY)
AND p.price = 0;
```

**Check SMTP errors**:
```sql
SELECT * FROM email_logs
WHERE status = 'failed'
ORDER BY sent_at DESC
LIMIT 10;
```

---

## 11. Troubleshooting

### Emails Not Sending

**Check**:
1. SMTP settings configured correctly
2. PHPMailer installed (vendor directory)
3. Firewall allows SMTP port
4. SMTP credentials valid
5. Check email_logs for errors

### Variables Not Replacing

**Check**:
1. Variable name spelling
2. Curly braces format: `{variable}`
3. User data exists in database
4. System settings configured

### Cron Not Running

**Check**:
1. Cron job added: `crontab -l`
2. PHP path correct: `which php`
3. File permissions: `chmod 644 cron_trial_notifications.php`
4. Test manually: `php cron_trial_notifications.php`
5. Check cron logs: `tail -f /var/log/cron`

### HTML Not Rendering

**Check**:
1. Email client supports HTML
2. Template has proper DOCTYPE
3. Inline CSS used (no external)
4. Images accessible (full URLs)

---

## 12. Security

### Email Security
- ✅ SMTP credentials stored in database (encrypted connection)
- ✅ HTML content sanitized
- ✅ XSS protection in admin panel
- ✅ Email validation before sending
- ✅ No sensitive data in logs
- ✅ Admin authentication required

### Best Practices
- Use strong SMTP password
- Enable 2FA on email account
- Monitor sent emails regularly
- Don't expose SMTP settings
- Keep PHPMailer updated
- Use TLS/SSL encryption

---

## 13. Performance

### Optimization
- Emails sent asynchronously when possible
- Cron batches multiple emails
- Database queries optimized
- Email logs can be archived

### Limits
- Cron sends one batch per run
- No rate limiting (SMTP server dependent)
- Email logs grow over time (consider cleanup)

### Scaling
- For high volume: Consider queue system
- For faster delivery: Increase cron frequency
- For reliability: Monitor logs regularly

---

## 14. Support

### Documentation Files
1. `SEND_MAIL_FEATURE.md` - Manual email sending
2. `CUSTOM_EMAIL_GUIDE.md` - Custom email examples
3. `TRIAL_NOTIFICATIONS_SETUP.md` - Cron setup
4. `CHANGES_SUMMARY.md` - Technical changes
5. `EMAIL_SYSTEM_OVERVIEW.md` - This file

### Getting Help
1. Check documentation first
2. Review email logs for errors
3. Test SMTP settings manually
4. Check PHP error logs
5. Verify database records

---

## Summary

The email system consists of:
- ✅ **Manual sending** from admin panel
- ✅ **Automated trial notifications** via cron
- ✅ **Template management** system
- ✅ **HTML email formatting** automatic
- ✅ **Variable replacement** for personalization
- ✅ **Email logging** for tracking
- ✅ **Professional design** mobile-responsive

All components work together to provide a complete email communication system.
