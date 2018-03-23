{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Class Reference</span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="clientPageListing" id="clientPageListing" class="form-control P5 pull-left" style="width:60px !important;">
        
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
		<tr class="bg-blueL" id="overAllClient">
			<th id="qb_cls_ref_class_ids"><a class="" href="javascript:void(0)" id="qb_cls_ref_class_id">QB Class Id</a></th>
			<th id="qb_cls_ref_class_names"><a class="" href="javascript:void(0)" id="qb_cls_ref_class_name">QB Class Name</a></th>
			<th id="qb_cls_ref_created_ons"><a class="" href="javascript:void(0)" id="qb_cls_ref_created_on">Created On</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $qbClassRefList}
				{foreach $qbClassRefList as $key=> $value}
					<tr class="">
						<td>{$value.qb_cls_ref_class_id}</td>
						<td>{$value.qb_cls_ref_class_name}</td>
						<td>{$value.qb_cls_ref_created_on|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>
							<a href="javascript:void(0)" class="clientUpdateAction m-l-10" id="clientId_{$value.qb_cls_ref_id}" title="Update"><i class="fa fa-pencil"></i></a>
							<a href="javascript:void(0)" class="clientDeleteAction m-l-10" id="clientId_{$value.qb_cls_ref_id}" title="Delete"><i class="fa fa-trash"></i></a>
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
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Class Reference</span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="clientPageListingNew" id="clientPageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
        
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
