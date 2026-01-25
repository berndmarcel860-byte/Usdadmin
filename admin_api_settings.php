<?php
require_once 'admin_header.php';

// Get current API settings
$settings = [];
try {
    $stmt = $pdo->prepare("SELECT setting_key, setting_value FROM system_settings WHERE setting_key LIKE ?");
    $stmt->execute(["api_%"]);
    while ($row = $stmt->fetch()) {
        $settings[$row['setting_key']] = $row['setting_value'];
    }
} catch (PDOException $e) {
    error_log("Error fetching API settings: " . $e->getMessage());
}
?>

<div class="main-content">
    <div class="page-header">
        <h2>API Configuration</h2>
        <div class="header-sub-title">
            <nav class="breadcrumb breadcrumb-dash">
                <a href="admin_dashboard.php" class="breadcrumb-item"><i class="anticon anticon-home"></i> Dashboard</a>
                <span class="breadcrumb-item active">API Settings</span>
            </nav>
        </div>
    </div>
    
    <!-- API Status -->
    <div class="row">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-green">
                            <i class="anticon anticon-api"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">API Status</p>
                            <h5 class="mb-0 text-success">Active</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-blue">
                            <i class="anticon anticon-key"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Active Keys</p>
                            <h5 class="mb-0">5</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-cyan">
                            <i class="anticon anticon-line-chart"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Requests Today</p>
                            <h5 class="mb-0">12,453</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-gold">
                            <i class="anticon anticon-clock-circle"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Avg Response</p>
                            <h5 class="mb-0">245ms</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- API General Settings -->
    <div class="card">
        <div class="card-body">
            <h5>General API Settings</h5>
            <form id="apiGeneralForm" class="mt-4">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>API Enabled</label>
                            <select class="form-control" name="api_enabled">
                                <option value="yes" <?= ($settings['api_enabled'] ?? 'yes') == 'yes' ? 'selected' : '' ?>>Enabled</option>
                                <option value="no" <?= ($settings['api_enabled'] ?? '') == 'no' ? 'selected' : '' ?>>Disabled</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>API Version</label>
                            <select class="form-control" name="api_version">
                                <option value="v1" <?= ($settings['api_version'] ?? 'v1') == 'v1' ? 'selected' : '' ?>>Version 1.0</option>
                                <option value="v2" <?= ($settings['api_version'] ?? '') == 'v2' ? 'selected' : '' ?>>Version 2.0 (Beta)</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Rate Limit (requests per minute)</label>
                            <input type="number" class="form-control" name="api_rate_limit" 
                                   value="<?= htmlspecialchars($settings['api_rate_limit'] ?? '60') ?>">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>API Base URL</label>
                            <?php 
                            $apiBaseUrl = $settings['api_base_url'] ?? '';
                            if (empty($apiBaseUrl)) {
                                $apiBaseUrl = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https' : 'http') . 
                                             '://' . $_SERVER['HTTP_HOST'] . '/api';
                            }
                            ?>
                            <input type="text" class="form-control" name="api_base_url" 
                                   value="<?= htmlspecialchars($apiBaseUrl) ?>" readonly>
                        </div>
                    </div>
                </div>
                
                <div class="custom-control custom-switch mt-3">
                    <input type="checkbox" class="custom-control-input" id="apiLogging" name="api_logging" 
                           <?= ($settings['api_logging'] ?? '1') == '1' ? 'checked' : '' ?>>
                    <label class="custom-control-label" for="apiLogging">Enable API Request Logging</label>
                </div>
                
                <div class="custom-control custom-switch mt-2">
                    <input type="checkbox" class="custom-control-input" id="apiDocumentation" name="api_documentation" 
                           <?= ($settings['api_documentation'] ?? '1') == '1' ? 'checked' : '' ?>>
                    <label class="custom-control-label" for="apiDocumentation">Enable API Documentation</label>
                </div>
                
                <button type="submit" class="btn btn-primary mt-3">
                    <i class="anticon anticon-save"></i> Save General Settings
                </button>
            </form>
        </div>
    </div>
    
    <!-- CORS Settings -->
    <div class="card">
        <div class="card-body">
            <h5>CORS (Cross-Origin Resource Sharing)</h5>
            <form id="corsForm" class="mt-4">
                <div class="form-group">
                    <label>Allowed Origins (one per line)</label>
                    <textarea class="form-control" name="api_allowed_origins" rows="4" 
                              placeholder="https://example.com&#10;https://app.example.com"><?= htmlspecialchars($settings['api_allowed_origins'] ?? '') ?></textarea>
                    <small class="text-muted">Leave empty to allow all origins (*)</small>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Allowed Methods</label>
                            <select class="form-control" name="api_allowed_methods" multiple size="5">
                                <?php 
                                $allowedMethods = explode(',', $settings['api_allowed_methods'] ?? 'GET,POST,PUT,DELETE');
                                $methods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'];
                                foreach ($methods as $method):
                                ?>
                                <option value="<?= $method ?>" <?= in_array($method, $allowedMethods) ? 'selected' : '' ?>><?= $method ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Allowed Headers</label>
                            <textarea class="form-control" name="api_allowed_headers" rows="5" 
                                      placeholder="Content-Type&#10;Authorization"><?= htmlspecialchars($settings['api_allowed_headers'] ?? 'Content-Type,Authorization') ?></textarea>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="anticon anticon-save"></i> Save CORS Settings
                </button>
            </form>
        </div>
    </div>
    
    <!-- API Keys Management -->
    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5>API Keys</h5>
                <button class="btn btn-primary" data-toggle="modal" data-target="#generateKeyModal">
                    <i class="anticon anticon-plus"></i> Generate New Key
                </button>
            </div>
            
            <div class="alert alert-info">
                <i class="anticon anticon-info-circle"></i> API keys are used to authenticate requests to your API. Keep them secure and never share them publicly.
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Key Name</th>
                            <th>API Key</th>
                            <th>Created</th>
                            <th>Last Used</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Production Key</td>
                            <td><code>sk_live_*********************abc123</code></td>
                            <td><?= date('Y-m-d') ?></td>
                            <td>2 hours ago</td>
                            <td><span class="badge badge-success">Active</span></td>
                            <td>
                                <button class="btn btn-sm btn-danger">
                                    <i class="anticon anticon-delete"></i> Revoke
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Generate API Key Modal -->
<div class="modal fade" id="generateKeyModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Generate New API Key</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <i class="anticon anticon-close"></i>
                </button>
            </div>
            <form id="generateKeyForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Key Name</label>
                        <input type="text" class="form-control" name="key_name" placeholder="e.g., Production Key" required>
                    </div>
                    <div class="form-group">
                        <label>Permissions</label>
                        <select class="form-control" name="permissions" multiple size="4">
                            <option value="read">Read Access</option>
                            <option value="write">Write Access</option>
                            <option value="delete">Delete Access</option>
                            <option value="admin">Admin Access</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Generate Key</button>
                </div>
            </form>
        </div>
    </div>
</div>

<?php require_once 'admin_footer.php'; ?>

<script>
$(document).ready(function() {
    // General API settings form
    $('#apiGeneralForm').submit(function(e) {
        e.preventDefault();
        saveSettings($(this), 'api_general');
    });
    
    // CORS settings form
    $('#corsForm').submit(function(e) {
        e.preventDefault();
        saveSettings($(this), 'api_cors');
    });
    
    // Generate API key
    $('#generateKeyForm').submit(function(e) {
        e.preventDefault();
        toastr.info('API key generation functionality coming soon');
        $('#generateKeyModal').modal('hide');
    });
    
    function saveSettings(form, type) {
        const formData = form.serialize();
        
        $.post('admin_ajax/save_settings.php', formData + '&type=' + type)
        .done(function(response) {
            if (response.success) {
                toastr.success('Settings saved successfully');
            } else {
                toastr.error(response.message || 'Failed to save settings');
            }
        })
        .fail(function() {
            toastr.error('Failed to save settings');
        });
    }
});
</script>
