var Settings = (function () {
    var init = function () {
        handleFormSubmit('#settingsFormGeneral');
        handleFormSubmit('#settingsFormSecurity');
    };

    var handleFormSubmit = function (selector) {
        $(selector).on('submit', function (e) {
            e.preventDefault();

            var formData = new FormData(this);
            var btn = $(this).find('button[type="submit"]');
            var btnHtml = btn.html();

            btn.html('<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

            $.ajax({
                url: base_url + "settings/update_settings",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                success: function (response) {
                    btn.html(btnHtml).prop('disabled', false);
                    if (response.success == 1) {
                        toastr.success(response.msg);
                    } else {
                        toastr.error(response.msg);
                    }
                },
                error: function () {
                    btn.html(btnHtml).prop('disabled', false);
                    toastr.error("Something went wrong!");
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
