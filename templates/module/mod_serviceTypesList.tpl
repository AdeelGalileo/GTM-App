{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Service Types </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="serviceTypePageListing" id="serviceTypePageListing" class="form-control P5 pull-left" style="width:60px !important;">
        
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
		<tr class="bg-blueL" id="overAllServiceType">
			<th id="serv_type_names"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th>
			<th style="color:#337ab7;">Task Type</th>
			<th id="serv_type_gal_rates"><a class="" href="javascript:void(0)" id="serv_type_gal_rate">Invoice Rate</a></th>
			<th id="serv_type_freel_rates"><a class="" href="javascript:void(0)" id="serv_type_freel_rate">Bill Rate</a></th>
			<th id="serv_type_created_ons"><a class="" href="javascript:void(0)" id="serv_type_created_on">Created</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $serviceTypesList}
				{foreach $serviceTypesList as $key=> $value}
					<tr class="">
						<td>{$value.serv_type_name}</td>
						<td>{if $value.serv_type_task_type == 1}
							Task Keyword
							{elseif $value.serv_type_task_type == 2}
							Task Content
							{/if}
						</td>
						<td>${$value.serv_type_gal_rate|number_format:'2'}</td>
						<td>${$value.serv_type_freel_rate|number_format:'2'}</td>
						<td>{$value.serv_type_created_on|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>
							<a href="javascript:void(0)" class="serviceTypeUpdateAction" id="serviceTypeId_{$value.serv_type_id}" title="Update"><i class="fa fa-pencil"></i></a>
							<a href="javascript:void(0)" class="serviceTypeDeleteAction m-l-10" id="serviceTypeId_{$value.serv_type_id}" title="Delete"><i class="fa fa-trash"></i></a>
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
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Service Types </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="serviceTypePageListingNew" id="serviceTypePageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
        
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
