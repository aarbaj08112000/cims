$(document).ready(function ($) {
    $("#headerFormResetPassword").validate({
        rules: {
            username: {
                required: true,
                email: true
            },
        },
        messages: {
            username: {
                required: "Please enter your email",
                email: "Please enter a valid email address"
            },
        },
        errorElement: "div",
        errorPlacement: function (error, element) {
            error.appendTo("#header_forgot_emailErr")
        },
        submitHandler: function (form) {
            var $btn = $("#headerResetBtn");
            var originalText = $btn.text();
            $btn.prop('disabled', true).text('Sending...');

            var formdata = new FormData(form);
            $.ajax({
                url: "user/Login/reset_password",
                data: formdata,
                processData: false,
                contentType: false,
                cache: false,
                type: "post",
                success: function (result) {
                    var data = JSON.parse(result);
                    if (data.success == 1) {
                        toaster("success", data.messages);
                        $("#headerForgotPasswordModal").modal('hide');
                        form.reset();
                    } else {
                        toaster("error", data.messages);
                    }
                },
                complete: function () {
                    $btn.prop('disabled', false).text(originalText);
                }
            });
        }
    });
});
