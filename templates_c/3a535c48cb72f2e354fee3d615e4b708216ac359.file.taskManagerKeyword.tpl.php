<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:12:23
         compiled from "/home/galileotechmedia/public_html/app/templates/taskManagerKeyword.tpl" */ ?>
<?php /*%%SmartyHeaderCode:4745364285a959177c9aa17-95152664%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '3a535c48cb72f2e354fee3d615e4b708216ac359' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/taskManagerKeyword.tpl',
      1 => 1519124500,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
    'fe48595746f164ad84270f55758bfad1b11504a6' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/uiPopup.tpl',
      1 => 1519124502,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '4745364285a959177c9aa17-95152664',
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
  'unifunc' => 'content_5a959177cf7173_98029610',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959177cf7173_98029610')) {function content_5a959177cf7173_98029610($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Task Manager Keyword</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
<script type="text/javascript">
   var strClassTask;
   var taskKeyFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdTask = 0;
   var sortIdTask = 0;
   var configDate;
   var d;
   $(document).ready(function(){
	   
	   d = new Date();
	   
	 $('body').on('keydown', '.task_keyword_no_of_pages', function(){
            if (event.shiftKey) {
                event.preventDefault();
            }

            if (event.keyCode == 46 || event.keyCode == 8) {
            }
            else {
                if (event.keyCode < 95) {
                    if (event.keyCode < 48 || event.keyCode > 57) {
                        event.preventDefault();
                    }
                }
                else {
                    if (event.keyCode < 96 || event.keyCode > 105) {
                        event.preventDefault();
                    }
                }
            }
        });
	 
	 
	$('body').on('change', '.task_keyword_service_type_id', function(){
		
		var serviceIdIp = $( this ).val();
		var task_keyword_added_box_date = $('.task_keyword_added_box_date').val();
		if(task_keyword_added_box_date){
			 d = new Date(task_keyword_added_box_date);
			 
			 if(serviceIdIp == '<?php echo @SERVICE_TYPE_KEYWORD_SETUP_ID;?>
'){
				 configDate= <?php echo @TACTIC_DUE_BUSINESS_DAY_KEYWORD_SETUP;?>
;
			 }
			 else{
				 configDate= <?php echo @TACTIC_DUE_BUSINESS_DAY_FOR_OTHERS;?>
;
			 }
			 
			 /* tacticDateVal = (startDate.getMonth() + 1) + '/' + (startDate.getDate() + configDate) + '/' +  startDate.getFullYear(); */
			 
			 tacticDateVal = addBusinessDays(d, configDate);
			 
			 $('.task_keyword_setup_due_date').val(tacticDateVal);
		 
		}
		
		$('.task_keyword_added_box_date').datepicker({
        format: "mm/dd/yyyy"
		}).on('changeDate',function(e){
			d = new Date(e.date);
		 
		 if(serviceIdIp == '<?php echo @SERVICE_TYPE_KEYWORD_SETUP_ID;?>
'){
			 configDate= <?php echo @TACTIC_DUE_BUSINESS_DAY_KEYWORD_SETUP;?>
;
		 }
		 else{
			 configDate= <?php echo @TACTIC_DUE_BUSINESS_DAY_FOR_OTHERS;?>
;
		 }
		 
		 /*tacticDateVal = (startDate.getMonth() + 1) + '/' + (startDate.getDate() + configDate) + '/' +  startDate.getFullYear();*/
		 tacticDateVal = addBusinessDays(d, configDate);
		 $('.task_keyword_setup_due_date').val(tacticDateVal);
		});
		   
	});
    

   loadTaskKeywordList(50,orderIdTask,sortIdTask);
   	
   $('body').on('click', '.descendingClassTask', function(){
          orderIdTask = $(this).attr('id');
          sortIdTask = 2;
   	pageNo = $('#pageDropDownValue').val();
          strClassTask = 'descendingClassTask';
   	var recCountValues = $('#taskPageListing').val();
          loadTaskKeywordList(recCountValues,orderIdTask,sortIdTask);
      });
   
    $('body').on('click', '.ascendingClassTask', function(){
          orderIdTask = $(this).attr('id');
          sortIdTask = 1;
   	pageNo = $('#pageDropDownValue').val();
   	strClassTask = 'ascendingClassTask';
   	var recCountValues = $('#taskPageListing').val();
          loadTaskKeywordList(recCountValues,orderIdTask,sortIdTask);
      });
   
      
     /* --------- Company LIST PAGINATION STARTS HERE ------------------- */
      $('body').on('click', '#paginationAuto .pagination-nav .rightArrowClass, #paginationAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationAuto .pageDropDown" ).val(pageNo);
          $( "#paginationAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#taskPageListing').val();
          loadTaskKeywordList(recCountValues,orderIdTask,sortIdTask);
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
          var recCountValues = $('#taskPageListing').val();
          loadTaskKeywordList(recCountValues,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#paginationAuto .pagination-nav .pageDropDown, #paginationAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoID').value = '';
          $('#currPageAutoID').val(links);
          var recCountValues = $('#taskPageListing').val();
          loadTaskKeywordList(recCountValues,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#taskPageListing', function(){
          var recCount = $(this).val();
          $('#taskPageListingNew').val(recCount);
          pageNo = 0;
          loadTaskKeywordList(recCount,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#taskPageListingNew', function(){
          var recCount = $(this).val();
          $('#taskPageListing').val(recCount);
          pageNo = 0;
          loadTaskKeywordList(recCount,orderIdTask,sortIdTask);
      });	
   
   $('.taskKeyFilterRangeStatus').hide();
    $('#divisionFilterBy').chosen({ width:"100%"});
   
   $( ".taskKeyFilterBy" ).change(function() {
   	taskKeyFilterBy =  $(this).val();
   	if(taskKeyFilterBy == 2 || taskKeyFilterBy == 3){
   		$('.taskKeyFilterRangeStatus').show();
		$('.divisionFilter').hide();
   	}
	else if(taskKeyFilterBy == 4){
		$('.taskKeyFilterRangeStatus').hide();
		$('.divisionFilter').show();
	}
   	else{
   		$('.taskKeyFilterRangeStatus').hide();
		$('.divisionFilter').hide();
   	}
   	if(taskKeyFilterBy > 1){
		$('.resetFilters').show();
	}
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
   });
   
   $('body').on('change', '.divisionFilterBy', function(){
		var divisionId = $( this ).val();
		if(divisionId == 3){
			return;
		}
		loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,divisionId);
   });
	
   $('body').on('click', '.applyBtn, .ranges', function(){
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
   });
   
   
   $('body').on('click', '.addNewTask', function(){
   	$(".addTaskManagerKeyword").toggle();
   	$(".updateTaskManagerKeyword").hide();
   });	
   
   
   $('body').on('click', '.resetFiltersAction', function(){
		location.reload();
   });	
   
   $('body').on('click', '.taskKeywordCancel', function(){
		location.reload();
   });	
   
   $('body').on('click', '.taskKeywordUpdateCancel', function(){
		location.reload();
   });	
   
   <?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?>
   
	$('#task_keyword_user_id').chosen({ width:"100%"});
	
   <?php }else{ ?>
	
		<?php if ($_SESSION['sessionClientId']==@MARRIOTT_CLIENT_ID){?>
	
			$(".task_keyword_service_type_id option[value=62]").remove();
	
		<?php }?>
	
   <?php }?>
   
   $('#task_keyword_service_type_id').chosen({ width:"100%"});
   $('#task_keyword_marsha_code').chosen({ width:"100%"});
   
   
   $('body').on('change', '.task_keyword_marsha_code', function(){
   	var marshaCodeIp = $( this ).val();
   	if(marshaCodeIp==''){
   			return false;
   	 }
   	 $.ajax({
   			url: 'ajax/clientEntity.php?rand='+Math.random(),
   			dataType: 'json',
   			 data: { getDivisionByMarshaCode:1, marshaCodeIp: marshaCodeIp },
   			 success: function(response) {
   					checkResponseRedirect(response);
   					$('.task_keyword_division').val(response.message.division_code);
   				}	
   	   });
   });
   
    $('body').on('click', '.taskKeywordDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
	});

    $('body').on('click', '.cancelTaskDelButton', function(){
            uiPopClose('confirmDelete');
	});
	
	$('body').on('click', '.okTaskDelButton', function(){
		fieldId = $('#delFieldId').val();
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordDelete: 1, taskKeywordDeleteId:fieldId },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmDelete');
				showMessage(response.message);
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	var task_complete;	
	$('body').on('click', '.taskKeywordCompleteAction', function(){
			$('#loadingOverlayEditor').show();
            var fieldId = $(this).attr('id').split('_')[1];
			var task_complete_val = $('#completeTask_'+fieldId);
			var attrCode = $(this).attr('attrCode');
			var attrDivCode = $(this).attr('attrDivCode');
			var attrUser = $(this).attr('attrUser');
			var attrServiceTypeName = $(this).attr('attrServiceTypeName');
			var attrIsSubTask = $(this).attr('attrIsSubTask');
			
			if (task_complete_val.is(':checked')) {
				task_complete = 1;
			}
			else{
				task_complete = 0;
			}
            $('#completeFieldId').val(fieldId);
			$('#attrCode').val(attrCode);
			$('#attrDivCode').val(attrDivCode);
			$('#attrUser').val(attrUser);
			$('#attrServiceTypeName').val(attrServiceTypeName);
			$('#attrIsSubTask').val(attrIsSubTask);
			
			$( ".okTaskCompButton" ).trigger( "click");
            /*$('#confirmComplete .uiContent').html($('#confirmCompletePop').html());
            uiPopupOpen('confirmComplete', 500, 125);*/
			
	});
	
	
	var task_admin_complete;	
	$('body').on('change', '.taskKeywordCompleteAdminAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
			var currentUserId = $(this).attr('currentUserId');
			var task_complete_admin_val = $('#completeAdminTask_'+fieldId).val();
			
			if (task_complete_admin_val == 1) {
				  task_admin_complete = 1;
				  $('#completeAdminFieldId').val(fieldId);
				  $('#confirmAdminComplete .uiContent').html($('#confirmAdminCompletePop').html());
				  uiPopupOpen('confirmAdminComplete', 500, 125);
			}
			else if(task_complete_admin_val == 2){
				  task_admin_complete = 2;
				  $('#completeAdminFieldId').val(fieldId);
				  $('.task_keyword_user_id_reassign option[value='+currentUserId+']').attr('selected','selected');
				  $('#confirmAdminReassign .uiContent').html($('#confirmAdminReassignPop').html());
				  uiPopupOpen('confirmAdminReassign', 500, 300);
			}
			
	});
   
   
    $('body').on('click', '.cancelTaskCompButton', function(){
          uiPopClose('confirmComplete');
		  loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.cancelAdminTaskCompButton', function(){
          uiPopClose('confirmAdminComplete');
		  loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.cancelAdminTaskReassignButton', function(){
          uiPopClose('confirmAdminReassign');
		  loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.okTaskCompButton', function(){
		$('#loadingOverlayEditor').show();
		fieldId = $('#completeFieldId').val();
		attrCode = $('#attrCode').val();
		attrDivCode = $('#attrDivCode').val();
		attrUser = $('#attrUser').val();
		attrServiceTypeName = $('#attrServiceTypeName').val();
		attrIsSubTask = $('#attrIsSubTask').val();
		
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordComplete: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_complete, attrCode:attrCode, attrDivCode:attrDivCode, attrUser:attrUser,attrServiceTypeName:attrServiceTypeName, attrIsSubTask:attrIsSubTask },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmComplete');
				showMessage(response.message);
				$('#loadingOverlayEditor').hide();
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	$('body').on('click', '.okAdminTaskCompButton', function(){
		$('#loadingOverlayEditor').show();
		fieldId = $('#completeAdminFieldId').val();
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordAdminComplete: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_admin_complete },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmAdminComplete');
				showMessage(response.message);
				$('#loadingOverlayEditor').hide();
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	$('body').on('click', '.okAdminTaskReassignButton', function(){
		$('#loadingOverlayEditor').show();
		fieldId = $('#completeAdminFieldId').val();
		adminNotes = $('.task_keyword_admin_notes').val();
		task_keyword_user_id_reassign = $('.task_keyword_user_id_reassign').val();
		
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordAdminReassign: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_admin_complete, taskKeywordAdminNotes:adminNotes, task_keyword_user_id_reassign:task_keyword_user_id_reassign },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmAdminReassign');
				showMessage(response.message);
				$('#loadingOverlayEditor').hide();
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	
	
	
   $('body').on('click', '.taskKeywordClone', function(){
      var taskKeywordCloneId = $(this).attr('id').split('_')[1];
	  var url= '<?php echo @ROOT_HTTP_PATH;?>
/taskClone.php?taskRecordId='+taskKeywordCloneId;
	  $("#taskClone .uiContent").html($("<iframe width='100%' frameborder='0'  height='100%' style='height:550px' />").attr("src",url));
	  uiPopupOpen('taskClone', '', 550);
   });
   
   
   $('.completeDateDiv').hide();
   $('body').on('change', '.task_keyword_setup_complete', function(){
		var thisVal = $('.task_keyword_setup_complete');
		if (thisVal.is(':checked')) {
			$('.completeDateDiv').show();
			$(".task_keyword_date.datepicker").datepicker("setDate", new Date());
		}
		else{
			$('.completeDateDiv').hide();
		}
   });
   
   $('body').on('click', '.taskKeywordSave', function(){
   	
   	var task_keyword_marsha_code = $('.task_keyword_marsha_code').val();
	var task_keyword_service_type_id = $('.task_keyword_service_type_id').val();
   	var task_keyword_no_of_pages = $('.task_keyword_no_of_pages').val();
	var task_keyword_added_box_date = $('.task_keyword_added_box_date').val();
   	var task_keyword_link_db_file = $('.task_keyword_link_db_file').val();
	var task_keyword_priority_val = $('.task_keyword_priority');
	var task_keyword_priority;
	
	if (task_keyword_priority_val.is(':checked')) {
		task_keyword_priority = 1;
	}
	else{
		task_keyword_priority = 0;
	}
	var task_keyword_setup_due_date = $('.task_keyword_setup_due_date').val();
	
	var task_keyword_setup_complete_val = $('.task_keyword_setup_complete');
	var task_keyword_setup_complete;
	
	if (task_keyword_setup_complete_val.is(':checked')) {
		task_keyword_setup_complete = 1;
	}
	else{
		task_keyword_setup_complete = 0;
	}
	
	var task_keyword_user_id = $('.task_keyword_user_id').val();
	var task_keyword_notes = $('.task_keyword_notes').val();
	var task_keyword_tire = $('.task_keyword_tire').val();
	
	if(task_keyword_service_type_id == '<?php echo @SERVICE_TYPE_KEYWORD_SETUP_ID;?>
'){
		taskCloneStatusId = 1;
	}
	else{
		taskCloneStatusId = 0;
	}
	
   	var taskKeywordId = $('.taskKeywordId').val();
	var taskCompletedDate = $('.task_keyword_date').val();
   	
   	if(task_keyword_marsha_code==''){
              showMessage('<?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
 is Required');
              $('.task_keyword_marsha_code').focus();
              return false;
          }
		
	
   	if(taskKeywordId > 0){
   		actionOperand = 2;
   	}
   	else{
   		actionOperand = 1;
   	}
   	
   	$.ajax({
   		url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
   		type: 'post',
   		dataType: 'json',
   		data: { actionOperand: actionOperand, marshaCodeData: task_keyword_marsha_code, noPagesData: task_keyword_no_of_pages, notesData: task_keyword_notes,boxAddedDateData: task_keyword_added_box_date,linkDbFileData: task_keyword_link_db_file, setupDueData: task_keyword_setup_due_date, setupCompleteData:  task_keyword_setup_complete, userIdData:  task_keyword_user_id , priorityData:  task_keyword_priority, task_keyword_service_type_id:task_keyword_service_type_id, taskCloneStatusId:taskCloneStatusId, task_keyword_tire:task_keyword_tire, taskCompletedDate:taskCompletedDate ,taskKeywordUpdateId:  taskKeywordId },
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
			$(".addTaskManagerKeyword").hide();
			$(".updateTaskManagerKeyword").hide();
   			loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   		}		
   	});
            
      });	
   
   $('body').on('click', '.taskKeywordUpdateAction', function(){
   	$(".addTaskManagerKeyword").hide();
   	$(".updateTaskManagerKeyword").show();
	
	 $('html,body').animate({
        scrollTop: $(".updateTaskManagerKeyword").offset().top},
        'slow');
	
   	var taskKeywordId = $(this).attr('id').split('_')[1];
   
          $.ajax({
   		url: 'getModuleInfo.php?rand='+Math.random(),
   		type:'post',
   		dataType: 'json',
   		data : { module: 'taskManagerKeywordUpdate', taskKeywordId: taskKeywordId },
              success: function(response) {
                  checkResponseRedirect(response);
   			$('.updateTaskManagerKeyword').html("");
   			$('.updateTaskManagerKeyword').html(response.message.content);
              }
          });
   });	
   
  
   
   
   
   });
   
   function loadTaskKeywordList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",divisionId=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#taskPageListing').val(recordCount);
      $('#taskPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'taskManagerKeywordList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy,divisionId:divisionId },
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
   		
   		
   		if(strClassTask && strClassTask!=''){
                  if(strClassTask=='ascendingClassTask'){
                      $('#'+orderId+'s a').removeClass('ascendingClassTask');
                      $('#'+orderId+'s a').addClass('descendingClassTask').prepend('<i class="fa fa-caret-up gray font13"></i>');
   				$('#overAllTask th a').addClass('descendingClassTask');
                  } else if(strClassTask=='descendingClassTask'){
                      $('#'+orderId+'s a').removeClass('descendingClassTask');
                      $('#'+orderId+'s a').addClass('ascendingClassTask').prepend('<i class="fa fa-caret-down gray font13"></i>');
   				$('#overAllTask th a').addClass('ascendingClassTask');
                  }
              } else {
   			$('#client_entity_marsha_codes a').addClass('descendingClassTask').prepend('<i class="fa fa-caret-up gray font13"></i>');
   			$('#division_codes a').addClass('descendingClassTask');
   			$('#task_keyword_no_of_pagess a').addClass('descendingClassTask');
   			$('#task_keyword_link_db_files a').addClass('descendingClassTask');
   			$('#task_keyword_setup_due_dates a').addClass('descendingClassTask');
			$('#task_keyword_prioritys a').addClass('descendingClassTask');
			$('#task_keyword_dates a').addClass('descendingClassTask');
   			$('#user_fnames a').addClass('descendingClassTask');
			$('#user_lnames a').addClass('descendingClassTask');
			$('#task_keyword_created_ons a').addClass('descendingClassTask');
			$('#serv_type_names a').addClass('descendingClassTask');
              }
   		
   		
          }
      });	 
   }

	function addBusinessDays(d,n) {
		d = new Date(d.getTime());
		var day = d.getDay();
		d.setDate(d.getDate() + n + (day === 6 ? 2 : +!day) + (Math.floor((n - 1 + (day % 6 || 1)) / 5) * 2));
		d = (d.getMonth() + 1) + '/' + (d.getDate()) + '/' +  d.getFullYear();
		return d;
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
<div id="loadingOverlayEditor" class="loadingOverlayEditor" style="display:none;">
	<img src="<?php echo @ROOT_HTTP_PATH;?>
/dist/img/gifload.gif" width="100px" height="100px"/>
</div>
	
<div class="updateTaskManagerKeyword"> </div>
<div class="row addTaskManagerKeyword" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
            <div class="form-group col-sm-3">
               <label ><?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
</label>
               <select class="form-control task_keyword_marsha_code" id="task_keyword_marsha_code">
                  <option value="">--- Enter <?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
 ---</option>
                  <?php if ($_smarty_tpl->tpl_vars['marshaCodesArray']->value){?>
                  <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['marshaCodesArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
                  <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['client_entity_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['client_entity_marsha_code'];?>
</option>
                  <?php } ?>
                  <?php }?>
               </select>
            </div>
            <div class="form-group col-sm-3">
               <label >Division</label>
               <input readonly class="form-control task_keyword_division" id="task_keyword_division" placeholder="">
            </div>
			<div class="form-group col-sm-3">
                  <label >Service Type</label>
                  <select class="form-control task_keyword_service_type_id" id="task_keyword_service_type_id">
                     <option value="">--- Select Service Type ---</option>
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
            <div class="form-group col-sm-3">
               <label >Number of Pages</label>
               <input type="text" class="form-control task_keyword_no_of_pages" id="task_keyword_no_of_pages" placeholder="">
            </div>
			
			 </div>
			 <div class="row">
				<div class="form-group col-sm-3">
					   <label >Start Date</label>
					   <div class="input-group date">
						  <div class="input-group-addon">
							 <i class="fa fa-calendar"></i>
						  </div>
						  <input readonly class="form-control pull-right task_keyword_added_box_date datepicker" id="task_keyword_added_box_date">
					   </div>
				</div>
				
				<div class="form-group col-sm-3">
				   <label >Source Link</label>
				   <input type="text" class="form-control task_keyword_link_db_file" id="task_keyword_link_db_file" placeholder="">
				</div>
				<div class="form-group col-sm-3" >
                  <label >Priority</label>
                  <br/>
                  <input type="checkbox" class="task_keyword_priority" id="task_keyword_priority" >
               </div>
				 <div class="form-group col-sm-3">
               <label >Tactic Due</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_setup_due_date datepicker" id="task_keyword_setup_due_date">
               </div>
				</div>
				 <div class="form-group col-sm-3">
				<label>Complete</label>
			   <br/>
				<input type="checkbox" class="task_keyword_setup_complete" id="task_keyword_setup_complete" >
				
				</div>
				<div class="form-group col-sm-3 completeDateDiv">
               <label >Complete Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_date datepicker" id="task_keyword_date">
               </div>
				</div>
				  <div class="form-group col-sm-3">
               <label >Consultant</label>
			   <?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?>
				   <select class="form-control task_keyword_user_id" id="task_keyword_user_id">
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
				<?php }else{ ?>
					<p><?php echo $_SESSION['userName'];?>
</p>
					<input type="hidden" name="task_keyword_user_id" id="task_keyword_user_id" class="task_keyword_user_id" value="<?php echo $_SESSION['userId'];?>
">
			    <?php }?>
            </div>
			 <div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_keyword_notes" id="task_keyword_notes"></textarea>
            </div>
			
			 </div>
			 <div class="row">
				 <div class="form-group col-sm-3">
               <label >Tier</label>
              <input type="text" class="form-control task_keyword_tire" id="task_keyword_tire">
            </div>
			 </div>
	
            <button type="button" class="btn btn-default pull-right margin taskKeywordCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin taskKeywordSave">Done</button>
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
                     <select class="form-control taskKeyFilterBy" name="taskKeyFilterBy">
                     <?php echo $_smarty_tpl->tpl_vars['filterByArray']->value;?>

                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-3">
               <div class="form-group taskKeyFilterRangeStatus" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Date Range</label>
                  </div>
                  <div class="col-sm-6">
                     <div class="input-group">
                        <div class="input-group-addon">
                           <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" readonly name="taskKeyFilterRange" class="form-control pull-right  taskKeyFilterRange" style="width:175px !important;">
                     </div>
                  </div>
                  <!-- /.input group -->
               </div>
			   <div class="form-group divisionFilter" style="display:none;">
                     <select class="form-control divisionFilterBy" id="divisionFilterBy" name="divisionFilterBy">
						 <?php if ($_smarty_tpl->tpl_vars['divisionArray']->value){?>
							 <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['divisionArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							 <option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['division_id'];?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
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
               <button type="button" class="btn btn-primary pull-right m-r-10 addNewTask"><i class="fa fa-plus"></i> Add New Task</button>
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
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_TASK_KEYWORD;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okTaskDelButton"><?php echo @LBL_YES;?>
</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskDelButton"><?php echo @LBL_NO;?>
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

<input type="hidden" name="completeFieldId" id="completeFieldId" value=""/>
<div id="confirmComplete">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmCompletePop" style="display:none;">
                    <div class="inner">
						<input type="hidden" name="completeFieldId" id="completeFieldId" value=""/>
						<input type="hidden" name="attrCode" id="attrCode" value=""/>
						<input type="hidden" name="attrDivCode" id="attrDivCode" value=""/>
						<input type="hidden" name="attrUser" id="attrUser" value=""/>
						<input type="hidden" name="attrServiceTypeName" id="attrServiceTypeName" value=""/>
						<input type="hidden" name="attrIsSubTask" id="attrIsSubTask" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_COMP_TASK_KEYWORD;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okTaskCompButton"><?php echo @LBL_YES;?>
</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskCompButton"><?php echo @LBL_NO;?>
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

<div id="confirmAdminComplete">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmAdminCompletePop" style="display:none;">
                    <div class="inner">
                        <input type="hidden" name="completeAdminFieldId" id="completeAdminFieldId" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_COMP_ADMIN_TASK_KEYWORD;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskCompButton"><?php echo @LBL_YES;?>
</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskCompButton"><?php echo @LBL_NO;?>
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

<div id="confirmAdminReassign">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmAdminReassignPop" style="display:none;">
                    <div class="inner">
                        <input type="hidden" name="completeAdminFieldId" id="completeAdminFieldId" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_REASSIGN_TASK_KEYWORD;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
							<tr>
                                <td class="p-t-10">
                                    <label>Select Consultant</label>
									<select class="form-control task_keyword_user_id_reassign" id="task_keyword_user_id_reassign">
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
                                </td>
                            </tr>
							<tr>
                                <td class="p-t-10">
                                    <label>Notes</label> <textarea class="form-control task_keyword_admin_notes" id="task_keyword_admin_notes"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskReassignButton"><?php echo @LBL_YES;?>
</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskReassignButton"><?php echo @LBL_NO;?>
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

    $('.taskKeyFilterRange').daterangepicker({
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

<?php /*  Call merged included template "uiPopup.tpl" */
$_tpl_stack[] = $_smarty_tpl;
 $_smarty_tpl = $_smarty_tpl->setupInlineSubTemplate("uiPopup.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array('popupId'=>'taskClone','title'=>"Task Clone"), 0, '4745364285a959177c9aa17-95152664');
content_5a959177cf3ed9_65148793($_smarty_tpl);
$_smarty_tpl = array_pop($_tpl_stack); /*  End of included template "uiPopup.tpl" */?>


</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?><?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:12:23
         compiled from "/home/galileotechmedia/public_html/app/templates/uiPopup.tpl" */ ?>
<?php if ($_valid && !is_callable('content_5a959177cf3ed9_65148793')) {function content_5a959177cf3ed9_65148793($_smarty_tpl) {?><div id="<?php echo $_smarty_tpl->tpl_vars['popupId']->value;?>
"><div class="pop-up-overlay" style="display:none;"><div class="pop-close">X</div><div class="container" style="display:none;"><div class="uiContent"> <img src="<?php echo @ROOT_HTTP_PATH;?>
/images/loading.gif" title="Loading" alt="Loading......." /> </div></div></div></div><?php }} ?>