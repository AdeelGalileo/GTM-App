{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Task Manager Keyword{/block}
{block name=header}
{strip}
<script type="text/javascript">
   var strClassTask;
   var taskKeyFilterBy;
   var startDateParam;
   var endDateParam;
   var orderIdTask = 0;
   var sortIdTask = 0;
   $(document).ready(function(){
   
   
   loadTaskContentList(50,orderIdTask,sortIdTask);
   	
   $('body').on('click', '.descendingClassTask', function(){
          orderIdTask = $(this).attr('id');
          sortIdTask = 2;
   	pageNo = $('#pageDropDownValue').val();
          strClassTask = 'descendingClassTask';
   	var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
      });
   
    $('body').on('click', '.ascendingClassTask', function(){
          orderIdTask = $(this).attr('id');
          sortIdTask = 1;
   	pageNo = $('#pageDropDownValue').val();
   	strClassTask = 'ascendingClassTask';
   	var recCountValues = $('#taskPageListing').val();
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
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
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
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
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
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
          loadTaskContentList(recCountValues,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#taskPageListing', function(){
          var recCount = $(this).val();
          $('#taskPageListingNew').val(recCount);
          pageNo = 0;
          loadTaskContentList(recCount,orderIdTask,sortIdTask);
      });
      $('body').on('change', '#taskPageListingNew', function(){
          var recCount = $(this).val();
          $('#taskPageListing').val(recCount);
          pageNo = 0;
          loadTaskContentList(recCount,orderIdTask,sortIdTask);
      });	
   
   $('.taskKeyFilterRangeStatus').hide();
   
   $( ".taskKeyFilterBy" ).change(function() {
   	taskKeyFilterBy =  $(this).val();
   	if(taskKeyFilterBy == 2){
   		$('.taskKeyFilterRangeStatus').show();
   	}
   	else{
		if(taskKeyFilterBy == 3){
   		$('.taskKeyFilterRangeStatus').hide();
		$('.taskKeyFilterUser').show();
	 
   	}
		else
		{
			$('.taskKeyFilterRangeStatus').hide();
			$('.taskKeyFilterUser').hide();
		}
   	}
   	
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
   });
   
    $( ".searchByWriter" ).change(function() {
		searchByWriter =  $(this).val();
		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy,searchByWriter);
    });
   
   $('body').on('click', '.applyBtn, .ranges', function(){
   	taskKeyFilterRangeVal =  $('.taskKeyFilterRange').val();
   	if(taskKeyFilterRangeVal.length > 0){
   		taskKeyFilterRangeVal=taskKeyFilterRangeVal.split('-');
   		startDateParam = taskKeyFilterRangeVal[0].trim();
   		endDateParam = taskKeyFilterRangeVal[1].trim();
   		loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   	}
   });
   
   $('body').on('click', '.addNewTask', function(){
   	$(".addTaskManagerContent").toggle();
   });	
   
   $('body').on('click', '.taskContentCancel', function(){
   	$(".addTaskManagerContent").toggle();
   });	
   
   $('body').on('click', '.taskContentUpdateCancel', function(){
   	$(".updateTaskManagerContent").toggle();
   });	
   
   $('#task_content_user_id').chosen({ width:"100%"});
   $('#task_content_marsha_code').chosen({ width:"100%"});
   $('#task_content_service_type_id').chosen({ width:"100%"});
   
   $('body').on('change', '.task_content_marsha_code', function(){
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
   					$('.task_content_division').val(response.message.division_code);
   				}	
   	   });
   });
   
   $('body').on('click', '.taskContentDeleteAction', function(){
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
			url: 'ajax/taskManagerContent.php?rand='+Math.random(),
			data : { taskContentDelete: 1, taskContentDeleteId:fieldId },
			dataType:'json', 
			success: function(response){
				checkResponseRedirect(response);
				uiPopClose('confirmDelete');
				showMessage(response.message);
				loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
			}
		});
	});
   
   
   $('body').on('click', '.taskContentSave', function(){
   	
   	var task_content_marsha_code = $('.task_content_marsha_code').val();
   	var task_content_service_type_id = $('.task_content_service_type_id').val();
   	var task_content_tire = $('.task_content_tire').val();
	
	var task_content_priority_val = $('.task_content_priority');
	var task_content_priority;
	
	if (task_content_priority_val.is(':checked')) {
		task_content_priority = 1;
	}
	else{
		task_content_priority = 0;
	}
	
   	var task_content_added_box_date = $('.task_content_added_box_date').val();
	var task_content_due_date = $('.task_content_due_date').val();
   	var task_content_added_box_due_date = $('.task_content_added_box_due_date').val();
	var task_content_rev_req = $('.task_content_rev_req').val();
	var task_content_rev_com = $('.task_content_rev_com').val();
	var task_content_rev_sec_req = $('.task_content_rev_sec_req').val();
	var task_content_rev_sec_com = $('.task_content_rev_sec_com').val();
   	var task_content_ass_writer_date = $('.task_content_ass_writer_date').val();
	var task_content_is_complete;
	
	var task_content_is_complete_val = $('.task_content_is_complete');
	
	if (task_content_is_complete_val.is(':checked')) {
		task_content_is_complete = 1;
	}
	else{
		task_content_is_complete = 0;
	}
	
	
	var task_content_proj_com_date = $('.task_content_proj_com_date').val();
   	var task_content_user_id = $('.task_content_user_id').val();
	var task_content_no_of_units = $('.task_content_no_of_units').val();
   	var task_content_link_to_file = $('.task_content_link_to_file').val();
	var task_content_notes = $('.task_content_notes').val();
	var taskContentId = $('.taskContentId').val();
	
   
   	if(task_content_marsha_code==''){
              showMessage('{$smarty.const.ERR_MARSHA_CODE}');
              $('.task_content_marsha_code').focus();
              return false;
          }
   	
  
   	if(task_content_user_id==''){
              showMessage('{$smarty.const.ERR_TASK_CONTENT_USER_ID}');
              $('.task_content_user_id').focus();
              return false;
          }
   
   
   if(taskContentId > 0){
   		actionOperand = 2;
   	}
   	else{
   		actionOperand = 1;
   	}
   
   	$.ajax({
   		url: 'ajax/taskManagerContent.php?rand='+Math.random(),
   		type: 'post',
   		dataType: 'json',
   		data: { actionOperand: actionOperand, marshaCodeData: task_content_marsha_code, serviceTypeIdData: task_content_service_type_id, tireData: task_content_tire, priorityData: task_content_priority, addedBoxData:  task_content_added_box_date , dueData:  task_content_due_date, addedBoxDueData:  task_content_added_box_due_date, revReqData:  task_content_rev_req , revComData:  task_content_rev_com, revSecReqData:  task_content_rev_sec_req, revComSecData:  task_content_rev_sec_com, assWriterData:  task_content_ass_writer_date, isCompleteData:  task_content_is_complete, projComData:  task_content_proj_com_date, writerIdData:  task_content_user_id, noUnitsData:  task_content_no_of_units, linkToFileData:  task_content_link_to_file, notesData:  task_content_notes, taskContentUpdateId:  taskContentId},
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
   			loadTaskContentList(50,orderIdTask,sortIdTask,startDateParam,endDateParam,taskKeyFilterBy);
   		}		
   	});
            
      });	
   
   $('body').on('click', '.taskContentUpdateAction', function(){
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
   
   
   });
   
   function loadTaskContentList(recCountValue,orderId="",sortId="",startDate="",endDate="",taskKeyFilterBy="",writerId=""){
   
   var page = pageNo ? pageNo : 1;
   
      var recordCount = recCountValue ? recCountValue : 50;
      $('#taskPageListing').val(recordCount);
      $('#taskPageListingNew').val(recordCount);
      /*$('#listingTabs').html(loadImg);*/
   
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'taskManagerContentList', page: page, recCount: recordCount, orderId: orderId, sortId: sortId, fromDate: startDate, toDate : endDate,taskKeyFilterBy:taskKeyFilterBy, writerId: writerId },
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
   			$('#serv_type_names a').addClass('descendingClassTask');
   			$('#task_content_tires a').addClass('descendingClassTask');
   			$('#task_content_link_to_files a').addClass('descendingClassTask');
   			$('#task_content_added_box_dates a').addClass('descendingClassTask');
   			$('#task_content_due_dates a').addClass('descendingClassTask');
   $('#task_content_prioritys a').addClass('descendingClassTask');
   			$('#user_fnames a').addClass('descendingClassTask');
   $('#task_content_is_completes a').addClass('descendingClassTask');
              }
   		
   		
          }
      });	 
   }	
