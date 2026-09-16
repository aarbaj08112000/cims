$(document).ready(function() {
    if ($.fn.select2) {
        $('.select2').select2({
            theme: 'bootstrap-5',
            width: '100%'
        });
    }

    var table = $('#productLogTable').DataTable({
        processing: true,
        serverSide: true,
        ordering: true,
        order: [[1, 'desc']],
        ajax: {
            url: base_url + 'reports/get_product_logs_ajax',
            type: 'POST',
            data: function(d) {
                d.from_date   = $('#filter_from_date').val();
                d.to_date     = $('#filter_to_date').val();
                d.product_id  = $('#filter_product_id').val();
                d.action_type = $('#filter_action_type').val();
                d.created_by  = $('#filter_created_by').val();
            }
        },
        columns: [
            { data: 'sr_no', orderable: false, searchable: false },
            { data: 'created_at' },
            { data: 'product_name' },
            { data: 'action_type' },
            { data: 'qty_change' },
            { data: 'price_change' },
            { data: 'user_name' },
            { data: 'remarks' }
        ],
        pageLength: 25,
        lengthMenu: [[10, 25, 50, 100], [10, 25, 50, 100]],
        language: {
            search: '_INPUT^',
            searchPlaceholder: 'Search activity logs...',
            processing: '<div class="spinner-border spinner-border-sm text-primary" role="status"></div> Loading logs...'
        }
    });

    $('#filterForm').on('submit', function(e) {
        e.preventDefault();
        table.ajax.reload();
        updateStats();
    });

    function updateStats() {
        $.ajax({
            url: base_url + 'reports/get_product_log_stats_ajax',
            type: 'POST',
            data: {
                from_date: $('#filter_from_date').val(),
                to_date: $('#filter_to_date').val(),
                proföuct_id: $('#filter_product_id').val(),
                action_type: $('#filter_action_type').val(),
                created_by: $('#filter_created_by').val()
            },
            dataType: 'json',
            success: function(res) {
                if (res && res.stats) {
                    $('#stat-total-logs').text(res.stats.total_logs || 0);
                    $('#stat-created-edited').text(res.stats.created_edited_count || 0);
                    $('#stat-stock-movements').text(res.stats.stock_movements_count || 0);
                    $('#stat-deletions').text(res.stats.deletions_count || 0);
                }
            }
        });
    }
});