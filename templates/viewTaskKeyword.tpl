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
			    <P>
					 {if $marshaCodesArray}
						{foreach $marshaCodesArray as $key=> $value}
							{if $taskKeywordData.task_keyword_marsha_code==$value.client_entity_id }{$value.client_entity_marsha_code}{/if}
						{/foreach}
					{/if}
				</p>
            </div>
            <div class="form-group col-sm-3">
               <label >Division</label>
               <P>{$taskKeywordData.division_code}</P>
            </div>
			 <div class="form-group col-sm-3">
                  <label>Service Type</label>
                     <p>{if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
						{if $taskKeywordData.task_keyword_service_type_id==$value.serv_type_id }{$value.serv_type_name}{/if}
                     {/foreach}
                     {/if}</p>
               </div>
            <div class="form-group col-sm-3">
               <label >Number of Pages</label>
				<P>{$taskKeywordData.task_keyword_no_of_pages}</P>
            </div>
			
			 </div>
			 <div class="row">
				
				<div class="form-group col-sm-3">
					   <label >Start Date</label>
						<P>{$taskKeywordData.task_keyword_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
					   
				</div>
				 <div class="form-group col-sm-3">
               <label>Source Link</label>
				<P>
			  
			  {if $taskKeywordData.task_keyword_link_db_file}
								<a href="{$taskKeywordData.task_keyword_link_db_file}" title="{$taskKeywordData.task_keyword_link_db_file}" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a>
							{/if}</P>
			  
             </div>
			  <div class="form-group col-sm-3" >
                  <label >Priority</label>
                  <br/>
				  <P>{if $taskKeywordData.task_keyword_priority==1}Yes{else}No{/if}</P>
               </div>
				 <div class="form-group col-sm-3">
               <label >Tactic Due</label>
             
				<P>{$taskKeywordData.task_keyword_setup_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
				</div>
				
				
				 
			 </div>
			
			<div class="row">
			 <div class="form-group col-sm-3">
               <label >Completed</label>
				<P>{if $taskKeywordData.task_keyword_setup_complete==1}Yes{else}No{/if}</P>
				</div>
				<div class="form-group col-sm-3">
				   <label >Completed Date</label>
				   <P>{$taskKeywordData.task_keyword_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</P>
				</div>
				
				
			  <div class="form-group col-sm-3">
               <label >Consultant</label>
			   {if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN }
					 {if $userArray}
						{foreach $userArray as $key=> $value}
							{if $taskKeywordData.task_keyword_user_id==$value.user_id }{$value.user_fname} {$value.user_lname}{/if}
						{/foreach}
					{/if}
				{else}
					<p>{$smarty.session.userName}</p>
			    {/if}  
            </div>
			 <div class="form-group col-sm-3">
                  <label >Tier</label>
				  <P>{$taskKeywordData.task_keyword_tire}</P>
				</div>
			</div>
			
			<div class="row">
				
			   <div class="form-group col-sm-3">
                  <label >Notes</label>
				  <P>{$taskKeywordData.task_keyword_notes}</P>
				</div>
			</div>
				
         </div>
      </div>
		</div>
      </div>

{/block}