# Testing Checklist for Send Mail Feature

## Prerequisites
- [ ] Admin panel is accessible and functional
- [ ] At least one user exists in the users table
- [ ] At least one email template exists in email_templates table
- [ ] SMTP settings are configured correctly
- [ ] Admin has valid login credentials

## Manual Testing Steps

### 1. Access Feature
- [ ] Log into admin panel
- [ ] Navigate to Users Management page (admin_users.php)
- [ ] Verify users table loads correctly
- [ ] Locate the mail icon (📧) in the Actions column for each user

### 2. Open Send Mail Modal
- [ ] Click the mail icon for a test user
- [ ] Modal should open with title "Send Email to User"
- [ ] Recipient field should be pre-filled with user's name and email
- [ ] Template dropdown should show "Custom Email (No Template)" and list of templates
- [ ] Subject field should be empty
- [ ] Message field should be empty

### 3. Test Template Selection
- [ ] Select an email template from the dropdown
- [ ] Verify subject field auto-fills with template subject
- [ ] Verify message field auto-fills with template content
- [ ] Check if "Available Variables" section appears (if template has variables)
- [ ] Verify variables are displayed correctly

### 4. Test Custom Email
- [ ] Select "Custom Email (No Template)" from dropdown
- [ ] Subject and message fields should clear
- [ ] Enter custom subject: "Test Email"
- [ ] Enter custom message: "Hello {first_name}, this is a test email for {email}"
- [ ] Verify hint text shows available variables

### 5. Send Email - Success Case
- [ ] With template or custom content filled in
- [ ] Click "Send Email" button
- [ ] Confirm in the confirmation dialog
- [ ] Wait for response
- [ ] Should see success toast message: "Email sent successfully to [email]"
- [ ] Modal should close automatically
- [ ] Check email_logs table: New entry should exist with status 'sent'
- [ ] Check admin_logs table: New entry should exist with action 'send_email'
- [ ] If SMTP is working: Check recipient's inbox for the email

### 6. Variable Replacement Verification
- [ ] Send email with template containing variables
- [ ] Check received email or email_logs table
- [ ] Verify all variables were replaced:
  - {first_name} → User's first name
  - {last_name} → User's last name
  - {email} → User's email
  - {balance} → User's balance (formatted)
  - {user_id} → User's ID
  - {site_url} → Site URL from settings
  - {site_name} → Site name from settings

### 7. Error Handling - Missing Fields
- [ ] Open send mail modal
- [ ] Leave subject empty
- [ ] Try to send
- [ ] Should show validation error (browser validation)
- [ ] Fill subject, clear message
- [ ] Try to send
- [ ] Should show validation error

### 8. Error Handling - Invalid User
- [ ] Try to manipulate user_id in browser console to non-existent ID
- [ ] Try to send
- [ ] Should show error message: "User not found"

### 9. XSS Protection Test
- [ ] Create a user with name containing HTML: `<script>alert('xss')</script>`
- [ ] Click mail icon for that user
- [ ] Verify no script executes
- [ ] Verify name is properly escaped in recipient field

### 10. HTML Content Test
- [ ] Select or create template with HTML content (bold, links, etc.)
- [ ] Send email
- [ ] Verify HTML is preserved in email_logs
- [ ] If receiving email: Verify HTML renders correctly

### 11. Multiple Templates Test
- [ ] Open modal
- [ ] Select template A
- [ ] Verify content loads
- [ ] Switch to template B
- [ ] Verify content changes to template B
- [ ] Switch to "Custom Email"
- [ ] Verify content clears

### 12. Close and Reopen
- [ ] Open send mail modal for user A
- [ ] Close without sending
- [ ] Open send mail modal for user B
- [ ] Verify recipient changed to user B
- [ ] Verify form fields are reset

### 13. Permission Test (if applicable)
- [ ] Log in as admin with limited permissions (if role system exists)
- [ ] Try to access send mail feature
- [ ] Should be allowed/denied based on permissions

## Database Verification

### Email Logs Table
```sql
SELECT * FROM email_logs ORDER BY id DESC LIMIT 5;
```
Expected: Recent entries with correct recipient, subject, content, status='sent'

### Admin Logs Table
```sql
SELECT * FROM admin_logs WHERE action = 'send_email' ORDER BY id DESC LIMIT 5;
```
Expected: Entries tracking admin_id, entity_type='user', entity_id, details

## Expected Results Summary

### Success Indicators:
- ✅ Modal opens and closes smoothly
- ✅ Templates load and populate fields correctly
- ✅ Variables are replaced with actual user data
- ✅ Email is logged in email_logs table
- ✅ Admin action is logged in admin_logs table
- ✅ Success toast appears
- ✅ No JavaScript console errors
- ✅ No PHP errors in server logs

### Known Limitations:
- Actual email delivery depends on SMTP configuration
- If SMTP fails, email is still logged as 'sent' in database (consider this for future improvement)

## Troubleshooting

### Email not appearing in recipient inbox?
1. Check SMTP settings are correct
2. Check spam/junk folder
3. Check server PHP error log for PHPMailer errors
4. Verify SMTP credentials and permissions

### Template not loading?
1. Check browser console for JavaScript errors
2. Verify email_templates table has data
3. Check admin_ajax/get_email_templates.php returns data
4. Test directly: `curl https://yourdomain.com/admin_ajax/get_email_templates.php`

### Modal not opening?
1. Check for JavaScript errors in browser console
2. Verify jQuery and Bootstrap are loaded
3. Check DataTables is initialized correctly

### Variables not replacing?
1. Verify variable format matches: `{variable_name}`
2. Check send_user_email.php has correct variable mappings
3. Check email_logs table to see if replacement happened

## Test Report Template

```
Test Date: [DATE]
Tester: [NAME]
Environment: [DEV/STAGING/PROD]

Results:
- Feature Access: [PASS/FAIL]
- Modal Functionality: [PASS/FAIL]
- Template Selection: [PASS/FAIL]
- Email Sending: [PASS/FAIL]
- Variable Replacement: [PASS/FAIL]
- Error Handling: [PASS/FAIL]
- Security (XSS): [PASS/FAIL]
- Database Logging: [PASS/FAIL]

Issues Found:
1. [Issue description]
2. [Issue description]

Notes:
[Additional observations]
```
