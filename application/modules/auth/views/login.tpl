<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta charset="utf-8" />
      <base href="<%$base_url%>" />
      <title><%$config['company_name']%></title>
      <!-- Favicon -->
      <link rel="icon" type="image/x-icon" href="<%base_url()%><%$config['company_fav_icon']%>" />
      <!-- Fonts -->
      <link rel="shortcut icon" href="https://cdnjs.cloudflare.com/ajax/libs/line-awesome/1.3.0/line-awesome/css/line-awesome.min.css" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
      <meta http-equiv="content-type" content="text/html; charset=utf-8" />
      <meta http-equiv="cache-control" content="no-cache" />
      <meta http-equiv="pragma" content="no-cache" />
      <link rel="stylesheet" href="<%$base_url%>public/css/gilroy-fonts.css" />
      <link rel="stylesheet" href="<%$base_url%>public/css/tabler_css/tabler_icons.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="<%$base_url%>public/css/login/login_page.css">
      <link rel="stylesheet" href="<%$base_url%>public/css/admin_modern.css">
      <!-- toaster -->
       <link rel="stylesheet" href="public/css/toaster/custom_toaster.css" />
        <link rel="stylesheet" href="public/css/fontawesome/font_awesome.css">
     <!-- toaster -->
   </head>
   <body class="modern-login-body">
      <div class="login-wrapper">
         <div class="login-card">
            <!-- Logo Section -->
            <div class="login-logo">
               <a href="<%$base_url%>">
                  <img src="<%base_url()%><%$config['company_logo']%>" alt="<%$config['company_name']%>" title="<%$config['company_name']%>" />
               </a>
            </div>

            <!-- Login Content -->
            <div id="login_div">
               <div class="login-header">
                  <h2>Welcome to Cloth Inventory Management System</h2>
                  <p>Please log in to your account to continue</p>
               </div>

               <!-- Error Notifications -->
               <div id="var_msg_cnt" style="display: none; margin-bottom: 1rem;">
                  <div class="alert alert-danger d-flex align-items-center justify-content-between p-2" style="font-size: 0.875rem; border-radius: 0.375rem;">
                     <span id="err_msg_cnt"></span>
                     <button type="button" class="btn-close" onclick="Project.closeMessage();" style="font-size: 0.5rem;"></button>
                  </div>
               </div>

               <form id="formAuthentication" action="javascript:void(0)" method="POST">
                  <div class="form-group">
                     <label for="login_name">Email or Username</label>
                     <div class="input-group-modern">
                        <i class="ti ti-mail"></i>
                        <input type="text" id="login_name" name="email" placeholder="Enter your username" autofocus />
                     </div>
                     <div class="error-msg text-danger mt-1" id="login_nameErr" style="font-size: 0.75rem;"></div>
                  </div>

                  <div class="form-group">
                     <label for="password">Password</label>
                     <div class="input-group-modern">
                        <i class="ti ti-lock"></i>
                        <input type="password" id="password" name="password" placeholder="············" />
                        <span id="pwd_show_hide" class="pwd-toggle"><i class="ti ti-eye-off" data-status="hide"></i></span>
                     </div>
                     <div class="error-msg text-danger mt-1" id="passwordErr" style="font-size: 0.75rem;"></div>
                  </div>

                  <div class="login-options">
                     <div class="remember-me">
                        <input type="checkbox" id="remember_me" name="remember_me" value="Yes" />
                        <label for="remember_me" class="m-0">Remember Me</label>
                     </div>
                     <a href="javascript://" id="show_forgot_pwd" class="forgot-link">Forgot Password?</a>
                  </div>

                  <button type="submit" class="btn-modern" id="loginBtn">
                     Login <i class="ti ti-arrow-right"></i>
                  </button>
               </form>
            </div>

            <!-- Forgot Password Content -->
            <div id="forgot_div" style="display: none;">
               <div class="login-header">
                  <h2>Forgot Password? 🔒</h2>
                  <p>Enter your username and we'll help you reset your password</p>
               </div>

               <form id="formRestePassword" action="javascript:void(0)" method="POST">
                  <div class="form-group">
                     <label for="username">Username</label>
                     <div class="input-group-modern">
                        <i class="ti ti-user"></i>
                        <input type="text" id="username" name="username" placeholder="Enter your username" />
                     </div>
                     <div class="error-msg text-danger mt-1" id="usernameErr" style="font-size: 0.75rem;"></div>
                  </div>

                  <button type="submit" class="btn-modern mb-3" id="resetBtn">
                     Send Reset Link <i class="ti ti-mail-forward"></i>
                  </button>

                  <div class="text-center">
                     <a href="javascript://" id="back_to_login" class="forgot-link" style="font-size: 0.875rem;">
                        <i class="ti ti-chevron-left" style="font-size: 0.75rem;"></i> Back to Login
                     </a>
                  </div>
               </form>
            </div>

            <div class="login-footer">
               Copyright © <%$smarty.now|date_format:"%Y"%> Code crafter infotech.
               <br>
               All Rights Reserved
            </div>
         </div>
      </div>

   </body>
   <!-- Core JS -->
  <!-- build:js assets/vendor/js/core.js -->
  <script src="<%$base_url%>public/js/admin/plugin/jquery.min.js"></script>
  <script src="<%$base_url%>public/assets/vendor/libs/popper/popper.js"></script>
  <script src="<%$base_url%>public/assets/vendor/js/bootstrap.js"></script>
  <script src="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

  <!-- endbuild -->

  <!-- Vendors JS -->

  <!-- Main JS -->
<link rel="stylesheet" href="<%$base_url%>public/plugin/select2/select2.min.css">
  <script  src="<%$base_url%>public/plugin/select2/select2.min.js"></script>
  <link rel="stylesheet" href="<%$base_url%>plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js" integrity="sha512-WMEKGZ7L5LWgaPeJtw9MBM4i5w5OSBlSjTjCtSnvFJGSVD26gE5+Td12qN5pvWXhuWaWcVwF++F7aqu9cvqP0A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
 <script src="public/js/toaster/custom_toaster.js"></script>
<script src="<%$base_url%>public/js/login.js"></script>
</html>