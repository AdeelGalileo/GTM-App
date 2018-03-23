{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Task Manager Keywords </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="taskPageListing" id="taskPageListing" class="form-control P5 pull-left" style="width:60px !important;">
        
              	{$recCountOptions}
              
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationAuto">{include file="paginationNew.tpl"}</span> 
	  </div>
    </div>
    {/if} </div>
  <div class="clear P10"></div>
</div>
{if $totalRecords > 0}
<div class="clear">&nbsp;</div>
{/if}

<table class="table table-bordered table-striped">
		<thead>
		<tr class="bg-blueL" id="overAllTask">
			<th id="client_entity_marsha_codes" style="width:50px !important"><a class="" href="javascript:void(0)" id="client_entity_marsha_code">{$codeLabelData}</a></th>
			<th id="division_codes"><a class="" href="javascript:void(0)" id="division_code">Division</a></th>
			<th id="serv_type_names" style="width:50px !important"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th>
			<th id="task_keyword_tires" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_tire">Tier</a></th>
			<th id="task_keyword_no_of_pagess" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_no_of_pages"># Pages</a></th>
			<th id="task_keyword_added_box_dates"><a class="" href="javascript:void(0)" id="task_keyword_added_box_date">Start Date</a></th>
			<th id="task_keyword_link_db_files" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_link_db_file">Source Link</a></th>
			<th id="task_keyword_prioritys"><a class="" href="javascript:void(0)" id="task_keyword_priority">Priority</a></th>
			<th id="task_keyword_setup_due_dates" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_setup_due_date">Tactic Due</a></th>
			<th style="color:#337ab7;" style="width:50px !important">Complete</a></th>
			<th id="task_keyword_dates"><a class="" href="javascript:void(0)" id="task_keyword_date">Date Complete</a></th>
			<th style="color:#337ab7;" style="width:50px !important">Notes</a></th>
			{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
				<th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th>
				<th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th>
			{/if}
			{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
				<th style="color:#337ab7;">Admin Notes</th>
			{/if}
			{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
				<th style="color:#337ab7;">Admin Review</th>
			{/if}
			<th style="color:#337ab7;width:75px !important">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $taskManagerKeywordList}
				{foreach $taskManagerKeywordList as $key=> $value}
				
					<tr class="{if $value.task_keyword_admin_complete==2 } statusBgColor {else} {/if}">
					
						<td>{$value.client_entity_marsha_code}</td>
						<td>{$value.division_code}</td>
						<td>{$value.serv_type_name}</td>
						<td>{$value.task_keyword_tire}</td>
						<td style="width:50px !important">{$value.task_keyword_no_of_pages}</td>
						<td>{$value.task_keyword_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>
							{if $value.task_keyword_link_db_file}
								<a href="{$value.task_keyword_link_db_file}" title="{$value.task_keyword_link_db_file}" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a>
							{/if}
						</td>
						<td style="width:50px !important">{if $value.task_keyword_priority==1}Yes{else}No{/if}</td>
						<td>{$value.task_keyword_setup_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
						
							<td>
							{if $value.task_keyword_admin_complete !=1 }
							<input type="checkbox" attrIsSubTask="{$value.task_is_sub_task}" attrCode="{$value.client_entity_marsha_code}" attrDivCode="{$value.division_code}" attrUser="{$value.user_fname} {$value.user_lname}" attrServiceTypeName="{$value.serv_type_name}" {if $value.task_keyword_setup_complete == 1}checked{/if} id="completeTask_{$value.task_keyword_id}" name="completeTask" class="taskKeywordCompleteAction"/>
							{/if}
							</td>
						
						{else}
							<td style="width:50px !important">{if $value.task_keyword_setup_complete==1}Yes{else}No{/if}</td>	
						{/if}
						<td>{$value.task_keyword_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
	 				    <td>{$value.task_keyword_notes} </td>
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
							<td>{$value.user_fname} </td>
							<td>{$value.user_lname} </td>
						{/if}
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
							<td>{$value.task_keyword_admin_notes} </td>
						{/if}
						
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN && $value.task_keyword_qb_process == 0 && $value.task_keyword_qb_inv_process == 0}
							<td style="width:100px !important">
							<select style="width:100px !important" class="form-control taskKeywordCompleteAdminAction" currentUserId="{$value.task_keyword_user_id}" id="completeAdminTask_{$value.task_keyword_id}" name="taskKeywordCompleteAdminAction" style="width:100px !important;">
								  <option value="">--- Select Review ---</option>
								  <option value="1" {if $value.task_keyword_admin_complete==1 }selected{/if}>Complete</option>
								  <option value="2" {if $value.task_keyword_admin_complete==2 }selected{/if}>Re-Assign</option>
							 </select>
							 </td>
						{else if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
							<td></td>
						{/if}
						</td>
						<td>
							<a href="javascript:void(0)" class="taskKeywordUpdateAction p-r-10" id="taskKeywordId_{$value.task_keyword_id}" title="Update"><i class="fa fa-pencil"></i></a>
							
							{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN && $value.task_keyword_service_type_id == $smarty.const.SERVICE_TYPE_KEYWORD_SETUP_ID && $value.task_is_sub_task == 0}
								<a href="javascript:void(0)" class="taskKeywordClone" id="taskKeywordClone_{$value.task_keyword_id}" title="Task Clone"><i class="fa fa-clone"></i></a>
							{/if}
							{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
								<a href="javascript:void(0)" class="taskKeywordDeleteAction m-l-10" id="taskKeywordId_{$value.task_keyword_id}" title="Delete"><i class="fa fa-trash"></i></a>
							{/if}
						</td>
						
					</tr>
				{/foreach}
				{else}
				<tr class="">
					<td colspan ="20" class="noRecords">{$smarty.const.LBL_NO_RECORDS}</td>
				</tr>
			{/if}
		</tbody>
</table>	


{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Task Manager Keywords </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="taskPageListingNew" id="taskPageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
        
                    {$recCountOptions}
                
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew">{include file="paginationNew.tpl"}</span> </div>
    </div>
	
  </div>
  <div class="clear"></div>
</div>
{/if}
<input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" />
<div class="clear"></div>
{/strip}
