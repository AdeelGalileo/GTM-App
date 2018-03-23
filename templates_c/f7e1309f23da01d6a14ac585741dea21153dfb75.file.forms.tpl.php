<?php /* Smarty version Smarty-3.1.11, created on 2018-03-07 17:20:09
         compiled from "/home/galileotechmedia/public_html/app/templates/forms.tpl" */ ?>
<?php /*%%SmartyHeaderCode:4237208015aa0659974a496-48286587%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f7e1309f23da01d6a14ac585741dea21153dfb75' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/forms.tpl',
      1 => 1519124483,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '4237208015aa0659974a496-48286587',
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
  'unifunc' => 'content_5aa06599790bc9_15086793',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5aa06599790bc9_15086793')) {function content_5aa06599790bc9_15086793($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Forms</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
<style>
.ajax-upload-dragdrop{ width:auto !important;}
</style>
<script type="text/javascript">
   var strClassForms;
   var formFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdForm = 0;
   var sortIdForm = 0;
   var userIdFilter = 0;
   
  $(document).ready(function(){
		
		
	    loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
	   
	     $('body').on('click', '.descendingClassForm', function(){
			orderIdForm = $(this).attr('id');
			sortIdForm = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassForms = 'descendingClassForm';
			var recCountValues = $('#formPageListing').val();
			loadFormList(recCountValues,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
		});
   
		$('body').on('click', '.ascendingClassForm', function(){
			orderIdForm = $(this).attr('id');
			sortIdForm = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassForms = 'ascendingClassForm';
			var recCountValues = $('#formPageListing').val();
			loadFormList(recCountValues,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
		});
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#formPageListing').val();
          loadFormList(recCountValues,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
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
          var recCountValues = $('#formPageListing').val();
          loadFormList(recCountValues,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#formPageListing').val();
          loadFormList(recCountValues,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
      });
      $('body').on('change', '#formPageListing', function(){
          var recCount = $(this).val();
          $('#formPageListingNew').val(recCount);
          pageNo = 0;
		  loadFormList(recCount,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
      });
      $('body').on('change', '#formPageListingNew', function(){
          var recCount = $(this).val();
          $('#formPageListing').val(recCount);
          pageNo = 0;
		  loadFormList(recCount,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,userIdFilter);
      });	
	   
	$('.formFilterRangeStatus').hide();
	$('.searchByWriter').chosen({ width:"auto"});
	$('.roleFilterBy').chosen({ width:"100%"});
   
   $( ".formFilterBy" ).change(function() {
		formFilterBy =  $(this).val();
		if(formFilterBy == 2){
			$('.formFilterRangeStatus').show();
			$('.formFilterUser').hide();
			$('.roleFilter').hide();
		}
		else if(formFilterBy == 4){
			$('.formFilterRangeStatus').hide();
			$('.roleFilter').show();
			$('.formFilterUser').hide();
		}
		else{
			if(formFilterBy == 3){
				$('.formFilterRangeStatus').hide();
				$('.formFilterUser').show();
				$('.roleFilter').hide();
			}
			else
			{
				$('.formFilterRangeStatus').hide();
				$('.formFilterUser').hide();
				$('.roleFilter').hide();
			}
		}
		
		if(formFilterBy > 1){
			$('.resetFilters').show();
		}
	
		formFilterRangeVal =  $('.formFilterRange').val();
		if(formFilterRangeVal.length > 0){
			formFilterRangeVal=formFilterRangeVal.split('-');
			startDateParam = formFilterRangeVal[0].trim();
			endDateParam = formFilterRangeVal[1].trim();
			loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy);
		}
   });
   
    $( ".searchByWriter" ).change(function() {
		searchByWriter =  $(this).val();
		loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,searchByWriter);
    });
	
	$('body').on('change', '.roleFilterBy', function(){
		var roleId = $(this).val();
		
		if(roleId == ""){
			return;
		}
		loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy,"",roleId);
    });
	
	$('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
	 $('body').on('click', '.applyBtn, .ranges', function(){
		formFilterRangeVal =  $('.formFilterRange').val();
		if(formFilterRangeVal.length > 0){
			formFilterRangeVal=formFilterRangeVal.split('-');
			startDateParam = formFilterRangeVal[0].trim();
			endDateParam = formFilterRangeVal[1].trim();
			loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy);
		}
	 });
		
	 $('body').on('click', '.addNewForm', function(){
			$(".addForm").toggle();
			$(".updateForm").hide();
	 });	
   
	   $('body').on('click', '.formCancel', function(){
			location.reload();
	   });	
   
	   $('body').on('click', '.formUpdateCancel', function(){
			location.reload();
	   });	

		$('body').on('click', '.formDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
		});
		
		$('body').on('click', '.okFormDelButton', function(){
			fieldId = $('#delFieldId').val();
			$.ajax({
				type : 'post',
				url: 'ajax/form.php?rand='+Math.random(),
				data : { formDelete: 1, formDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy);
				}
			});
		});
		
		$('body').on('click', '.cancelFormDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		 $('body').on('click', '.formUpdateAction', function(){
			$(".addForm").hide();
			$(".updateForm").show();
			var formId = $(this).attr('id').split('_')[1];
			var attrFormUserId = $(this).attr('attrFormUserId');
				$.ajax({
					url: 'getModuleInfo.php?rand='+Math.random(),
					type:'post',
					dataType: 'json',
					data : { module: 'formUpdate', formUpdateId: formId, attrFormUserId:attrFormUserId },
						  success: function(response) {
							  checkResponseRedirect(response);
							  $('.updateForm').html("");
							  $('.updateForm').html(response.message.content);
						  }
				});
			});	
		
		
		 $('#form_user_id').chosen({ width:"100%"});
		 
		$('body').on('click', '.addFormSave', function(){
			
			var form_user_id = $('.form_user_id').val();
			var form_first_name = $('.form_first_name').val();
			var form_last_name = $('.form_last_name').val();
			var form_email = $('.form_email').val();
			var form_contact_no = $('.form_contact_no').val();
			var form_street = $('.form_street').val();
			var form_city = $('.form_city').val();
			var form_state = $('.form_state').val();
			var form_zipcode = $('.form_zipcode').val();
			var form_country = $('.form_country').val();
			var form_notes = $('.form_notes').val();
			var form_needed = $('.form_needed').val();
			var formUpdateId = $('.formUpdateId').val();
			
			if(form_user_id==''){
				  showMessage('<?php echo @ERR_FORM_USER_ID;?>
');
				  $('.form_user_id').focus();
				  return false;
			 }
		   
		  
		   if(formUpdateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/form.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand, form_user_id: form_user_id, form_first_name: form_first_name, form_last_name: form_last_name, form_email: form_email, form_contact_no:  form_contact_no , form_street:  form_street ,form_city :form_city, form_state :form_state, form_zipcode :form_zipcode, form_country :form_country, form_notes :form_notes , form_needed :form_needed, formUpdateId:  formUpdateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addForm").hide();
					$(".updateForm").hide();
					/*loadFormList(50,orderIdForm,sortIdForm,startDateParam,endDateParam,formFilterBy);*/
					location.reload();
				}		
			});
            
      });
		
	  
	var settings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "w9Form",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadW9').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   $("#mulitplefileuploaderW9").uploadFile(settings);
		
	var resumeSettings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "resumeForm",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadResume').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   $("#mulitplefileuploaderResume").uploadFile(resumeSettings);
   
   var achFormSettings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "achForm",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadAch').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   $("#mulitplefileuploaderAch").uploadFile(achFormSettings);
   
   var agreementSettings = {
		url: "forms.php",
		method: "POST",
		allowedTypes: "jpg,jpeg,png,pdf,doc,docx",
		fileName: "agreementForm",
		multiple: false,
		dataType: "json",
		showStatusAfterSuccess: false,
		showStatusAfterSuccess:false,
		onSuccess:function(files,data,xhr){
		$('#fileUploadAgreement').html('<span class="fa fa-check-circle-o m-r-5"></span><?php echo @MSG_FILE_UPLOAD_SUCCESS;?>
');
		},
		onError: function(files,status,errMsg){
			$("#status").html("<font color='red'>Upload is Failed</font>");
		}
   }
   $("#mulitplefileuploaderAgreement").uploadFile(agreementSettings);
   
  });
   
   function loadFormList(recCountValue,orderId="",sortId="",startDate="",endDate="",formFilterBy="",writerId="",roleId=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#formPageListing').val(recordCount);
      $('#formPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'formList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,formFilterBy:formFilterBy, writerId: writerId, filterRoleId:roleId },
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
   		
   		
   		if(strClassForms && strClassForms!=''){
			  if(strClassForms=='ascendingClassForm'){
				  $('#'+orderId+'s a').removeClass('ascendingClassForm');
				  $('#'+orderId+'s a').addClass('descendingClassForm').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllForm th a').addClass('descendingClassForm');
			  } else if(strClassForms=='descendingClassForm'){
				  $('#'+orderId+'s a').removeClass('descendingClassForm');
				  $('#'+orderId+'s a').addClass('ascendingClassForm').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllForm th a').addClass('ascendingClassForm');
			  }
			  } else {
				$('#user_fnames a').addClass('descendingClassForm').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#user_lnames a').addClass('descendingClassForm');
				$('#user_role_names a').addClass('descendingClassForm');
				$('#form_notes a').addClass('descendingClassForm');
				$('#form_neededs a').addClass('descendingClassForm');
				$('#form_created_ons a').addClass('descendingClassForm');
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
<div class="updateForm"></div>
<div class="row addForm" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
           <div class="form-group col-sm-4">
               <label >Consultant</label>
               <select class="form-control form_user_id" id="form_user_id">
                  <option value="">--- Select Consultant ---</option>
                  <?php if ($_smarty_tpl->tpl_vars['userArray']->value){?>
                  <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['userArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
					<option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
</option>
                  <?php } ?>
                  <?php }?>
               </select>
            </div>
            <div class="form-group col-sm-4">
               <label >W9</label>
				<span id="mulitplefileuploaderW9">
				<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
				</span>
				<span id="fileUploadW9" class="font14 bold blue"></span>
            </div>
           
			 <div class="form-group col-sm-4">
                <label >Resume</label>
				<span id="mulitplefileuploaderResume">
				<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
				</span>
				<span id="fileUploadResume" class="font14 bold blue"></span>
            </div>
			 </div>
			 <div class="row">
				<div class="form-group col-sm-4">
					<label >ACH Form</label>
					<span id="mulitplefileuploaderAch">
					<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
					</span>
					<span id="fileUploadAch" class="font14 bold blue"></span>
				</div>
				<div class="form-group col-sm-4">
					<label >Consultant Agreement</label>
					<span id="mulitplefileuploaderAgreement">
					<a href="javascript:void(0);" class="btn btn-primary" id="uploadHtml">Upload</a>
					</span>
					<span id="fileUploadAgreement" class="font14 bold blue"></span>
				</div>
				 
			 </div>
			
			
		
            <button type="button" class="btn btn-default pull-right margin formCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addFormSave">Done</button>
         </div>
      </div>
   </div>
</div>
<div class="row">
   <div class="col-sm-12">
      <div class="box box-primary">
         <div class="box-header ">
         </div>
         <div class="row ">
            <div class="col-sm-3">
               <div class="form-group">
                  <div class="col-sm-6">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-6">
                     <select class="form-control formFilterBy" name="formFilterBy">
                     <?php echo $_smarty_tpl->tpl_vars['formFilterArray']->value;?>

                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-3">
               <div class="form-group formFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="formFilterRange" class="form-control pull-right  formFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			    <div class="form-group formFilterUser" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Consultant</label>
                  </div>
                  <div class="col-sm-6">
                   <select class="form-control searchByWriter" id="searchByWriter">
                     <option value="">--- Select Consultant ---</option>
                     <?php if ($_smarty_tpl->tpl_vars['userArray']->value){?>
                     <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['userArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
                     <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
</option>
                     <?php } ?>
                     <?php }?>
                  </select>
                  </div>
                  <!-- /.input group -->
               </div>
			   <div class="form-group roleFilter" style="display:none;">
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
			<div class="col-sm-3">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right  resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-3">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewForm"><i class="fa fa-plus"></i> Add New Form</button>
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
							<h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_FORM;?>
</h5>
							<table border="0" cellspacing="0" cellpadding="5" align="center">
								<tr>
									<td class="p-t-10">
										<a href="javascript:void(0);" class="btn btn-primary M2 okFormDelButton"><?php echo @LBL_YES;?>
</a>
										<a href="javascript:void(0);" class="btn btn-default M2 cancelFormDelButton"><?php echo @LBL_NO;?>
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
	
	<script>
   $(function () {
   
     $('[data-mask]').inputmask();
   
     //Date range picker
    var start = moment().subtract(29, 'days');
    var end = moment();

    function cb(start, end) {
       
    }

    $('.formFilterRange').daterangepicker({
        startDate: start,
        endDate: end,
		autoclose: false,
        ranges: {
           'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);

    cb(start, end);
	
   
   
     //Date picker
     $('.datepicker').datepicker({
       autoclose: true,
		format: "mm/dd/yyyy"
     });
   
     //iCheck for checkbox and radio inputs
     $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
       checkboxClass: 'icheckbox_minimal-blue',
       radioClass   : 'iradio_minimal-blue'
     });
   
     //Red color scheme for iCheck
     $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
       checkboxClass: 'icheckbox_minimal-red',
       radioClass   : 'iradio_minimal-red'
     });
   
     //Flat red color scheme for iCheck
     $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
       checkboxClass: 'icheckbox_flat-green',
       radioClass   : 'iradio_flat-green'
     });
   
     //Colorpicker
     $('.my-colorpicker1').colorpicker();
     //color picker with addon
     $('.my-colorpicker2').colorpicker();
   
     //Timepicker
     $('.timepicker').timepicker({
       showInputs: false
     });
   });
</script>
</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?>