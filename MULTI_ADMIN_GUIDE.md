# Multi-Admin Data Isolation Guide

## Overview

The admin panel now supports **multiple admin users** with **complete data isolation**. Each admin can only see and manage their own data:

- ✅ **Users** - Only users they created
- ✅ **Cases** - Only cases they created  
- ✅ **Logs** - Only their own activity logs
- ✅ **Other entities** - Similarly isolated by admin_id

## Features

### 1. Data Isolation by Admin ID

Each admin user is assigned a unique `admin_id` when they log in. This ID is stored in `$_SESSION['admin_id']` and used to filter all data queries.

**Tables with admin_id tracking:**
- `users` - `admin_id` column tracks which admin created the user
- `cases` - `admin_id` column tracks which admin created the case
- `admin_logs` - `admin_id` column tracks which admin performed the action
- `withdrawals` - `admin_id` column tracks which admin processed the withdrawal
- `deposits` - `admin_id` column tracks which admin processed the deposit
- `support_tickets` - `assigned_admin_id` tracks assignment
- `user_documents` - `reviewed_by_admin_id` tracks reviewer
- `case_recovery_transactions` - `added_by_admin_id` tracks who added recovery

### 2. Automatic Admin ID Assignment

When an admin creates a new entity, the system automatically assigns their `admin_id`:

**Example - Creating a user:**
```php
// admin_ajax/add_user.php
$data['admin_id'] = $_SESSION['admin_id'];  // Auto-assign current admin
$stmt = $pdo->prepare("INSERT INTO users (..., admin_id) VALUES (..., :admin_id)");
```

**Example - Creating a case:**
```php
// admin_ajax/add_case.php
$creatorAdminId = (int)$_SESSION['admin_id'];
$stmt = $pdo->prepare("INSERT INTO cases (..., admin_id) VALUES (..., :admin_id)");
```

### 3. Filtered Data Retrieval

All data retrieval queries are filtered by the current admin's ID:

**Example - Getting users:**
```php
// admin_ajax/get_users.php
$currentAdminId = (int)$_SESSION['admin_id'];
$query = "SELECT * FROM users WHERE admin_id = :admin_id AND status != 'suspended'";
```

**Example - Getting cases:**
```php
// admin_ajax/get_cases.php
$currentAdminId = (int)$_SESSION['admin_id'];
$query = "SELECT * FROM cases WHERE admin_id = :admin_id";
```

**Example - Getting logs:**
```php
// admin_ajax/get_admin_logs.php
$currentAdminId = (int)$_SESSION['admin_id'];
$query = "SELECT * FROM admin_logs WHERE admin_id = :admin_id";
```

## Installation

### Step 1: Run Database Migration

Execute the SQL migration to add necessary columns and indexes:

```bash
mysql -u your_username -p your_database < migration_multi_admin_support.sql
```

Or via phpMyAdmin:
1. Open phpMyAdmin
2. Select your database
3. Go to "SQL" tab
4. Copy and paste the contents of `migration_multi_admin_support.sql`
5. Click "Go"

### Step 2: Update Existing Records (Optional)

If you have existing users, cases, and logs without admin_id values, you may want to assign them to a default admin:

```sql
-- Assign all existing users to admin ID 1
UPDATE users SET admin_id = 1 WHERE admin_id IS NULL;

-- Assign all existing cases to admin ID 1
UPDATE cases SET admin_id = 1 WHERE admin_id IS NULL;

-- Note: admin_logs already has admin_id, so no update needed
```

### Step 3: Test the Feature

1. Log in as Admin 1
2. Create a test user
3. Create a test case
4. Log out
5. Log in as Admin 2
6. Verify you don't see Admin 1's users and cases
7. Create your own user and case
8. Verify you only see your own data

## Modified Files

### AJAX Endpoints Modified:
- ✅ `admin_ajax/add_user.php` - Sets admin_id on user creation
- ✅ `admin_ajax/add_case.php` - Sets admin_id on case creation
- ✅ `admin_ajax/get_users.php` - Filters users by admin_id
- ✅ `admin_ajax/get_cases.php` - Filters cases by admin_id
- ✅ `admin_ajax/get_admin_logs.php` - Filters logs by admin_id

