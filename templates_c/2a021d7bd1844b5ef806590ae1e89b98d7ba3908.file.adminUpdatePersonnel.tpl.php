<?php /* Smarty version Smarty-3.1.11, created on 2018-03-07 17:17:31
         compiled from "/home/galileotechmedia/public_html/app/templates/adminUpdatePersonnel.tpl" */ ?>
<?php /*%%SmartyHeaderCode:16165238235aa064fbe44921-85936151%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2a021d7bd1844b5ef806590ae1e89b98d7ba3908' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/adminUpdatePersonnel.tpl',
      1 => 1519124470,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
    '3377116cc951593f297b34303bfc7963f5987aad' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/rolesDescription.tpl',
      1 => 1519124492,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '16165238235aa064fbe44921-85936151',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'lastPage' => 0,
    'pageLink' => 0,
    'messages' => 0,
    'content' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5aa064fbe8e273_98737680',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5aa064fbe8e273_98737680')) {function content_5aa064fbe8e273_98737680($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Admin</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
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
            showMessage('<?php echo @ERR_USER_FIRST_NAME;?>
');
            $('.userFirstName').focus();
            return false;
        }
		
		if(userLastName==''){
            showMessage('<?php echo @ERR_USER_LAST_NAME;?>
');
            $('.userLastName').focus();
            return false;
        }
		
		if(userEmail==''){
            showMessage('<?php echo @ERR_USER_EMAIL;?>
');
            $('.userEmail').focus();
            return false;
        }
		
		if(! validateEmail(userEmail)){
			 showMessage('<?php echo @ERR_INVALID_USER_EMAIL;?>
');
			 $('.userEmail').focus();
             return false;
		}
		
		if(userRole==''){
            showMessage('<?php echo @ERR_USER_ROLE;?>
');
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
						showMessage('<?php echo @ERR_USER_EMAIL_EXISTS;?>
');
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
								window.location = "<?php echo @ROOT_HTTP_PATH;?>
/userManager.php";
							}		
						});
					}
                }		
         });
		
		
		
		
	
		
    });	
	
		
});	


</script> 

   </head>
  <body class="skin-blue sidebar-mini sidebar-collapse">
<div class="wrapper">
      <?php echo $_smarty_tpl->getSubTemplate ("layout/body_header_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
<?php echo $_smarty_tpl->getSubTemplate ("layout/left_menu.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
<div class="content-wrapper"><section class="content-header"><h1><?php echo $_smarty_tpl->tpl_vars['lastPage']->value;?>
</h1><ol class="breadcrumb"><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/dashboard.php"><i class="fa fa-dashboard"></i> Home</a></li><?php if ($_smarty_tpl->tpl_vars['pageLink']->value){?><li><?php echo $_smarty_tpl->tpl_vars['pageLink']->value;?>
</li><?php }?><li class="active"><?php echo $_smarty_tpl->tpl_vars['lastPage']->value;?>
</li></ol></section><div id="Messages" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;<?php }?>"><div id="inner_message"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div></div><div id="MessagesAuto" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;z-index:99999999;<?php }?>"><div id="inner_Auto" class="text-center"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div></div><section class="content">

		<form role="form" method="post">
		<div class="row " >
   <div class="col-md-12">
         <div class="box box-primary">
		  <div class="box-body">
      <div class="row">
		<div class="col-md-12">
          <!-- general form elements -->
		   <?php if ($_smarty_tpl->tpl_vars['outputErrorArray']->value){?>
			<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['outputErrorArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
?>
				<P style="color:red;"><?php echo $_smarty_tpl->tpl_vars['val']->value;?>
<p>
			<?php } ?>
			<?php }?>
          <div class="">
         
            <!-- form start -->
			<input type="hidden" class="userUpdateId" name="userUpdateId"  id="userUpdateId" value="<?php echo $_smarty_tpl->tpl_vars['userUpdateId']->value;?>
" >
              <div class="box-body">
                <div class="form-group col-sm-3">
                  <label for="userFirstName">First Name</label>
                  <input type="type" class="form-control userFirstName" id="userFirstName" value="<?php echo $_smarty_tpl->tpl_vars['userData']->value['user_fname'];?>
" placeholder="">
                </div>
				<div class="form-group col-sm-3">
                  <label for="userLastName">Last Name</label>
                  <input type="type" class="form-control userLastName" id="userLastName" value="<?php echo $_smarty_tpl->tpl_vars['userData']->value['user_lname'];?>
" placeholder="">
                </div>
				<div class="form-group col-sm-3">
                  <label for="userEmail">Email</label>
                  <input type="type" class="form-control userEmail" value="<?php echo $_smarty_tpl->tpl_vars['userData']->value['user_email'];?>
" id="userEmail" placeholder="">
				  <input type="hidden" class="form-control userEmailExist" value="<?php echo $_smarty_tpl->tpl_vars['userData']->value['user_email'];?>
" id="userEmailExist" placeholder="">
				  
                </div>
				
				<div class="form-group col-sm-3">
                  <label for="userRole">Role</label>
                  <select class="form-control userRole" id="userRole">
					 <?php echo $_smarty_tpl->tpl_vars['rolesArray']->value;?>

					 <?php if ($_smarty_tpl->tpl_vars['rolesArray']->value){?>
						<?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['rolesArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							 <option <?php if ($_smarty_tpl->tpl_vars['value']->value['user_role_id']==$_smarty_tpl->tpl_vars['userData']->value['user_role_id']){?>selected="selected"<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_name'];?>
</option>
						<?php } ?>
					<?php }?>
                  </select>
                </div>
				
				<div class="form-group col-sm-3">
				  <label for="user_qb_ref_id">QB Associated Name</label>
					<select class="form-control user_qb_ref_id" id="user_qb_ref_id">
					<option value="">--- Select QB Associated Name ---</option>
					<?php if ($_smarty_tpl->tpl_vars['outputArray']->value){?>
					<?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['outputArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
					<option <?php if ($_smarty_tpl->tpl_vars['value']->value->Id==$_smarty_tpl->tpl_vars['userData']->value['user_qb_ref_id']){?>selected="selected"<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['value']->value->Id;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value->DisplayName;?>
</option>
					<?php } ?>
					<?php }?>
					</select>
				</div>
              </div>
			 
              <!-- /.box-body -->
          </div>
          <!-- /.box -->
		</div>    
		</div>
			<a class="btn btn-default pull-right margin" href="<?php echo @ROOT_HTTP_PATH;?>
/userManager.php">Cancel</a>
			<button type="button" class="btn btn-info pull-right margin adminPersonnelSave">Done</button>
			 <?php /*  Call merged included template "rolesDescription.tpl" */
