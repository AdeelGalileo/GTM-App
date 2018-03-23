{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Task Manager Keyword{/block}
{block name=header}

{/block}
{block name=content}
	
				<div class="row " >
		   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
               <div class="form-group col-sm-3">
                  <label >{$codeLabelData}</label>
					 <p>{if $marshaCodesArray}
						{foreach $marshaCodesArray as $key=> $value}
							 {if $taskContentData.task_content_marsha_code==$value.client_entity_id }{$value.client_entity_marsha_code}{/if}
						{/foreach}
					{/if}</p>
               </div>
               <div class="form-group col-sm-3">
                  <label >Division</label>
				  <p>{$taskContentData.division_code}</p>
               </div>
               <div class="form-group col-sm-3">
                  <label >Service Type</label>
					  <p>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
						{if $taskContentData.task_content_service_type_id==$value.serv_type_id }{$value.serv_type_name}{/if}
                     {/foreach}
                     {/if}
					</p>
               </div>
               <div class="form-group col-sm-3">
                  <label >Tier</label>
				  <p>{$taskContentData.task_content_tire}</p>
               </div>
			   
            </div>
            <div class="row">
			  <div class="form-group col-sm-3">
                  <label ># Pages</label>
				  <p>{$taskContentData.task_content_no_of_units}</p>
               </div>
			    <div class="form-group col-sm-3">
                  <label >Start Date</label>
				  <P>{$taskContentData.task_content_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
               </div>
			    <div class="form-group col-sm-3">
                  <label >Source Link</label>
						<p>{if $taskContentData.task_content_link_to_file}
							<a href="{$taskContentData.task_content_link_to_file}" title="{$taskContentData.task_content_link_to_file}" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a>
						{/if}</p>
				 
               </div>
               <div class="form-group col-sm-3" >
                  <label >Priority</label>
				   <P>{if $taskContentData.task_content_priority==1}Yes{else}No{/if}</P>
               </div>
              
            
              
            </div>
            <div class="row">
				   <div class="form-group col-sm-3">
                  <label >Tactic Due</label>
				  <P>{$taskContentData.task_content_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
               </div>
			    <div class="form-group col-sm-3">
                  <label >Complete</label>
				  <P>{if $taskContentData.task_content_is_complete==1}Yes{else}No{/if}</P>
               </div>
			    <div class="form-group col-sm-3">
                  <label >Completed Date</label>
				  <P>{$taskContentData.task_content_proj_com_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
               </div>
			      <div class="form-group col-sm-3">
                  <label >Upload Link</label>
				  <p>{if $taskContentData.task_content_upload_link}
							<a href="{$taskContentData.task_content_upload_link}" title="{$taskContentData.task_content_upload_link}" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a>
						{/if}</p>
               </div>
              
             
            </div>
            <div class="row">
				 <div class="form-group col-sm-3">
                  <label >Date Revision Requested</label>
				  <P>{$taskContentData.task_content_rev_req|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
               </div>
             
				  <div class="form-group col-sm-3">
                  <label >1st Revision Complete</label>
				  <P>{$taskContentData.task_content_rev_com|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
               </div>
               <div class="form-group col-sm-3">
                  <label >Consultant</label>
				    {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
						<p class="">{$taskContentData.user_fname} {$taskContentData.user_lname}</p>
					{else}
						<p>{$smarty.session.userName}</p>
					{/if}
               </div>
			  <div class="form-group col-sm-3">
                  <label >Notes</label>
				  <p>{$taskContentData.task_content_notes}</p>
               </div>
            </div>
            
         </div>
      </div>
   </div>
      </div>
{/block}