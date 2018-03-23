<script>
  $(function () {
	  
	{if $smarty.session.sessionClientId == $smarty.const.MARRIOTT_CLIENT_ID }  
	
   
   {/if}
   
  });
</script>

{strip}
<div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
			   <div class="form-group col-sm-4">
				   <label >Consultant</label>
					  <p>
						  {if $userArray}
						  {foreach $userArray as $key=> $value}
							 {if $consultantSkillData.cons_user_id==$value.user_id}
								{$value.user_fname} {$value.user_lname}
							 {/if}
						  {/foreach}
						  {/if}
					  </p>
				</div>
				
				<div class="form-group col-sm-6">
                  <label >Skills</label>
                  <select class="form-control cons_service_type_id" multiple data-placeholder="Choose a Skills" id="cons_service_type_id">
                     <option value="">--- Select Skills ---</option>
                     {if $serviceTypeArray}
                     {foreach $serviceTypeArray as $key=> $value}
                     <option value="{$value.serv_type_id}"
					 {foreach $service_type_existing_id as $exKey => $exVal} 
					 {if $exVal==$value.serv_type_id }selected{/if}
					{/foreach}  > 
					{$value.serv_type_name} </option>
                     {/foreach}
                     {/if}
                  </select>
               </div>
			 </div>
			
            <button type="button" class="btn btn-default pull-right margin skillUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addSkillSave">Done</button>
         </div>
      </div>
   </div>
</div>
<input type="hidden" name="skillUpateId" id="skillUpateId" class="skillUpateId" value="{$skillUpateId}">
<input type="hidden" name="cons_user_id" id="cons_user_id" class="cons_user_id" value="{$consultantSkillData.cons_user_id}">

{/strip}

<script>
  $(function () {
	
   $('#cons_service_type_id').chosen({ width:"100%"});
  
  });
</script>
	  