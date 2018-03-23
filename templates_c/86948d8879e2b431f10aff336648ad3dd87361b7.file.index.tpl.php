<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:13:52
         compiled from "/home/galileotechmedia/public_html/app/templates/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:10231980725a9591d0f25781-95685539%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '86948d8879e2b431f10aff336648ad3dd87361b7' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/index.tpl',
      1 => 1519124484,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '10231980725a9591d0f25781-95685539',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'messages' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a9591d10097e3_50261316',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a9591d10097e3_50261316')) {function content_5a9591d10097e3_50261316($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
<?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="javascript:void(0);"><b>Admin</b></a>
  </div>
   <div id="Messages" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;<?php }?>">
		<div id="inner_message"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div>
   </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	
    <p class="login-box-msg"><img src="<?php echo @ROOT_HTTP_PATH;?>
/dist/img/galileo.png"/></p>
	<!--<p class="login-box-msg">Sign in to start your session</p>-->
    <form action="<?php echo @ROOT_HTTP_PATH;?>
/index.php" method="post">
      <div class="form-group has-feedback">
        <input type="text"  name="userEmail" id="userEmail" class="form-control" placeholder="Email">
		<input type="hidden" name="login" id="login" value="1"  />
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" name="userPassword" id="userPassword" class="form-control" placeholder="Password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
    
        <!-- /.col -->
        <div class="col-xs-4">
		   <input type="submit" name="loginBtn" id="loginBtn" value="Sign In" title="Sign In" class="btn btn-primary btn-block btn-flat" />
        </div>
        <!-- /.col -->
      </div>
    </form>
	<br/>
	<a href="<?php echo @ROOT_HTTP_PATH;?>
/forgotPassword.php">I forgot my password</a><br>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="<?php echo @ROOT_HTTP_PATH;?>
/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="<?php echo @ROOT_HTTP_PATH;?>
/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="<?php echo @ROOT_HTTP_PATH;?>
/plugins/iCheck/icheck.min.js"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
</script>
</body>
</html>
<?php }} ?>