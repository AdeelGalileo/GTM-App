<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:10:41
         compiled from "/home/galileotechmedia/public_html/app/templates/paginationNew.tpl" */ ?>
<?php /*%%SmartyHeaderCode:5810614045a959111d300a7-87181330%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '779bbc38f9cb8694b538c04e15821032e5d8c344' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/paginationNew.tpl',
      1 => 1519124488,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '5810614045a959111d300a7-87181330',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalPages' => 0,
    'modelClass' => 0,
    'start' => 0,
    'pageArr' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959111d5ae28_23852609',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959111d5ae28_23852609')) {function content_5a959111d5ae28_23852609($_smarty_tpl) {?><?php if ($_smarty_tpl->tpl_vars['totalPages']->value>1){?><span class="pagination-nav <?php echo $_smarty_tpl->tpl_vars['modelClass']->value;?>
"><select class="pageDropDown pull-left form-control P5" name="pageDropDownValue" id="pageDropDownValue" style="width:60px !important;"><?php $_smarty_tpl->tpl_vars['start'] = new Smarty_Variable;$_smarty_tpl->tpl_vars['start']->step = 1;$_smarty_tpl->tpl_vars['start']->total = (int)ceil(($_smarty_tpl->tpl_vars['start']->step > 0 ? $_smarty_tpl->tpl_vars['totalPages']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['totalPages']->value)+1)/abs($_smarty_tpl->tpl_vars['start']->step));
if ($_smarty_tpl->tpl_vars['start']->total > 0){
for ($_smarty_tpl->tpl_vars['start']->value = 1, $_smarty_tpl->tpl_vars['start']->iteration = 1;$_smarty_tpl->tpl_vars['start']->iteration <= $_smarty_tpl->tpl_vars['start']->total;$_smarty_tpl->tpl_vars['start']->value += $_smarty_tpl->tpl_vars['start']->step, $_smarty_tpl->tpl_vars['start']->iteration++){
$_smarty_tpl->tpl_vars['start']->first = $_smarty_tpl->tpl_vars['start']->iteration == 1;$_smarty_tpl->tpl_vars['start']->last = $_smarty_tpl->tpl_vars['start']->iteration == $_smarty_tpl->tpl_vars['start']->total;?><option value="<?php echo $_smarty_tpl->tpl_vars['start']->value;?>
" title="<?php echo $_smarty_tpl->tpl_vars['start']->value;?>
" id="<?php echo $_smarty_tpl->tpl_vars['start']->value;?>
" <?php if ($_POST['page']==$_smarty_tpl->tpl_vars['start']->value||$_smarty_tpl->tpl_vars['pageArr']->value['current']==$_smarty_tpl->tpl_vars['start']->value){?> selected <?php }?>><?php echo $_smarty_tpl->tpl_vars['start']->value;?>
</option><?php }} ?></select><a class="fa fa-angle-left font26 gray m-l-10 leftArrowClass pointer" title="Previous" style="<?php if (($_POST['page']==1||$_smarty_tpl->tpl_vars['pageArr']->value['current']==1)){?>display:none;<?php }else{ ?><?php if (($_POST['page']==$_smarty_tpl->tpl_vars['totalPages']->value||$_smarty_tpl->tpl_vars['pageArr']->value['current']==$_smarty_tpl->tpl_vars['totalPages']->value)){?>padding:3px 10px 0px 0px<?php }?><?php }?>"></a><a class="fa fa-angle-right font26 gray m-l-10 m-r-10 m-t-2 rightArrowClass pointer" title="Next" style="<?php if (($_POST['page']==$_smarty_tpl->tpl_vars['totalPages']->value||$_smarty_tpl->tpl_vars['pageArr']->value['current']==$_smarty_tpl->tpl_vars['totalPages']->value)){?>display:none;<?php }?>"></a></span><?php }?><?php }} ?>