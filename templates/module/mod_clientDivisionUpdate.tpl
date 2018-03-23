{strip}
<script type="text/javascript">
   $(document).ready(function(){
		$('.client_qb_ref_qb_id').chosen({ width:"100%"});
   });
 </script>
	  <div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
				<div class="row">
						<div class="form-group col-sm-3">
							<label >Division</label>
							 <select class="form-control client_qb_ref_division_id" id="client_qb_ref_division_id">
							 <option value="">--- Select Division ---</option>
								{if $divisionArray}
								 {foreach $divisionArray as $key=> $value}
									<option value="{$value.division_id}" {if $clientDivisionData.client_qb_ref_division_id==$value.division_id }selected{/if}>{$value.division_code}</option>
								 {/foreach}
							 {/if}
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label >Client QB Class</label>
							
							<select class="form-control client_qb_ref_qb_class" id="client_qb_ref_qb_class">
							<option value="">--- Select Qb Class ---</option>
							{if $qbClassNamesArray}
							{foreach $qbClassNamesArray as $key=> $value}
							<option value="{$value.qb_cls_ref_id}" {if $clientDivisionData.client_qb_ref_qb_class==$value.qb_cls_ref_id }selected{/if}>{$value.qb_cls_ref_class_name}</option>
							{/foreach}
							{/if}
							</select>
							
						</div>
						<div class="form-group col-sm-3">
						    <label >QB Associated Client</label>
						   {*<input type="text" class="form-control client_qb_ref_qb_id" id="client_qb_ref_qb_id" placeholder="" value="{$clientDivisionData.client_qb_ref_qb_id}">*}
						    <select class="form-control client_qb_ref_qb_id" id="client_qb_ref_qb_id">
							<option value="">--- Select QB Associated Client ---</option>
							{if $outputArray}
								{foreach $outputArray as $key=> $value}
									<option {if $value->Id==$clientDivisionData.client_qb_ref_qb_id}selected="selected"{/if} value="{$value->Id}">{$value->DisplayName}</option>
							{/foreach}
							{/if}
							</select>
						   
						</div>
				 </div>
			
            <button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
	 <input type="hidden" name="clientQbRefUpdateId" id="clientQbRefUpdateId" class="clientQbRefUpdateId" value="{$clientQbRefUpdateId}">
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
 $('#client_qb_ref_qb_class').chosen({ width:"100%"});
	
  });
</script>
	  