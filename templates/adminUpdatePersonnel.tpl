{extends file='layout.tpl'}
{strip}
{block name=title}{$SiteTitle} - Admin{/block}
{block name=header}
<script type="text/javascript">
$(document).ready(function(){
	
	$('.user_qb_ref_id').chosen({ width:"100%"});
	
	$('body').on('click', '.adminPersonnelSave', function(){
		
		var userFirstName = $('.userFirstName').val();
		var userUpdateId = $('.userUpdateId').val();
		var userLastName = $('.userLastName').val();
		var user_qb_ref_id = $('.user_qb_ref_id').val();
		var userRole = $('.userRole').val();
		var userEmail = $('.userEmail').val();
		var userEmailExist = $('.userEmailExist').val();
		
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
		
		if(userRole==''){
            showMessage('{$smarty.const.ERR_USER_ROLE}');
            $('.userRole').focus();
            return false;
        }
		
		
		$.ajax({
                url: 'ajax/adminPersonnel.php?rand='+Math.random(),
                type: 'post',
                dataType: 'json',
                data: { checkUserEmailExistForUpdate: 1,  userEmailData: userEmail, userUpdateId:userUpdateId },
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
							data: { updateAdminPersonnel: 1, userFirstNameData: userFirstName, userLastNameData: userLastName, userRoleData: userRole, user_qb_ref_id:user_qb_ref_id,  userEmailData: userEmail, userEmailExist:userEmailExist,  userUpdateId:userUpdateId },
							success: function(response) {
								checkResponseRedirect(response);
								showMessage(response.message);
								window.location = "{$smarty.const.ROOT_HTTP_PATH}/userManager.php";
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
		<div class="row " >
   <div class="col-md-12">
         <div class="box box-primary">
		  <div class="box-body">
      <div class="row">
		<div class="col-md-12">
          <!-- general form elements -->
		   {if $outputErrorArray}
			{foreach $outputErrorArray as $val}
				<P style="color:red;">{$val}<p>
			{/foreach}
			{/if}
          <div class="">
         
            <!-- form start -->
			<input type="hidden" class="userUpdateId" name="userUpdateId"  id="userUpdateId" value="{$userUpdateId}" >
              <div class="box-body">
                <div class="form-group col-sm-3">
                  <label for="userFirstName">First Name</label>
                  <input type="type" class="form-control userFirstName" id="userFirstName" value="{$userData.user_fname}" placeholder="">
                </div>
				<div class="form-group col-sm-3">
                  <label for="userLastName">Last Name</label>
                  <input type="type" class="form-control userLastName" id="userLastName" value="{$userData.user_lname}" placeholder="">
                </div>
				<div class="form-group col-sm-3">
                  <label for="userEmail">Email</label>
                  <input type="type" class="form-control userEmail" value="{$userData.user_email}" id="userEmail" placeholder="">
				  <input type="hidden" class="form-control userEmailExist" value="{$userData.user_email}" id="userEmailExist" placeholder="">
				  
                </div>
				
				<div class="form-group col-sm-3">
                  <label for="userRole">Role</label>
                  <select class="form-control userRole" id="userRole">
					 {$rolesArray}
					 {if $rolesArray}
						{foreach $rolesArray as $key=> $value}
							 <option {if $value.user_role_id==$userData.user_role_id}selected="selected"{/if} value="{$value.user_role_id}">{$value.user_role_name}</option>
						{/foreach}
					{/if}
                  </select>
                </div>
				
				<div class="form-group col-sm-3">
				  <label for="user_qb_ref_id">QB Associated Name</label>
					<select class="form-control user_qb_ref_id" id="user_qb_ref_id">
					<option value="">--- Select QB Associated Name ---</option>
					{if $outputArray}
					{foreach $outputArray as $key=> $value}
					<option {if $value->Id==$userData.user_qb_ref_id}selected="selected"{/if} value="{$value->Id}">{$value->DisplayName}</option>
					{/foreach}
					{/if}
					</select>
				</div>
              </div>
			 
              <!-- /.box-body -->
          </div>
          <!-- /.box -->
		</div>    
		</div>
			<a class="btn btn-default pull-right margin" href="{$smarty.const.ROOT_HTTP_PATH}/userManager.php">Cancel</a>
			<button type="button" class="btn btn-info pull-right margin adminPersonnelSave">Done</button>
			 {include file="rolesDescription.tpl"}
  
	</div>    
		</div></div>    
		</div>
	   </form>
      <!-- /.row -->
	  
	  
{/strip}	 
{/block}