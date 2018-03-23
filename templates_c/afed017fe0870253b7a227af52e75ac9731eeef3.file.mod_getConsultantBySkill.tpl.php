<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:53:32
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_getConsultantBySkill.tpl" */ ?>
<?php /*%%SmartyHeaderCode:8253012385a959b1cf28594-50004028%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'afed017fe0870253b7a227af52e75ac9731eeef3' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_getConsultantBySkill.tpl',
      1 => 1519124691,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '8253012385a959b1cf28594-50004028',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'consultantList' => 0,
    'value' => 0,
    'taskContentData' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959b1d00aa64_44734710',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959b1d00aa64_44734710')) {function content_5a959b1d00aa64_44734710($_smarty_tpl) {?><select class="form-control task_content_user_id task_content_reassign_user_id" id="task_content_user_id"><option value="">--- Select Consultant ---</option><?php if ($_smarty_tpl->tpl_vars['consultantList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['consultantList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_id'];?>
" <?php if ($_smarty_tpl->tpl_vars['taskContentData']->value['task_content_user_id']==$_smarty_tpl->tpl_vars['value']->value['user_id']){?>selected<?php }?> ><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
</option><?php } ?><?php }?></select>

<script>
  $(function () {
	$('#task_content_user_id').chosen({ width:"100%"});
  });
</script><?php }} ?>