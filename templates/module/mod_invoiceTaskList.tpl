{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalInvoiceTask">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Invoices </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="invoicePageListing" id="invoicePageListing" class="form-control P5 pull-left" style="width:60px !important;">
              	{$recCountOptions}
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationInvoiceAuto">{include file="paginationNew.tpl"}</span> 
	  </div>
    </div>
	{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }
		<button type="button" class="btn btn-primary pull-right margin exportSubmittedData"><i class="fa fa-download"></i> Export</button>
	{/if}
	
    {/if} </div>
  <div class="clear P10"></div>
</div>
{if $totalRecords > 0}
<div class="clear">&nbsp;</div>
{/if}

<table class="table table-bordered table-striped">
		<thead>
		<tr class="bg-blueL" id="overAllInvoice">
			<th id="invoice_reference_user_fnames"><a class="" href="javascript:void(0)" id="invoice_reference_user_fname">First Name</a></th>
			<th id="invoice_reference_user_lnames"><a class="" href="javascript:void(0)" id="invoice_reference_user_lname">Last Name</a></th>
			<th id="invoice_reference_marsha_codes"><a class="" href="javascript:void(0)" id="invoice_reference_marsha_code">{$codeLabelData}</a></th>
			<th id="invoice_reference_division_codes"><a class="" href="javascript:void(0)" id="invoice_reference_division_code">Division</a></th>
			<th id="invoice_reference_service_type_names"><a class="" href="javascript:void(0)" id="invoice_reference_service_type_name">Service Type</a></th>
			<th id="invoice_reference_rate_per_units"><a class="" href="javascript:void(0)" id="invoice_reference_rate_per_unit">Rate Per Unit</a></th>
			<th id="invoice_reference_no_of_unitss"><a class="" href="javascript:void(0)" id="invoice_reference_no_of_units">No of Units</a></th>
			<th style="color:#337ab7;">Total</th>
			<th id="invoice_reference_tires"><a class="" href="javascript:void(0)" id="invoice_reference_tire">Box Folder</a></th>
			<th id="invoice_reference_created_ons"><a class="" href="javascript:void(0)" id="invoice_reference_created_on">Invoice Date</a></th>
			<th id="invoice_reference_doc_numbers"><a class="" href="javascript:void(0)" id="invoice_reference_doc_number">QB Id</a></th>
		</tr>
		</thead>
		 <tbody>
			{if $invoiceTaskList}
				{assign var=totalVal value=0}
				{assign var=grandTotal value=0}
				{foreach $invoiceTaskList as $key=> $value}
					<tr class="">
						<td>{$value.invoice_reference_user_fname} </td>
						<td>{$value.invoice_reference_user_lname}</td>
						<td>{$value.invoice_reference_marsha_code}</td>
						<td>{$value.invoice_reference_division_code}</td>
						<td>{$value.invoice_reference_service_type_name}</td>
						<td align="right">${$value.invoice_reference_rate_per_unit|number_format:'2'}</td>
						{$totalVal = $value.invoice_reference_no_of_units * $value.invoice_reference_rate_per_unit }
						{$grandTotal = $grandTotal+ $totalVal}
						<td align="right">{$value.invoice_reference_no_of_units}</td>
						<td align="right">${$totalVal|number_format:'2'}</td>
						<td>{$value.invoice_reference_tire}</td>
						<td>{$value.invoice_reference_created_on|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>{$value.invoice_reference_doc_number}</td>
					</tr>
				{/foreach}
					 <tr class="">
						
						<td colspan="6"></td>
						<td align="right"><strong>Grand Total</strong></td>
						<td align="right">${$grandTotal|number_format:'2'}</td>
						<td></td>
						<td></td>
						<td></td>
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
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalInvoiceTaskNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Invoices </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="invoicePageListingNew" id="invoicePageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
                    {$recCountOptions}
      </select>
    </div>
    <div class="pull-left m-r-10">
      <div class="pull-left p-r-10 p-t-10">On Page</div>
      <div class="grayBg box-rounded inBlock"> <span id="paginationInvoiceAutoNew">{include file="paginationNew.tpl"}</span> </div>
    </div>
	{if (($smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN)) }
		<button type="button" class="btn btn-primary pull-right margin exportSubmittedData"><i class="fa fa-download"></i> Export</button>
	{/if}
  </div>
  <div class="clear"></div>
</div>
{/if}
<input type="hidden" id="currPageAutoInvoiceID" value="" name="currPageAutoInvoiceID" />
<div class="clear"></div>
{/strip}
