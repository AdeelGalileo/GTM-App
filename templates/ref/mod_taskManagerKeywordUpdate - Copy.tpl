{strip}
		<div class="row " >
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
               <label >Sig + (# of Pages TBD)</label>
               <input type="text" class="form-control task_keyword_no_of_pages" id="task_keyword_no_of_pages" value="{$taskKeywordData.task_keyword_no_of_pages}">
            </div>
			<div class="form-group col-sm-3">
               <label >Foundations Program </label>
               <input type="text" class="form-control task_keyword_foun_prog" id="task_keyword_foun_prog" placeholder="" value="{$taskKeywordData.task_keyword_foun_prog}">
            </div>
			 </div>
			 <div class="row">
			<div class="form-group col-sm-3">
               <label >Expanded Seo</label>
               <input type="text" class="form-control task_keyword_expanded_seo" id="task_keyword_expanded_seo" placeholder="" value="{$taskKeywordData.task_keyword_expanded_seo}">
            </div>
			<div class="form-group col-sm-3">
               <label >Outlet Marketing Bundle </label>
               <input type="text" class="form-control task_keyword_outlet_mark" id="task_keyword_outlet_mark" placeholder="" value="{$taskKeywordData.task_keyword_outlet_mark}">
            </div>
			 <div class="form-group col-sm-3">
                  <label >Notes</label>
                  <textarea class="form-control pull-right task_keyword_notes" id="task_keyword_notes">{$taskKeywordData.task_keyword_notes}</textarea>
            </div>
			<div class="form-group col-sm-3">
               <label >BOX Location</label>
               <input type="text" class="form-control task_keyword_box_location" id="task_keyword_box_location" placeholder="" value="{$taskKeywordData.task_keyword_box_location}">
            </div>
           
			 </div>
			 <div class="row">
				 <div class="form-group col-sm-3">
               <label >Date Added to BOX</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_added_box_date datepicker" id="task_keyword_added_box_date" value="{$taskKeywordData.task_keyword_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
            </div>
			  
            <div class="form-group col-sm-3">
               <label >Kw set up due date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
				  <input readonly class="form-control pull-right task_keyword_setup_due_date datepicker" id="task_keyword_setup_due_date" value="{$taskKeywordData.task_keyword_setup_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
            </div>
			<div class="form-group col-sm-3">
               <label >Keyword Set Up and Uploaded to Box </label>
			   <input type="text" class="form-control task_keyword_setup_file" id="task_keyword_setup_file" value="{$taskKeywordData.task_keyword_setup_file}">
            </div>
			 <div class="form-group col-sm-3">
               <label >Keyword Completed  Due Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
				  <input readonly class="form-control pull-right task_keyword_com_due_date datepicker" id="task_keyword_com_due_date" value="{$taskKeywordData.task_keyword_com_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
				  
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
				  <input readonly class="form-control pull-right task_keyword_com_date datepicker" id="task_keyword_com_date" value="{$taskKeywordData.task_keyword_com_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
            </div>
			  <div class="form-group col-sm-3">
               <label >Personnel</label>
               <select class="form-control task_keyword_user_id" id="task_keyword_user_id">
					<option value="">--- Select Personnel ---</option>
					 {if $userArray}
						{foreach $userArray as $key=> $value}
							 <option value="{$value.user_id}" {if $taskKeywordData.task_keyword_user_id==$value.user_id }selected{/if} >{$value.user_fname} {$value.user_lname}</option>
						{/foreach}
					{/if}
                  </select>
            </div>
			  <div class="form-group col-sm-3">
               <label >Link to db file</label>
                <input type="text" class="form-control task_keyword_link_db_file" id="task_keyword_link_db_file" value="{$taskKeywordData.task_keyword_link_db_file}">
            </div>
			
			<div class="form-group col-sm-3">
               <label >Kw Task Date</label>
               <div class="input-group date">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div>
                  <input readonly class="form-control pull-right task_keyword_date datepicker" id="task_keyword_date" value="{$taskKeywordData.task_keyword_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}">
               </div>
            </div>

			</div>
				
				<button type="button" class="btn btn-default pull-right margin taskKeywordUpdateCancel">Cancel</button>
				<button type="button" class="btn btn-info pull-right margin taskKeywordSave">Done</button>
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
  
  });
</script>
	  