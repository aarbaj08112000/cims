$(document).ready(function () {
   var mode = $("#mode").val();
  $("#product_form").validate({
    rules: {
      name: {
        required: true,
        minlength: 2
      },
      price: {
        required: true,
        number: true,
        min: 0.01
      },
      description: {
        required: true,
        minlength: 5
      },
      image: {
        required: function () {
          return mode === 'Add';
        }
      }
    },
    messages: {
      name: {
        required: "Please enter product name",
        minlength: "Name must be at least 2 characters"
      },
      price: {
        required: "Please enter the product price",
        number: "Enter a valid number",
        min: "Price must be greater than 0"
      },
      description: {
        required: "Please enter a description",
        minlength: "Description must be at least 5 characters"
      },
      image: {
        required: "Please upload an image",
      }
    },
    errorClass: "is-invalid",
    validClass: "is-valid",
    errorElement: "div",
    errorPlacement: function (error, element) {
      error.addClass("invalid-feedback");
      if (element.prop("type") === "file") {
        error.insertAfter(element);
      } else {
        error.insertAfter(element);
      }
    },
    highlight: function (element) {
      $(element).addClass("is-invalid").removeClass("is-valid");
    },
    unhighlight: function (element) {
      $(element).removeClass("is-invalid").addClass("is-valid");
    },
    submitHandler: function (form) {
     var formData = new FormData(form);
      var product_id = $("#product_id").val();
      if(product_id == ""){
        var url = 'save_product_data';
      }else{
        var url = 'update_product_data';
      }
      
      
      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (response) {
          //  response = JSON.parse(response);
          var msg = response.msg;
          var success = response.success;
          if (success == 1) {
            toaster("success",msg);
            setTimeout(function(){
              window.location.href = "product";
            },1000);

          } else {
            toaster("error",msg);
          }
        },
        error: function (xhr, status, error) {
          console.error("AJAX Error:", error);
          alert("Something went wrong. Please try again.");
        }
      });

      return false;
    }
  });


  
});