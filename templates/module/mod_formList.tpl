{strip}
<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Forms </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="formPageListing" id="formPageListing" class="form-control P5 pull-left" style="width:60px !important;">
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
		<tr class="bg-blueL" id="overAllForm">
			<th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th>
			<th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th>
			<th id="user_role_names"><a class="" href="javascript:void(0)" id="user_role_name">Role</a></th>
			<th style="color:#337ab7;">W9</a></th>
			<th style="color:#337ab7;">Resume</a></th>
			<th style="color:#337ab7;">ACH Form</a></th>
			<th style="color:#337ab7;">Consultant Agreement</a></th>
			<th id="form_created_ons"><a class="" href="javascript:void(0)" id="form_created_on">Created On</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $formList}
				{foreach $formList as $key=> $value}
					<tr class="">
						
						<td>{$value.user_fname}</td>
						<td>{$value.user_lname}</td>
						<td>{$value.user_role_name}</td>
						
						<td>
						{assign var="form1" value=$formFilePath|cat:'w9/'|cat:$value.form_w_nine}
						{if file_exists($form1) && !empty($value.form_w_nine)}  
							<a href="{$smarty.const.ROOT_HTTP_PATH}/forms.php?downloadForms={$value.form_w_nine}&formType=1" class="m-l-10" id="w9_{$value.form_id}" title="W9"><i class="fa fa-download"></i></a>
						{/if}
						</td>
						<td>
						{assign var="form2" value=$formFilePath|cat:'resume/'|cat:$value.form_resume}
						{if file_exists($form2) && !empty($value.form_resume)} 
							<a href="{$smarty.const.ROOT_HTTP_PATH}/forms.php?downloadForms={$value.form_resume}&formType=2" class="m-l-10" id="res_{$value.form_id}" title="Resume"><i class="fa fa-download"></i></a>
						{/if}
						</td>
						<td>
						{assign var="form3" value=$formFilePath|cat:'achForm/'|cat:$value.form_ach}
						{if file_exists($form3) && !empty($value.form_ach)} 
							<a href="{$smarty.const.ROOT_HTTP_PATH}/forms.php?downloadForms={$value.form_ach}&formType=3" class="m-l-10" id="ach_{$value.form_id}" title="ACH Form"><i class="fa fa-download"></i></a>
						{/if}
						</td>
						<td>
						{assign var="form4" value=$formFilePath|cat:'agreement/'|cat:$value.form_consultant_agree}
						{if file_exists($form4) && !empty($value.form_consultant_agree)} 
							<a href="{$smarty.const.ROOT_HTTP_PATH}/forms.php?downloadForms={$value.form_consultant_agree}&formType=4" class="m-l-10" id="agreement_{$value.form_id}" title="Consultant Agreement"><i class="fa fa-download"></i></a>
						{/if}
						</td>
						<td>{$value.form_created_on|date_format:$smarty.const.CALENDAR_DATE_FORMAT}</td>
						<td>
						<a href="javascript:void(0)" class="formUpdateAction m-l-10" attrFormUserId="{$value.form_user_id}" id="formId_{$value.form_id}" title="Update"><i class="fa fa-pencil"></i></a>
							<a href="javascript:void(0)" class="formDeleteAction m-l-10" id="formId_{$value.form_id}" title="Delete"><i class="fa fa-trash"></i></a>
						</td>
					</tr>
				{/foreach}
			 {else}
				<tr class="">
					<td colspan ="13" class="noRecords">{$smarty.const.LBL_NO_RECORDS}</td>
				</tr>
			{/if}
		</tbody>
</table>	


{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Forms </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="formPageListingNew" id="formPageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
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
