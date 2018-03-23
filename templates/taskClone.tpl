{extends file="innerLayout.tpl"}
{block name=header}
<script type="text/javascript">
   $(document).ready(function(){
	   
	   $(".task_keyword_service_type_id option[value=62]").remove();
	   
	   {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }

			$('#task_keyword_user_id').chosen({ width:"100%"});
			$('#task_keyword_service_type_id').chosen({ width:"100%"});

		{/if}
		
	$('body').on('click', '.taskKeywordCancel', function(){
		window.parent.uiPopClose('taskClone');
    });		
	
	$('body').on('click', '.taskKeywordSave', function(){
   	
   	var task_keyword_marsha_code = $('.task_keyword_marsha_code').val();
	var task_keyword_service_type_id = $('.task_keyword_service_type_id').val();
   	var task_keyword_no_of_pages = $('.task_keyword_no_of_pages').val();
	var task_keyword_added_box_date = $('.task_keyword_added_box_date').val();
   	var task_keyword_link_db_file = $('.task_keyword_link_db_file').val();
   	var task_keyword_setup_due_date = $('.task_keyword_setup_due_date').val();
   	var task_keyword_setup_complete = $('.task_keyword_setup_complete').val();
   	var task_keyword_user_id = $('.task_keyword_user_id').val();
	var task_keyword_date = $('.task_keyword_date').val();
	var task_keyword_priority = $('.task_keyword_priority').val();
	var task_keyword_notes = $('.task_keyword_notes').val();
	var task_is_sub_task = $('.task_is_sub_task').val();
	var task_keyword_tire = $('.task_keyword_tire').val();
	var taskRecordId = $('.taskRecordId').val();
	
	if(task_keyword_user_id==''){
		  showMessage('{$smarty.const.ERR_TASK_KEYWORD_USER_ID}');
		  $('.task_keyword_user_id').focus();
		  return false;
	  }
	
   	actionOperand = 1;
   	
   	$.ajax({
   		url: 'ajax/taskManagerKeyword.php?rand='+Math.random(),
   		type: 'post',
   		dataType: 'json',
   		data: { actionOperand: actionOperand, marshaCodeData: task_keyword_marsha_code, noPagesData: task_keyword_no_of_pages, notesData: task_keyword_notes,boxAddedDateData: task_keyword_added_box_date,linkDbFileData: task_keyword_link_db_file, setupDueData: task_keyword_setup_due_date, setupCompleteData:  task_keyword_setup_complete , taskDateData:  task_keyword_date , userIdData:  task_keyword_user_id , priorityData:  task_keyword_priority, task_is_sub_task:task_is_sub_task, taskRecordId:taskRecordId, taskCloneStatusId:1 },
   		success: function(response) {
   			checkResponseRedirect(response);
   			showMessage(response.message);
			window.parent.uiPopClose('taskClone');
			window.parent.loadTaskKeywordList(50,window.parent.orderIdTask,window.parent.sortIdTask,window.parent.startDateParam,window.parent.endDateParam,window.parent.taskKeyFilterBy);

   		}		
   	});
            
      });	
		
		
    });
</script>
	
