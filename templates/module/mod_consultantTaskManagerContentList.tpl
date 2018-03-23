{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Task Manager Content </span>
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
			<th id="client_entity_marsha_codes"><a class="" href="javascript:void(0)" id="client_entity_marsha_code">MARSHA code</a></th>
			<th id="client_names"><a class="" href="javascript:void(0)" id="client_name">Client Name</a></th>
			<th id="task_content_due_dates"><a class="" href="javascript:void(0)" id="task_content_due_date">Due Date</a></th>
			<th id="division_codes"><a class="" href="javascript:void(0)" id="division_code">Division</a></th>
			<th id="serv_type_names"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th>
			<th id="task_content_tires"><a class="" href="javascript:void(0)" id="task_content_tire">TIER</a></th>
			<th id="task_content_added_box_dates"><a class="" href="javascript:void(0)" id="task_content_added_box_date">Date added to box</a></th>
			<th id="task_content_prioritys"><a class="" href="javascript:void(0)" id="task_content_priority">Is Priority</a></th>
			<th id="user_fname"><a class="" href="javascript:void(0)" id="user_fname">Consultant</a></th>
			<th id="task_content_is_completes"><a class="" href="javascript:void(0)" id="task_content_is_complete">Is Complete</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $taskManagerContentList}
				{foreach $taskManagerContentList as $key=> $value}
					<tr class="">
						<td>{$value.client_entity_marsha_code}</td>
						<td>{$value.client_name}</td>
						<td>{$value.task_content_due_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>{$value.division_code}</td>
						<td>{$value.serv_type_name}</td>
						<td>{$value.task_content_tire}</td>
						<td>{$value.task_content_added_box_date|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>{if $value.task_content_priority==1}Yes{else}No{/if}</td>
						<td>{$value.user_fname}</td>
						<td>{if $value.task_content_is_complete==1}Yes{else}No{/if}</td>
						<td>
							
							
							<a href="javascript:void(0)" class="taskContentUpdateAction m-l-10" id="taskContentId_{$value.task_content_id}" title="Update"><i class="fa fa-pencil"></i></a>
							<a href="javascript:void(0)" class="taskContentDeleteAction m-l-10" id="taskContentId_{$value.task_content_id}" title="Delete"><i class="fa fa-trash"></i></a>
						</td>
					</tr>
				{/foreach}
			 {else}
				<tr class="">
					<td colspan ="11" class="noRecords">{$smarty.const.LBL_NO_RECORDS}</td>
				</tr>
			{/if}
		</tbody>
</table>	


{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Task Manager Content </span>
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
