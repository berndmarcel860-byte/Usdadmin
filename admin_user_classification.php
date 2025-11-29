<?php
// admin_user_classification.php
// User Classification Dashboard - Classify users by onboarding, package status, etc.

require_once 'admin_header.php';

// Get classification statistics
try {
    // Total users
    $totalUsers = $pdo->query("SELECT COUNT(*) FROM users")->fetchColumn();
    
    // Users with onboarding
    $withOnboarding = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM user_onboarding")->fetchColumn();
    $withCompletedOnboarding = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM user_onboarding WHERE completed = 1")->fetchColumn();
    $withoutOnboarding = $totalUsers - $withOnboarding;
    
    // Users with packages
    $withPackage = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM user_packages")->fetchColumn();
    $withActivePackage = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM user_packages WHERE status = 'active'")->fetchColumn();
    $withExpiredPackage = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM user_packages WHERE status = 'expired'")->fetchColumn();
    $withoutPackage = $totalUsers - $withPackage;
    
    // Users with cases
    $withCases = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM cases")->fetchColumn();
    $withActiveCases = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM cases WHERE status IN ('open', 'documents_required', 'under_review')")->fetchColumn();
    $withoutCases = $totalUsers - $withCases;
    
    // KYC Status
    $withKYC = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM kyc_verification_requests")->fetchColumn();
    $kycApproved = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM kyc_verification_requests WHERE status = 'approved'")->fetchColumn();
    $kycPending = $pdo->query("SELECT COUNT(DISTINCT user_id) FROM kyc_verification_requests WHERE status = 'pending'")->fetchColumn();
    
} catch (PDOException $e) {
    $totalUsers = $withOnboarding = $withoutOnboarding = $withPackage = $withoutPackage = 0;
    $withCases = $withoutCases = $withKYC = $kycApproved = $kycPending = 0;
}
?>

