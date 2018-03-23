<?php /* Smarty version Smarty-3.1.11, created on 2018-02-28 11:44:00
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_serviceTypeUpdate.tpl" */ ?>
<?php /*%%SmartyHeaderCode:6692142025a96dc50327732-78364186%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c4d7024df7232761ca71190bbd196927d7b8519c' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_serviceTypeUpdate.tpl',
      1 => 1519124699,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '6692142025a96dc50327732-78364186',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'outputArray' => 0,
    'value' => 0,
    'serviceType' => 0,
    'serviceTypeId' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a96dc5034eb83_91800420',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a96dc5034eb83_91800420')) {function content_5a96dc5034eb83_91800420($_smarty_tpl) {?><script type="text/javascript">$(document).ready(function(){$('.serv_type_qb_id').chosen({ width:"100%"});});</script><div class="row"><div class="col-md-12"><div class="box box-primary"><div class="box-body"><div class="row"><div class="form-group col-sm-3"><label >QB Associated Service Type Name</label><select class="form-control serv_type_qb_id" id="serv_type_qb_id"><option value="">--- Select QB Associated Service Type Name ---</option><?php if ($_smarty_tpl->tpl_vars['outputArray']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['outputArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><option <?php if ($_smarty_tpl->tpl_vars['value']->value->Id==$_smarty_tpl->tpl_vars['serviceType']->value['serv_type_qb_id']){?>selected="selected"<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['value']->value->Id;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value->Name;?>
</option><?php } ?><?php }?></select></div><div class="form-group col-sm-3"><label >Service Type</label><input type="text" class="form-control serv_type_name" id="serv_type_name" value="<?php echo $_smarty_tpl->tpl_vars['serviceType']->value['serv_type_name'];?>
"></div><div class="form-group col-sm-3"><label >Invoice Rate</label><input type="text" class="form-control serv_type_gal_rate" id="serv_type_gal_rate" value="<?php echo $_smarty_tpl->tpl_vars['serviceType']->value['serv_type_gal_rate'];?>
"></div><div class="form-group col-sm-3"><label >Bill Rate</label><input type="text" class="form-control serv_type_freel_rate" id="serv_type_freel_rate" value="<?php echo $_smarty_tpl->tpl_vars['serviceType']->value['serv_type_freel_rate'];?>
"></div></div><div class="row"><div class="form-group col-sm-3"><label >Service Task Type</label><select class="form-control serv_type_task_type" name="serv_type_task_type"><option value="">--Select Service Task Type--</option><option value="1" <?php if ($_smarty_tpl->tpl_vars['serviceType']->value['serv_type_task_type']==1){?>selected<?php }?>>Task Keyword</option><option value="2" <?php if ($_smarty_tpl->tpl_vars['serviceType']->value['serv_type_task_type']==2){?>selected<?php }?>>Task Content</option></select></div></div><button type="button" class="btn btn-default pull-right margin serviceTypeUpdateCancel">Cancel</button><button type="button" class="btn btn-info pull-right margin serviceTypeSave">Done</button></div></div></div></div><input type="hidden" name="servTypeUpdateId" id="servTypeUpdateId" class="servTypeUpdateId" value="<?php echo $_smarty_tpl->tpl_vars['serviceTypeId']->value;?>
">
<?php }} ?>