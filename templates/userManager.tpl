{extends file='layout.tpl'}
{strip}
{block name=title}{$SiteTitle} - Admin{/block}
{block name=header}
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
{/block}
{block name=content}

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
				
				<div class="form-group col-sm-6 qbIdStatus">
				  <label for="user_qb_ref_id">QB Associated Name</label>
					<select class="form-control user_qb_ref_id" id="user_qb_ref_id">
					<option value="">--- Select QB Associated Name ---</option>
					{if $outputArray}
					{foreach $outputArray as $key=> $value}
					<option value="{$value->Id}">{$value->DisplayName}</option>
					{/foreach}
					{/if}
					</select>
				</div>
				
              </div>
              <!-- /.box-body -->
				
		</div>
		</div>
		 <button type="button" class="btn btn-default pull-right margin adminPersonnelCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin adminPersonnelSave">Done</button>
			{include file="rolesDescription.tpl"}
      </div>
           
         </div>
   </div>
</div>


<div class="row">
	
   <div class="col-sm-12">
	{if $outputErrorArray}
		{foreach $outputErrorArray as $val}
			<P style="color:red;">{$val}<p>
		{/foreach}
	{/if}
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
                     {$userManagerArray}
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
						 {if $rolesArray}
							{foreach $rolesArray as $key=> $value}
								 <option value="{$value.user_role_id}">{$value.user_role_name}</option>
							{/foreach}
						{/if}
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_USER}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okUserDelButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelUserDelButton">{$smarty.const.LBL_NO}</a>
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
	  
{/block}
{/strip}