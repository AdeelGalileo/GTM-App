<?php /* Smarty version Smarty-3.1.11, created on 2018-02-28 11:59:56
         compiled from "/home/galileotechmedia/public_html/app/templates/adminConsultant.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1783767535a96e00c97ebd3-16341209%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4713902afaf344ed0d6ae2550b6c38f3665507d6' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/adminConsultant.tpl',
      1 => 1519124468,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1783767535a96e00c97ebd3-16341209',
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
  'unifunc' => 'content_5a96e00c9d4745_31497574',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a96e00c9d4745_31497574')) {function content_5a96e00c9d4745_31497574($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Consultants</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
<style>

</style>
<script type="text/javascript">
   var strClassTask;
   var strClassTaskBill;
   var strClassTaskOutBill;
   var taskKeyFilterBy;
   var taskKeyFilterByBilling;
   var startDateParam;
   var endDateParam;
   var orderIdTask = 0;
   var sortIdTask = 0;
   var orderIdTaskBill = 0;
   var sortIdTaskBill = 0;
   var orderIdTaskOutBill = 0;
   var sortIdTaskOutBill = 0;
   var writerIdFilter = 0;
   var currentTabActive = "tabId_1";
   var isComplete = 0;
   var divisionId;
   var qbIdFilterBy;
  $(document).ready(function(){
	  
		<?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?>
		
			$(".taskKeyFilterBy option[value=3]").remove();
		
		<?php }?>
		 
		if(currentTabActive == 'tabId_1'){
			isComplete = 1;
		}
		
		
		<?php if ($_REQUEST['dashboard']==''){?>	
			loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		<?php }?>	
		
	   
	     $('body').on('click', '.descendingClassTask', function(){
			orderIdTask = $(this).attr('id');
			sortIdTask = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassTask = 'descendingClassTask';
			var recCountValues = $('#taskPageListing').val();
			loadAdminConsultantTaskList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
   
		$('body').on('click', '.ascendingClassTask', function(){
			orderIdTask = $(this).attr('id');
			sortIdTask = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassTask = 'ascendingClassTask';
			var recCountValues = $('#taskPageListing').val();
			loadAdminConsultantTaskList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
		
		 $('body').on('click', '.descendingClassTaskBill', function(){
			orderIdTaskBill = $(this).attr('id');
			sortIdTaskBill = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassTaskBill = 'descendingClassTaskBill';
			var recCountValues = $('#billPageListing').val();
			loadBillTaskList(recCountValues,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
   
		$('body').on('click', '.ascendingClassTaskBill', function(){
			orderIdTaskBill = $(this).attr('id');
			sortIdTaskBill = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassTaskBill = 'ascendingClassTaskBill';
			var recCountValues = $('#billPageListing').val();
			loadBillTaskList(recCountValues,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
		
		 $('body').on('click', '.descendingClassTaskOutBill', function(){
			orderIdTaskOutBill = $(this).attr('id');
			sortIdTaskOutBill = 2;
			pageNo = $('#pageDropDownValue').val();
			strClassTaskOutBill = 'descendingClassTaskOutBill';
			var recCountValues = $('#outBillPageListing').val();
			loadOutstandingBillingList(recCountValues,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
		});
   
		$('body').on('click', '.ascendingClassTaskOutBill', function(){
			orderIdTaskOutBill = $(this).attr('id');
			sortIdTaskOutBill = 1;
			pageNo = $('#pageDropDownValue').val();
			strClassTaskOutBill = 'ascendingClassTaskOutBill';
			var recCountValues = $('#outBillPageListing').val();
			loadOutstandingBillingList(recCountValues,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
          loadAdminConsultantTaskList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
          loadAdminConsultantTaskList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
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
          loadAdminConsultantTaskList(recCountValues,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#taskPageListing', function(){
          var recCount = $(this).val();
          $('#taskPageListingNew').val(recCount);
          pageNo = 0;
		  loadAdminConsultantTaskList(recCount,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#taskPageListingNew', function(){
          var recCount = $(this).val();
          $('#taskPageListing').val(recCount);
          pageNo = 0;
		  loadAdminConsultantTaskList(recCount,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });	
	  
	  
	  $('body').on('click', '#paginationBillAuto .pagination-nav .rightArrowClass, #paginationBillAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationBillAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationBillAuto .pageDropDown" ).val(pageNo);
          $( "#paginationBillAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#billPageListing').val();
          loadBillTaskList(recCountValues,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('click', '#paginationBillAuto .pagination-nav .leftArrowClass, #paginationBillAutoNew .pagination-nav .leftArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationBillAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo-1;
          $( "#paginationBillAuto .pageDropDown" ).val(pageNo);
          $( "#paginationBillAutoNew .pageDropDown" ).val(pageNo);
          document.getElementById('currPageAutoBillID').value = '';
          $('#currPageAutoBillID').val(links);
          var recCountValues = $('#billPageListing').val();
          loadBillTaskList(recCountValues,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#paginationBillAuto .pagination-nav .pageDropDown, #paginationBillAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoBillID').value = '';
          $('#currPageAutoBillID').val(links);
          var recCountValues = $('#billPageListing').val();
          loadBillTaskList(recCountValues,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#billPageListing', function(){
          var recCount = $(this).val();
          $('#billPageListingNew').val(recCount);
          pageNo = 0;
		  loadBillTaskList(recCount,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#billPageListingNew', function(){
          var recCount = $(this).val();
          $('#billPageListing').val(recCount);
          pageNo = 0;
		  loadBillTaskList(recCount,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });	
	  
	  
	  $('body').on('click', '#paginationOutBillAuto .pagination-nav .rightArrowClass, #paginationOutBillAutoNew .pagination-nav .rightArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationOutBillAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo+1;
          $( "#paginationOutBillAuto .pageDropDown" ).val(pageNo);
          $( "#paginationOutBillAutoNew .pageDropDown" ).val(pageNo);
          var recCountValues = $('#outBillPageListing').val();
          loadOutstandingBillingList(recCountValues,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('click', '#paginationOutBillAuto .pagination-nav .leftArrowClass, #paginationOutBillAutoNew .pagination-nav .leftArrowClass', function(event){
          event.preventDefault();
          var links = $('#paginationOutBillAuto .pageDropDown').val();
          pageNo = parseInt(links, 10);
          pageNo = pageNo-1;
          $( "#paginationOutBillAuto .pageDropDown" ).val(pageNo);
          $( "#paginationOutBillAutoNew .pageDropDown" ).val(pageNo);
          document.getElementById('currPageAutoOutBillID').value = '';
          $('#currPageAutoOutBillID').val(links);
          var recCountValues = $('#outBillPageListing').val();
          loadOutstandingBillingList(recCountValues,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#paginationOutBillAuto .pagination-nav .pageDropDown, #paginationOutBillAutoNew .pagination-nav .pageDropDown', function(event){
          event.preventDefault();
          var linksValue = $('option:selected', this).attr('id');
          var links = $(this).val();
          if(pageNo == links) return;
          pageNo = parseInt(links, 10);
          document.getElementById('currPageAutoOutBillID').value = '';
          $('#currPageAutoOutBillID').val(links);
          var recCountValues = $('#outBillPageListing').val();
          loadOutstandingBillingList(recCountValues,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#outBillPageListing', function(){
          var recCount = $(this).val();
          $('#outBillPageListingNew').val(recCount);
          pageNo = 0;
		  loadOutstandingBillingList(recCount,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });
      $('body').on('change', '#outBillPageListingNew', function(){
          var recCount = $(this).val();
          $('#outBillPageListing').val(recCount);
          pageNo = 0;
		  loadOutstandingBillingList(recCount,orderIdTask,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
      });	
	   
	   $('.writerIdFilter').chosen({ width:"100%"});
	   $('#divisionFilterBy').chosen({ width:"100%"});
	   $('.taskKeyFilterRangeStatus').hide();

		
	$('body').on('change', '.taskKeyFilterBy', function(){
			taskKeyFilterBy =  $(this).val();
		   if(taskKeyFilterBy == 2){
				$('.taskKeyFilterRangeStatus').show();
				$('.taskKeyFilterUser').hide();
				$('.moveMultipleQb').hide();
				$('.divisionFilter').hide();
			}
			else if(taskKeyFilterBy == 4){
				$('.taskKeyFilterRangeStatus').hide();
				$('.moveMultipleQb').hide();
				$('.divisionFilter').show();
				$('.taskKeyFilterUser').hide();
			}
			else{
				if(taskKeyFilterBy == 3){
					$('.taskKeyFilterRangeStatus').hide();
					$('.taskKeyFilterUser').show();
					$('.divisionFilter').hide();
					if(writerIdFilter > 0){
						$('.moveMultipleQb').show();
					}
					else{
						$('.moveMultipleQb').hide();
					}
				}
				else
				{
					$('.taskKeyFilterRangeStatus').hide();
					$('.taskKeyFilterUser').hide();
					$('.divisionFilter').hide();
					$('.moveMultipleQb').hide();
				}
			}
			
			if(taskKeyFilterBy > 1){
				$('.resetFilters').show();
			}
			
			taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
			if(taskKeyFilterRangeVal.length > 0){
				taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
				startDateParam = taskKeyFilterRangeVal[0].trim();
				endDateParam = taskKeyFilterRangeVal[1].trim();
				loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
	});
   
	$('body').on('change', '.taskKeyFilterByBilling', function(){
			taskKeyFilterByBilling =  $(this).val();
		   if(taskKeyFilterByBilling == 2){
				$('.taskKeyFilterRangeStatus').show();
				$('.taskKeyFilterUser').hide();
				$('.divisionFilter').hide();
				$('.qbIdFilter').hide();
			}
			else if(taskKeyFilterByBilling == 4){
				$('.taskKeyFilterRangeStatus').hide();
				$('.divisionFilter').show();
				$('.taskKeyFilterUser').hide();
				$('.qbIdFilter').hide();
			}
			else if(taskKeyFilterByBilling == 5){
				$('.taskKeyFilterRangeStatus').hide();
				$('.divisionFilter').hide();
				$('.taskKeyFilterUser').hide();
				$('.qbIdFilter').show();
			}
			else{
				if(taskKeyFilterByBilling == 3){
					$('.taskKeyFilterRangeStatus').hide();
					$('.taskKeyFilterUser').show();
					$('.divisionFilter').hide();
					$('.qbIdFilter').hide();
				}
				else
				{
					$('.taskKeyFilterRangeStatus').hide();
					$('.taskKeyFilterUser').hide();
					$('.divisionFilter').hide();
					$('.qbIdFilter').hide();
				}
			}
			
			if(taskKeyFilterByBilling > 1){
				$('.resetFilters').show();
			}
			
			taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
			if(taskKeyFilterRangeVal.length > 0){
				taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
				startDateParam = taskKeyFilterRangeVal[0].trim();
				endDateParam = taskKeyFilterRangeVal[1].trim();
				loadBillTaskList(50,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterByBilling,writerIdFilter);
			}
	});
   
   
    $('body').on('click', '.resetFiltersAction', function(){
		location.reload();
    });	
		
		
	
		
		
	   $('.completedTaskTab').click(function(event) {
		    $('.taskKeyFilterBy').show();
			$('.taskKeyFilterByBilling').hide();
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').hide();
			$('.divisionFilter').hide();
			$('.qbIdFilter').hide();
			
		    $('.taskKeyFilterBy').prop('selectedIndex',0);
			$('.taskKeyFilterByBilling').prop('selectedIndex',0);
			$('.qbIdFilter').hide();
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_1').addClass('active');
			$('#tab_1').show();
			$('#tab_2').hide();
			$('#tab_3').hide();
			$('#tab_4').hide();
			currentTabActive= "tabId_1";
			pageNo = 0;
			loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,"","","","");
		});	
		
		$('body').on('click', '.pendingTaskTab', function(){
			$('.taskKeyFilterBy').show();
			$('.taskKeyFilterByBilling').hide();
			$('.qbIdFilter').hide();
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').hide();
			$('.divisionFilter').hide();
			$('.taskKeyFilterBy').prop('selectedIndex',0);
			$('.taskKeyFilterByBilling').prop('selectedIndex',0);
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_2').addClass('active');
			$('#tab_1').hide();
			$('#tab_2').show();
			$('#tab_3').hide();
			$('#tab_4').hide();
			currentTabActive= "tabId_2";
			pageNo = 0;
			loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,"","","","");
		});	
		
		$('body').on('click', '.submittedBillingTab', function(){
			$('.taskKeyFilterBy').hide();
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').hide();
			$('.divisionFilter').hide();
			$('.taskKeyFilterByBilling').show();
			$('.taskKeyFilterBy').prop('selectedIndex',0);
			if(taskKeyFilterByBilling == 3){
				$('.qbIdFilter').show();
			}
			$('.taskKeyFilterBy').prop('selectedIndex',0);
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_3').addClass('active');
			$('#tab_1').hide();
			$('#tab_2').hide();
			$('#tab_3').show();
			$('#tab_4').hide();
			currentTabActive= "tabId_3";
			pageNo = 0;
			loadBillTaskList(50,orderIdTaskBill,sortIdTaskBill,"","","","");
		});	
		
		$('.outstandingBillingTab').click(function(event) {
			$('.taskKeyFilterBy').show();
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').hide();
			$('.divisionFilter').hide();
			$('.taskKeyFilterByBilling').hide();
			$('.qbIdFilter').hide();
			$('.taskKeyFilterBy').prop('selectedIndex',0);
			$('.taskKeyFilterByBilling').prop('selectedIndex',0);
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_4').addClass('active');
			$('#tab_1').hide();
			$('#tab_2').hide();
			$('#tab_3').hide();
			$('#tab_4').show();
			currentTabActive= "tabId_4";
			pageNo = 0;
			loadOutstandingBillingList(50,orderIdTaskOutBill,sortIdTaskOutBill,"","","","");
		});	
		
		<?php if ($_REQUEST['dashboard']=='submittedBillingTab'){?>	
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_3').addClass('active');
			$('.tab-pane').removeClass('active');
			$('.submittedBillingTabPane').addClass('active');
			$( ".submittedBillingTab" ).trigger("click");
			
		<?php }elseif($_REQUEST['dashboard']=='pendingTaskTab'){?>
			
			$('.consultantTabs li.active').removeClass('active');
			$('.consultantTabs li.tab_2').addClass('active');
			$('.tab-pane').removeClass('active');
			$('.pendingTaskTabPane').addClass('active');
			$( ".pendingTaskTab" ).trigger("click");
			
		<?php }?>	
		
		$( ".writerIdFilter" ).change(function() {
			 writerIdFilter =  $(this).val();
			 pageNo = 0;
			 if(currentTabActive == "tabId_1" || currentTabActive == "tabId_2"){
				 loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
			 }
			 else if(currentTabActive == "tabId_3"){
				 loadBillTaskList(50,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterByBilling,writerIdFilter);
			 }
			 else if(currentTabActive == "tabId_4"){
				 loadOutstandingBillingList(50,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
			 }
			 
		});
		
		$('body').on('click', '.applyBtn, .ranges', function(){
			taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
			if(taskKeyFilterRangeVal.length > 0){
				taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
				startDateParam = taskKeyFilterRangeVal[0].trim();
				endDateParam = taskKeyFilterRangeVal[1].trim();
				 if(currentTabActive == "tabId_1" || currentTabActive == "tabId_2"){
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
				 }
				 else if(currentTabActive == "tabId_3"){
					loadBillTaskList(50,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterByBilling,writerIdFilter);
				}
				else if(currentTabActive == "tabId_4"){
					loadOutstandingBillingList(50,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
				}
			}
		});
		
		$('body').on('change', '.divisionFilterBy', function(){
			divisionId = $( this ).val();
			if(currentTabActive == "tabId_1" || currentTabActive == "tabId_2"){
				loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId);
			}
			else if(currentTabActive == "tabId_3"){
				loadBillTaskList(50,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterByBilling,writerIdFilter,divisionId);
			}
			else if(currentTabActive == "tabId_4"){
				loadOutstandingBillingList(50,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter,divisionId);
			}
		});
		
		
		$('body').on('click', '.qbIdFilterBySearch', function(){
			qbIdFilterBy = $('#qbIdFilterBy').val();
			if(qbIdFilterBy == ''){
				return;
			}
			loadBillTaskList(50,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterByBilling,writerIdFilter,divisionId,qbIdFilterBy);
		});
		
		 $('body').on('click', '.taskDeleteAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
            $('#delFieldId').val(fieldId);
            $('#confirmDelete .uiContent').html($('#confirmDeletePop').html());
            uiPopupOpen('confirmDelete', 500, 125);
		});
		
		$('body').on('click', '.okTaskDelButton', function(){
			fieldId = $('#delFieldId').val();
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerContent.php?rand='+Math.random(),
				data : { taskContentDelete: 1, taskContentDeleteId:fieldId },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmDelete');
					showMessage(response.message);
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
				}
			});
		});
		
		$('body').on('click', '.cancelTaskDelButton', function(){
            uiPopClose('confirmDelete');
		});
		
		$('body').on('click', '.taskUpdateCancel', function(){
			location.reload();
		});
		

		
		$('body').on('click', '.taskUpdateAction', function(){
			$(".addTaskManagerContent").hide();
			$(".updateTaskManagerContent").show();
			var taskContentId = $(this).attr('id').split('_')[1];
		   
			$.ajax({
				url: 'getModuleInfo.php?rand='+Math.random(),
				type:'post',
				dataType: 'json',
				data : { module: 'taskManagerContentUpdate', taskContentId: taskContentId },
					  success: function(response) {
						checkResponseRedirect(response);
						$('.updateTaskManagerContent').html("");
						$('.updateTaskManagerContent').html(response.message.content);
					  }
			});
		});	
		
		
	var task_complete;	
	$('body').on('click', '.taskCompleteAction', function(){
           
			var taskType = $(this).attr('taskType');
			var fieldId = $(this).attr('id').split('_')[2];
			var task_complete_val = $('#completeTask_'+taskType+'_'+fieldId);
			
			if (task_complete_val.is(':checked')) {
				task_complete = 1;
			}
			else{
				task_complete = 0;
			}
            $('#completeFieldId').val(fieldId);
			$('#completeTaskType').val(taskType);
			$( ".okTaskCompButton" ).trigger( "click");
            /*$('#confirmComplete .uiContent').html($('#confirmCompletePop').html());
            uiPopupOpen('confirmComplete', 500, 125);*/
			
	});
	
	var changePriorityVal;	
	$('body').on('click', '.changePriority', function(){
			var taskType = $(this).attr('taskType');
			var fieldId = $(this).attr('id').split('_')[2];
			var priority_val = $('#changePriority_'+taskType+'_'+fieldId);
			
			if (priority_val.is(':checked')) {
				changePriorityVal = 1;
			}
			else{
				changePriorityVal = 0;
			}
            $('#priorityFieldId').val(fieldId);
			$('#priorityAdminTaskType').val(taskType);
			$( ".okPriorityButton" ).trigger( "click");
            /*$('#confirmComplete .uiContent').html($('#confirmCompletePop').html());
            uiPopupOpen('confirmComplete', 500, 125);*/
	});
	
	
	var task_admin_complete;	
	$('body').on('change', '.taskCompleteAdminAction', function(){
		
			var taskType = $(this).attr('taskType');
			var fieldId = $(this).attr('id').split('_')[2];
			var task_complete_admin_val = $('#completeAdminTask_'+taskType+'_'+fieldId).val();
			
			if (task_complete_admin_val == 1) {
				  task_admin_complete = 1;
				  $('#completeAdminFieldId').val(fieldId);
				  $('#completeAdminTaskType').val(taskType);
				  $('#confirmAdminComplete .uiContent').html($('#confirmAdminCompletePop').html());
				  uiPopupOpen('confirmAdminComplete', 500, 125);
			}
			else if(task_complete_admin_val == 2){
				  task_admin_complete = 2;
				  $('#completeAdminFieldId').val(fieldId);
				  $('#completeAdminTaskType').val(taskType);
				  $('#confirmAdminReassign .uiContent').html($('#confirmAdminReassignPop').html());
				  uiPopupOpen('confirmAdminReassign', 500, 250);
			}
			
	});	

	$('body').on('click', '.cancelAdminTaskCompButton', function(){
          uiPopClose('confirmAdminComplete');
		  loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.cancelAdminTaskReassignButton', function(){
          uiPopClose('confirmAdminReassign');
		  loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.cancelPriorityButton', function(){
          uiPopClose('confirmPriority');
		  loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
	});
	
	$('body').on('click', '.okTaskCompButton', function(){
		fieldId = $('#completeFieldId').val();
		adminTaskType = $('#completeTaskType').val();
		
		if(adminTaskType == 1){
			$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordComplete: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_complete },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmComplete');
				showMessage(response.message);
				loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
			});
		}
		else if(adminTaskType == 2){
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerContent.php?rand='+Math.random(),
				data : { taskContentComplete: 1, taskContentCompId:fieldId, taskContentCompVal : task_complete },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmComplete');
					showMessage(response.message);
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
				}
			});
		}
	});
	
	$('body').on('click', '.okPriorityButton', function(){
		fieldId = $('#priorityFieldId').val();
		adminTaskType = $('#priorityAdminTaskType').val();
		
		if(adminTaskType == 1){
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
				data : { changeKeywordPriority: 1, taskPriorityId:fieldId, taskPriorityVal : changePriorityVal },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmPriority');
					showMessage(response.message);
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
				}
			});
		}
		
		else if(adminTaskType == 2){
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerContent.php?rand='+Math.random(),
				data : { changeContentPriority: 1, taskPriorityId:fieldId, taskPriorityVal : changePriorityVal },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmPriority');
					showMessage(response.message);
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
				}
			});
		}
		
	});
	
	
	$('body').on('click', '.okAdminTaskCompButton', function(){
		fieldId = $('#completeAdminFieldId').val();
		adminTaskType = $('#completeAdminTaskType').val();
		
		if(adminTaskType == 1){
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
				data : { taskKeywordAdminComplete: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_admin_complete },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmAdminComplete');
					showMessage(response.message);
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
				}
			});
		}
		else if(adminTaskType == 2){
			$.ajax({
				type : 'post',
				url: 'ajax/taskManagerContent.php?rand='+Math.random(),
				data : { taskContentAdminComplete: 1, taskContentCompId:fieldId, taskContentCompVal : task_admin_complete },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					uiPopClose('confirmAdminComplete');
					showMessage(response.message);
					loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
				}
			});
		}
		
		
		
	});
	
	$('body').on('click', '.okAdminTaskReassignButton', function(){
			fieldId = $('#completeAdminFieldId').val();
			adminNotes = $('.task_content_admin_notes').val();
			adminTaskType = $('#completeAdminTaskType').val();
			if(adminTaskType == 1){
				$.ajax({
					type : 'post',
					url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
					data : { taskKeywordAdminReassign: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_admin_complete, taskKeywordAdminNotes:adminNotes },
					dataType:'json', 
					success: function(response){
						checkResponseRedirect(response);
						uiPopClose('confirmAdminReassign');
						showMessage(response.message);
						loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
					}
				});
			}
			else if(adminTaskType == 2){
				$.ajax({
					type : 'post',
					url: 'ajax/taskManagerContent.php?rand='+Math.random(),
					data : { taskContentAdminReassign: 1, taskContentCompId:fieldId, taskContentCompVal : task_admin_complete, taskContentAdminNotes:adminNotes },
					dataType:'json', 
					success: function(response){
						checkResponseRedirect(response);
						uiPopClose('confirmAdminReassign');
						showMessage(response.message);
						loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
					}
				});
			}
	});
	
		$('body').on('change', '.chkqbTransfer', function(){
			var leng = $(".chkqbTransfer:checked").length;
			 
			if(leng==0)
			{
				$( ".chkqbTransfer" ).removeAttr("disabled");
				return;
			}
			if($(this).is(":checked")) 
			{
				var checledvalue =$(this).attr('consultantId');
				$( ".chkqbTransfer" ).each(function( index ) {
					if($(this).attr('consultantId')!=checledvalue)
					{
						$(this).attr("disabled", true);
					}
					else
					{
						$(this).removeAttr("disabled");
					}
				});
            
			}
			else
			{
				var checledvalue =$(this).attr('consultantId');
				$( ".chkqbTransfer" ).each(function( index ) {
				if($(this).attr('consultantId')!=checledvalue)
					{
						$(this).attr("disabled", true);
					}
					else
					{
						$(this).removeAttr("disabled");
					}
				});
			}
		 });
		
	
	$('body').on('click', '.ckbCheckAll', function(){	
		$(".qbTransfer").attr('checked', this.checked);
	});	

	$('body').on('click', '.exportOutstandingData', function(){
		exportOutstandingBillingList(50,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy,writerIdFilter);
	});
   
	
   
	$('body').on('click', '.moveToQb', function(){	
		$('#loadingOverlayEditor').show();
		var qbTransferIds = $('.qbTransfer:checked').map(function(_, el) {
			var taskType = $(this).attr('taskType');
			var fieldId = $(this).attr('id').split('_')[1]+'_'+$(this).attr('id').split('_')[2]+'_'+$(this).attr('id').split('_')[3];
			return fieldId;
		}).get();
		
		
		var idsLength = qbTransferIds.length;
		
		if(idsLength > 0){
			
			$.ajax({
				type : 'post',
				url: 'ajax/qbTransfer.php?rand='+Math.random(),
				data : { qbTransfer: 1, qbTransferIds:qbTransferIds },
				dataType:'json', 
				success: function(response){
					checkResponseRedirect(response);
					showMessage(response.message);
					$('#loadingOverlayEditor').hide();
					if(currentTabActive == 'tabId_1'){
						loadAdminConsultantTaskList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
					}
					else if(currentTabActive == 'tabId_4'){
						loadOutstandingBillingList(50,orderIdTaskOutBill,sortIdTaskOutBill,startDateParam,endDateParam,taskKeyFilterBy);
					}
					
					
				}
			});
		}
		else{
			showMessage('<?php echo @ERR_QB_SELECT;?>
');
			$('#loadingOverlayEditor').hide();
		}
	});
    
	$('body').on('click', '.exportSubmittedData', function(){
		exportBillTaskList(50,orderIdTaskBill,sortIdTaskBill,startDateParam,endDateParam,taskKeyFilterByBilling,writerIdFilter,divisionId,qbIdFilterBy);
	});	
		
		
  });
   
   function loadAdminConsultantTaskList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#taskPageListing').val(recordCount);
      $('#taskPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	   if(currentTabActive == 'tabId_4'){
				isComplete=2;
		}
		else if(currentTabActive == 'tabId_3'){
				isComplete=2;
		}
		else if(currentTabActive == 'tabId_2'){
				isComplete=2;
		}
		else if(currentTabActive == 'tabId_1'){
				isComplete=1;
		}
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'adminConsultantTaskList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId,currentTabActive:currentTabActive },
          success: function(response) {
              checkResponseRedirect(response);
			  $('#listingTab3').html("");
			  $('#listingTab2').html("");
			  $('#listingTab1').html("");

			  if(currentTabActive == 'tabId_3'){
				$('#listingTab3').html(response.message.content);
			  }
			  else if(currentTabActive == 'tabId_2'){
				$('#listingTab2').html(response.message.content);
			  }
			  else if(currentTabActive == 'tabId_1'){
				$('#listingTab1').html(response.message.content);
			  }
			  
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
				$('#marshaCodes a').addClass('descendingClassTask').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#divisionCodes a').addClass('descendingClassTask');
				$('#servTypeNames a').addClass('descendingClassTask');
				$('#TaskTypeVals a').addClass('descendingClassTask');
				$('#tires a').addClass('descendingClassTask');
				$('#dateAddedToBoxs a').addClass('descendingClassTask');
				$('#contentDues a').addClass('descendingClassTask');
				$('#prioritys a').addClass('descendingClassTask');
				$('#userNames a').addClass('descendingClassTask');
				$('#userLNames a').addClass('descendingClassTask');
				$('#isCompleteds a').addClass('descendingClassTask');
			 }
          }
      });	 
   }	
   
   
   function exportBillTaskList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId="",qbIdFilterBy=""){
	  
	  var page = pageNo ? pageNo : 1;
      var recordCount = recCountValue ? recCountValue : 50;
	  
	    if(currentTabActive == 'tabId_4'){
				isComplete=2;
		}
		else if(currentTabActive == 'tabId_3'){
				isComplete=2;
		}
	  
		$.ajax({
			type: 'post',
			data : { page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,billFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId,qbBillingId:qbIdFilterBy },
			url: 'billingExcel.php',
			success: function(response){
			   url = "billingExcel.php?page="+page+"&recCount="+recordCount+"&orderId="+orderId+"&sortId="+sortId+"&fromDate="+startDate+"&toDate="+endDate+"&billFilterBy="+taskKeyFilterBy+"&writerId="+writerIdFilter+"&isCompleteData="+isComplete+"&divisionId="+divisionId+"&qbBillingId="+qbIdFilterBy;
			   window.open(url,'_blank');
			}
		});
   }
   
    function loadBillTaskList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId="",qbIdFilterBy=""){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#billPageListing').val(recordCount);
      $('#billPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	   if(currentTabActive == 'tabId_4'){
				isComplete=2;
		}
		else if(currentTabActive == 'tabId_3'){
				isComplete=2;
		}
		
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'billingTaskList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,billFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId,qbBillingId:qbIdFilterBy },
          success: function(response) {
              checkResponseRedirect(response);
			  $('#listingTab3').html("");
			  $('#listingTab2').html("");
			  $('#listingTab1').html("");

			  if(currentTabActive == 'tabId_3'){
				$('#listingTab3').html(response.message.content);
			  }
			  else if(currentTabActive == 'tabId_2'){
				$('#listingTab2').html(response.message.content);
			  }
			  else if(currentTabActive == 'tabId_1'){
				$('#listingTab1').html(response.message.content);
			  }
			  
              $('#paginationBillAuto').html(response.message.pagination);
              $('#paginationBillAutoNew').html(response.message.pagination);
              $('#totalBillTask').html(response.message.totalRecords);
              $('#totalBillTaskNew').html(response.message.totalRecords);
   
              if(page==1 && page <= response.message.totalPages){
                  $('#paginationBillAuto .fa-angle-left').hide();
                  $('#paginationBillAutoNew .fa-angle-left').hide();	
                  $('#paginationBillAuto .fa-angle-right').show();
                  $('#paginationBillAutoNew .fa-angle-right').show();
              } else if(page > 1  && page < response.message.totalPages){
                  $('#paginationBillAuto .fa-angle-left').show();
                  $('#paginationBillAutoNew .fa-angle-left').show();
                  $('#paginationBillAuto .fa-angle-right').show();
                  $('#paginationBillAutoNew .fa-angle-right').show();
              } else if(page == response.message.totalPages){
                  $('#paginationBillAuto .fa-angle-right').hide();
                  $('#paginationBillAutoNew .fa-angle-right').hide();
                  $('#paginationBillAuto .fa-angle-left').show();
                  $('#paginationBillAuto .fa-angle-left').css("padding", "3px 10px 0px 0px");
                  $('#paginationBillAutoNew .fa-angle-left').show();	
                  $('#paginationBillAutoNew .fa-angle-left').css("padding", "3px 10px 0px 0px");
              }
   		
   		
   		if(strClassTaskBill && strClassTaskBill!=''){
			  if(strClassTaskBill=='ascendingClassTaskBill'){
				  $('#'+orderId+'s a').removeClass('ascendingClassTaskBill');
				  $('#'+orderId+'s a').addClass('descendingClassTaskBill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllBill th a').addClass('descendingClassTaskBill');
			  } else if(strClassTaskBill=='descendingClassTaskBill'){
				  $('#'+orderId+'s a').removeClass('descendingClassTaskBill');
				  $('#'+orderId+'s a').addClass('ascendingClassTaskBill').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllBill th a').addClass('ascendingClassTaskBill');
			  }
			  } else {
				$('#billing_reference_user_fnames a').addClass('descendingClassTaskBill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				$('#billing_reference_user_lnames a').addClass('descendingClassTaskBill');
				$('#billing_reference_marsha_codes a').addClass('descendingClassTaskBill');
				$('#billing_reference_division_codes a').addClass('descendingClassTaskBill');
				$('#billing_reference_service_type_names a').addClass('descendingClassTaskBill');
				$('#billing_reference_rate_per_units a').addClass('descendingClassTaskBill');
				$('#billing_reference_no_of_unitss a').addClass('descendingClassTaskBill');
				$('#billing_reference_tires a').addClass('descendingClassTaskBill');
				$('#billing_reference_created_ons a').addClass('descendingClassTaskBill');
				$('#billing_reference_doc_numbers a').addClass('descendingClassTaskBill');
			 }
          }
      });	 
   }
   
  
   
   function loadOutstandingBillingList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId){
	  
	  var page = pageNo ? pageNo : 1;
	  
      var recordCount = recCountValue ? recCountValue : 50;
      $('#outBillPageListing').val(recordCount);
      $('#outBillPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
	   if(currentTabActive == 'tabId_4'){
				isComplete=1;
		}
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'outstandingBillingTaskList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,billFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId },
          success: function(response) {
              checkResponseRedirect(response);
			  $('#listingTab4').html("");
			  $('#listingTab3').html("");
			  $('#listingTab2').html("");
			  $('#listingTab1').html("");
			  $('#listingTab4').html(response.message.content);
			 
              $('#paginationOutBillAuto').html(response.message.pagination);
              $('#paginationOutBillAutoNew').html(response.message.pagination);
              $('#totalOutBillTask').html(response.message.totalRecords);
              $('#totalOutBillTaskNew').html(response.message.totalRecords);
   
              if(page==1 && page <= response.message.totalPages){
                  $('#paginationOutBillAuto .fa-angle-left').hide();
                  $('#paginationOutBillAutoNew .fa-angle-left').hide();	
                  $('#paginationOutBillAuto .fa-angle-right').show();
                  $('#paginationOutBillAutoNew .fa-angle-right').show();
              } else if(page > 1  && page < response.message.totalPages){
                  $('#paginationOutBillAuto .fa-angle-left').show();
                  $('#paginationOutBillAutoNew .fa-angle-left').show();
                  $('#paginationOutBillAuto .fa-angle-right').show();
                  $('#paginationOutBillAutoNew .fa-angle-right').show();
              } else if(page == response.message.totalPages){
                  $('#paginationOutBillAuto .fa-angle-right').hide();
                  $('#paginationOutBillAutoNew .fa-angle-right').hide();
                  $('#paginationOutBillAuto .fa-angle-left').show();
                  $('#paginationOutBillAuto .fa-angle-left').css("padding", "3px 10px 0px 0px");
                  $('#paginationOutBillAutoNew .fa-angle-left').show();	
                  $('#paginationOutBillAutoNew .fa-angle-left').css("padding", "3px 10px 0px 0px");
              }
   		
   		
   		if(strClassTaskOutBill && strClassTaskOutBill!=''){
			  if(strClassTaskOutBill=='ascendingClassTaskOutBill'){
				  $('#'+orderId+'s a').removeClass('ascendingClassTaskOutBill');
				  $('#'+orderId+'s a').addClass('descendingClassTaskOutBill').prepend('<i class="fa fa-caret-up gray font13"></i>');
				  $('#overAllOutBill th a').addClass('descendingClassTaskOutBill');
			  } else if(strClassTaskOutBill=='descendingClassTaskOutBill'){
				  $('#'+orderId+'s a').removeClass('descendingClassTaskOutBill');
				  $('#'+orderId+'s a').addClass('ascendingClassTaskOutBill').prepend('<i class="fa fa-caret-down gray font13"></i>');
				  $('#overAllOutBill th a').addClass('ascendingClassTaskOutBill');
			  }
			  } else {
				$('#userNames a').addClass('descendingClassTaskOutBill').prepend('<i class="fa fa-caret-up gray font13"></i>');  
				$('#contentDues a').addClass('descendingClassTaskOutBill');
				$('#marshaCodes a').addClass('descendingClassTaskOutBill');
				$('#divisionCodes a').addClass('descendingClassTaskOutBill');
				$('#servTypeNames a').addClass('descendingClassTaskOutBill');
				$('#unitNos a').addClass('descendingClassTaskOutBill');
				$('#tires a').addClass('descendingClassTaskOutBill');
				$('#cons_rate_per_units a').addClass('descendingClassTaskOutBill');
			 }
          }
      });	 
   }
   
    function exportOutstandingBillingList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerIdFilter="",divisionId){
	  
	  var page = pageNo ? pageNo : 1;
      var recordCount = recCountValue ? recCountValue : 50;
	  
	  isComplete=2;
	  
    $.ajax({
        type: 'post',
        data : { page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,billFilterBy:taskKeyFilterBy, writerId: writerIdFilter, isCompleteData: isComplete,divisionId:divisionId },
        url: 'outstandingBillingExcel.php',
        success: function(response){
		   url = "outstandingBillingExcel.php?page="+page+"&recCount="+recordCount+"&orderId="+orderId+"&sortId="+sortId+"&fromDate="+startDate+"&toDate="+endDate+"&billFilterBy="+taskKeyFilterBy+"&writerId="+writerIdFilter+"&isCompleteData="+isComplete+"&divisionId="+divisionId;
           window.open(url,'_blank');
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
  
    <!-- Main content -->
    <section class="content">
		<div id="loadingOverlayEditor" class="loadingOverlayEditor" style="display:none;">
			<img src="<?php echo @ROOT_HTTP_PATH;?>
/dist/img/gifload.gif" width="100px" height="100px"/>
		</div>
		<div class="updateTaskManagerContent"> </div>
		
		   <div class="box box-primary filterStatus">
		   
		  <div class="row ">
            <div class="col-sm-3 m-t-20 m-b-20">
               <div class="form-group ">
                  <div class="col-sm-6">
                     <label>Filter By</label>
                  </div>
                  <div class="col-sm-6">
                     <select class="form-control taskKeyFilterBy" name="taskKeyFilterBy">
                     <?php echo $_smarty_tpl->tpl_vars['adminConsultantArray']->value;?>

                     </select>
					 <select class="form-control taskKeyFilterByBilling" name="taskKeyFilterByBilling" style="display:none;">
                     <?php echo $_smarty_tpl->tpl_vars['adminConsultantBillingArray']->value;?>

                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-3 m-t-20 m-b-20">
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
			    <div class="form-group taskKeyFilterUser" style="display:none;">
                  <div class="col-sm-4">
                     <label>Consultant</label>
                  </div>
                  <div class="col-sm-8">
                   <select class="form-control writerIdFilter" id="writerIdFilter">
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
				
				 <div class="form-group qbIdFilter" style="display:none;">
					 <div class="col-sm-6">
						<input type="text" class="form-control qbIdFilterBy" placeholder="QB Id" id="qbIdFilterBy" name="qbIdFilterBy"/>
					 </div>
					  <div class="col-sm-6">
						<button type="button" class="btn btn-primary pull-right qbIdFilterBySearch"><i class="fa fa-search"></i> Search</button>
					 </div>
                </div>
			   
            </div>
			<div class="col-sm-3 m-b-20">
				<div class="form-group resetFilters" style="display:none;">
						<button type="button" class="btn btn-primary pull-right m-t-20 resetFiltersAction"><i class="fa fa-minus"></i> Reset Filters</button>
				</div>
			</div>
             
         </div>
</div>		 
			 
      <div class="row">
        <div class="col-md-12">
		
          <!-- Custom Tabs -->
          <div class="nav-tabs-custom">
			<ul class="nav nav-tabs consultantTabs">
				<li data-tabId ="tabId_1" class="active tab_1" ><a href="javascript:void(0);" data-toggle="tab" class="completedTaskTab">Completed Tasks</a></li>
				<li data-tabId ="tabId_2" class="tab_2" ><a href="javascript:void(0);" data-toggle="tab" class="pendingTaskTab">Pending Tasks</a></li>
				<li data-tabId ="tabId_3" class="tab_3" ><a href="javascript:void(0);" data-toggle="tab" class="submittedBillingTab">Submitted Billing</a></li>
				<li data-tabId ="tabId_4" class="tab_4" ><a href="javascript:void(0);" data-toggle="tab" class="outstandingBillingTab">Outstanding Billing</a></li>
			 </ul>
			
            <div class="tab-content">
              <div class="tab-pane active" id="tab_1">
					<div class="box-header with-border">
						 <div id="listingTab1"></div>
					</div>
              </div>
			  <div class="tab-pane pendingTaskTabPane" id="tab_2">
					<div class="box-header with-border">
						 <div id="listingTab2"></div>
					</div>
              </div>
              <div class="tab-pane submittedBillingTabPane" id="tab_3">
					<div class="box-header with-border">
						 <div id="listingTab3"></div>
					</div>
              </div>
			   <div class="tab-pane" id="tab_4">
					<div class="box-header with-border">
						 <div id="listingTab4"></div>
					</div>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- nav-tabs-custom -->
		  
		  
		  
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      <!-- END CUSTOM TABS -->
      

    </section>

	<div id="confirmDelete">
		<div class="pop-up-overlay " style="display:none;">
			<div class="pop-close">X</div>
			<div class="container " style="display:none;">
				<div class="uiContent">
					<div class="dialog notitle" id="confirmDeletePop" style="display:none;">
						<div class="inner">
							<input type="hidden" name="delFieldId" id="delFieldId" value=""/>
							<h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_DELETE_TASK_CONTENT;?>
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
	
	<div id="confirmComplete">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmCompletePop" style="display:none;">
                    <div class="inner">
						<input type="hidden" name="completeFieldId" id="completeFieldId" value=""/>
						<input type="hidden" name="completeTaskType" id="completeTaskType" value=""/>
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

<div id="confirmPriority">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
                <div class="dialog notitle" id="confirmPriorityPop" style="display:none;">
                    <div class="inner">
						<input type="hidden" name="priorityFieldId" id="priorityFieldId" value=""/>
						<input type="hidden" name="priorityAdminTaskType" id="priorityAdminTaskType" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_PRIRORITY_TASK;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okPriorityButton"><?php echo @LBL_YES;?>
</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelPriorityButton"><?php echo @LBL_NO;?>
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
						<input type="hidden" name="completeAdminTaskType" id="completeAdminTaskType" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_COMP_ADMIN_TASK_CONTENT;?>
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
						<input type="hidden" name="completeAdminTaskType" id="completeAdminTaskType" value=""/>
                        <h5 align="center" class="lineB P25 M0"><?php echo @CONFIRM_REASSIGN_TASK_CONTENT;?>
</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
							<tr>
                                <td class="p-t-10">
                                    <label>Notes</label> <textarea class="form-control task_content_admin_notes" id="task_content_admin_notes"></textarea>
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
</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?>