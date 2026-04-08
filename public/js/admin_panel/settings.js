var Settings = (function () {
    var init = function () {
        handleFormSubmit('#settingsFormGeneral');
        handleFormSubmit('#settingsFormSecurity');
        handleFormSubmit('#settingsFormTax');
        handleTaxToggle();
    };

    var handleTaxToggle = function () {
        var $toggle = $('select[name="pos_tax_enabled"]');
        var $percentage = $('input[name="pos_tax_percentage"]');

        var toggleFields = function () {
            if ($toggle.val() === 'No') {
                $percentage.val(0).prop('readOnly', true).addClass('bg-light');
            } else {
                $percentage.prop('readOnly', false).removeClass('bg-light');
            }
        };

        $toggle.on('change', toggleFields);
        toggleFields(); // Run on load
    };

    var handleFormSubmit = function (selector) {
        $(selector).on('submit', function (e) {
            e.preventDefault();

            // Validation for Tax Settings
            if (selector === '#settingsFormTax') {
                var taxEnabled = $(this).find('[name="pos_tax_enabled"]').val();
                var taxPercentage = parseFloat($(this).find('[name="pos_tax_percentage"]').val()) || 0;

                if (taxEnabled === 'Yes' && taxPercentage <= 0) {
                    toaster('error', 'Tax percentage must be greater than 0 when tax is enabled.');
                    return false;
                }
            }

            var formData = new FormData(this);
            var btn = $(this).find('button[type="submit"]');
            var btnHtml = btn.html();

            btn.html('<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

            $.ajax({
                url: base_url + "update_settings",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                success: function (response) {
                    btn.html(btnHtml).prop('disabled', false);
                    if (response.success == 1) {
                        toaster('success', response.msg);
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function (xhr) {
                    btn.html(btnHtml).prop('disabled', false);
                    toaster('error', "Something went wrong!");
                }
            });
        });
    };

    return {
        init: init
    };
})();

$(document).ready(function () {
    Settings.init();
});
