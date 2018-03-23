<?php /* Smarty version Smarty-3.1.11, created on 2018-03-16 22:16:27
         compiled from "/home/galileotechmedia/public_html/app/templates/userManager.tpl" */ ?>
<?php /*%%SmartyHeaderCode:15797248945a959987b05746-18679342%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6879cec240b993b291237fcfde1f62af1ea11e25' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/userManager.tpl',
      1 => 1521252980,
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
  'nocache_hash' => '15797248945a959987b05746-18679342',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959987b4cd44_03956067',
  'variables' => 
  array (
    'lastPage' => 0,
    'pageLink' => 0,
    'messages' => 0,
    'content' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959987b4cd44_03956067')) {function content_5a959987b4cd44_03956067($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Admin</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
<script type="text/javascript">
var strClassUser;
var orderIdUser = 0;
var sortIdUser = 0;
var userFilterBy;
var roleIdFilter=0;
var formIdFilter=0;
$(document).ready(function(){
	
	$('.user_qb_ref_id').chosen({ width:"100%"});
	
	loadUserList(50,orderIdUser,sortIdUser);
	
	$('.roleFilterBy').chosen({ width:"100%"});
	$('.formFilterBy').chosen({ width:"100%"});
	
	$( ".userFilterBy" ).change(function() {
		userFilterBy =  $(this).val();
		if(userFilterBy == 2){
			$('.roleFilter').show();
			$('.formFilter').hide();
			$(".formFilter .allFilterTop").removeClass("allFilterTopStyle");
			
		}
		else{
			if(userFilterBy == 3){
				$('.formFilter').show();
				$('.roleFilter').hide();
				$(".formFilter .allFilterTop").removeClass("allFilterTopStyle");
			}
			else if(userFilterBy == 4){
				$('.formFilter').show();
				$('.roleFilter').show();
				$(".formFilter .allFilterTop").addClass("allFilterTopStyle");
			}
			else
			{
				$(".formFilter .allFilterTop").removeClass("allFilterTopStyle");	
				$('.formFilter').hide();
				$('.roleFilter').hide();
			}
		}
		if(userFilterBy > 1){
			$('.resetFilters').show();
		}
   });
	
	$('body').on('change', '.roleFilterBy', function(){
		roleIdFilter = $(this).val();
		if(roleIdFilter == ""){
			return;
		}
		pageNo = 0;
		if(userFilterBy == 4){
			loadUserList(50,orderIdUser,sortIdUser,userFilterBy,roleIdFilter);
		}
		else{
			loadUserList(50,orderIdUser,sortIdUser,userFilterBy,$(this).val());
		}
    });
	
	$('body').on('change', '.formFilterBy', function(){
		formIdFilter = $(this).val();
		
		if(formIdFilter == ""){
			return;
		}
		pageNo = 0;
		if(userFilterBy == 4){
			loadUserList(50,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
		}
		else{
			loadUserList(50,orderIdUser,sortIdUser,userFilterBy,"",$(this).val());
		}
		
    });
	
		
	$('body').on('click', '.descendingClassUser', function(){
        orderIdUser = $(this).attr('id');
        sortIdUser = 2;
		pageNo = $('#pageDropDownValue').val();
        strClassUser = 'descendingClassUser';
		var recCountValues = $('#userPageListing').val();
        loadUserList(recCountValues,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });
	
	 $('body').on('click', '.ascendingClassUser', function(){
        orderIdUser = $(this).attr('id');
        sortIdUser = 1;
		pageNo = $('#pageDropDownValue').val();
		strClassUser = 'ascendingClassUser';
		var recCountValues = $('#userPageListing').val();
        loadUserList(recCountValues,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });
	
    
   /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
    $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
        event.preventDefault();
        var links = $('#paginationAuto .pageDropDown').val();
        pageNo = parseInt(links, 10);
        pageNo = pageNo+1;
        $( "#paginationAuto .pageDropDown" ).val(pageNo);
        $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
        var recCountValues = $('#userPageListing').val();
        loadUserList(recCountValues,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });
    $('body').on('click', '#paginationAuto .pagination-nav .leftArrowClass, #paginationAutoNew .pagination-nav .leftArrowClass', function(event){
        event.preventDefault();
        var links = $('#paginationAuto .pageDropDown').val();
        pageNo = parseInt(links, 10);
        pageNo = pageNo-1;
        $( "#paginationAuto .pageDropDown" ).val(pageNo);
        $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
        document.getElementById('currPageAutoID').value = '';
        $('#currPageAutoID').val(links);
        var recCountValues = $('#userPageListing').val();
        loadUserList(recCountValues,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });
    $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
        event.preventDefault();
        var linksValue = $('option:selected', this).attr('id');
        var links = $(this).val();
        if(pageNo == links) return;
        pageNo = parseInt(links, 10);
        document.getElementById('currPageAutoID').value = '';
        $('#currPageAutoID').val(links);
        var recCountValues = $('#userPageListing').val();
        loadUserList(recCountValues,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });
    $('body').on('change', '#userPageListing', function(){
        var recCount = $(this).val();
        $('#userPageListingNew').val(recCount);
        pageNo = 0;
        loadUserList(recCount,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });
    $('body').on('change', '#userPageListingNew', function(){
        var recCount = $(this).val();
        $('#userPageListing').val(recCount);
        pageNo = 0;
        loadUserList(recCount,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
    });	
	
	
	$('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
	
	
	$('body').on('click', '.userDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
	});
   
   $('body').on('click', '.cancelUserDelButton', function(){
            uiPopClose('confirmDelete');
	});
	
	$('body').on('click', '.okUserDelButton', function(){
		fieldId = $('#delFieldId').val();
		$.ajax({
			type : 'post',
			url: 'ajax/adminPersonnel.php?rand='+Math.random(),
			data : { deleteAdminPersonnel: 1, userDeleteId:fieldId },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmDelete');
				showMessage(response.message);
				loadUserList(50,orderIdUser,sortIdUser,userFilterBy,roleIdFilter,formIdFilter);
			}
		});
	});
	
	$('body').on('click', '.adminPersonnelCancel', function(){
			location.reload();
	   });	
	
	$('body').on('click', '.addNewUser', function(){
			$(".addUser").toggle();
			$(".updateUser").hide();
	});	
	
	$('body').on('click', '.adminPersonnelSave', function(){
		
		var userFirstName = $('.userFirstName').val();
		var userLastName = $('.userLastName').val();
		var userRole = $('.userRole').val();
		var userEmail = $('.userEmail').val();
		var userPassword = $('.userPassword').val();
		var userConfirmPassword = $('.userConfirmPassword').val();
		var user_qb_ref_id = $('.user_qb_ref_id').val();
		
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
		
		if(userRole==''){
            showMessage('<?php echo @ERR_USER_ROLE;?>
');
            $('.userRole').focus();
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
		
		if(userPassword==''){
            showMessage('<?php echo @ERROR_USER_PASSWORD;?>
');
            $('.userPassword').focus();
            return false;
        }
		
		if(userConfirmPassword==''){
            showMessage('<?php echo @ERROR_USER_CONFIRM_PASSWORD;?>
');
            $('.userConfirmPassword').focus();
            return false;
        }
		
		if (userPassword.toLowerCase() !== userConfirmPassword.toLowerCase()){
			 showMessage('<?php echo @ERROR_PASSWORD_MISMATCH;?>
');
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
						showMessage('<?php echo @ERR_USER_EMAIL_EXISTS;?>
');
					}
					else{
						$.ajax({
							url: 'ajax/adminPersonnel.php?rand='+Math.random(),
							type: 'post',
							dataType: 'json',
							data: { addAdminPersonnel: 1, userFirstNameData: userFirstName, userLastNameData: userLastName, userRoleData: userRole, userEmailData: userEmail, userPasswordData:  userPassword, user_qb_ref_id:user_qb_ref_id },
							success: function(response) {
								checkResponseRedirect(response);
								showMessage(response.message);
								location.reload();
							}		
						});
					}
                }		
         });
		
    });	
	

	
	
	
});	


function loadUserList(recCountValue,orderId="",sortId="",userFilter="",roleFilter="",formFilter=""){
	
	var page = pageNo ? pageNo : 1;
	
    var recordCount = recCountValue ? recCountValue : 50;
    $('#userPageListing').val(recordCount);
    $('#userPageListingNew').val(recordCount);
    /*$('#listingTabs').html(loadImg);*/

    $.ajax({
        url: 'getModuleInfo.php?rand='+Math.random(),
        type:'post',
        dataType: 'json',
        data : { module: 'userList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, userFilter:userFilter, filterRoleId:roleFilter, formFilter:formFilter  },
        success: function(response) {
            checkResponseRedirect(response);
			$('#listingTabs').html("");
            $('#listingTabs').html(response.message.content);
            $('#paginationAuto').html(response.message.pagination);
            $('#paginationAutoNew').html(response.message.pagination);
            $('#totalAutomation').html(response.message.totalRecords);
            $('#totalAutomationNew').html(response.message.totalRecords);

            if(page==1 && page <= response.message.totalPages){
                $('#paginationAuto .fa-angle-left').hide();
                $('#paginationAutoNew .fa-angle-left').hide();	
                $('#paginationAuto .fa-angle-right').show();
                $('#paginationAutoNew .fa-angle-right').show();
            } else if(page > 1  && page < response.message.totalPages){
                $('#paginationAuto .fa-angle-left').show();
                $('#paginationAutoNew .fa-angle-left').show();
                $('#paginationAuto .fa-angle-right').show();
                $('#paginationAutoNew .fa-angle-right').show();
            } else if(page == response.message.totalPages){
                $('#paginationAuto .fa-angle-right').hide();
                $('#paginationAutoNew .fa-angle-right').hide();
                $('#paginationAuto .fa-angle-left').show();
                $('#paginationAuto .fa-angle-left').css("padding", "3px 10px 0px 0px");
                $('#paginationAutoNew .fa-angle-left').show();	
                $('#paginationAutoNew .fa-angle-left').css("padding", "3px 10px 0px 0px");
            }
			
			
			if(strClassUser && strClassUser!=''){
                if(strClassUser=='ascendingClassUser'){
                    $('#'+orderId+'s a').removeClass('ascendingClassUser');
                    $('#'+orderId+'s a').addClass('descendingClassUser').prepend('<i class="fa fa-caret-up gray font13"></i>');
					$('#overAllUser th a').addClass('descendingClassUser');
                } else if(strClassUser=='descendingClassUser'){
                    $('#'+orderId+'s a').removeClass('descendingClassUser');
                    $('#'+orderId+'s a').addClass('ascendingClassUser').prepend('<i class="fa fa-caret-down gray font13"></i>');
					$('#overAllUser th a').addClass('ascendingClassUser');
                }
            } else {
				$('#user_fnames a').addClass('descendingClassUser').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#user_lnames a').addClass('descendingClassUser');
				$('#user_emails a').addClass('descendingClassUser');
				$('#user_role_names a').addClass('descendingClassUser');
				$('#user_form_completeds a').addClass('descendingClassUser');
            }
			
			
        }
    });	 
}
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

