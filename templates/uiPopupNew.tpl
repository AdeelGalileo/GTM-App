<style type="text/css">

#{$popupId} .pop-up-overlay .container { 
	max-width:830px !important; 
	margin:50px auto;
    background:#fff; 
	display:none; 
	width:100% !important; 
	position:relative !important; 
	box-shadow:0px 0 20px rgba(0,0,0,0.8); 
	border-radius:0 !important; 
	overflow:auto; 
	}
#{$popupId} .pop-up-overlay .pop-close
{
	/*width:initial !important;
	height:initial !important;
	top: -18px;
    right: -8px;
	line-height: initial !important;
	padding: 0px 9px 2px 9px;*/
}

</style>

{strip}
<div id="{$popupId}">
  <div class="pop-up-overlay hide" >
    <div class="pop-close">x</div>
    <div class="container hide" style="background: #f9f9fa;border-top: 3px solid #efd24a;padding:0 0;overflow: visible;">
	  
      <div class="uiContent"> <img src="{$smarty.const.ROOT_HTTP_PATH}/images/loading.gif" title="Loading" alt="Loading......." /> </div>
    </div>
  </div>
</div>
{/strip}