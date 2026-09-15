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
      <!-- toaster -->
       <link rel="stylesheet" href="<%$base_url%>public/css/toaster/custom_toaster.css" />
        <link rel="stylesheet" href="<%$base_url%>public/css/fontawesome/font_awesome.css">
     <!-- toaster -->
   
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Gilroy', sans-serif;
            background: #ffffff;
            overflow-x: hidden;
        }

        .split-layout {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }

        /* Left Banner Section */
        .split-left {
            display: none;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 60%;
            background: linear-gradient(135deg, rgba(56, 57, 166, 0.85) 0%, rgba(38, 41, 115, 0.95) 100%),
                        url('<%$base_url%>public/images/login_bg.jpg') center/cover no-repeat;
            position: relative;
            overflow: hidden;
            padding: 40px;
        }

        @media (min-width: 992px) {
            .split-left {
                display: flex;
            }
        }

        /* Beautiful Background Decor */
        .decor-circle-1 {
            position: absolute;
            width: 600px;
            height: 600px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
            top: -150px;
            left: -150px;
            backdrop-filter: blur(5px);
        }

        .decor-circle-2 {
            position: absolute;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: 50%;
            bottom: -50px;
            right: -100px;
            backdrop-filter: blur(5px);
        }

        .banner-content {
            position: relative;
            z-index: 10;
            text-align: center;
            color: #ffffff;
            max-width: 600px;
        }

        .banner-content h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
            letter-spacing: -0.5px;
        }

        .banner-content p {
            font-size: 1.1rem;
            opacity: 0.85;
            line-height: 1.6;
        }

        /* Right Form Section */
        .split-right {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            padding: 40px 20px;
            background: #ffffff;
        }

        @media (min-width: 992px) {
            .split-right {
                width: 40%;
                padding: 40px 60px;
            }
        }

        .form-container {
            width: 100%;
            max-width: 420px;
        }

        .logo-wrapper {
            margin-bottom: 40px;
            text-align: left;
        }

        .logo-wrapper img {
            max-height: 45px;
        }

        .form-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: #2b3445;
            margin-bottom: 8px;
        }

        .form-subtitle {
            font-size: 0.95rem;
            color: #7d879c;
            margin-bottom: 35px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #4b566b;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-group-modern {
            position: relative;
            display: flex;
            align-items: center;
            width: 100%;
        }

        .input-group-modern > i.ti-mail, .input-group-modern > i.ti-lock, .input-group-modern > i.ti-user {
            position: absolute;
            left: 16px;
            color: #a0a5ba;
            font-size: 1.1rem;
            z-index: 5;
            pointer-events: none;
        }

        .input-group-modern input {
            width: 100% !important;
            padding: 14px 45px !important;
            font-size: 0.95rem;
            color: #2b3445 !important;
            background-color: #f6f9fc !important;
            border: 1px solid #e3e9ef !important;
            border-radius: 8px !important;
            transition: all 0.3s ease;
        }

        .input-group-modern input:focus {
            outline: none !important;
            background-color: #ffffff !important;
            border-color: #5b5fc7 !important;
            box-shadow: 0 0 0 4px rgba(91, 95, 199, 0.1) !important;
        }
        
        /* Fix Chrome autofill background overriding borders */
        .input-group-modern input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 1000px #f6f9fc inset !important;
            -webkit-text-fill-color: #2b3445 !important;
            border: 1px solid #e3e9ef !important;
        }
        
        .input-group-modern input:-webkit-autofill:focus {
            -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
            border-color: #5b5fc7 !important;
        }

        .pwd-toggle {
            position: absolute;
            right: 16px;
            color: #a0a5ba;
            cursor: pointer;
            z-index: 5;
        }

        .error-msg {
            font-size: 0.8rem;
            color: #ea5455;
            margin-top: 5px;
            display: block;
        }

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .remember-me input {
            width: 16px;
            height: 16px;
            accent-color: #5b5fc7;
            cursor: pointer;
        }

        .remember-me label {
            font-size: 0.9rem;
            color: #4b566b;
            cursor: pointer;
            margin: 0;
        }

        .forgot-link {
            font-size: 0.9rem;
            color: #5b5fc7;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s;
        }

        .forgot-link:hover {
            color: #4a4eab;
        }

        .btn-modern {
            width: 100%;
            padding: 14px;
            font-size: 1rem;
            font-weight: 600;
            color: #ffffff;
            background: #5b5fc7;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 14px rgba(91, 95, 199, 0.3);
        }

        .btn-modern:hover {
            background: #4a4eab;
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(91, 95, 199, 0.4);
        }

        .btn-modern:active {
            transform: translateY(1px);
        }

        .login-footer {
            margin-top: 40px;
            text-align: center;
            font-size: 0.85rem;
            color: #a0a5ba;
        }
    </style>
