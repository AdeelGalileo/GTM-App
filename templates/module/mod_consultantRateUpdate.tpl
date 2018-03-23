{strip}
<div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
			   <div class="form-group col-sm-4">
				   <label >Consultant</label>
				     <p>{$rateData.user_fname} {$rateData.user_lname}</p>
				</div>
				 <div class="form-group col-sm-6">
					 <label >Service Type</label>
				     <p>{$rateData.serv_type_name}</p>
				 </div>
				<div class="form-group col-sm-2">
                  <label >Rate Per Unit</label>
				   <input type="text" value="{$rateData.cons_rate_per_unit|number_format:'2'}" class="form-control cons_rate_per_unit" id="cons_rate_per_unit" placeholder="">
               </div>
			 </div>
			
            <button type="button" class="btn btn-default pull-right margin rateUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addRateSave">Done</button>
         </div>
      </div>
   </div>
</div>
<input type="hidden" name="rateUpdateId" id="rateUpdateId" class="rateUpdateId" value="{$rateUpdateId}">
<input type="hidden" name="cons_rate_user_id" id="cons_rate_user_id" class="cons_rate_user_id" value="{$rateData.cons_rate_user_id}">
<input type="hidden" name="cons_rate_service_type_id" id="cons_rate_service_type_id" class="cons_rate_service_type_id" value="{$rateData.cons_rate_service_type_id}">

{/strip}

<script>
  $(function () {
	
   $('#cons_service_type_id').chosen({ width:"100%"});
  
  });
</script>
	  