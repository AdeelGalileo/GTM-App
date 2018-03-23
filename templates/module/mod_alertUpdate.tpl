{strip}
<div class="row">
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
            <div class="row">
               <div class="form-group col-sm-3">
                  <label >User</label>
                  <p>{$alertData.user_fname} {$alertData.user_lname}</p>
               </div>
               <div class="form-group col-sm-3">
                  <label >Module</label>
					  <p> 
                     {if $modulesArray}
						{foreach $modulesArray as $key=> $value}
							{if $alertData.notification_module_id==$value.modules_id }{$value.modules_name}{/if}
						{/foreach}
                     {/if}
					 </p>
                 
               </div>
               <div class="form-group col-sm-3">
                  <label >Email</label>
                  <input type="text" class="form-control notification_email" id="notification_email" value="{if $alertData.notification_email} {$alertData.notification_email} {else} {$alertData.user_email} {/if}">
               </div>
            </div>
            <button type="button" class="btn btn-default pull-right margin alertUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin alertSave">Done</button>
         </div>
      </div>
   </div>
</div>
	  <input type="hidden" name="alertUpdateId" id="alertUpdateId" class="alertUpdateId" value="{$alertId}">
	  <input type="hidden" name="notification_user_id" id="notification_user_id" class="notification_user_id" value="{$alertData.notification_user_id}">
	  <input type="hidden" name="notification_module_id" id="notification_module_id" class="notification_module_id" value="{$alertData.notification_module_id}">


{/strip}

<script>
  $(function () {
	
    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
  
  });
</script>
	  