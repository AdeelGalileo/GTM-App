{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Tasks </span>
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
	{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN) && ($currentTabActive == 'tabId_1')) }
		<button type="button" class="btn btn-primary pull-right margin moveToQb"><i class="fa fa-share"></i> Move to QB</button>
		<div class="moveMultipleQb pull-right margin" {if (($params.taskKeyFilterBy == 3) && ($params.writerId > 1))} style="display:block;" {else} style="display:none;"  {/if} > <input type="checkbox" id="ckbCheckAll" class="ckbCheckAll"/>&nbsp;Select All</div>
	{/if}
	 {/if} 
	</div>
  <div class="clear P10"></div>
</div>
{if $totalRecords > 0}
<div class="clear">&nbsp;</div>
{/if}

<table class="table table-bordered table-striped">
		<thead>
		<tr class="bg-blueL" id="overAllTask">
			<th id="marshaCodes"><a class="" href="javascript:void(0)" id="marshaCode">{$codeLabelData}</a></th>
			<th id="divisionCodes"><a class="" href="javascript:void(0)" id="divisionCode">Division</a></th>
			<th id="servTypeNames"><a class="" href="javascript:void(0)" id="servTypeName">Service Type</a></th>
			<th id="TaskTypeVals"><a class="" href="javascript:void(0)" id="TaskTypeVal">Task Type</a></th>
			<th id="tires"><a class="" href="javascript:void(0)" id="tire">Tier</a></th>
			<th style="color:#337ab7;">Link to File</a></th>
			<th id="dateAddedToBoxs"><a class="" href="javascript:void(0)" id="dateAddedToBox">Date added to box</a></th>
			<th id="contentDues"><a class="" href="javascript:void(0)" id="contentDue">Task Due Date</a></th>
			<th id="prioritys"><a class="" href="javascript:void(0)" id="priority">Priority</a></th>
			<th id="userNames"><a class="" href="javascript:void(0)" id="userName">First Name</a></th>
			<th id="userLNames"><a class="" href="javascript:void(0)" id="userLName">Last Name</a></th>
			{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
				<th id="isCompleteds"><a class="" href="javascript:void(0)" id="isCompleted">Completed</a></th>
			{else}
				<th id="isCompleteds"><a class="" href="javascript:void(0)" id="isCompleted">Completed</a></th>
			{/if}
			{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
				<th style="color:#337ab7;" >Admin Notes</th>
			{/if}
			{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN) && ($currentTabActive == 'tabId_1')) }
				<th style="color:#337ab7;" class="adminReviewCls">Admin Review</th>
				<th style="color:#337ab7;" class="moveToCls">Move to Qb</th>
			{/if}
			
			{*<th style="color:#337ab7;">Action</th>*}
		</tr>
		</thead>
		 <tbody>
			{if $taskList}
				{foreach $taskList as $key=> $value}
					<tr class="">
						<td>{$value.marshaCode}</td>
						<td>{$value.divisionCode}</td>
						<td>{$value.servTypeName}</td>
						<td>{$value.TaskTypeVal}</td>
						<td>{$value.tire}</td>
						<td>
						{if $value.linkToFile}
							<a href="{$value.linkToFile}" title="{$value.linkToFile}" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a>
						{/if}
						</td>
						<td>{$value.dateAddedToBox|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>{$value.contentDue|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
							<td><input type="checkbox" {if $value.priority == 1}checked{/if} taskType="{$value.TaskType}" id="changePriority_{$value.TaskType}_{$value.taskId}" name="changePriority" class="changePriority"/></td>
						{else}
							<td>{if $value.priority==1}Yes{else}No{/if}</td>	
						{/if}
						
						<td>{$value.userName}</td>
						<td>{$value.userLName}</td>
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
							<td><input type="checkbox" {if $value.isCompleted == 1}checked{/if} taskType="{$value.TaskType}" id="completeTask_{$value.TaskType}_{$value.taskId}" name="completeTask" class="taskCompleteAction"/></td>
						{else}
							<td>{if $value.isCompleted==1}Yes{else}No{/if}</td>	
						{/if}
						
						{if $smarty.session.userRole == $smarty.const.USER_ROLE_CONSULTANT}
							<td>{$value.adminNotes} </td>
						{/if}
						{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN) && ($currentTabActive == 'tabId_1')) }
							<td style="width:200px !important" class="adminSelectTaskCls">
							{if $value.isQbProcess == 0}
							<select class="form-control taskCompleteAdminAction" taskType="{$value.TaskType}" id="completeAdminTask_{$value.TaskType}_{$value.taskId}" name="taskCompleteAdminAction">
								  <option value="">--- Select Review ---</option>
								  <option value="1" {if $value.adminComplete==1 }selected{/if}>Complete</option>
								  <option value="2" {if $value.adminComplete==2 }selected{/if}>Re-Assign</option>
							 </select>
							 {else}
								Submitted
							 {/if}
							</td>
							{if $value.adminComplete==1 && $value.isQbProcess == 0}
								<td><input type="checkbox" consultantId="{$value.user_id}"  taskType="{$value.TaskType}" id="qbTransfer_{$value.TaskType}_{$value.taskId}_{$value.unitNo}" name="qbTransfer" class="chkqbTransfer qbTransfer"/></td>
							{else if $value.adminComplete==1 && $value.isQbProcess == 1}
								<td>Moved</td>
							{else}
								<td></td>
							{/if}
						{/if}
						{*<td>
						
							<a href="javascript:void(0)"><i class="fa fa-pencil"></i></a>
							<a href="javascript:void(0)" class="taskUpdateAction m-l-10" id="taskId_{$value.task_content_id}" title="Update"><i class="fa fa-pencil"></i></a>
								<a href="javascript:void(0)" class="taskDeleteAction m-l-10" id="taskId_{$value.task_content_id}" title="Delete"><i class="fa fa-trash"></i></a>
						</td>*}
					</tr>
				{/foreach}
			 {else}
				<tr class="">
					<td colspan ="12" class="noRecords">{$smarty.const.LBL_NO_RECORDS}</td>
				</tr>
			{/if}
		</tbody>
</table>	


{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Tasks </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="taskPageListingNew" id="taskPageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
        
                    {$recCountOptions}
                
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew">{include file="paginationNew.tpl"}</span> </div>
    </div>
	{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN) && ($currentTabActive == 'tabId_1')) }
		<button type="button" class="btn btn-primary pull-right margin moveToQb"><i class="fa fa-share"></i> Move to QB</button>
	{/if}

  </div>
  <div class="clear"></div>

</div>
{/if}
<input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" />
<div class="clear"></div>
{/strip}
