<?php
require_once 'admin_header.php';
?>

<div class="main-content">
    <div class="page-header">
        <h2>File Management</h2>
        <div class="header-sub-title">
            <nav class="breadcrumb breadcrumb-dash">
                <a href="admin_dashboard.php" class="breadcrumb-item"><i class="anticon anticon-home"></i> Dashboard</a>
                <span class="breadcrumb-item active">File Manager</span>
            </nav>
        </div>
    </div>
    
    <!-- File Upload -->
    <div class="card">
        <div class="card-body">
            <h5>Upload Files</h5>
            <form id="uploadForm" class="mt-3" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-8">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="fileUpload" name="files[]" multiple>
                            <label class="custom-file-label" for="fileUpload">Choose files...</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary btn-block">
                            <i class="anticon anticon-upload"></i> Upload Files
                        </button>
                    </div>
                </div>
                <small class="text-muted d-block mt-2">
                    Allowed types: PDF, DOC, DOCX, XLS, XLSX, JPG, PNG, GIF (Max: 10MB per file)
                </small>
            </form>
        </div>
    </div>
    
    <!-- Storage Stats -->
    <div class="row">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="avatar avatar-icon avatar-lg avatar-blue">
                            <i class="anticon anticon-folder"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Total Files</p>
                            <h4 class="mb-0" id="totalFiles">--</h4>
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
                            <i class="anticon anticon-file-pdf"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Documents</p>
                            <h4 class="mb-0" id="totalDocs">--</h4>
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
                            <i class="anticon anticon-picture"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Images</p>
                            <h4 class="mb-0" id="totalImages">--</h4>
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
                            <i class="anticon anticon-database"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-muted mb-0">Storage Used</p>
                            <h4 class="mb-0" id="storageUsed">--</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- File Filters -->
    <div class="card">
        <div class="card-body">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <h5>File Library</h5>
                </div>
                <div class="col-md-8 text-right">
                    <div class="btn-group mr-2" role="group">
                        <button type="button" class="btn btn-sm btn-default active" data-filter="all">All</button>
                        <button type="button" class="btn btn-sm btn-default" data-filter="documents">Documents</button>
                        <button type="button" class="btn btn-sm btn-default" data-filter="images">Images</button>
                        <button type="button" class="btn btn-sm btn-default" data-filter="videos">Videos</button>
                    </div>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-sm btn-default active" data-view="grid">
                            <i class="anticon anticon-appstore"></i>
                        </button>
                        <button type="button" class="btn btn-sm btn-default" data-view="list">
                            <i class="anticon anticon-bars"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- File Grid -->
    <div class="card">
        <div class="card-body">
            <div id="fileGrid" class="row">
                <!-- Sample files - in production, load from database -->
                <div class="col-md-3 mb-4">
                    <div class="card file-card">
                        <div class="card-body text-center">
                            <i class="anticon anticon-file-pdf font-size-40 text-danger"></i>
                            <h6 class="mt-2 mb-1">document.pdf</h6>
                            <small class="text-muted">2.5 MB</small>
                            <div class="mt-3">
                                <button class="btn btn-sm btn-primary mr-1" onclick="downloadFile('document.pdf')">
                                    <i class="anticon anticon-download"></i>
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteFile('document.pdf')">
                                    <i class="anticon anticon-delete"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="card file-card">
                        <div class="card-body text-center">
                            <i class="anticon anticon-file-image font-size-40 text-success"></i>
                            <h6 class="mt-2 mb-1">photo.jpg</h6>
                            <small class="text-muted">1.8 MB</small>
                            <div class="mt-3">
                                <button class="btn btn-sm btn-primary mr-1" onclick="downloadFile('photo.jpg')">
                                    <i class="anticon anticon-download"></i>
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteFile('photo.jpg')">
                                    <i class="anticon anticon-delete"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="card file-card">
                        <div class="card-body text-center">
                            <i class="anticon anticon-file-excel font-size-40 text-success"></i>
                            <h6 class="mt-2 mb-1">report.xlsx</h6>
                            <small class="text-muted">3.2 MB</small>
                            <div class="mt-3">
                                <button class="btn btn-sm btn-primary mr-1" onclick="downloadFile('report.xlsx')">
                                    <i class="anticon anticon-download"></i>
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteFile('report.xlsx')">
                                    <i class="anticon anticon-delete"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once 'admin_footer.php'; ?>

<style>
.file-card {
    transition: transform 0.2s;
}
.file-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
</style>

<script>
$(document).ready(function() {
    // Update file input label
    $('.custom-file-input').on('change', function() {
        const fileCount = $(this)[0].files.length;
        const label = fileCount > 1 ? fileCount + ' files selected' : $(this)[0].files[0].name;
        $(this).next('.custom-file-label').html(label);
    });
    
    // Upload form handler
    $('#uploadForm').submit(function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        
        // TODO: Create admin_ajax/upload_file.php endpoint
        toastr.warning('File upload endpoint not yet implemented');
        
        // Uncomment when backend endpoint is ready:
        // $.ajax({
        //     url: 'admin_ajax/upload_file.php',
        //     type: 'POST',
        //     data: formData,
        //     processData: false,
        //     contentType: false,
        //     success: function(response) {
        //         if (response.success) {
        //             toastr.success('Files uploaded successfully');
        //             loadFiles();
        //             $('#uploadForm')[0].reset();
        //             $('.custom-file-label').html('Choose files...');
        //         } else {
        //             toastr.error(response.message || 'Upload failed');
        //         }
        //     },
        //     error: function() {
        //         toastr.error('Failed to upload files');
        //     }
        // });
    });
    
    // Filter buttons
    $('[data-filter]').click(function() {
        $('[data-filter]').removeClass('active');
        $(this).addClass('active');
        const filter = $(this).data('filter');
        // In production, filter files based on type
        toastr.info('Filtering by: ' + filter);
    });
    
    // View toggle
    $('[data-view]').click(function() {
        $('[data-view]').removeClass('active');
        $(this).addClass('active');
        const view = $(this).data('view');
        // Toggle between grid and list view
        toastr.info('Switched to ' + view + ' view');
    });
    
    // Load initial stats
    loadStats();
    
    function loadStats() {
        $('#totalFiles').text('127');
        $('#totalDocs').text('45');
        $('#totalImages').text('82');
        $('#storageUsed').text('2.3 GB');
    }
});

function downloadFile(filename) {
    toastr.success('Downloading: ' + filename);
    // In production, trigger actual download
}

function deleteFile(filename) {
    if (confirm('Are you sure you want to delete ' + filename + '?')) {
        toastr.success('File deleted: ' + filename);
        // In production, call API to delete file
    }
}
</script>


