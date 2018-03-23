<?php /* Smarty version Smarty-3.1.11, created on 2018-03-08 04:31:27
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_qbClientTokenUpdate.tpl" */ ?>
<?php /*%%SmartyHeaderCode:11680916635aa102ef92f6c6-23593840%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '1b8fea4cfb0d11050d582ffa5bbbb51886228250' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_qbClientTokenUpdate.tpl',
      1 => 1519124696,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '11680916635aa102ef92f6c6-23593840',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'qbClientTokenData' => 0,
    'clientQbTokenUpateId' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5aa102ef950074_46194862',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5aa102ef950074_46194862')) {function content_5aa102ef950074_46194862($_smarty_tpl) {?><div class="row" ><div class="col-md-12"><div class="box box-primary"><div class="box-body"><div class="row"><div class="form-group col-sm-6"><label >QB Client Id</label><input type="text" class="form-control qb_client_token_client_id" id="qb_client_token_client_id" placeholder="" value="<?php echo $_smarty_tpl->tpl_vars['qbClientTokenData']->value['qb_client_token_client_id'];?>
"></div><div class="form-group col-sm-6"><label >QB Client Secret Id</label><input type="text" class="form-control qb_client_token_client_secret" id="qb_client_token_client_secret" placeholder="" value="<?php echo $_smarty_tpl->tpl_vars['qbClientTokenData']->value['qb_client_token_client_secret'];?>
"></div></div><div class="row"><div class="form-group col-sm-6"><label >QB Real MID</label><input type="text" class="form-control qb_client_token_qbo_real_id" id="qb_client_token_qbo_real_id" placeholder="" value="<?php echo $_smarty_tpl->tpl_vars['qbClientTokenData']->value['qb_client_token_qbo_real_id'];?>
"></div><div class="form-group col-sm-6"><label >QB Base URL</label><input type="text" class="form-control qb_client_token_base_url" id="qb_client_token_base_url" placeholder="" value="<?php echo $_smarty_tpl->tpl_vars['qbClientTokenData']->value['qb_client_token_base_url'];?>
"></div></div><div class="row"><div class="form-group col-sm-6"><label >QB Refresh Token</label><input type="text" class="form-control qb_client_token_refresh_token" id="qb_client_token_refresh_token" placeholder="" value="<?php echo $_smarty_tpl->tpl_vars['qbClientTokenData']->value['qb_client_token_refresh_token'];?>
"></div><div class="form-group col-sm-6"><label >QB Access Token</label><input type="text" class="form-control qb_client_token_access_token" id="qb_client_token_access_token" placeholder="" value="<?php echo $_smarty_tpl->tpl_vars['qbClientTokenData']->value['qb_client_token_access_token'];?>
"></div></div><button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button><button type="button" class="btn btn-info pull-right margin addClientSave">Done</button></div></div></div><input type="hidden" name="clientQbTokenUpateId" id="clientQbTokenUpateId" class="clientQbTokenUpateId" value="<?php echo $_smarty_tpl->tpl_vars['clientQbTokenUpateId']->value;?>
"></div>

	  <?php }} ?>