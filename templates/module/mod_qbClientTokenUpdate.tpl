{strip}
<div class="row" >
   <div class="col-md-12">
      <div class="box box-primary">
         <div class="box-body">
				<div class="row">
					<div class="form-group col-sm-6">
						<label >QB Client Id</label>
						<input type="text" class="form-control qb_client_token_client_id" id="qb_client_token_client_id" placeholder="" value="{$qbClientTokenData.qb_client_token_client_id}">
					</div>
					<div class="form-group col-sm-6">
					   <label >QB Client Secret Id</label>
					   <input type="text" class="form-control qb_client_token_client_secret" id="qb_client_token_client_secret" placeholder="" value="{$qbClientTokenData.qb_client_token_client_secret}">
					</div>
					 </div>
					 <div class="row">
					<div class="form-group col-sm-6">
					   <label >QB Real MID</label>
					   <input type="text" class="form-control qb_client_token_qbo_real_id" id="qb_client_token_qbo_real_id" placeholder="" value="{$qbClientTokenData.qb_client_token_qbo_real_id}">
					</div>
					<div class="form-group col-sm-6">
					   <label >QB Base URL</label>
					   <input type="text" class="form-control qb_client_token_base_url" id="qb_client_token_base_url" placeholder="" value="{$qbClientTokenData.qb_client_token_base_url}">
					</div>
				 </div>
				 <div class="row">
					<div class="form-group col-sm-6">
					   <label >QB Refresh Token</label>
					   <input type="text" class="form-control qb_client_token_refresh_token" id="qb_client_token_refresh_token" placeholder="" value="{$qbClientTokenData.qb_client_token_refresh_token}">
					</div>
					<div class="form-group col-sm-6">
					   <label >QB Access Token</label>
					   <input type="text" class="form-control qb_client_token_access_token" id="qb_client_token_access_token" placeholder="" value="{$qbClientTokenData.qb_client_token_access_token}">
					</div>
				 </div>
			
            <button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button>
            <button type="button" class="btn btn-info pull-right margin addClientSave">Done</button>
         </div>
      </div>
   </div>
	 <input type="hidden" name="clientQbTokenUpateId" id="clientQbTokenUpateId" class="clientQbTokenUpateId" value="{$clientQbTokenUpateId}">
</div>
{/strip}

	  