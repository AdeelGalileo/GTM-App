{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalOutInvoiceTask">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Outstanding Invoice</span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="outInvoicePageListing" id="outInvoicePageListing" class="form-control P5 pull-left" style="width:60px !important;">
              	{$recCountOptions}
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationOutInvoiceAuto">{include file="paginationNew.tpl"}</span> 
	  </div>
    </div>
   
	{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }
		<button type="button" class="btn btn-primary pull-right margin moveToQb"><i class="fa fa-share"></i> Move to QB</button>
		<div class="moveMultipleQb pull-right margin" {if (($params.taskKeyFilterBy == 4) && ($params.divisionId > 0))} style="display:block;" {else} style="display:none;"  {/if} > <input type="checkbox" id="ckbCheckAll" class="ckbCheckAll"/>&nbsp;Select All</div>
		<button type="button" class="btn btn-primary pull-right margin exportOutstandingData"><i class="fa fa-download"></i> Export</button>
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
		<tr class="bg-blueL" id="overAllOutInvoice">
			<th id="userNames"><a class="" href="javascript:void(0)" id="userName">First Name</a></th>
			<th id="userLNames"><a class="" href="javascript:void(0)" id="userLName">Last Name</a></th>
			<th id="marshaCodes"><a class="" href="javascript:void(0)" id="marshaCode">{$codeLabelData}</a></th>
			<th id="divisionCodes"><a class="" href="javascript:void(0)" id="divisionCode">Division</a></th>
			<th id="servTypeNames"><a class="" href="javascript:void(0)" id="servTypeName">Service Type</a></th>
			<th id="servTypeGalRates"><a class="" href="javascript:void(0)" id="servTypeGalRate">Rate Per Unit</a></th>
			<th id="unitNos"><a class="" href="javascript:void(0)" id="unitNo">No of Units</a></th>
			<th style="color:#337ab7;">Total</th>
			<th id="tires"><a class="" href="javascript:void(0)" id="tire">Box Folder</a></th>
			{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }
				<th style="color:#337ab7;" class="moveToCls">Move to Qb</th>
			{/if}
		</tr>
		</thead>
		 <tbody>
			{if $invoiceTaskList}
				{assign var=totalVal value=0}
				{assign var=clientRate value=0}
				{assign var=grandTotal value=0}
				{foreach $invoiceTaskList as $key=> $value}
					<tr class="">
						<td>{$value.userName} </td>
						<td>{$value.userLName} </td>
						<td>{$value.marshaCode}</td>
						<td>{$value.divisionCode}</td>
						<td>{$value.servTypeName}</td>
							 {$clientRate = $value.servTypeGalRate}
						<td align="right">${$clientRate|number_format:'2'}</td>
						{$totalVal = {$value.unitNo} * $clientRate }
						{$grandTotal = $grandTotal+ $totalVal}
						<td align="right">{$value.unitNo}</td>
						<td align="right">${$totalVal|number_format:'2'}</td>
						<td>{$value.tire}</td>
						{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }
							{if $value.adminComplete==1 && $value.isQbProcess == 0}
								<td><input type="checkbox" divisionType={$value.divisionCode}  taskType="{$value.TaskType}" id="qbTransfer_{$value.TaskType}_{$value.taskId}_{$value.unitNo}" name="qbTransfer" class="chkqbTransfer qbTransfer"/></td>
							{else}
								<td></td>
							{/if}
					    {/if}
					</tr>
				{/foreach}
					 <tr class="">
						
						<td colspan="6"></td>
						<td align="right"><strong>Grand Total</strong></td>
						<td align="right">${$grandTotal|number_format:'2'}</td>
						<td></td>
						{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }<td></td>  {/if}
					 </tr>
			 {else}
				<tr class="">
					<td colspan ="13" class="noRecords">{$smarty.const.LBL_NO_RECORDS}</td>
				</tr>
			{/if}
		</tbody>
</table>	

{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalOutInvoiceTaskNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Outstanding Invoice </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="outInvoicePageListingNew" id="outInvoicePageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
                    {$recCountOptions}
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationOutInvoiceAutoNew">{include file="paginationNew.tpl"}</span> </div>
    </div>
	{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }
		<button type="button" class="btn btn-primary pull-right margin moveToQb"><i class="fa fa-share"></i> Move to QB</button>
		<button type="button" class="btn btn-primary pull-right margin exportOutstandingData"><i class="fa fa-download"></i> Export</button>
	{/if}
		
  </div>
  <div class="clear"></div>
</div>
{/if}
<input type="hidden" id="currPageAutoOutInvoiceID" value="" name="currPageAutoOutInvoiceID" />
<div class="clear"></div>
{/strip}
