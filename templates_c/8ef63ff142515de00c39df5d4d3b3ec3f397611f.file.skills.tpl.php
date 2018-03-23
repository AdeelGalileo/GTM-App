<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:10:41
         compiled from "/home/galileotechmedia/public_html/app/templates/skills.tpl" */ ?>
<?php /*%%SmartyHeaderCode:7390604125a9591111a4c78-26623387%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8ef63ff142515de00c39df5d4d3b3ec3f397611f' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/skills.tpl',
      1 => 1519750982,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '7390604125a9591111a4c78-26623387',
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
  'unifunc' => 'content_5a9591111ea7a3_89942763',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a9591111ea7a3_89942763')) {function content_5a9591111ea7a3_89942763($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Skills</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
<style>
.ajax-upload-dragdrop{ width:auto !important;}
</style>
<script type="text/javascript">
   var strClassSkills;
   var skillFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdSkill = 0;
   var sortIdSkill = 0;
   var searchByWriter=0;
   var skillFilterSkillId=0;
   
  $(document).ready(function(){
	  
	<?php if ($_SESSION['sessionClientId']==@MARRIOTT_CLIENT_ID){?>    
    
	
	<?php }?>
		
	loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
	
	$('.skillFilterRangeStatus').hide();
	$('.searchByWriter').chosen({ width:"100%"});
	$('.cons_user_id').chosen({ width:"100%"});
	$(".cons_service_type_id").chosen({ width:"100%"});
	$(".skillFilterSkillBy").chosen({ width:"100%"});
   
	$( ".skillFilterBy" ).change(function() {
		skillFilterBy =  $(this).val();
		if(skillFilterBy == 2){
			$('.skillFilterRangeStatus').show();
			$('.skillFilterUser').hide();
			$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
			$('.skillFilterSkill').hide();
		}
		else{
			if(skillFilterBy == 3){
				$('.skillFilterRangeStatus').hide();
				$('.skillFilterUser').show();
				$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
				$('.skillFilterSkill').hide();
			}
			else if(skillFilterBy == 5){
				$('.skillFilterRangeStatus').hide();
				$('.skillFilterUser').hide();
				$('.skillFilterSkill').show();
				$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
			}
			else if(skillFilterBy == 4){
				$('.skillFilterUser').show();
				$('.skillFilterSkill').show();
				$(".skillFilterSkill .allFilterTop").addClass("allFilterTopStyle");
			}
			
			else
			{	
				$(".skillFilterSkill .allFilterTop").removeClass("allFilterTopStyle");
				$('.skillFilterRangeStatus').hide();
				$('.skillFilterUser').hide();
			}
		}
		
		if(skillFilterBy > 1){
			$('.resetFilters').show();
		}
	
   });
   
    $(".searchByWriter").change(function() {
		searchByWriter =  $(this).val();
		pageNo = 0;
		if(skillFilterBy == 4){
			loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
		}
		else{
			loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,$(this).val(),skillFilterSkillId);
		}
		
    });
	
	$('body').on('change', '.skillFilterSkillBy', function(){
		skillFilterSkillId = $(this).val();
		
		if(skillFilterSkillId == ""){
			return;
		}
		pageNo = 0;
		if(skillFilterBy == 4){
			loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
		}
		else{
			loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,"",$(this).val());
		}
		
    });
	
	$('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
   
	
		
	     $('body').on('click', '.descendingClassSkill', function(){
			orderIdSkill = $(this).attr('id');
			sortIdSkill = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassSkills = 'descendingClassSkill';
			var recCountValues = $('#skillPageListing').val();
			loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
		});
   
		$('body').on('click', '.ascendingClassSkill', function(){
			orderIdSkill = $(this).attr('id');
			sortIdSkill = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassSkills = 'ascendingClassSkill';
			var recCountValues = $('#skillPageListing').val();
			loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
		});
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#skillPageListing').val();
          loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
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
          var recCountValues = $('#skillPageListing').val();
          loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#skillPageListing').val();
          loadSkillList(recCountValues,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
      });
      $('body').on('change', '#skillPageListing', function(){
          var recCount = $(this).val();
          $('#skillPageListingNew').val(recCount);
          pageNo = 0;
		  loadSkillList(recCount,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
      });
      $('body').on('change', '#skillPageListingNew', function(){
          var recCount = $(this).val();
          $('#skillPageListing').val(recCount);
          pageNo = 0;
		  loadSkillList(recCount,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
      });	
	   
	
		
	 $('body').on('click', '.addNewSkill', function(){
			$(".addSkill").toggle();
			$(".updateSkill").hide();
	 });	
   
	   $('body').on('click', '.skillCancel', function(){
			location.reload();
	   });	
   
	   $('body').on('click', '.skillUpdateCancel', function(){
			location.reload();
	   });	

		$('body').on('click', '.skillDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
		});
		
		$('body').on('click', '.okSkillDelButton', function(){
			fieldId = $('#delFieldId').val();
			$.ajax({
				type : 'post',
				url: 'ajax/skills.php?rand='+Math.random(),
				data : { skillDelete: 1, skillDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
				}
			});
		});
		
		$('body').on('click', '.cancelSkillDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		
		$('body').on('click', '.addSkillSave', function(){
			
			var cons_user_id = $('.cons_user_id').val();
			var cons_service_type_id = $('.cons_service_type_id').val();
			var skillUpdateId = $('.skillUpdateId').val();
			
			
			if(cons_user_id==''){
				  showMessage('<?php echo @ERR_FORM_USER_ID;?>
');
				  $('.cons_user_id').focus();
				  return false;
			 }
		   
			if(cons_service_type_id==''){
				  showMessage('<?php echo @ERR_SKILL_TYPE;?>
');
				  $('.cons_service_type_id').focus();
				  return false;
			 }
			 
			 	
		   if(skillUpdateId > 0){
				actionOperand = 2;
			}
			else{
				actionOperand = 1;
			}
		   
			$.ajax({
				url: 'ajax/skills.php?rand='+Math.random(),
				type: 'post',
				dataType: 'json',
				data: { actionOperand: actionOperand, cons_user_id: cons_user_id, cons_service_type_id: cons_service_type_id, skillUpdateId: skillUpdateId},
				success: function(response) {
					checkResponseRedirect(response);
					showMessage(response.message);
					$(".addSkill").hide();
					$(".updateSkill").hide();
					loadSkillList(50,orderIdSkill,sortIdSkill,startDateParam,endDateParam,skillFilterBy,searchByWriter,skillFilterSkillId);
				}		
			});
            
      });
		
	  $('body').on('click', '.skillUpdateAction', function(){
		$(".addSkill").hide();
		$(".updateSkill").show();
		
		$('html,body').animate({
        scrollTop: $(".updateSkill").offset().top},
        'slow');
		
		var skillUpateId = $(this).attr('id').split('_')[1];
	   
		$.ajax({
			url: 'getModuleInfo.php?rand='+Math.random(),
			type:'post',
			dataType: 'json',
			data : { module: 'skillUpdate', skillUpateId: skillUpateId },
				  success: function(response) {
					checkResponseRedirect(response);
					$('.updateSkill').html("");
					$('.updateSkill').html(response.message.content);
				  }
		});
	});	
	
	
  });
   
   
   function loadSkillList(recCountValue,orderId="",sortId="",startDate="",endDate="",skillFilterBy="",writerId="",skillFilterSkillId=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#skillPageListing').val(recordCount);
      $('#skillPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'skillList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,skillFilterBy:skillFilterBy, writerId: writerId, skillFilterSkillId:skillFilterSkillId },
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
   		
   		
   		if(strClassSkills && strClassSkills!=''){
			  if(strClassSkills=='ascendingClassSkill'){
				  $('#'+orderId+'s a').removeClass('ascendingClassSkill');
				  $('#'+orderId+'s a').addClass('descendingClassSkill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllSkill th a').addClass('descendingClassSkill');
			  } else if(strClassSkills=='descendingClassSkill'){
				  $('#'+orderId+'s a').removeClass('descendingClassSkill');
				  $('#'+orderId+'s a').addClass('ascendingClassSkill').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllSkill th a').addClass('ascendingClassSkill');
			  }
			  } else {
				$('#user_fnames a').addClass('descendingClassSkill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#user_lnames a').addClass('descendingClassSkill');
				$('#user_role_names a').addClass('descendingClassSkill');
				$('#cons_created_ons a').addClass('descendingClassSkill');
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
<div class="updateSkill"></div>
<div class="row addSkill" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
			   <div class="form-group col-sm-4">
				   <label >Consultant</label>
				   <select class="form-control cons_user_id" id="cons_user_id">
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
				<div class="form-group col-sm-6">
                  <label >Skills</label>
                  <select class="form-control cons_service_type_id" multiple data-placeholder="Choose a Skills" id="cons_service_type_id">
                     <option value="">--- Select Skills ---</option>
                     <?php if ($_smarty_tpl->tpl_vars['serviceTypeArray']->value){?>
                     <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['serviceTypeArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
                     <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
</option>
                     <?php } ?>
                     <?php }?>
                  </select>
               </div>
			 </div>
			
			
            <button type="button" class="btn btn-default pull-right margin skillCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addSkillSave">Done</button>
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
                     <select class="form-control skillFilterBy" name="skillFilterBy">
                     <?php echo $_smarty_tpl->tpl_vars['skillArray']->value;?>

                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4">
               <div class="form-group skillFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="skillFilterRange" class="form-control pull-right  skillFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			    <div class="form-group skillFilterUser" style="display:none;">
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
			  <div class="form-group skillFilterSkill" style="display:none;">
					<div class="col-sm-6 allFilterTop allFilterTopStyle">
                     <label>Select Skill</label>
                  </div>
				   <div class="form-group col-sm-6 allFilterTop allFilterTopStyle">
					  <select class="form-control skillFilterSkillBy"  id="skillFilterSkillBy">
						 <option value="">--- Select Skill ---</option>
						 <?php if ($_smarty_tpl->tpl_vars['serviceTypeArray']->value){?>
						 <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['serviceTypeArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
						 <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
</option>
						 <?php } ?>
						 <?php }?>
					  </select>
				   </div>
			   </div>
			   
            </div>
			<div class="col-sm-2">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right  resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
            <div class="col-sm-3">
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewSkill"><i class="fa fa-plus"></i> Add New Skill</button>
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
							<h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_SKILL;?>
</h5>
							<table border="0" cellspacing="0" cellpadding="5" align="center">
								<tr>
									<td class="p-t-10">
										<a href="javascript:void(0);" class="btn btn-primary M2 okSkillDelButton"><?php echo @LBL_YES;?>
</a>
										<a href="javascript:void(0);" class="btn btn-default M2 cancelSkillDelButton"><?php echo @LBL_NO;?>
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

    $('.skillFilterRange').daterangepicker({
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