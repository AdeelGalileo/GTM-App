{extends file='layout.tpl'}
{strip}
{block name=title}{$SiteTitle} - Import Wizard Success{/block}
{block name=header}

<script type="text/javascript">
	$(document).ready(function(e) {
		
		 {if $importSuccessMsg}
            $('#importSuccess .uiContent').html('<div class="P50 M50 boldL text-center">{$importSuccessMsg}</div>');
            uiPopupOpen('importSuccess', 750, 150);
			
			setTimeout(function() { 
				window.location.href = "{$smarty.const.ROOT_HTTP_PATH}/taskManagerKeyword.php";
			}, 30000);
			
        {/if}
		
		
		
     });
</script>
{/block}
{block name=content}
<div class="row " >
   <div class="col-md-12 text-center ">
      <div class="box box-primary">
		<div class="box-body">
		<h3 class="m-t-10">Import Wizard Completed</h3> </div>
   </div>
</div>
</div>
<div id="importSuccess">
    <div class="pop-up-overlay " style="display:none;">
        <div class="pop-close">X</div>
        <div class="container " style="display:none;">
            <div class="uiContent">
            </div>
        </div>
    </div>
</div>

{/block}
{/strip}