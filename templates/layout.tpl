<!DOCTYPE html>
<html>
   <head>
      {strip}
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <title>{block name="title"}Galileo{/block}</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="description" content="">
      {include file="layout/script.tpl"}
      {/strip}
      {block name="header"}{/block}
   </head>
  <body class="skin-blue sidebar-mini sidebar-collapse">
<div class="wrapper">
      {strip}
		 {include file="layout/body_header_content.tpl"}
         {include file="layout/left_menu.tpl"}
         <div class="content-wrapper">
			 <section class="content-header">
					<h1>
						{$lastPage}
					</h1>
				  <ol class="breadcrumb">
					<li><a href="{$smarty.const.ROOT_HTTP_PATH}/dashboard.php"><i class="fa fa-dashboard"></i> Home</a></li>
					 {if $pageLink}
						<li>
							{$pageLink}
						</li>
					{/if}
					<li class="active">{$lastPage}</li>
				  </ol>
			</section>
            <div id="Messages" style="{if !$messages}display:none;{/if}">
               <div id="inner_message">{$messages}</div>
            </div>
            <div id="MessagesAuto" style="{if !$messages}display:none;z-index:99999999;{/if}">
               <div id="inner_Auto" class="text-center">{$messages}</div>
            </div>
            <section class="content">
               {block name=content}{$content}{/block} 
            </section>
         </div>
		 {include file="layout/body_footer_content.tpl"}
      {/strip}
	</div>
   </body>
</html>