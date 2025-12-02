# Send Mail to Users Feature

## Overview
This feature allows administrators to send custom emails to individual users directly from the Users Management page. The feature integrates with the existing email template system and supports variable replacement for personalization.

## How to Use

### 1. Access the Feature
1. Navigate to the **Users Management** page (`admin_users.php`)
2. In the users table, find the user you want to email
3. Click the **green mail icon** (📧) in the Actions column

### 2. Compose Email
A modal will open with the following options:

- **Recipient**: Pre-filled with the selected user's name and email (read-only)
- **Email Template**: Select from existing templates or choose "Custom Email (No Template)"
- **Subject**: Email subject line (auto-filled if template is selected)
- **Message**: Email content (auto-filled if template is selected)
- **Available Variables**: Shows variables that can be used in the email

### 3. Using Email Templates
When you select a template from the dropdown:
- Subject and content are automatically loaded
- Available variables for that template are displayed
- You can still edit the subject and content after loading a template

### 4. Variable Replacement
The following variables are automatically replaced when sending the email:

**User-specific variables:**
- `{user_id}` - User's database ID
- `{uuid}` - User's UUID
- `{email}` - User's email address
- `{first_name}` - User's first name
- `{last_name}` - User's last name
- `{full_name}` - User's full name (first + last)
- `{balance}` - User's account balance (formatted)
- `{status}` - User's account status
- `{registration_date}` - Date user registered

**System variables:**
- `{site_url}` - Website URL
- `{site_name}` - Site/brand name
- `{contact_email}` - Support email
- `{contact_phone}` - Support phone number

### 5. Send the Email
1. Review the email content
2. Click the **"Send Email"** button
3. Confirm the action in the confirmation dialog
4. Wait for success/error message

## Technical Details

### Files Added/Modified

1. **admin_users.php**
   - Added mail icon button in actions column
   - Added send mail modal
   - Added JavaScript handlers for email functionality

2. **admin_ajax/send_user_email.php** (NEW)
   - Backend API endpoint for sending emails
   - Handles variable replacement
   - Integrates with PHPMailer and SMTP settings
   - Logs emails to `email_logs` table
   - Logs admin actions to `admin_logs` table

3. **admin_ajax/get_email_templates.php**
   - Updated to support both GET and POST requests
   - GET requests return simple list of templates
   - POST requests continue to support DataTables

### Database Tables Used

- `users` - To fetch user details
- `email_templates` - To load template content
- `smtp_settings` - For email server configuration
- `system_settings` - For site-wide variables
- `email_logs` - To log sent emails
- `admin_logs` - To track admin actions

### Security Features

- HTML escaping for user data in data attributes
- Email validation before sending
- Admin authentication required
- SMTP authentication via configured settings
- XSS protection in modal
- Action logging for audit trail

## Troubleshooting

### Email not sending?
1. Check SMTP settings in Admin Panel → Settings → SMTP Settings
2. Verify SMTP credentials are correct
3. Check server PHP error logs for detailed error messages
4. Ensure PHPMailer library is installed (`vendor/phpmailer`)

### Variables not being replaced?
- Ensure you're using the correct format: `{variable_name}`
- Both `{variable}` and `{{variable}}` formats are supported
- Variables are case-sensitive

### Template not loading?
1. Verify email templates exist in `email_templates` table
2. Check browser console for JavaScript errors
3. Ensure admin has permission to access templates

## Email Template Examples

### Example 1: Welcome Email
```
Subject: Welcome to {site_name}, {first_name}!

Dear {first_name} {last_name},

Welcome to {site_name}! Your account has been successfully created.

Account Details:
- Email: {email}
- Registration Date: {registration_date}
- Current Balance: {balance}

You can access your account at: {site_url}

If you have any questions, please contact us at {contact_email}

Best regards,
{site_name} Team
```

### Example 2: Account Update Notification
```
Subject: Account Update - Action Required

Hello {first_name},

We're writing to inform you about an important update to your account.

Your current account status: {status}
Account balance: {balance}

Please log in to your account to review the details: {site_url}

If you have any concerns, contact support at {contact_email}

Thank you,
{site_name} Support Team
```

## Best Practices

1. **Use Templates**: Create reusable templates for common email types
2. **Test First**: Send test emails to yourself before bulk sending
3. **Personalize**: Always use variables to personalize emails
4. **Clear Subject**: Use clear, descriptive subject lines
5. **Professional Tone**: Maintain a professional and friendly tone
6. **Contact Info**: Always include contact information
7. **Review Before Sending**: Double-check content before clicking send

## Future Enhancements

Potential improvements for future versions:
- Bulk email sending to multiple users
- Email scheduling
- Email templates with rich text editor
- Email attachments support
- Email open tracking
- Click tracking for links
- Email preview before sending
- Email drafts/templates per admin
