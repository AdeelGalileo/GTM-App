{extends file='layout.tpl'}
{strip}
{block name=title}{$SiteTitle} - Admin{/block}
{block name=header}
<script type="text/javascript">
$(document).ready(function(){
	
	$('body').on('click', '.adminPersonnelSave', function(){
		
		var userFirstName = $('.userFirstName').val();
		var userLastName = $('.userLastName').val();
		var userRole = $('.userRole').val();
		var userEmail = $('.userEmail').val();
		var userPassword = $('.userPassword').val();
		var userConfirmPassword = $('.userConfirmPassword').val();
		
		if(userFirstName==''){
            showMessage('{$smarty.const.ERR_USER_FIRST_NAME}');
            $('.userFirstName').focus();
            return false;
        }
		
		if(userLastName==''){
            showMessage('{$smarty.const.ERR_USER_LAST_NAME}');
            $('.userLastName').focus();
            return false;
        }
		
		if(userRole==''){
            showMessage('{$smarty.const.ERR_USER_ROLE}');
            $('.userRole').focus();
            return false;
        }
		
		if(userEmail==''){
            showMessage('{$smarty.const.ERR_USER_EMAIL}');
            $('.userEmail').focus();
            return false;
        }
		
		if(! validateEmail(userEmail)){
			 showMessage('{$smarty.const.ERR_INVALID_USER_EMAIL}');
			 $('.userEmail').focus();
             return false;
		}
		
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
		
		$.ajax({
                url: 'ajax/adminPersonnel.php?rand='+Math.random(),
                type: 'post',
                dataType: 'json',
                data: { checkUserEmailExist: 1,  userEmailData: userEmail },
                success: function(response) {
                    checkResponseRedirect(response);
					if(response.message == 1){
						showMessage('{$smarty.const.ERR_USER_EMAIL_EXISTS}');
					}
					else{
						$.ajax({
							url: 'ajax/adminPersonnel.php?rand='+Math.random(),
							type: 'post',
							dataType: 'json',
							data: { addAdminPersonnel: 1, userFirstNameData: userFirstName, userLastNameData: userLastName, userRoleData: userRole, userEmailData: userEmail, userPasswordData:  userPassword },
							success: function(response) {
								checkResponseRedirect(response);
								showMessage(response.message);
								window.location.href = '{$smarty.const.ROOT_HTTP_PATH}/userManager.php'; 
							}		
						});
					}
                }		
         });
		
    });	
		
});	


</script> 
{/block}
{block name=content}

		<form role="form" method="post">
      <div class="row">
		<div class="col-md-12">
          <!-- general form elements -->
		 
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Admin Personnel</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
			
              <div class="box-body">
                <div class="form-group col-sm-6">
                  <label for="userFirstName">First Name</label>
                  <input type="type" class="form-control userFirstName" id="userFirstName" placeholder="">
                </div>
				<div class="form-group col-sm-6">
                  <label for="userLastName">Last Name</label>
                  <input type="type" class="form-control userLastName" id="userLastName" placeholder="">
                </div>
				<div class="form-group col-sm-6">
                  <label for="userRole">Role</label>
                  <select class="form-control userRole" id="userRole">
					 {if $rolesArray}
						{foreach $rolesArray as $key=> $value}
							 <option value="{$value.user_role_id}">{$value.user_role_name}</option>
						{/foreach}
					{/if}
                  </select>
                </div>
				<div class="form-group col-sm-6">
                  <label for="userEmail">Email</label>
                  <input type="type" class="form-control userEmail" id="userEmail" placeholder="">
                </div>
				
				<div class="form-group col-sm-6">
                  <label for="userPassword">Password</label>
                  <input type="password" class="form-control userPassword" id="userPassword" placeholder="" maxlength="12">
                </div>
				<div class="form-group col-sm-6">
                  <label for="userConfirmPassword">Confirm Password</label>
                  <input type="password" class="form-control userConfirmPassword" id="userConfirmPassword" placeholder="">
                </div>
              </div>
              <!-- /.box-body -->
          </div>
          <!-- /.box -->
		</div>
      </div>
	  <div class="row">
		 <div class="col-xs-12">
			<a class="btn btn-default pull-right margin" href="{$smarty.const.ROOT_HTTP_PATH}/userManager.php">Cancel</a>
			<button type="button" class="btn btn-info pull-right margin adminPersonnelSave">Done</button>
		 </div>
	  </div>
	   </form>
      <!-- /.row -->
	  
	 {include file="rolesDescription.tpl"}
	  
{/strip}	 
{/block}