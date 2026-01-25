# Multi-Admin Data Isolation & Role-Based Access Control Guide

## Overview

The admin panel now supports **multiple admin users** with **complete data isolation** and **role-based access control**. The system has two role types:

### Role Types

#### 1. Superadmin (`role = 'superadmin'`)
- ✅ **Full System Access** - Can view ALL data across all admins
- ✅ **Users** - Can see all users in the system
- ✅ **Cases** - Can see all cases across all admins
- ✅ **Logs** - Can see all admin activity logs
- ✅ **No Filtering** - No admin_id restrictions applied

#### 2. Admin (`role = 'admin'`)
- ✅ **Limited Access** - Can only view their own data
- ✅ **Users** - Only users they created (filtered by admin_id)
- ✅ **Cases** - Only cases they created (filtered by admin_id)
- ✅ **Logs** - Only their own activity logs (filtered by admin_id)
- ✅ **Data Isolation** - Strict admin_id filtering enforced

## Features

### 1. Role-Based Data Filtering

### 2. Data Isolation by Admin ID (for regular admins)

For regular admin users (not superadmin), each admin is assigned a unique `admin_id` when they log in. This ID is stored in `$_SESSION['admin_id']` and used to filter all data queries.

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

### Step 2: Set Admin Roles

Assign roles to your admin users. You need at least one superadmin:

```sql
-- Make specific admin a superadmin (can see all data)
UPDATE admins SET role = 'superadmin' WHERE id = 1;

-- Set other admins as regular admins (see only their data)
UPDATE admins SET role = 'admin' WHERE id != 1;

-- Or update all NULL roles to 'admin' by default
UPDATE admins SET role = 'admin' WHERE role IS NULL OR role = '';
```

### Step 3: Update Existing Records (Optional)

If you have existing users, cases, and logs without admin_id values, you may want to assign them to a default admin:

```sql
-- Assign all existing users to admin ID 1
UPDATE users SET admin_id = 1 WHERE admin_id IS NULL;

-- Assign all existing cases to admin ID 1
UPDATE cases SET admin_id = 1 WHERE admin_id IS NULL;

-- Note: admin_logs already has admin_id, so no update needed
```

### Step 4: Test the Feature

**Test Superadmin:**
1. Log in as the superadmin account (role='superadmin')
2. Verify you can see ALL users and cases in the system
3. Create a test user and case

**Test Regular Admin:**
1. Log out and log in as a regular admin (role='admin')
2. Verify you only see users/cases created by your admin account
3. Verify you DON'T see the superadmin's test data
4. Create your own user and case
5. Verify data isolation is working correctly

## Modified Files

### AJAX Endpoints Modified:
- ✅ `admin_ajax/add_user.php` - Sets admin_id on user creation
- ✅ `admin_ajax/add_case.php` - Sets admin_id on case creation
- ✅ `admin_ajax/get_users.php` - Role-based filtering (superadmin sees all, admin sees own)
- ✅ `admin_ajax/get_cases.php` - Role-based filtering (superadmin sees all, admin sees own)
- ✅ `admin_ajax/get_admin_logs.php` - Role-based filtering (superadmin sees all, admin sees own)

### Frontend Pages Modified:
- ✅ `admin_cases.php` - User dropdown filtered by role (superadmin sees all users, admin sees only their users)

### Session Variables:
- ✅ `$_SESSION['admin_role']` - Stores 'superadmin' or 'admin'
- ✅ `$_SESSION['admin_id']` - Stores current admin's ID

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

### Role-Based Access Control (RBAC)

The system now includes built-in role-based access control with two roles:

**Superadmin (`role = 'superadmin'`):**
- Full system access
- Can view ALL users, cases, and logs
- No data filtering applied
- Ideal for: System administrators, managers

**Admin (`role = 'admin'`):**
- Limited access to own data only
- Can only view users/cases they created
- Strict admin_id filtering enforced
- Ideal for: Individual admins, team members

**Implementation Example:**
```php
// Check role and apply filtering
$currentAdminRole = $_SESSION['admin_role'] ?? 'admin';

if ($currentAdminRole === 'superadmin') {
    // No filtering - see all data
    $query = "SELECT * FROM users WHERE status != 'suspended'";
} else {
    // Filter by admin_id - see only own data
    $query = "SELECT * FROM users WHERE status != 'suspended' AND admin_id = :admin_id";
}
```

### Changing Admin Roles

To promote an admin to superadmin or demote them:

```sql
-- Promote admin ID 5 to superadmin
UPDATE admins SET role = 'superadmin' WHERE id = 5;

-- Demote admin ID 5 back to regular admin
UPDATE admins SET role = 'admin' WHERE id = 5;
```

**Note:** The role change takes effect on next login (session refresh required).

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
var_dump($_SESSION['admin_role']); // Should show 'admin' or 'superadmin'
```

### Issue: Admin Can't See Any Data

**Problem:** Regular admin user logs in but sees no users or cases.

**Solution:**  
1. Check if admin_id is set correctly when creating entities
2. Verify the admin has created some users/cases
3. Check role is set to 'admin' (not NULL)
4. If brand new admin, they won't see data until they create some

### Issue: Superadmin Seeing Filtered Data

**Problem:** Superadmin is seeing filtered data instead of all data.

**Solution:**
1. Verify role is exactly 'superadmin': `SELECT id, email, role FROM admins WHERE id = YOUR_ID;`
2. Check session variable: Log out and log back in to refresh `$_SESSION['admin_role']`
3. Ensure role was set before login: `UPDATE admins SET role = 'superadmin' WHERE id = YOUR_ID;`

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
