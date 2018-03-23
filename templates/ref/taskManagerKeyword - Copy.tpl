{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Task Manager Keyword{/block}
{block name=header}
<script type="text/javascript">
   var strClassTask;
   var taskKeyFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdTask = 0;
   var sortIdTask = 0;
   $(document).ready(function(){
   
   
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
   
   $( ".taskKeyFilterBy" ).change(function() {
   	taskKeyFilterBy =  $(this).val();
   	if(taskKeyFilterBy > 1){
   		$('.taskKeyFilterRangeStatus').show();
   	}
   	else{
   		$('.taskKeyFilterRangeStatus').hide();
   	}
   	
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
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
   
   $('body').on('click', '.taskKeywordCancel', function(){
   	$(".addTaskManagerKeyword").toggle();
   });	
   
   $('body').on('click', '.taskKeywordUpdateCancel', function(){
   	$(".updateTaskManagerKeyword").toggle();
   });	
   
   $('#task_keyword_user_id').chosen({ width:"100%"});
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
            var fieldId = $(this).attr('id').split('_')[1];
			var task_complete_val = $('#completeTask_'+fieldId);
			
			if (task_complete_val.is(':checked')) {
				task_complete = 1;
			}
			else{
				task_complete = 0;
			}
            $('#completeFieldId').val(fieldId);
            $('#confirmComplete .uiContent').html($('#confirmCompletePop').html());
            uiPopupOpen('confirmComplete', 500, 125);
	});
	
	
	var task_admin_complete;	
	$('body').on('change', '.taskKeywordCompleteAdminAction', function(){
            var fieldId = $(this).attr('id').split('_')[1];
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
				  $('#confirmAdminReassign .uiContent').html($('#confirmAdminReassignPop').html());
				  uiPopupOpen('confirmAdminReassign', 500, 250);
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
		fieldId = $('#completeFieldId').val();
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordComplete: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_complete },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmComplete');
				showMessage(response.message);
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	$('body').on('click', '.okAdminTaskCompButton', function(){
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
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
	$('body').on('click', '.okAdminTaskReassignButton', function(){
		fieldId = $('#completeAdminFieldId').val();
		adminNotes = $('.task_keyword_admin_notes').val();
		$.ajax({
			type : 'post',
			url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
			data : { taskKeywordAdminReassign: 1, taskKeywordCompId:fieldId, taskKeywordCompVal : task_admin_complete, taskKeywordAdminNotes:adminNotes },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmAdminReassign');
				showMessage(response.message);
				loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
	
   
   
   $('body').on('click', '.taskKeywordSave', function(){
   	
   	var task_keyword_marsha_code = $('.task_keyword_marsha_code').val();
   	var task_keyword_no_of_pages = $('.task_keyword_no_of_pages').val();
	var task_keyword_foun_prog = $('.task_keyword_foun_prog').val();
	var task_keyword_expanded_seo = $('.task_keyword_expanded_seo').val();
	var task_keyword_outlet_mark = $('.task_keyword_outlet_mark').val();
	var task_keyword_notes = $('.task_keyword_notes').val();
	var task_keyword_box_location = $('.task_keyword_box_location').val();
	var task_keyword_added_box_date = $('.task_keyword_added_box_date').val();
   	var task_keyword_link_db_file = $('.task_keyword_link_db_file').val();
   	var task_keyword_setup_due_date = $('.task_keyword_setup_due_date').val();
   	var task_keyword_setup_file = $('.task_keyword_setup_file').val();
   	var task_keyword_com_due_date = $('.task_keyword_com_due_date').val();
   	var task_keyword_com_date = $('.task_keyword_com_date').val();
   	var task_keyword_user_id = $('.task_keyword_user_id').val();
   	var taskKeywordId = $('.taskKeywordId').val();
	var task_keyword_date = $('.task_keyword_date').val();
   	
   	if(task_keyword_marsha_code==''){
              showMessage('{$smarty.const.ERR_TASK_KEYWORD_MARSHA_CODE}');
              $('.task_keyword_marsha_code').focus();
              return false;
          }
   	
   	if(task_keyword_user_id==''){
              showMessage('{$smarty.const.ERR_TASK_KEYWORD_USER_ID}');
              $('.task_keyword_user_id').focus();
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
   		data: { actionOperand: actionOperand, marshaCodeData: task_keyword_marsha_code, noPagesData: task_keyword_no_of_pages, foundProgData: task_keyword_foun_prog, expandSeoData: task_keyword_expanded_seo,outletMarkData: task_keyword_outlet_mark, notesData: task_keyword_notes,boxLocationData: task_keyword_box_location, boxAddedDateData: task_keyword_added_box_date,linkDbFileData: task_keyword_link_db_file, setupDueData: task_keyword_setup_due_date, setupUplboxData:  task_keyword_setup_file , comDueData:  task_keyword_com_due_date, completedData:  task_keyword_com_date, taskDateData:  task_keyword_date , userIdData:  task_keyword_user_id, taskKeywordUpdateId:  taskKeywordId },
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
   			loadTaskKeywordList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   		}		
   	});
            
      });	
   
   $('body').on('click', '.taskKeywordUpdateAction', function(){
   	$(".addTaskManagerKeyword").hide();
   	$(".updateTaskManagerKeyword").show();
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
   
   function loadTaskKeywordList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#taskPageListing').val(recordCount);
      $('#taskPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'taskManagerKeywordList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy },
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
   			$('#task_keyword_setup_files a').addClass('descendingClassTask');
   			$('#task_keyword_com_due_dates a').addClass('descendingClassTask');
   			$('#task_keyword_com_dates a').addClass('descendingClassTask');
			$('#task_keyword_dates a').addClass('descendingClassTask');
   			$('#user_fnames a').addClass('descendingClassTask');
			$('#task_keyword_created_ons a').addClass('descendingClassTask');
              }
   		
   		
          }
      });	 
   }	
</script> 
{/block}
{block name=content}
<div class="updateTaskManagerKeyword"> </div>
<div class="row addTaskManagerKeyword" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
            <div class="form-group col-sm-3">
               <label >Marsha Code</label>
               <select class="form-control task_keyword_marsha_code" id="task_keyword_marsha_code">
                  <option value="">--- Select Marsha Code ---</option>
                  {if $marshaCodesArray}
                  {foreach $marshaCodesArray as $key=> $value}
                  <option value="{$value.client_entity_id}">{$value.client_entity_marsha_code}</option>
                  {/foreach}
                  {/if}
               </select>
            </div>
            <div class="form-group col-sm-3">
               <label >Division</label>
               <input readonly class="form-control task_keyword_division" id="task_keyword_division" placeholder="">
            </div>
            <div class="form-group col-sm-3">
               <label >Sig + (# of Pages TBD)</label>
               <input type="text" class="form-control task_keyword_no_of_pages" id="task_keyword_no_of_pages" placeholder="">
            </div>
			<div class="form-group col-sm-3">
               <label >Foundations Program </label>
               <input type="text" class="form-control task_keyword_foun_prog" id="task_keyword_foun_prog" placeholder="">
            </div>
			 </div>
			 <div class="row">
			<div class="form-group col-sm-3">
               <label >Expanded Seo</label>
               <input type="text" class="form-control task_keyword_expanded_seo" id="task_keyword_expanded_seo" placeholder="">
            </div>
			<div class="form-group col-sm-3">
               <label >Outlet Marketing Bundle </label>
               <input type="text" class="form-control task_keyword_outlet_mark" id="task_keyword_outlet_mark" placeholder="">
            </div>
			 <div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_keyword_notes" id="task_keyword_notes"></textarea>
            </div>
			<div class="form-group col-sm-3">
               <label >BOX Location</label>
               <input type="text" class="form-control task_keyword_box_location" id="task_keyword_box_location" placeholder="">
            </div>
           
			 </div>
			 <div class="row">
				 <div class="form-group col-sm-3">
               <label >Date Added to BOX</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_added_box_date datepicker" id="task_keyword_added_box_date">
               </div>
            </div>
			  
            <div class="form-group col-sm-3">
               <label >Kw set up due date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_setup_due_date datepicker" id="task_keyword_setup_due_date">
               </div>
            </div>
			<div class="form-group col-sm-3">
               <label >Keyword Set Up and Uploaded to Box </label>
               <input type="text" class="form-control task_keyword_setup_file" id="task_keyword_setup_file" placeholder="">
            </div>
			 <div class="form-group col-sm-3">
               <label >Keyword Completed  Due Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_com_due_date datepicker" id="task_keyword_com_due_date">
               </div>
            </div>
			 </div>
			  <div class="row">
			   <div class="form-group col-sm-3">
               <label >Kw submitted</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_com_date datepicker" id="task_keyword_com_date">
               </div>
            </div>
			  <div class="form-group col-sm-3">
               <label >Personnel</label>
               <select class="form-control task_keyword_user_id" id="task_keyword_user_id">
                  <option value="">--- Select Personnel ---</option>
                  {if $userArray}
                  {foreach $userArray as $key=> $value}
                  <option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
                  {/foreach}
                  {/if}
               </select>
            </div>
			  <div class="form-group col-sm-3">
               <label >Link to db file</label>
               <input type="text" class="form-control task_keyword_link_db_file" id="task_keyword_link_db_file" placeholder="">
            </div>
			  
			<div class="form-group col-sm-3">
               <label >Kw Task Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_date datepicker" id="task_keyword_date">
               </div>
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
                     {$filterByArray}
                     </select>
                  </div>
                  <!-- /.input group -->
               </div>
            </div>
            <div class="col-sm-4">
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
            </div>
            <div class="col-sm-5">
               <button type="button" class="btn btn-primary pull-right margin addNewTask"><i class="fa fa-plus"></i> Add New Task</button>
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
               <button type="button" class="btn btn-primary pull-right margin addNewTask"><i class="fa fa-plus"></i> Add New Task</button>
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_TASK_KEYWORD}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okTaskDelButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskDelButton">{$smarty.const.LBL_NO}</a>
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_COMP_TASK_KEYWORD}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okTaskCompButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelTaskCompButton">{$smarty.const.LBL_NO}</a>
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_COMP_ADMIN_TASK_KEYWORD}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskCompButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskCompButton">{$smarty.const.LBL_NO}</a>
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_REASSIGN_TASK_KEYWORD}</h5>
                        <table border="0" cellspacing="0" cellpadding="5" align="center">
							<tr>
                                <td class="p-t-10">
                                    <label>Notes</label> <textarea class="form-control task_keyword_admin_notes" id="task_keyword_admin_notes"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="p-t-10">
                                    <a href="javascript:void(0);" class="btn btn-primary M2 okAdminTaskReassignButton">{$smarty.const.LBL_YES}</a>
                                    <a href="javascript:void(0);" class="btn btn-default M2 cancelAdminTaskReassignButton">{$smarty.const.LBL_NO}</a>
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
{/block}