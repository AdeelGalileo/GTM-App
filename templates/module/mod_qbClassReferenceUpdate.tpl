{strip}
<script type="text/javascript">
   $(document).ready(function(){
		$('.qb_cls_ref_class_id').chosen({ width:"100%"});
   });
 </script>


<div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
				<div class="row">
					<div class="form-group col-sm-3">
						<label >QB Associated Class Name</label>
						<select class="form-control qb_cls_ref_class_id" id="qb_cls_ref_class_id">
					<option value="">--- Select QB Associated Service Type Name ---</option>
					{if $outputArray}
						{foreach $outputArray as $key=> $value}
							<option {if $value->Id==$qbClassReferenceData.qb_cls_ref_class_id}selected="selected"{/if} value="{$value->Id}">{$value->Name}</option>
					{/foreach}
					{/if}
					</select>
					{*<input type="text" class="form-control qb_cls_ref_class_id" id="qb_cls_ref_class_id" placeholder="" value="{$qbClassReferenceData.qb_cls_ref_class_id}">*}
					</div>
					<div class="form-group col-sm-3">
					   <label >Class Name</label>
					   <input type="text" class="form-control qb_cls_ref_class_name" id="qb_cls_ref_class_name" placeholder="" value="{$qbClassReferenceData.qb_cls_ref_class_name}">
					</div>
				 </div>
			
            <button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
	 <input type="hidden" name="classQbRefUpateId" id="classQbRefUpateId" class="classQbRefUpateId" value="{$classQbRefUpateId}">
</div>
{/strip}

	  