{strip}
<script type="text/javascript">
   $(document).ready(function(){
		$('.client_qb_associated_reference').chosen({ width:"100%"});
   });
 </script>
	  <div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
            <div class="form-group col-sm-3">
               <label >Client Name</label>
			   <input  class="form-control client_name" id="client_name" value="{$clientData.client_name}">
            </div>
            <div class="form-group col-sm-3">
               <label >Street</label>
               <input  class="form-control client_street" id="client_street" value="{$clientData.client_street}">
            </div>
            <div class="form-group col-sm-3">
               <label >City</label>
               <input type="text" class="form-control client_city" id="client_city" value="{$clientData.client_city}">
            </div>
			 <div class="form-group col-sm-3">
                  <label >State</label>
                   <input type="text" class="form-control client_state" id="client_state" value="{$clientData.client_state}">
            </div>
			 </div>
			 <div class="row">
				<div class="form-group col-sm-3">
				   <label >Zip Code</label>
				   <input type="text" class="form-control client_zipcode" id="client_zipcode" value="{$clientData.client_zipcode}">
				</div>
				<div class="form-group col-sm-3">
					<label >Country</label>
					<input type="text" class="form-control client_country" id="client_country" value="{$clientData.client_country}">
				</div>
				<div class="form-group col-sm-3">
					<label >Active Status</label>
					 <select class="form-control client_record_status" id="client_record_status">
                     <option value="">--- Select Active Status---</option>
					 <option value="0" {if $clientData.client_record_status==0 }selected{/if}>Active</option>
					 <option value="1" {if $clientData.client_record_status==1 }selected{/if}>In-Active</option>
                  </select>
				</div>
				<div class="form-group col-sm-3">
				   <label >QB Associated Client</label>
				   <select class="form-control client_qb_associated_reference" id="client_qb_associated_reference">
					<option value="">--- Select QB Associated Client ---</option>
					{if $outputArray}
						{foreach $outputArray as $key=> $value}
							<option {if $value->Id==$clientData.client_qb_associated_reference}selected="selected"{/if}  value="{$value->Id}">{$value->DisplayName}</option>
					{/foreach}
					{/if}
					</select>
				</div>
			 </div>
			<div class="row">
				<div class="form-group col-sm-9"><p style="font-weight:bold;">Note :  If the Associated QB class and QB Id for this client is different for each divisions. Please update QB class & Qb Id for the divisions of this client.</p></div>
			</div>
            <button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
   	  <input type="hidden" name="clientUpateId" id="clientUpateId" class="clientUpateId" value="{$clientUpateId}">

</div>

{/strip}

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
   $('#task_content_user_id').chosen({ width:"100%"});
   $('#task_content_marsha_code').chosen({ width:"100%"});
   $('#task_content_service_type_id').chosen({ width:"100%"});
  
  });
</script>
	  