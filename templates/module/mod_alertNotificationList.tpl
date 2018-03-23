{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Notifications </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="alertPageListing" id="alertPageListing" class="form-control P5 pull-left" style="width:60px !important;">
        
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
		<tr class="bg-blueL" id="overAllAlert">
			<th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th>
			<th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th>
			<th id="modules_names"><a class="" href="javascript:void(0)" id="modules_name">Module</a></th>
			<th id="alert_notification_messages"><a class="" href="javascript:void(0)" id="alert_notification_message">Message</a></th>
			<th id="alert_notification_created_ons"><a class="" href="javascript:void(0)" id="alert_notification_created_on">Created</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $alertNotificationList}
				{foreach $alertNotificationList as $key=> $value}
					<tr class="">
						<td>{$value.user_fname}</td>
						<td>{$value.user_lname}</td>
						<td>{$value.modules_name}</td>
						<td>{$value.alert_notification_message}</td>
						<td>{$value.alert_notification_created_on|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>
							{if $value.modules_id==$smarty.const.NOTIFICATION_MODULE_INVOICE_ID}
								{assign var="redirectUrl" value= "{$smarty.const.ROOT_HTTP_PATH}/viewInvoice.php?taskId={$value.alert_notification_invoice_id}&alertNotificationId={$value.alert_notification_id}"}
							{elseif $value.modules_id==$smarty.const.NOTIFICATION_MODULE_TASK_KEYWORD_ID}
								{assign var="redirectUrl" value= "{$smarty.const.ROOT_HTTP_PATH}/viewTaskKeyword.php?taskId={$value.alert_notification_task_id}&alertNotificationId={$value.alert_notification_id}"}
							{elseif $value.modules_id==$smarty.const.NOTIFICATION_MODULE_TASK_CONTENT_ID}
								{assign var="redirectUrl" value= "{$smarty.const.ROOT_HTTP_PATH}/viewTaskContent.php?taskId={$value.alert_notification_task_id}&alertNotificationId={$value.alert_notification_id}"}
							{/if}
							<a href="{$redirectUrl}" target="_blank" class="alertViewAction" id="notificationId_{$value.alert_notification_id}" title="View"><i class="fa fa-eye"></i></a>
						</td>
					</tr>
				{/foreach}
				{else}
				<tr class="">
					<td colspan ="6" class="noRecords">{$smarty.const.LBL_NO_RECORDS}</td>
				</tr>
			{/if}
		</tbody>
</table>	


{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Notifications </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="alertPageListingNew" id="alertPageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
        
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