<div class="updateUser"></div>
<div class="row addUser" style="display:none;">
   <div class="col-md-12">
         <div class="box box-primary">
		  <div class="box-body">
			      <div class="row">
		<div class="col-md-12">
          <!-- general form elements -->
           
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
					 <?php if ($_smarty_tpl->tpl_vars['rolesArray']->value){?>
						<?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['rolesArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							 <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_name'];?>
</option>
						<?php } ?>
					<?php }?>
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
				
				<div class="form-group col-sm-6 qbIdStatus">
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
					<option value="<?php echo $_smarty_tpl->tpl_vars['value']->value->Id;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value->DisplayName;?>
</option>
					<?php } ?>
					<?php }?>
					</select>
				</div>
				
              </div>
              <!-- /.box-body -->
				
		</div>
		</div>
		 <button type="button" class="btn btn-default pull-right margin adminPersonnelCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin adminPersonnelSave">Done</button>
			<?php /*  Call merged included template "rolesDescription.tpl" */
$_tpl_stack[] = $_smarty_tpl;
 $_smarty_tpl = $_smarty_tpl->setupInlineSubTemplate("rolesDescription.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0, '15797248945a959987b05746-18679342');
content_5aac7a7b613031_77777809($_smarty_tpl);
$_smarty_tpl = array_pop($_tpl_stack); /*  End of included template "rolesDescription.tpl" */?>
      </div>
           
         </div>
   </div>
</div>


<div class="row">
	
   <div class="col-sm-12">
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
      <div class="box box-primary">
         <div class="box-header ">
         </div>
         <div class="row ">
			<div class="col-sm-3">
               <div class="form-group">
                  <div class="col-sm-4">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-8">
                     <select class="form-control userFilterBy" name="userFilterBy">
                     <?php echo $_smarty_tpl->tpl_vars['userManagerArray']->value;?>

                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
			<div class="col-sm-5">
				<div class="form-group  roleFilter" style="display:none;">
					  <div class="col-sm-4 ">
						 <label>Select Role</label>
					  </div>
					  <div class="col-sm-8 ">
						 <select class="form-control roleFilterBy" id="roleFilterBy" name="roleFilterBy">
						  <option value="">--- Select Role ---</option>
						 <?php if ($_smarty_tpl->tpl_vars['rolesArray']->value){?>
							<?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['rolesArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
								 <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_name'];?>
</option>
							<?php } ?>
						<?php }?>
						</select>
				     </div>
			    </div>
				<div class="form-group  formFilter" style="display:none;">
					  <div class="col-sm-4 allFilterTop allFilterTopStyle">
						 <label>Forms Completed</label>
					  </div>
					  <div class="col-sm-8 allFilterTop allFilterTopStyle">
						 <select class="form-control formFilterBy" id="formFilterBy" name="formFilterBy">
						  <option value="">--- Select Form Completed Status ---</option>
						  <option value="1">Yes</option>
						  <option value="0">No</option>
						</select>
				     </div>
			    </div>
			</div>
			<div class="col-sm-2">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right  resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-2">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewUser"><i class="fa fa-plus"></i> Add New User</button>
            </div>
         </div>
		 
		 
         <!-- /.box-header -->
         <div class="box-body">
            <div id="listingTabs"></div>
         </div>
         <!-- /.box-body -->
         <div class="row">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-4">
            </div>
            <div class="col-sm-5">
            </div>
         </div>
      </div>
      <!-- /.box -->
   </div>
   <!-- /.col -->
</div>
	  
	  <div id="confirmDelete">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmDeletePop" style="display:none;">
                    <div class="inner">
                        <input type="hidden" name="delFieldId" id="delFieldId" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_USER;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okUserDelButton"><?php echo @LBL_YES;?>
</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelUserDelButton"><?php echo @LBL_NO;?>
</a>
                                </td>
                            </tr>
                        </table>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
	  
</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?><?php /* Smarty version Smarty-3.1.11, created on 2018-03-16 22:16:27
         compiled from "/home/galileotechmedia/public_html/app/templates/rolesDescription.tpl" */ ?>
<?php if ($_valid && !is_callable('content_5aac7a7b613031_77777809')) {function content_5aac7a7b613031_77777809($_smarty_tpl) {?>
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