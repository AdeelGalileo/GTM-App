{strip}
	  <div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
				<div class="row">
						<div class="form-group col-sm-3">
							<label >Division</label>
							 <select class="form-control client_entity_division_id" id="client_entity_division_id">
							 <option value="">--- Select Division ---</option>
								{if $divisionArray}
								 {foreach $divisionArray as $key=> $value}
									<option value="{$value.division_id}" {if $clientEntityData.client_entity_division_id==$value.division_id }selected{/if}>{$value.division_code}</option>
								 {/foreach}
							 {/if}
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label >{$codeLabelData}</label>
							<input type="text" class="form-control client_entity_marsha_code" id="client_entity_marsha_code" placeholder="" value="{$clientEntityData.client_entity_marsha_code}">
						</div>
						<div class="form-group col-sm-3">
						   <label >Location Name</label>
						   <input type="text" class="form-control client_entity_hotel_name" id="client_entity_hotel_name" placeholder="" value="{$clientEntityData.client_entity_hotel_name}">
						</div>
						<div class="form-group col-sm-3">
						   <label >Street</label>
						   <input type="text" class="form-control client_entity_street" id="client_entity_street" placeholder="" value="{$clientEntityData.client_entity_street}">
						</div>
				 </div>
				 <div class="row">
					<div class="form-group col-sm-3">
						   <label >City</label>
						   <input type="text" class="form-control client_entity_city" id="client_entity_city" placeholder="" value="{$clientEntityData.client_entity_city}">
					</div>
					<div class="form-group col-sm-3">
						   <label >State</label>
						   <input type="text" class="form-control client_entity_state" id="client_entity_state" placeholder="" value="{$clientEntityData.client_entity_state}">
					</div>
					<div class="form-group col-sm-3">
						   <label >Zip Code</label>
						   <input type="text" class="form-control client_entity_zipcode" id="client_entity_zipcode" placeholder="" value="{$clientEntityData.client_entity_zipcode}">
					</div>
					<div class="form-group col-sm-3">
						   <label >Country</label>
						   <input type="text" class="form-control client_entity_country" id="client_entity_country" placeholder="" value="{$clientEntityData.client_entity_country}">
					</div>
				 </div>
            <button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
	 <input type="hidden" name="clientEntityUpdateId" id="clientEntityUpdateId" class="clientEntityUpdateId" value="{$clientEntityUpdateId}">
   	 

</div>

{/strip}

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
 $('#client_qb_ref_division_id').chosen({ width:"100%"});
 $('#client_entity_division_id').chosen({ width:"100%"});	
  });
</script>
	  