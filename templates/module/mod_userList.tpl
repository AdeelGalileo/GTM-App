{strip}

<div class="row-fluid">
  <div class="p-t-15 p-b-15"> {if $totalRecords > 0} <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation">{if $totalRecords==''}0{else} {$totalRecords} {/if}</span> Users </span>
    <div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span>
      <select name="userPageListing" id="userPageListing" class="form-control P5 pull-left" style="width:60px !important;">
        
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
		<tr class="bg-blueL" id="overAllUser">
			<th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th>
			<th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th>
			<th id="user_emails"><a class="" href="javascript:void(0)" id="user_email">Email</a></th>
			<th id="user_form_completeds"><a class="" href="javascript:void(0)" id="user_form_completed">Forms Completed</a></th>
			<th id="user_role_names"><a class=""  href="javascript:void(0)" id="user_role_name">Role</a></th>
			<th style="color:#337ab7;">Action</th>
		</tr>
		</thead>
		 <tbody>
			{if $userList}
				{foreach $userList as $key=> $value}
					<tr class="">
						<td>{$value.user_fname}</td>
						<td>{$value.user_lname}</td>
						<td>{$value.user_email}</td>
						<td>
						{if $value.user_form_completed==1}
							Yes
						{else}
							No
						{/if}
						</td>
						<td>{$value.user_role_name}</td>
						
						<td>
							{if $smarty.session.userRole == $smarty.const.USER_ROLE_ADMIN}
							<a href="{$smarty.const.ROOT_HTTP_PATH}/adminPersonnel.php?userUpdateId={$value.user_id}" title="Update User"><i class="fa fa-pencil"></i></a>
							
							<a href="javascript:void(0)" class="userDeleteAction m-l-10" id="userDeleteId_{$value.user_id}" title="Delete"><i class="fa fa-trash"></i></a>
							{/if}
						</td>
						
					</tr>
				{/foreach}
			{/if}
		</tbody>
</table>	


{if $totalRecords > 0}
<div class="row-fluid">
  <div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew">{if $totalRecords==''}0{else}{$totalRecords}{/if}</span> Users </span>
    <div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span>
      <select name="userPageListingNew" id="userPageListingNew" class="form-control P5 pull-left" style="width:60px !important;">
        
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
