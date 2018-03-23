{extends file='layout.tpl'}
{block name=title}{$SiteTitle} - Admin{/block}
{block name=header}{/block}
{block name=content}
<h2 class="page-header">Select Clients</h2>
<div class="row">
	{if $clientData}
		 {foreach $clientData as $key=> $value}
		<div class="col-md-3 col-sm-6 col-xs-12">
		  <a href="{$smarty.const.ROOT_HTTP_PATH}/clientForm.php?consultantClientId={$value.client_id}">
		  <div class="info-box">
			<span class="info-box-icon bg-aqua"><i class="fa fa-user"></i></span>
			<div class="info-box-content">
			  <span class="info-box-text">{$value.client_name}</span>
			</div>
		  </div>
		  </a>
		</div>
	 {/foreach}
	 {/if}
</div>
{/block}