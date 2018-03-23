{extends file='layout.tpl'}
{strip}
{block name=title}{$SiteTitle} - Form Upload Pending{/block}
{block name=header}

<script type="text/javascript">
	$(document).ready(function(e) {
		 {if $formUploadPending}
            $('#formUploadPending .uiContent').html('<div class="P50 M50 boldL text-center">{$formUploadPendingMsg}</div>');
            uiPopupOpen('formUploadPending', 750, 150);
        {/if}
		
     });
</script>
{/block}
{block name=content}
<div class="row " >
   <div class="col-md-12 text-center ">
      <div class="box box-primary">
		<div class="box-body">
		<h3 class="m-t-10">Form Upload Pending</h3> </div>
   </div>
</div>
</div>
<div id="formUploadPending">
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