{strip}
 <div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
			<div class="row">
				<div class="form-group col-sm-3">
				   <label >Division Code</label>
				   <input type="text" class="form-control division_code" id="division_code" value="{$divisionData.division_code}">
				</div>
			 </div>
            <button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
	 <input type="hidden" name="divisionUpdateId" id="divisionUpdateId" class="divisionUpdateId" value="{$divisionUpdateId}">
</div>
{/strip}
