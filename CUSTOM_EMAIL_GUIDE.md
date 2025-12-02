# Custom Email Guide - Simplified Workflow

## Overview
Custom emails are now super simple! Just write your message text, and the system automatically wraps it in a professional HTML template.

---

## How to Send a Custom Email

### Step 1: Click Mail Icon
Click the green mail icon (📧) on any user row in the Users Management page.

### Step 2: Write Your Message
The modal opens with "Custom Email (No Template)" selected by default.

Just type your message in the textarea. For example:
```
Hello!

We wanted to inform you that your account status has been updated.

Your current balance is {balance} and your account is {status}.

If you have any questions, please contact us.
```

### Step 3: Click Send
That's it! The system automatically wraps your message in the professional HTML template.

---

## What Happens Automatically

### Your Input:
```
Hello!

We wanted to inform you that your account status has been updated.

Your current balance is {balance} and your account is {status}.

If you have any questions, please contact us.
```

### Email Received by User:
```html
<!DOCTYPE html>
<html>
<head>
  <style>
    /* Professional styling with gradient header, containers, etc. */
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>Your Subject Here</h1>
    </div>

    <div class="content">
      <p>Sehr geehrte/r John Doe,</p>

      Hello!

      We wanted to inform you that your account status has been updated.

      Your current balance is 1,234.56 and your account is active.

      If you have any questions, please contact us.

      <p>Mit freundlichen Grüßen,</p>

      <div class="signature">
        <img src="https://kryptox.co.uk/assets/img/logo.png">
        <strong>KryptoX Team</strong><br>
        Davidson House Forbury Square, Reading, RG1 3EU, UNITED KINGDOM<br>
        E: info@kryptox.co.uk | W: https://kryptox.co.uk
      </div>
    </div>

    <div class="footer">
      © 2025 KryptoX. Alle Rechte vorbehalten.
    </div>
  </div>
</body>
</html>
```

---

## Available Variables

You can use any of these variables in your message:

### User Variables:
- `{first_name}` → John
- `{last_name}` → Doe
- `{full_name}` → John Doe
- `{email}` → john.doe@example.com
- `{user_id}` → 123
- `{uuid}` → abc-123-def
- `{balance}` → 1,234.56
- `{status}` → active
- `{registration_date}` → 2025-01-15

### Site Variables:
- `{site_url}` → https://kryptox.co.uk
- `{site_name}` → KryptoX
- `{contact_email}` → info@kryptox.co.uk
- `{contact_phone}` → +49...

---

## HTML Template Features

The automatic wrapper includes:

### 1. Professional Header
- Gradient background (blue to cyan)
- White text
- Subject displayed as H1

### 2. Content Container
- White background
- Rounded corners
- Shadow effect
- Responsive (mobile-friendly)

### 3. Greeting
- Automatically adds: "Sehr geehrte/r {first_name} {last_name},"

### 4. Your Message
- Your text content goes here
- All variables are replaced

### 5. Signature Section
- Company logo
- Company name
- Address
- Contact email and website links

### 6. Footer
- Copyright notice with current year
- Company name

---

## Tips for Writing Messages

### Use Line Breaks
Separate paragraphs with blank lines:
```
First paragraph here.

Second paragraph here.

Third paragraph here.
```

### Use Variables
Make it personal:
```
Hello {first_name}!

Your balance of {balance} is now available.
```

### Add Emphasis
You can use simple HTML tags if needed:
```
Your account is <strong>active</strong>.

Please <a href="{site_url}/login.php">login here</a>.
```

### Create Lists
Use HTML for lists:
```
Important updates:
<ul>
  <li>Balance: {balance}</li>
  <li>Status: {status}</li>
  <li>Last login: Today</li>
</ul>
```

---

## Comparison: Custom vs Template Emails

### Custom Email (Simplified):
- **Input**: Just message text
- **Output**: Automatically wrapped in HTML template
- **Use Case**: Quick messages to individual users
- **Effort**: Minimal - just type and send

### Template Email:
- **Input**: Full HTML template with styling
- **Output**: Sent as-is
- **Use Case**: Consistent branded communications
- **Effort**: Medium - select template, maybe edit

---

## Examples

### Example 1: Balance Update
**Your Input**:
```
Subject: Balance Update

Your current balance has been updated to {balance}.

This change is effective immediately.
```

**User Receives**: Professional HTML email with gradient header, your message, signature, footer.

---

### Example 2: Account Notification
**Your Input**:
```
Subject: Account Status Change

Your account status has changed to {status}.

Current details:
- Balance: {balance}
- Registration date: {registration_date}
- Account ID: {user_id}

Please contact us if you have questions.
```

**User Receives**: Fully formatted HTML email.

---

### Example 3: Welcome Message
**Your Input**:
```
Subject: Welcome to KryptoX!

Welcome aboard {first_name}!

We're excited to have you with us. Your account is now set up and ready to use.

Your account details:
- Email: {email}
- Balance: {balance}
- Status: {status}

<a href="{site_url}/login.php" style="color: #007bff;">Click here to log in</a>
```

**User Receives**: Beautiful HTML email with all styling applied.

---

## Technical Details

### How It Works:
1. You write message in textarea
2. Hidden field `use_html_wrapper` is set to `1`
3. Backend receives your content
4. Backend wraps content in HTML template
5. Variables are replaced
6. Email is sent via SMTP

### When NOT to Use:
- If you need complete control over HTML structure
- If you're sending a specific branded template
- Solution: Select a template from dropdown instead

### When to Use:
- Quick personal messages
- Individual user communications
- Simple notifications
- Any message where you just want to write text

---

## Troubleshooting

### Variables Not Replacing?
- Make sure you use correct format: `{variable_name}`
- Check spelling of variable names
- Variables are case-sensitive

### Email Looks Plain?
- Make sure "Custom Email (No Template)" is selected
- If template is selected, it won't wrap automatically
- Check that email client supports HTML

### Formatting Issues?
- Use `<p>` tags for paragraphs
- Use `<br>` for line breaks
- Use `<strong>` for bold
- Use `<a href="">` for links

---

## Summary

**Before**: Had to write full HTML template with all styling
**Now**: Just write your message, system handles all formatting

This makes sending custom emails much faster and easier while maintaining a professional appearance!