</script> 
{/strip}
{/block}
{block name=content}
<div class="updateTaskManagerContent"> </div>
<div class="row addTaskManagerContent" style="display:none;">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
               <div class="form-group col-sm-3">
                  <label >Marsha Code</label>
                  <select class="form-control task_content_marsha_code" id="task_content_marsha_code">
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
                  <input readonly class="form-control task_content_division" id="task_content_division" placeholder="">
               </div>
               <div class="form-group col-sm-3">
                  <label >Service Type</label>
                  <select class="form-control task_content_service_type_id" id="task_content_service_type_id">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
               <div class="form-group col-sm-3">
                  <label >Tier</label>
                  <input type="text" class="form-control task_content_tire" id="task_content_tire" placeholder="">
               </div>
            </div>
            <div class="row">
               <div class="form-group col-sm-3" >
                  <label >Priority</label>
                  <br/>
                  <input type="checkbox" class="task_content_priority" id="task_content_priority" >
               </div>
               <div class="form-group col-sm-3">
                  <label >Date added to box</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_added_box_date datepicker" id="task_content_added_box_date">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >Due by</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_due_date datepicker" id="task_content_due_date">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >(Done) Date added to box</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_added_box_due_date datepicker" id="task_content_added_box_due_date">
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="form-group col-sm-3">
                  <label >Revision Request</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_rev_req datepicker" id="task_content_rev_req">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >Revision Complete</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_rev_com datepicker" id="task_content_rev_com">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >Second Revision Request</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_rev_sec_req datepicker" id="task_content_rev_sec_req">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >Second Revision Complete</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_rev_sec_com datepicker" id="task_content_rev_sec_com">
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="form-group col-sm-3">
                  <label >Assigned to writer</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_ass_writer_date datepicker" id="task_content_ass_writer_date">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >Complete</label>
                  <br/>
                  <input type="checkbox" class="task_content_is_complete" id="task_content_is_complete" >
               </div>
               <div class="form-group col-sm-3">
                  <label >Projected Completion</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_proj_com_date datepicker" id="task_content_proj_com_date">
                  </div>
               </div>
               <div class="form-group col-sm-3">
                  <label >Consultant</label>
                  <select class="form-control task_content_user_id" id="task_content_user_id">
                     <option value="">--- Select Consultant ---</option>
                     {if $userArray}
                     {foreach $userArray as $key=> $value}
                     <option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
            </div>
            <div class="row">
               <div class="form-group col-sm-3">
                  <label ># Pages</label>
                  <input type="text" class="form-control task_content_no_of_units" id="task_content_no_of_units" placeholder="">
               </div>
               <div class="form-group col-sm-3">
                  <label >Link to file</label>
                  <input type="text" class="form-control task_content_link_to_file" id="task_content_link_to_file" placeholder="">
               </div>
               <div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_content_notes" id="task_content_notes"></textarea>
               </div>
            </div>
            <button type="button" class="btn btn-default pull-right margin taskContentCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin taskContentSave">Done</button>
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
                     {$filterByContentArray}
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
			    <div class="form-group taskKeyFilterUser" style="display:none;">
                  <div class="col-sm-6">
                     <label>Select Consultant</label>
                  </div>
                  <div class="col-sm-6">
                   <select class="form-control searchByWriter" id="searchByWriter">
                     <option value="">--- Select Consultant ---</option>
                     {if $userArray}
                     {foreach $userArray as $key=> $value}
                     <option value="{$value.user_id}">{$value.user_fname} {$value.user_lname}</option>
                     {/foreach}
                     {/if}
                  </select>
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
                        <h5 align="center" class="lineB P25 M0">{$smarty.const.CONFIRM_DELETE_TASK_CONTENT}</h5>
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