{/block}
{block name=content}
{strip}
  <div class="row" >
		<div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
            <div class="form-group col-sm-3">
               <label >{$codeLabelData}</label>
               <p>{$taskKeywordData.client_entity_marsha_code}</p>
			   <input type="hidden" class="form-control task_keyword_marsha_code" id="task_keyword_marsha_code" value="{$taskKeywordData.task_keyword_marsha_code}">
			   
			    <input type="hidden" class="form-control task_is_sub_task" id="task_is_sub_task" value="1">
				
				
				<input type="hidden" class="form-control taskRecordId" id="taskRecordId" value="{$taskKeywordData.task_keyword_id}">
            </div>
            <div class="form-group col-sm-3">
               <label >Division</label>
               <p>{$taskKeywordData.division_code}</p>
			   <input type="hidden" class="form-control task_keyword_division" id="task_keyword_division" value="{$taskKeywordData.division_id}">
            </div>
			 <div class="form-group col-sm-3">
                  <label>Service Type</label>
                  <select class="form-control task_keyword_service_type_id" id="task_keyword_service_type_id">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}">{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
			   
			   
            <div class="form-group col-sm-3">
               <label >Number of Pages</label>
				<p>{$taskKeywordData.task_keyword_no_of_pages}</p>
				 <input type="hidden" class="form-control task_keyword_no_of_pages" id="task_keyword_no_of_pages" value="{$taskKeywordData.task_keyword_no_of_pages}">
            </div>
			<div class="form-group col-sm-3">
					<label >Start Date</label>
					<p>{$taskKeywordData.task_keyword_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</p>
					  <input type="hidden" class="form-control pull-right task_keyword_added_box_date" id="task_keyword_added_box_date" value="{$taskKeywordData.task_keyword_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
				</div>
				
				 <div class="form-group col-sm-3">
               <label >Link to Completed Keyword File</label>
			   <p>{$taskKeywordData.task_keyword_link_db_file}</p>
			    <input type="hidden" class="form-control task_keyword_link_db_file" id="task_keyword_link_db_file" value="{$taskKeywordData.task_keyword_link_db_file}">
            </div>
			 <div class="form-group col-sm-3" >
                  <label >Priority</label>
				  <p>{if $taskKeywordData.task_keyword_priority==1}Yes{else}No{/if}</p>
				  <input type="hidden" class="form-control task_keyword_priority" id="task_keyword_priority" value="{if $taskKeywordData.task_keyword_priority==1}1{else}0{/if}">
               </div>
			    <div class="form-group col-sm-3">
               <label >Tactic Due</label>
			   <p>{$taskKeywordData.task_keyword_setup_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</p>
			    <input type="hidden" class="form-control pull-right task_keyword_setup_due_date datepicker" id="task_keyword_setup_due_date" value="{$taskKeywordData.task_keyword_setup_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
				</div>
			
			 </div>
			 <div class="row">
				 <div class="form-group col-sm-3">
               <label >Complete</label>
				<p>{if $taskKeywordData.task_keyword_setup_complete==1}Yes{else}No{/if}</p>
				<input type="hidden" class="form-control task_keyword_setup_complete" id="task_keyword_setup_complete" value="{if $taskKeywordData.task_keyword_setup_complete==1}1{else}0{/if}">
				</div>
				<div class="form-group col-sm-3">
				   <label >Date Complete</label>
				   <p>{$taskKeywordData.task_keyword_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</p>
				   <input type="hidden" class="form-control pull-right task_keyword_date" id="task_keyword_date" value="{$taskKeywordData.task_keyword_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
				</div>
				 <div class="form-group col-sm-3">
               <label >Consultant</label>
               <select class="form-control task_keyword_user_id" id="task_keyword_user_id">
					<option value="">--- Select Personnel ---</option>
					 {if $userArray}
						{foreach $userArray as $key=> $value}
							 <option value="{$value.user_id}" >{$value.user_fname} {$value.user_lname}</option>
						{/foreach}
					{/if}
                  </select>
				</div>
				<div class="form-group col-sm-3">
                  <label >Notes</label>
				  <p>{$taskKeywordData.task_keyword_notes}</p>
				   <input type="hidden" class="form-control task_keyword_notes" id="task_keyword_notes" value="{$taskKeywordData.task_keyword_notes}">
            </div>
			 </div>
			
			<div class="row">
				 <div class="form-group col-sm-3">
               <label >Tier</label>
			   <p>{$taskKeywordData.task_keyword_tire}</p>
            </div>
				 
			</div>
				<button type="button" class="btn btn-default pull-right margin taskKeywordCancel">Cancel</button>
				<button type="button" class="btn btn-info pull-right margin taskKeywordSave">Done</button>
         </div>
      </div>
		</div>
      </div>
{/strip}
{/block}