</head>
   <body class="outer-div-box">
      <div class="split-layout">
         
         <!-- Left Graphic Section -->
         <div class="split-left">
            <div class="decor-circle-1"></div>
            <div class="decor-circle-2"></div>
            
            <div class="banner-content">
               <img src="<%base_url()%><%$config['company_logo']%>" alt="<%$config['company_name']%>" style="max-height: 60px; margin-bottom: 30px; filter: brightness(0) invert(1);" />
               <h1>Inventory Management System</h1>
               <p>Experience seamless inventory tracking, powerful analytics, and total control over your business operations in one intuitive platform.</p>
            </div>
         </div>

         <!-- Right Form Section -->
         <div class="split-right">
            <div class="form-container">
               <!-- Logo for Mobile -->
               <div class="logo-wrapper d-lg-none">
                  <a href="<%$base_url%>">
                     <img src="<%base_url()%><%$config['company_logo']%>" alt="<%$config['company_name']%>" />
                  </a>
               </div>

               <!-- Login Content -->
               <div id="login_div">
                  <h2 class="form-title">Welcome to <%$config['company_name']%> 👋</h2>
                  <p class="form-subtitle">Please sign in to your account to continue</p>

                  <!-- Error Notifications -->
                  <div id="var_msg_cnt" style="display: none; margin-bottom: 1.5rem;">
                     <div class="alert alert-danger d-flex align-items-center justify-content-between p-3" style="font-size: 0.9rem; border-radius: 8px; border: none; background-color: #fce4e4; color: #ea5455;">
                        <span id="err_msg_cnt"></span>
                        <button type="button" class="btn-close" onclick="Project.closeMessage();" style="font-size: 0.75rem;"></button>
                     </div>
                  </div>

                  <form id="formAuthentication" action="javascript:void(0)" method="POST">
                     <div class="form-group">
                        <label for="login_name" class="form-label">Email or Username</label>
                        <div class="input-group-modern">
                           <i class="ti ti-mail"></i>
                           <input type="text" id="login_name" name="email" placeholder="Enter your email or username" autofocus />
                        </div>
                        <div class="error-msg" id="login_nameErr"></div>
                     </div>

                     <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group-modern">
                           <i class="ti ti-lock"></i>
                           <input type="password" id="password" name="password" placeholder="············" />
                           <span id="pwd_show_hide" class="pwd-toggle"><i class="ti ti-eye-off" data-status="hide"></i></span>
                        </div>
                        <div class="error-msg" id="passwordErr"></div>
                     </div>

                     <div class="login-options">
                        <div class="remember-me">
                           <input type="checkbox" id="remember_me" name="remember_me" value="Yes" />
                           <label for="remember_me">Remember Me</label>
                        </div>
                        <a href="javascript://" id="show_forgot_pwd" class="forgot-link">Forgot Password?</a>
                     </div>

                     <button type="submit" class="btn-modern" id="loginBtn">
                        Sign In <i class="ti ti-arrow-right"></i>
                     </button>
                  </form>
               </div>

               <!-- Forgot Password Content -->
               <div id="forgot_div" style="display: none;">
                  <h2 class="form-title">Forgot Password? 🔒</h2>
                  <p class="form-subtitle">Enter your username and we'll send you instructions to reset your password</p>

                  <form id="formRestePassword" action="javascript:void(0)" method="POST">
                     <div class="form-group mb-4">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-group-modern">
                           <i class="ti ti-user"></i>
                           <input type="text" id="username" name="username" placeholder="Enter your username" />
                        </div>
                        <div class="error-msg" id="usernameErr"></div>
                     </div>

                     <button type="submit" class="btn-modern mb-4" id="resetBtn">
                        Send Reset Link <i class="ti ti-mail-forward"></i>
                     </button>

                     <div class="text-center">
                        <a href="javascript://" id="back_to_login" class="forgot-link">
                           <i class="ti ti-chevron-left me-1"></i> Back to Login
                        </a>
                     </div>
                  </form>
               </div>

               <div class="login-footer">
                  Copyright © <%$smarty.now|date_format:"%Y"%> Code crafter infotech.<br>All Rights Reserved
               </div>
            </div>
         </div>
      </div>

   </body>
   <!-- Core JS -->
  <script src="<%$base_url%>public/js/admin/plugin/jquery.min.js"></script>
  <script src="<%$base_url%>public/assets/vendor/libs/popper/popper.js"></script>
  <script src="<%$base_url%>public/assets/vendor/js/bootstrap.js"></script>
  <script src="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

  <!-- Vendors JS -->
  <link rel="stylesheet" href="<%$base_url%>public/plugin/select2/select2.min.css">
  <script  src="<%$base_url%>public/plugin/select2/select2.min.js"></script>
  <link rel="stylesheet" href="<%$base_url%>plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js" integrity="sha512-WMEKGZ7L5LWgaPeJtw9MBM4i5w5OSBlSjTjCtSnvFJGSVD26gE5+Td12qN5pvWXhuWaWcVwF++F7aqu9cvqP0A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script type="text/javascript">
  var base_url = <%$base_url|@json_encode%>;
</script>
 <script src="<%$base_url%>public/js/toaster/custom_toaster.js"></script>
<script src="<%$base_url%>public/js/login.js"></script>
</html>