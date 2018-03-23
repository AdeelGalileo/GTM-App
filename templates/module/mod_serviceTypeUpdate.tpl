{strip}

<script type="text/javascript">
   $(document).ready(function(){
		$('.serv_type_qb_id').chosen({ width:"100%"});
   });
 </script>

<div class="row">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
				<div class="row">
						<div class="form-group col-sm-3">
					<label >QB Associated Service Type Name</label>
					<select class="form-control serv_type_qb_id" id="serv_type_qb_id">
					<option value="">--- Select QB Associated Service Type Name ---</option>
					{if $outputArray}
						{foreach $outputArray as $key=> $value}
							<option {if $value->Id==$serviceType.serv_type_qb_id}selected="selected"{/if} value="{$value->Id}">{$value->Name}</option>
					{/foreach}
					{/if}
					</select>
					
				</div>
					   <div class="form-group col-sm-3">
						  <label >Service Type</label>
						   <input type="text" class="form-control serv_type_name" id="serv_type_name" value="{$serviceType.serv_type_name}">
					   </div>
					   <div class="form-group col-sm-3">
						  <label >Invoice Rate</label>
						   <input type="text" class="form-control serv_type_gal_rate" id="serv_type_gal_rate" value="{$serviceType.serv_type_gal_rate}">
					   </div>
					   <div class="form-group col-sm-3">
						  <label >Bill Rate</label>
						  <input type="text" class="form-control serv_type_freel_rate" id="serv_type_freel_rate" value="{$serviceType.serv_type_freel_rate}">
					   </div>
					   {*<div class="form-group col-sm-3">
						  <label >Service Type Qb Id</label>
						  <input type="text" class="form-control serv_type_qb_id" id="serv_type_qb_id" value="{$serviceType.serv_type_qb_id}">
					   </div>*}
				</div>
				<div class="row">
					<div class="form-group col-sm-3">
                  <label >Service Task Type</label>
                     <select class="form-control serv_type_task_type" name="serv_type_task_type">
						 <option value="">--Select Service Task Type--</option>
						 <option value="1" {if $serviceType.serv_type_task_type==1 }selected{/if}>Task Keyword</option>
						 <option value="2" {if $serviceType.serv_type_task_type==2 }selected{/if}>Task Content</option>
                     </select>
               </div>
			  </div>
            <button type="button" class="btn btn-default pull-right margin serviceTypeUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin serviceTypeSave">Done</button>
         </div>
      </div>
   </div>
</div>
	  <input type="hidden" name="servTypeUpdateId" id="servTypeUpdateId" class="servTypeUpdateId" value="{$serviceTypeId}">
{/strip}
