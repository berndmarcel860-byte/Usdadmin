<?php
require_once 'admin_header.php';

// Get cryptocurrency statistics
$cryptoStats = [];
try {
    $stmt = $pdo->query("SELECT 
        COUNT(*) as total_cryptos,
        SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_cryptos,
        (SELECT COUNT(*) FROM cases WHERE currency_type = 'crypto') as crypto_cases,
        (SELECT COUNT(*) FROM withdrawals WHERE currency_type = 'crypto') as crypto_withdrawals
        FROM cryptocurrencies");
    $cryptoStats = $stmt->fetch(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    error_log("Error fetching crypto stats: " . $e->getMessage());
    $cryptoStats = ['total_cryptos' => 0, 'active_cryptos' => 0, 'crypto_cases' => 0, 'crypto_withdrawals' => 0];
}
?>

<div class="main-content">
    <div class="page-header">
        <h2>Cryptocurrency Management</h2>
        <div class="header-sub-title">
            <nav class="breadcrumb breadcrumb-dash">
                <a href="admin_dashboard.php" class="breadcrumb-item"><i class="anticon anticon-home"></i> Dashboard</a>
                <span class="breadcrumb-item active">Crypto Management</span>
            </nav>
        </div>
    </div>
    
    <!-- Crypto Statistics -->
    <div class="row">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-blue">
                            <i class="anticon anticon-bitcoin"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Total Cryptos</p>
                            <h4 class="mb-0"><?= number_format($cryptoStats['total_cryptos']) ?></h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-green">
                            <i class="anticon anticon-check-circle"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Active Cryptos</p>
                            <h4 class="mb-0 text-success"><?= number_format($cryptoStats['active_cryptos']) ?></h4>
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
                            <i class="anticon anticon-folder-open"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Crypto Cases</p>
                            <h4 class="mb-0"><?= number_format($cryptoStats['crypto_cases']) ?></h4>
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
                            <i class="anticon anticon-wallet"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Crypto Withdrawals</p>
                            <h4 class="mb-0"><?= number_format($cryptoStats['crypto_withdrawals']) ?></h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Filter Bar -->
    <div class="card">
        <div class="card-body">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h5>Cryptocurrency List</h5>
                </div>
                <div class="col-md-6 text-right">
                    <div class="btn-group mr-2" role="group">
                        <button type="button" class="btn btn-sm btn-default active" data-filter="all">All</button>
                        <button type="button" class="btn btn-sm btn-success" data-filter="active">Active</button>
                        <button type="button" class="btn btn-sm btn-secondary" data-filter="inactive">Inactive</button>
                    </div>
                    <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addCryptoModal">
                        <i class="anticon anticon-plus"></i> Add Cryptocurrency
                    </button>
                    <button class="btn btn-info btn-sm" id="refreshCryptos">
                        <i class="anticon anticon-reload"></i> Refresh
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Cryptocurrencies Table -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table id="cryptoTable" class="table table-hover">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Symbol</th>
                            <th>Name</th>
                            <th>USD Rate</th>
                            <th>Cases</th>
                            <th>Withdrawals</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Cryptocurrency Modal -->
<div class="modal fade" id="addCryptoModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Cryptocurrency</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <i class="anticon anticon-close"></i>
                </button>
            </div>
            <form id="addCryptoForm">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Symbol</label>
                        <input type="text" class="form-control" name="symbol" placeholder="e.g., BTC" required>
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" name="name" placeholder="e.g., Bitcoin" required>
                    </div>
                    <div class="form-group">
                        <label>Rank</label>
                        <input type="number" class="form-control" name="rank" placeholder="e.g., 1" required>
                    </div>
                    <div class="form-group">
                        <label>Icon URL (optional)</label>
                        <input type="url" class="form-control" name="icon_url" placeholder="https://...">
                    </div>
                    <div class="custom-control custom-switch">
                        <input type="checkbox" class="custom-control-input" id="addCryptoActive" name="is_active" checked>
                        <label class="custom-control-label" for="addCryptoActive">Active</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Cryptocurrency</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Cryptocurrency Modal -->
<div class="modal fade" id="editCryptoModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Cryptocurrency</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <i class="anticon anticon-close"></i>
                </button>
            </div>
            <form id="editCryptoForm">
                <input type="hidden" name="crypto_id" id="editCryptoId">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Symbol</label>
                        <input type="text" class="form-control" name="symbol" id="editCryptoSymbol" required>
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" name="name" id="editCryptoName" required>
                    </div>
                    <div class="form-group">
                        <label>Rank</label>
                        <input type="number" class="form-control" name="rank" id="editCryptoRank" required>
                    </div>
                    <div class="form-group">
                        <label>USD Rate</label>
                        <input type="number" step="0.01" class="form-control" name="usd_rate" id="editCryptoRate">
                        <small class="text-muted">Leave empty to fetch from API</small>
                    </div>
                    <div class="form-group">
                        <label>Icon URL (optional)</label>
                        <input type="url" class="form-control" name="icon_url" id="editCryptoIcon">
                    </div>
                    <div class="custom-control custom-switch">
                        <input type="checkbox" class="custom-control-input" id="editCryptoActive" name="is_active">
                        <label class="custom-control-label" for="editCryptoActive">Active</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update Cryptocurrency</button>
                </div>
            </form>
        </div>
    </div>
</div>

<?php require_once 'admin_footer.php'; ?>

<script>
$(document).ready(function() {
    let currentFilter = 'all';
    
    // Initialize DataTable
    const cryptoTable = $('#cryptoTable').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: 'admin_ajax/get_cryptocurrencies.php',
            type: 'POST',
            data: function(d) {
                d.filter = currentFilter;
            }
        },
        order: [[0, 'asc']],
        columns: [
            { data: 'rank' },
            { 
                data: 'symbol',
                render: function(data) {
                    return '<strong>' + data + '</strong>';
                }
            },
            { data: 'name' },
            {
                data: null,
                render: function(data) {
                    if (data.usd_rate && data.usd_rate > 0) {
                        return '$' + parseFloat(data.usd_rate).toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
                    }
                    return '<span class="text-muted">Not set</span>';
                }
            },
            { 
                data: 'case_count',
                render: function(data) {
                    return data || 0;
                }
            },
            { 
                data: 'withdrawal_count',
                render: function(data) {
                    return data || 0;
                }
            },
            {
                data: 'is_active',
                render: function(data) {
                    return data == 1 
                        ? '<span class="badge badge-success">Active</span>' 
                        : '<span class="badge badge-secondary">Inactive</span>';
                }
            },
            {
                data: null,
                render: function(data) {
                    return `
                        <div class="btn-group">
                            <button class="btn btn-sm btn-primary edit-crypto" data-id="${data.id}" title="Edit">
                                <i class="anticon anticon-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-${data.is_active == 1 ? 'warning' : 'success'} toggle-crypto" 
                                    data-id="${data.id}" 
                                    data-status="${data.is_active}"
                                    title="${data.is_active == 1 ? 'Deactivate' : 'Activate'}">
                                <i class="anticon anticon-${data.is_active == 1 ? 'stop' : 'check-circle'}"></i>
                            </button>
                        </div>
                    `;
                }
            }
        ]
    });
    
    // Filter buttons
    $('[data-filter]').click(function() {
        $('[data-filter]').removeClass('active');
        $(this).addClass('active');
        currentFilter = $(this).data('filter');
        cryptoTable.ajax.reload();
    });
    
    // Refresh button
    $('#refreshCryptos').click(function() {
        cryptoTable.ajax.reload();
    });
    
    // Add cryptocurrency
    $('#addCryptoForm').submit(function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        formData.append('is_active', $('#addCryptoActive').is(':checked') ? 1 : 0);
        
        $.ajax({
            url: 'admin_ajax/add_cryptocurrency.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.success) {
                    toastr.success('Cryptocurrency added successfully');
                    $('#addCryptoModal').modal('hide');
                    $('#addCryptoForm')[0].reset();
                    cryptoTable.ajax.reload();
                } else {
                    toastr.error(response.message || 'Failed to add cryptocurrency');
                }
            }
        });
    });
    
    // Edit cryptocurrency
    $('#cryptoTable').on('click', '.edit-crypto', function() {
        const cryptoId = $(this).data('id');
        
        $.get('admin_ajax/get_cryptocurrency.php', { id: cryptoId }, function(response) {
            if (response.success) {
                const crypto = response.data;
                $('#editCryptoId').val(crypto.id);
                $('#editCryptoSymbol').val(crypto.symbol);
                $('#editCryptoName').val(crypto.name);
                $('#editCryptoRank').val(crypto.rank);
                $('#editCryptoRate').val(crypto.usd_rate);
                $('#editCryptoIcon').val(crypto.icon_url);
                $('#editCryptoActive').prop('checked', crypto.is_active == 1);
                $('#editCryptoModal').modal('show');
            }
        });
    });
    
    $('#editCryptoForm').submit(function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        formData.append('is_active', $('#editCryptoActive').is(':checked') ? 1 : 0);
        
        $.ajax({
            url: 'admin_ajax/update_cryptocurrency.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.success) {
                    toastr.success('Cryptocurrency updated successfully');
                    $('#editCryptoModal').modal('hide');
                    cryptoTable.ajax.reload();
                } else {
                    toastr.error(response.message || 'Failed to update cryptocurrency');
                }
            }
        });
    });
    
    // Toggle cryptocurrency status
    $('#cryptoTable').on('click', '.toggle-crypto', function() {
        const cryptoId = $(this).data('id');
        const currentStatus = $(this).data('status');
        const newStatus = currentStatus == 1 ? 0 : 1;
        
        $.post('admin_ajax/toggle_cryptocurrency.php', {
            id: cryptoId,
            is_active: newStatus
        }, function(response) {
            if (response.success) {
                toastr.success(newStatus == 1 ? 'Cryptocurrency activated' : 'Cryptocurrency deactivated');
                cryptoTable.ajax.reload();
            } else {
                toastr.error(response.message || 'Failed to toggle status');
            }
        });
    });
});
</script>
