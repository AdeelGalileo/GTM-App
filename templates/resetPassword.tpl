<!DOCTYPE html>
<html>
<head>
{include file="layout/script.tpl"}
<script>


$(document).ready(function(event) {

    $('body').on('click', '.resetPassBtn', function(){
       
	 var userPassword = $('.userPassword').val();
	 var userConfirmPassword = $('.userConfirmPassword').val();
	
	if(userPassword==''){
		showMessage('{$smarty.const.ERROR_USER_PASSWORD}');
		$('.userPassword').focus();
		 return false;
	}
	
	if(userConfirmPassword==''){
		showMessage('{$smarty.const.ERROR_USER_CONFIRM_PASSWORD}');
		$('.userConfirmPassword').focus();
		 return false;
	}
	
	if (userPassword.toLowerCase() !== userConfirmPassword.toLowerCase()){
		 showMessage('{$smarty.const.ERROR_PASSWORD_MISMATCH}');
		$('.userConfirmPassword').focus();
		  return false;
	}
		
    });
});

</script>
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
    <form action="{$smarty.const.ROOT_HTTP_PATH}/resetPassword.php" name="resetForm" method="post">
	
		  <input type="hidden" value="{$userLinkData.user_id}" name="user_id_hidden" id="user_id_hidden" class="form-control user_id_hidden"/>
		  <input type="hidden" value="{$userLinkData.user_activation_link}" name="user_activation_link_hidden" id="user_activation_link_hidden" class="form-control user_activation_link_hidden"/>
		  
       <div class="form-group has-feedback">
        <input type="password" name="userPassword" id="userPassword" class="form-control userPassword" placeholder="New Password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
	   <div class="form-group has-feedback">
        <input type="password" name="userConfirmPassword" id="userConfirmPassword" class="form-control userConfirmPassword" placeholder="Confirm Password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <!-- /.col -->
        <div class="col-xs-8">
		   <input type="submit" name="resetPassBtn" id="resetPassBtn" value="Change Password" title="Reset My Password" class="btn btn-primary btn-block btn-flat resetPassBtn"  />
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