### Database Schema:
- ✅ `migration_multi_admin_support.sql` - Adds admin_id columns and indexes

### Documentation:
- ✅ `MULTI_ADMIN_GUIDE.md` - This file

## Security Considerations

### 1. Session Security
The admin ID is stored in the session (`$_SESSION['admin_id']`) which is:
- Protected by `session_name('ADMINSESSID')` for separation from user sessions
- Uses `session.use_strict_mode` and `session.cookie_httponly` for security
- Regenerated periodically to prevent fixation attacks

### 2. SQL Injection Prevention
All queries use prepared statements with parameter binding:
```php
$stmt = $pdo->prepare("SELECT * FROM users WHERE admin_id = ?");
$stmt->execute([$currentAdminId]);
```

### 3. Authorization Checks
Every AJAX endpoint verifies the admin is logged in:
```php
if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}
```

### 4. Data Isolation Enforcement
Admin ID filtering is applied at the database query level, ensuring:
- Admins cannot bypass UI restrictions
- API calls are equally protected
- No cross-admin data leakage

## Advanced Configuration

### Super Admin Access (Optional)

If you want to create a "super admin" who can see all data, you can modify the queries:

```php
// Check if admin has super privileges
$isSuperAdmin = ($_SESSION['admin_role'] === 'super_admin');

// Apply filter conditionally
if (!$isSuperAdmin) {
    $query .= " WHERE admin_id = :admin_id";
    $params['admin_id'] = $currentAdminId;
}
```

Don't forget to add a `role` column to the `admins` table:
```sql
ALTER TABLE admins ADD COLUMN role ENUM('admin', 'super_admin') DEFAULT 'admin';
```

### Shared Resources

Some resources may need to be shared across admins (like scam platforms, cryptocurrencies):

- **scam_platforms** - Shared globally (no admin_id needed)
- **cryptocurrencies** - Shared globally (no admin_id needed)
- **email_templates** - Shared globally (no admin_id needed)
- **system_settings** - Shared globally (no admin_id needed)

These tables don't need admin_id filtering.

## Troubleshooting

### Issue: Users/Cases Not Showing Up

**Problem:** After migration, existing users or cases don't appear.

**Solution:** Assign them to your admin ID:
```sql
UPDATE users SET admin_id = YOUR_ADMIN_ID WHERE admin_id IS NULL;
UPDATE cases SET admin_id = YOUR_ADMIN_ID WHERE admin_id IS NULL;
```

### Issue: "Unauthorized" Error

**Problem:** AJAX requests return unauthorized errors.

**Solution:** Ensure you're logged in and session is active:
```php
// Check session
var_dump($_SESSION['admin_id']); // Should show your admin ID
```

### Issue: Logs Not Filtering

**Problem:** Seeing logs from other admins.

**Solution:** Verify the migration was applied correctly:
```sql
-- Check if admin_logs has index
SHOW INDEX FROM admin_logs WHERE Key_name = 'idx_admin_logs_admin_id';
```

## Benefits

### 1. Multi-Tenant Support
- Multiple admin users can work independently
- No data overlap or confusion
- Each admin has their own workspace

### 2. Data Privacy
- Sensitive user data is isolated per admin
- Prevents unauthorized access to other admins' clients
- Complies with data privacy regulations

### 3. Performance
- Indexes on admin_id improve query performance
- Smaller result sets mean faster page loads
- Efficient filtering at database level

### 4. Auditability
- Clear ownership of all data entities
- Easy to track which admin performed which action
- Accountability for data management

## Future Enhancements

Potential additions to the multi-admin system:

1. **Team/Group Support** - Allow admins to be grouped into teams that share data
2. **Delegation** - Allow admins to temporarily delegate access to specific users/cases
3. **Admin Hierarchy** - Create manager roles that can see subordinate admin data
4. **Data Transfer** - Transfer users/cases between admins
5. **Shared Cases** - Allow multiple admins to collaborate on specific cases

## Support

For issues or questions about multi-admin functionality:

1. Check this guide first
2. Review the modified AJAX files for implementation details
3. Verify database migration was applied successfully
4. Test with multiple admin accounts to isolate the issue

---

**Version:** 1.0  
**Last Updated:** 2026-01-18  
**Compatibility:** PHP 7.4+, MySQL 5.7+
