<script>
	
	var d;
	
$(document).ready(function(){
	d = new Date();
	$('.completeDateDiv').hide();
});

  $(function () {
	  
	 {if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID }
	
			$(".task_content_service_type_id option[value=6]").remove();
   
    {/if}
   
   
   $('.task_content_added_box_date').datepicker({
	format: "mm/dd/yyyy"
	}).on('changeDate',function(e){
	 d = new Date(e.date);
	 
	 configDate= {$smarty.const.TACTIC_DUE_BUSINESS_DAY_FOR_OTHERS};
	 
	 /*tacticDateVal = (startDate.getMonth() + 1) + '/' + (startDate.getDate() + configDate) + '/' +  startDate.getFullYear();*/
	 tacticDateVal = addBusinessDays(d, configDate);
	 $('.task_content_due_date').val(tacticDateVal);
	});
   
  });
</script>

{strip}
		<div class="row " >
		   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
               <div class="form-group col-sm-3">
                  <label >{$codeLabelData}</label>
				   <select class="form-control task_content_marsha_code" id="task_content_marsha_code">
					<option value="">--- Enter {$codeLabelData} ---</option>
					 {if $marshaCodesArray}
						{foreach $marshaCodesArray as $key=> $value}
							 <option value="{$value.client_entity_id}" {if $taskContentData.task_content_marsha_code==$value.client_entity_id }selected{/if}>{$value.client_entity_marsha_code}</option>
						{/foreach}
					{/if}
                  </select>
               </div>
               <div class="form-group col-sm-3">
                  <label >Division</label>
                  <input readonly class="form-control task_content_division" id="task_content_division" value="{$taskContentData.division_code}">
               </div>
               <div class="form-group col-sm-3">
                  <label >Service Type</label>
                  <select class="form-control task_content_service_type_id" id="task_content_service_type_id">
                     <option value="">--- Select Service Type ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}" {if $taskContentData.task_content_service_type_id==$value.serv_type_id }selected{/if}>{$value.serv_type_name}</option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
               <div class="form-group col-sm-3">
                  <label >Tier</label>
                  <input type="text" class="form-control task_content_tire" id="task_content_tire" value="{$taskContentData.task_content_tire}">
               </div>
            </div>
            <div class="row">
			<div class="form-group col-sm-3">
                  <label ># Pages</label>
                  <input type="text" class="form-control task_content_no_of_units" id="task_content_no_of_units" value="{$taskContentData.task_content_no_of_units}">
               </div>
              
               <div class="form-group col-sm-3">
                  <label >Start Date</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_added_box_date datepicker" id="task_content_added_box_date" value="{$taskContentData.task_content_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
                  </div>
               </div>
			   
			     <div class="form-group col-sm-3">
                  <label >Source Link</label>
                  <input type="text" class="form-control task_content_link_to_file" id="task_content_link_to_file" value="{$taskContentData.task_content_link_to_file}">
               </div>
			   
			     <div class="form-group col-sm-3" >
                  <label >Priority</label>
                  <br/>
                  <input type="checkbox" class="task_content_priority" id="task_content_priority" {if $taskContentData.task_content_priority==1}checked{/if}  >
               </div>
			   
              
			  
              
            </div>
            <div class="row">
			
				 <div class="form-group col-sm-3">
                  <label >Tactic Due</label>
                  <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_due_date datepicker" id="task_content_due_date" value="{$taskContentData.task_content_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
                  </div>
               </div>
			  <div class="form-group col-sm-3">
                  <label >Complete</label>
                  <br/>
                  <input type="checkbox" class="task_content_is_complete" id="task_content_is_complete"  {if $taskContentData.task_content_is_complete==1}checked{/if}  >
               </div>
			     <div class="form-group col-sm-3 completeDateDiv">
               <label >Complete Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_content_proj_com_date datepicker" id="task_content_proj_com_date" value="{$taskKeywordData.task_content_proj_com_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
				</div>
			   
			    <div class="form-group col-sm-3">
                  <label >Upload Link</label>
                  <input type="text" class="form-control task_content_upload_link" id="task_content_upload_link" placeholder="">
               </div>
              
            </div>
            <div class="row">
			 <div class="form-group col-sm-3">
                  <label >Date Revision Requested</label>
				   <div class="input-group date">
                     <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                     </div>
                     <input readonly class="form-control pull-right task_content_rev_req datepicker" id="task_content_rev_req" value="{$taskContentData.task_content_rev_req|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
                  </div>
               </div>
			 <div class="form-group col-sm-3">
                  <label >1st Revision Complete</label>
				   <br/>
				  <input type="checkbox" class="task_content_rev_com" id="task_content_rev_com" {if $taskContentData.task_content_rev_com==1}checked{/if}>
               </div>
               <div class="form-group col-sm-3">
                  <label >Consultant</label>
				    {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
						{*<p class="existWriterSkillUser">{$taskContentData.user_fname} {$taskContentData.user_lname}</p>*}
						<input type="hidden" name="task_content_user_id" id="task_content_user_id_hidden" class="task_content_user_id" value="{$taskContentData.task_content_user_id}" >
						<div class="writerSkill"></div>
						
						<div class="writerSkillDefault">
							  <select class="form-control task_content_user_id task_content_user_id_chosen" id="task_content_user_id">
								  <option value="">--- Select Consultant ---</option>
								  {if $userArray}
								  {foreach $userArray as $key=> $value}
								  <option value="{$value.user_id}"  {if $taskContentData.task_content_user_id==$value.user_id }selected{/if}>{$value.user_fname} {$value.user_lname}</option>
								  {/foreach}
								  {/if}
								</select>
						</div>
						
					{else}
						<p>{$smarty.session.userName}</p>
						<input type="hidden" name="task_content_user_id" id="task_content_user_id" class="task_content_user_id" value="{$smarty.session.userId}">
					{/if}
               </div>
			  <div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_content_notes" id="task_content_notes">{$taskContentData.task_content_notes}</textarea>
               </div>
            </div>
          
            <button type="button" class="btn btn-default pull-right margin taskContentUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin taskContentSave">Done</button>
         </div>
      </div>
   </div>
      </div>
	  <input type="hidden" name="taskContentId" id="taskContentId" class="taskContentId" value="{$taskContentId}">
	  <input type="hidden" name="task_content_user_id_val" id="task_content_user_id_val" class="task_content_user_id_val" value="{$taskContentData.task_content_user_id}">

{/strip}

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
   $('#task_content_marsha_code').chosen({ width:"100%"});
   $('#task_content_service_type_id').chosen({ width:"100%"});
   $('.task_content_user_id_chosen').chosen({ width:"100%"});
   
   {if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID }
   
		$(".task_content_service_type_id option[value=6]").remove();
   
   {/if}
  
  });
</script>
	  