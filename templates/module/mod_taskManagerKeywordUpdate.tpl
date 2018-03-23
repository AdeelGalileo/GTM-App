{strip}
<script type="text/javascript">
  
   var configDate;
   var d;
	
   $(document).ready(function(){
	    d = new Date();
		$('.completeDateDiv').hide();
		$('.task_keyword_added_box_date').datepicker({
        format: "mm/dd/yyyy"
		}).on('changeDate',function(e){
			d = new Date(e.date);
		 
		 if({$taskKeywordData.task_keyword_service_type_id} == '{$smarty.const.SERVICE_TYPE_KEYWORD_SETUP_ID}'){
			 configDate= {$smarty.const.TACTIC_DUE_BUSINESS_DAY_KEYWORD_SETUP};
		 }
		 else{
			 configDate= {$smarty.const.TACTIC_DUE_BUSINESS_DAY_FOR_OTHERS};
		 }
		 
		 /*tacticDateVal = (startDate.getMonth() + 1) + '/' + (startDate.getDate() + configDate) + '/' +  startDate.getFullYear();*/
		 tacticDateVal = addBusinessDays(d, configDate);
		 $('.task_keyword_setup_due_date').val(tacticDateVal);
		});
});

</script>

		<div class="row " >
		<div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
            <div class="form-group col-sm-3">
               <label >{$codeLabelData}</label>
              <select class="form-control task_keyword_marsha_code" id="task_keyword_marsha_code">
					<option value="">--- Enter {$codeLabelData} ---</option>
					 {if $marshaCodesArray}
						{foreach $marshaCodesArray as $key=> $value}
							 <option value="{$value.client_entity_id}" {if $taskKeywordData.task_keyword_marsha_code==$value.client_entity_id }selected{/if}>{$value.client_entity_marsha_code}</option>
						{/foreach}
					{/if}
                  </select>
            </div>
            <div class="form-group col-sm-3">
               <label >Division</label>
               <input readonly class="form-control task_keyword_division" id="task_keyword_division" value="{$taskKeywordData.division_code}">
            </div>
			 <div class="form-group col-sm-3">
				  {if $taskKeywordData.task_keyword_service_type_id !=$smarty.const.SERVICE_TYPE_KEYWORD_SETUP_ID}
                  <label>Service Type</label>
                  <select class="form-control task_keyword_service_type_id" id="task_keyword_service_type_id">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}" {if $taskKeywordData.task_keyword_service_type_id==$value.serv_type_id }selected{/if}>{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
				  {else}
					<label>Service Type</label>
					<p>
						{if $serviceTypeArray}
						 {foreach $serviceTypeArray as $key=> $value}
							{if $taskKeywordData.task_keyword_service_type_id==$value.serv_type_id }{$value.serv_type_name}{/if} 
						 {/foreach}
						 {/if}
					 </p>
					<input type="hidden" class="form-control pull-right task_keyword_service_type_id" id="task_keyword_service_type_id" value="{$taskKeywordData.task_keyword_service_type_id}">
				   {/if}
               </div>
            <div class="form-group col-sm-3">
               <label >Number of Pages</label>
                <input type="text" class="form-control task_keyword_no_of_pages" id="task_keyword_no_of_pages" value="{$taskKeywordData.task_keyword_no_of_pages}">
            </div>
			
			 </div>
			 <div class="row">
				
				<div class="form-group col-sm-3">
					   <label >Start Date</label>
					   <div class="input-group date">
						  <div class="input-group-addon">
							 <i class="fa fa-calendar"></i>
						  </div>
						   <input readonly class="form-control pull-right task_keyword_added_box_date datepicker" id="task_keyword_added_box_date" value="{$taskKeywordData.task_keyword_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
					   </div>
				</div>
				  <div class="form-group col-sm-3">
               <label >Source Link</label>
              <input type="text" class="form-control task_keyword_link_db_file" id="task_keyword_link_db_file" value="{$taskKeywordData.task_keyword_link_db_file}">
            </div>
			<div class="form-group col-sm-3" >
                  <label >Priority</label>
                  <br/>
                  <input type="checkbox" class="task_keyword_priority" id="task_keyword_priority" {if $taskKeywordData.task_keyword_priority==1}checked{/if}  >
               </div>
				 <div class="form-group col-sm-3">
               <label >Tactic Due</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                   <input readonly class="form-control pull-right task_keyword_setup_due_date datepicker" id="task_keyword_setup_due_date" value="{$taskKeywordData.task_keyword_setup_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
				</div>
				 
			 </div>
			
			<div class="row">
				
				{if $taskKeywordData.task_keyword_admin_complete != 1}
					<div class="form-group col-sm-3">
						<label >Complete</label>
						<br/>
						<input type="checkbox" class="task_keyword_setup_complete" id="task_keyword_setup_complete" {if $taskKeywordData.task_keyword_setup_complete==1}checked{/if} >
					</div>
					
					<div class="form-group col-sm-3 completeDateDiv">
               <label >Complete Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_date datepicker" id="task_keyword_date" value="{$taskKeywordData.task_keyword_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
				</div>
				
				{else}
					<input type="hidden" name="task_keyword_setup_complete" id="task_keyword_setup_complete" class="task_keyword_setup_complete" value="{$taskKeywordData.task_keyword_setup_complete}">
				{/if}
				
				
				
			  <div class="form-group col-sm-3">
               <label >Consultant</label>
			   {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
               <select class="form-control task_keyword_user_id" id="task_keyword_user_id">
					<option value="">--- Select Personnel ---</option>
					 {if $userArray}
						{foreach $userArray as $key=> $value}
							 <option value="{$value.user_id}" {if $taskKeywordData.task_keyword_user_id==$value.user_id }selected{/if} >{$value.user_fname} {$value.user_lname}</option>
						{/foreach}
					{/if}
                  </select>
				{else}
					<p>{$smarty.session.userName}</p>
					<input type="hidden" name="task_keyword_user_id" id="task_keyword_user_id" class="task_keyword_user_id" value="{$smarty.session.userId}">
			    {/if}  
            </div>
			<div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_keyword_notes" id="task_keyword_notes">{$taskKeywordData.task_keyword_notes}</textarea>
				</div>
				 
			</div>
			
			<div class="row">
				<div class="form-group col-sm-3">
				   <label >Tier</label>
				  <input type="text" class="form-control task_keyword_tire" id="task_keyword_tire" value="{$taskKeywordData.task_keyword_tire}">
				</div>
			</div>
			
				<button type="button" class="btn btn-default pull-right margin taskKeywordUpdateCancel">Cancel</button>
				{if $disableEdit}
					<p class="pull-right margin"><strong>{$smarty.const.TASK_KEYWORD_UPDATE_DISABLE_MSG}</strong></p>
				{else}
					<button type="button" class="btn btn-info pull-right margin taskKeywordSave">Done</button>
				{/if}
         </div>
      </div>
		</div>
      </div>
	  <input type="hidden" name="taskKeywordId" id="taskKeywordId" class="taskKeywordId" value="{$taskKeywordId}">
	  

{/strip}

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
	 
	 $('#task_keyword_marsha_code').chosen({ width:"100%"});
	 
	 {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
	 
		$('#task_keyword_user_id').chosen({ width:"100%"});
	
	{else}
		
		{if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID }
		
			$(".task_keyword_service_type_id option[value=62]").remove();
		
		{/if}
		
	 {/if}
	 
	 {if $taskKeywordData.task_is_sub_task==1}
	 
		 {if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID }
	 
			$(".task_keyword_service_type_id option[value=62]").remove();
		
		 {/if}
		
	 {/if}
	 
	 {if $taskKeywordData.task_keyword_service_type_id !=$smarty.const.SERVICE_TYPE_KEYWORD_SETUP_ID}
	 
		$('#task_keyword_service_type_id').chosen({ width:"100%"});
		
	 {/if}
  });
</script>
	  