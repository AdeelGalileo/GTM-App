{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Consultant Rates </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="ratePageListing" id="ratePageListing" class="form-control P5 pull-left" style="width:60px !important;">
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
		<tr class="bg-blueL" id="overAllRate">
			<th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th>
			<th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th>
			<th id="serv_type_names"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th>
			<th id="cons_rate_per_units"><a class="" href="javascript:void(0)" id="cons_rate_per_unit">Bill Rate</a></th>
			<th id="cons_rate_created_ons"><a class="" href="javascript:void(0)" id="cons_rate_created_on">Created On</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $consultantRateList}
				{foreach $consultantRateList as $key=> $value}
					<tr class="">
						<td>{$value.user_fname}</td>
						<td>{$value.user_lname}</td>
						<td>{$value.serv_type_name}</td>
						<td>$ {$value.cons_rate_per_unit|number_format:'2'}
						</td>
						
						<td>{$value.cons_rate_created_on|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>
							<a href="javascript:void(0)" class="rateUpdateAction m-l-10" id="rateId_{$value.cons_rate_id}" title="Update"><i class="fa fa-pencil"></i></a>
							<a href="javascript:void(0)" class="rateDeleteAction m-l-10" id="rateId_{$value.cons_rate_id}" title="Delete"><i class="fa fa-trash"></i></a>
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
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Consultant Rates </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="ratePageListingNew" id="ratePageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
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