<div class="main-content">
    <div class="page-header">
        <h2 class="header-title">User Classification</h2>
        <div class="header-sub-title">
            <nav class="breadcrumb breadcrumb-dash">
                <a href="admin_dashboard.php" class="breadcrumb-item"><i class="anticon anticon-home"></i> Dashboard</a>
                <a href="admin_users.php" class="breadcrumb-item">Users</a>
                <span class="breadcrumb-item active">Classification</span>
            </nav>
        </div>
    </div>
    
    <!-- Summary Stats -->
    <div class="row">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="media align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-blue">
                            <i class="anticon anticon-team"></i>
                        </div>
                        <div class="m-l-15">
                            <h2 class="m-b-0"><?= number_format($totalUsers) ?></h2>
                            <p class="m-b-0 text-muted">Total Users</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="media align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-green">
                            <i class="anticon anticon-check-circle"></i>
                        </div>
                        <div class="m-l-15">
                            <h2 class="m-b-0"><?= number_format($withCompletedOnboarding) ?></h2>
                            <p class="m-b-0 text-muted">Onboarding Complete</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="media align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-cyan">
                            <i class="anticon anticon-gift"></i>
                        </div>
                        <div class="m-l-15">
                            <h2 class="m-b-0"><?= number_format($withActivePackage) ?></h2>
                            <p class="m-b-0 text-muted">Active Packages</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="media align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-gold">
                            <i class="anticon anticon-folder-open"></i>
                        </div>
                        <div class="m-l-15">
                            <h2 class="m-b-0"><?= number_format($withActiveCases) ?></h2>
                            <p class="m-b-0 text-muted">Active Cases</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Classification Cards -->
    <div class="row">
        <!-- Onboarding Classification -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title"><i class="anticon anticon-form text-primary"></i> Onboarding Status</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-success-light mb-2">
                                <h3 class="text-success"><?= number_format($withCompletedOnboarding) ?></h3>
                                <p class="mb-0">Completed Onboarding</p>
                                <a href="#" class="btn btn-sm btn-success mt-2 filter-users" data-filter="onboarding_completed">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-warning-light mb-2">
                                <h3 class="text-warning"><?= number_format($withOnboarding - $withCompletedOnboarding) ?></h3>
                                <p class="mb-0">Incomplete Onboarding</p>
                                <a href="#" class="btn btn-sm btn-warning mt-2 filter-users" data-filter="onboarding_incomplete">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-danger-light">
                                <h3 class="text-danger"><?= number_format($withoutOnboarding) ?></h3>
                                <p class="mb-0">No Onboarding</p>
                                <a href="#" class="btn btn-sm btn-danger mt-2 filter-users" data-filter="no_onboarding">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-info-light">
                                <h3 class="text-info"><?= number_format($withOnboarding) ?></h3>
                                <p class="mb-0">Has Onboarding (Any)</p>
                                <a href="#" class="btn btn-sm btn-info mt-2 filter-users" data-filter="has_onboarding">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Package Classification -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title"><i class="anticon anticon-gift text-success"></i> Package Status</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-success-light mb-2">
                                <h3 class="text-success"><?= number_format($withActivePackage) ?></h3>
                                <p class="mb-0">Active Package</p>
                                <a href="#" class="btn btn-sm btn-success mt-2 filter-users" data-filter="package_active">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-danger-light mb-2">
                                <h3 class="text-danger"><?= number_format($withExpiredPackage) ?></h3>
                                <p class="mb-0">Expired Package</p>
                                <a href="#" class="btn btn-sm btn-danger mt-2 filter-users" data-filter="package_expired">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-secondary-light">
                                <h3 class="text-secondary"><?= number_format($withoutPackage) ?></h3>
                                <p class="mb-0">No Package</p>
                                <a href="#" class="btn btn-sm btn-secondary mt-2 filter-users" data-filter="no_package">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-primary-light">
                                <h3 class="text-primary"><?= number_format($withPackage) ?></h3>
                                <p class="mb-0">Has Package (Any)</p>
                                <a href="#" class="btn btn-sm btn-primary mt-2 filter-users" data-filter="has_package">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <!-- Cases Classification -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title"><i class="anticon anticon-folder-open text-warning"></i> Cases Status</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-warning-light mb-2">
                                <h3 class="text-warning"><?= number_format($withActiveCases) ?></h3>
                                <p class="mb-0">Active Cases</p>
                                <a href="#" class="btn btn-sm btn-warning mt-2 filter-users" data-filter="cases_active">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-success-light mb-2">
                                <h3 class="text-success"><?= number_format($withCases) ?></h3>
                                <p class="mb-0">Has Cases (Any)</p>
                                <a href="#" class="btn btn-sm btn-success mt-2 filter-users" data-filter="has_cases">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-secondary-light">
                                <h3 class="text-secondary"><?= number_format($withoutCases) ?></h3>
                                <p class="mb-0">No Cases</p>
                                <a href="#" class="btn btn-sm btn-secondary mt-2 filter-users" data-filter="no_cases">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- KYC Classification -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title"><i class="anticon anticon-safety-certificate text-info"></i> KYC Verification</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-success-light mb-2">
                                <h3 class="text-success"><?= number_format($kycApproved) ?></h3>
                                <p class="mb-0">KYC Approved</p>
                                <a href="#" class="btn btn-sm btn-success mt-2 filter-users" data-filter="kyc_approved">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-warning-light mb-2">
                                <h3 class="text-warning"><?= number_format($kycPending) ?></h3>
                                <p class="mb-0">KYC Pending</p>
                                <a href="#" class="btn btn-sm btn-warning mt-2 filter-users" data-filter="kyc_pending">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-secondary-light">
                                <h3 class="text-secondary"><?= number_format($totalUsers - $withKYC) ?></h3>
                                <p class="mb-0">No KYC Submitted</p>
                                <a href="#" class="btn btn-sm btn-secondary mt-2 filter-users" data-filter="no_kyc">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 text-center border rounded bg-info-light">
                                <h3 class="text-info"><?= number_format($withKYC) ?></h3>
                                <p class="mb-0">Has KYC (Any)</p>
                                <a href="#" class="btn btn-sm btn-info mt-2 filter-users" data-filter="has_kyc">
                                    View Users <i class="anticon anticon-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Users List Section -->
    <div class="card" id="usersListCard" style="display: none;">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h4 class="card-title" id="filterTitle">Users</h4>
            <button class="btn btn-sm btn-secondary" id="clearFilter">
                <i class="anticon anticon-close"></i> Clear Filter
            </button>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="classificationUsersTable" class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Balance</th>
                            <th>Onboarding</th>
                            <th>Package</th>
                            <th>Cases</th>
                            <th>KYC</th>
                            <th>Registered</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<style>
