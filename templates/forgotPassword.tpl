<!DOCTYPE html>
<html>
<head>
{include file="layout/script.tpl"}
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="javascript:void(0);"><b>Admin</b></a>
  </div>
   <div id="Messages" style="{if !$messages}display:none;{/if}">
		<div id="inner_message">{$messages}</div>
   </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	
    <p class="login-box-msg"><img src="{$smarty.const.ROOT_HTTP_PATH}/dist/img/galileo.png"/></p>
	<!--<p class="login-box-msg">Sign in to start your session</p>-->
    <form action="{$smarty.const.ROOT_HTTP_PATH}/forgotPassword.php" method="post">
      <div class="form-group has-feedback">
        <input type="text"  name="userEmail" id="userEmail" class="form-control" placeholder="Email">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="row">
        <!-- /.col -->
        <div class="col-xs-8">
		   <input type="submit" name="loginBtn" id="loginBtn" value="Reset My Password" title="Reset My Password" class="btn btn-primary btn-block btn-flat" />
        </div>
		 <div class="col-xs-4">
		   <a href="{$smarty.const.ROOT_HTTP_PATH}" class="btn btn-primary btn-block btn-flat">Cancel</a>
        </div>
        <!-- /.col -->
      </div>
    </form>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 3 -->
<script src="{$smarty.const.ROOT_HTTP_PATH}/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="{$smarty.const.ROOT_HTTP_PATH}/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="{$smarty.const.ROOT_HTTP_PATH}/plugins/iCheck/icheck.min.js"></script>
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
