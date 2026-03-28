<%*<html class="no-js">
<!--<![endif]-->
<head>
<%include file="top/meta_headers.tpl"%>        
<%$this->css->add_css("style_v2.css")%>
<%$this->general->addModuleWiseCssV2()%>
<%$this->css->css_src()%>
</head>
<body>
<%include file="loader.tpl"%>
<%include file="top/analytics.tpl"%>
</body>
</html>*%>

<!doctype html>
<title>Configure.IT-  Under Maintenance</title>
<style>
    body { text-align: center; padding: 150px; }
    h1 { font-size: 50px; }
    body { font: 20px Helvetica, sans-serif; color: #333; }
    article { display: block; text-align: left; width: 650px; margin: 0 auto; }
    a { color: #01bbe4; text-decoration: none; }
    a:hover { color:#01bbe4; text-decoration: none; }
    .logo{}
</style>
<h1 class="logo"><a title="A Complete Mobile App Development Platform" href="<%$this->config->item('site_url')%>"><img src="<%$this->config->item('admin_images_url')%>shortcut-logo.png" alt="Configure.IT Login"></a></h1>
<article>    
    <h2>We&rsquo;ll be back soon!</h2>    
    <div style="width: 100%;display: block;">        
        <div style="float: left;">
            <p>Sorry for the inconvenience but we&rsquo;re performing some maintenance at the moment. If you need to you can always contact administrator, otherwise we&rsquo;ll be back online shortly!</p>
        <p>&mdash; Team MRS</p>
        </div>
    </div>
</article>