.bg-success-light { background-color: rgba(40, 199, 111, 0.1); }
.bg-warning-light { background-color: rgba(255, 159, 67, 0.1); }
.bg-danger-light { background-color: rgba(234, 84, 85, 0.1); }
.bg-info-light { background-color: rgba(0, 188, 212, 0.1); }
.bg-primary-light { background-color: rgba(63, 81, 181, 0.1); }
.bg-secondary-light { background-color: rgba(145, 158, 171, 0.1); }
</style>

<script>
$(document).ready(function() {
    var currentFilter = '';
    var table = null;
    
    // Filter users click
    $('.filter-users').click(function(e) {
        e.preventDefault();
        currentFilter = $(this).data('filter');
        var filterTitle = $(this).closest('.p-3').find('p').text();
        
        $('#filterTitle').text('Users: ' + filterTitle);
        $('#usersListCard').show();
        
        // Initialize or reload DataTable
        if (table) {
            table.destroy();
        }
        
        table = $('#classificationUsersTable').DataTable({
            processing: true,
            serverSide: true,
            ajax: {
                url: 'admin_ajax/get_classified_users.php',
                type: 'POST',
                data: function(d) {
                    d.classification = currentFilter;
                }
            },
            order: [[0, 'desc']],
            columns: [
                { data: 'id' },
                { data: null, render: data => data.first_name + ' ' + data.last_name },
                { data: 'email' },
                { 
                    data: 'status',
                    render: data => {
                        const cls = {active:'success', suspended:'warning', banned:'danger'}[data] || 'secondary';
                        return `<span class="badge badge-${cls}">${data}</span>`;
                    }
                },
                { data: 'balance', render: d => '€' + parseFloat(d || 0).toFixed(2) },
                { 
                    data: 'has_onboarding',
                    render: d => d == '1' ? '<span class="badge badge-success">Yes</span>' : '<span class="badge badge-secondary">No</span>'
                },
                { 
                    data: 'package_status',
                    render: d => {
                        if (!d) return '<span class="badge badge-secondary">None</span>';
                        const cls = {active:'success', pending:'warning', expired:'danger'}[d] || 'secondary';
                        return `<span class="badge badge-${cls}">${d}</span>`;
                    }
                },
                { 
                    data: 'cases_count',
                    render: d => d > 0 ? `<span class="badge badge-info">${d}</span>` : '<span class="badge badge-secondary">0</span>'
                },
                { 
                    data: 'kyc_status',
                    render: d => {
                        if (!d) return '<span class="badge badge-secondary">None</span>';
                        const cls = {approved:'success', pending:'warning', rejected:'danger'}[d] || 'secondary';
                        return `<span class="badge badge-${cls}">${d}</span>`;
                    }
                },
                { data: 'created_at', render: d => new Date(d).toLocaleDateString('de-DE') },
                {
                    data: null,
                    orderable: false,
                    render: data => `
                        <div class="btn-group">
                            <a href="admin_users.php?view=${data.id}" class="btn btn-sm btn-info" title="View Details">
                                <i class="anticon anticon-eye"></i>
                            </a>
                            <a href="admin_user_packages.php?user_id=${data.id}" class="btn btn-sm btn-primary" title="Manage Package">
                                <i class="anticon anticon-gift"></i>
                            </a>
                        </div>
                    `
                }
            ]
        });
        
        // Scroll to table
        $('html, body').animate({
            scrollTop: $('#usersListCard').offset().top - 100
        }, 500);
    });
    
    // Clear filter
    $('#clearFilter').click(function() {
        $('#usersListCard').hide();
        if (table) {
            table.destroy();
        }
        currentFilter = '';
    });
});
</script>

<?php require_once 'admin_footer.php'; ?>