$_tpl_stack[] = $_smarty_tpl;
 $_smarty_tpl = $_smarty_tpl->setupInlineSubTemplate("rolesDescription.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0, '16165238235aa064fbe44921-85936151');
content_5aa064fbe8c0b1_61052454($_smarty_tpl);
$_smarty_tpl = array_pop($_tpl_stack); /*  End of included template "rolesDescription.tpl" */?>
  
	</div>    
		</div></div>    
		</div>
	   </form>
      <!-- /.row -->
	  
	  
	 
</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?><?php /* Smarty version Smarty-3.1.11, created on 2018-03-07 17:17:31
         compiled from "/home/galileotechmedia/public_html/app/templates/rolesDescription.tpl" */ ?>
<?php if ($_valid && !is_callable('content_5aa064fbe8c0b1_61052454')) {function content_5aa064fbe8c0b1_61052454($_smarty_tpl) {?>
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>ROLE</th>
					<th>ACCESS TO</th>
					<th>NOTES</th>	
                </tr>
                </thead>
                <tbody>
                <tr>
                  <td>FULL ACCESS</td> 
					<td>ALL MARHSA CODES<br>
ALL PROJECTS<br>
ALL TASKS<br>
ALL BILLING RATES<br>
ALL CONSULTANT RATES<br>
ALL INVOICES : CREATE, EDIT,  SUBMIT AND CHECK STATUS<br>
ADD PERSONNEL<br>
CREATE USER NAMES AND PASSWORDS</td>
					<td>NOTE TO DEVELOPER: THIS PERSON HAS ACCESS EDIT ENTIRE MODULE</td>
					
                </tr>
				<tr>
					<td>BILLING</td>
					<td>ACCESS TO QUICKBOOKS</td>
					<td>NOTE TO DEVELOPER THIS USER HAS ONLY ACCESS TO BILLABLE RATES ASSIGNED.</td>
                </tr>
				<tr>
					<td>PROJECT MANAGER</td>
					<td>ASSIGNED CONSULTANT RATES<br>
INVOICES : CREATE,   EDIT AND CHECK STATUS<br>
CAN VIEW ASSIGNED PROJECTS <br>
CAN CREATE TASKS IN TASK MANAGER CONTENT</td>
					<td>NOTE TO DEVELOPER THIS USER HAS ONLY ACCESS TO INFORMATION THEY ARE ASSIGNED</td>
					
                </tr>
				<tr>
					<td>CONSULTANT</td>
					<td>VIEW ASSIGNED TASK<br>
INVOICES : CREATE, EDIT,  SUBMIT AND CHECK STATUS<br>
**USER NAME : JOHN CONOLLY HAS ACCESS TO TASK MANAGER KEYWORD RESEARCH**</td>
					<td>NOTE TO DEVELOPER THIS USER HAS ONLY ACCESS TO INFORMATION THEY ARE ASSIGNED</td>
                </tr>
                </tbody>
              </table>
<?php }} ?>