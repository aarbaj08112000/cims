$(document).ready(function() {
    if ($.fn.daterangepicker) {
        var fromDate = $('#filter_from_date').val();
        var toDate = $('#filter_to_date').val();
        $('#date_range_picker').daterangepicker({
            autoUpdateInput: false,
            open: 'left',
            dropdownParent: $('#filterOffcanvas'),
            startDate: fromDate ? moment(fromDate, 'YYYY-MM-DD') : moment().startOf('month'),
            endDate: toDate ? moment(toDate, 'YYYY-MM-DD') : moment().endOf('month'),
            maxDate: moment(),
            locale: {
                format: 'YYYY-MM-DD',
                cancelLabel: 'Clear'
            }
        });
        if (fromDate && toDate) {
            $('#date_range_picker').val(fromDate + ' ~ ' + toDate);
        }
        $('#date_range_picker').on('apply.daterangepicker', function(eve, picker) {
            $(this).val(picker.startDate.format('YYYY-MM-DD') + ' ~ ' + picker.endDate.format('YYYY-MM-DD'));
            $('#filter_from_date').val(picker.startDate.format('YYYY-MM-DD'));
            $('#filter_to_date').val(picker.endDate.format('YYYY-MM-DD'));
        });
        $('#date_range_picker').on('cancel.daterangepicker', function(eve, picker) {
            $(this).val('');
            $('#filter_from_date, #filter_to_date, #date_range_picker').val('');
        });
    }
    if ($.fn.select2) {
        $('.select2').select2({
            theme: 'bootstrap-5',
            width: '100%',
            dropdownParent: $('#filterOffcanvas')
        });
    }

    updateStats();
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
            { data: 'changes_values', orderable: false },
            { data: 'qty_change' },
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
        var el = document.getElementById('filterOffcanvas');
        if (el && window.bootstrap) {
            var instance = bootstrap.Offcanvas.getInstance(el) || new bootstrap.Offcanvas(el);
            instance.hide();
        }
    });

    $(document).on('click', '#btn-reset-filter', function() {
        $('#filter_from_date, #filter_to_date, #date_range_picker').val('');
        $('#filter_product_id, #filter_action_type, #filter_created_by').val('').trigger('change');
        $('#filterForm').submit();
    });

    function updateStats() {
        $.ajax({
            url: base_url + 'reports/get_product_log_stats_ajax',
            type: 'POST',
            data: {
                from_date: $('#filter_from_date').val(),
                to_date: $('#filter_to_date').val(),
                product_id: $('#filter_product_id').val(),
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