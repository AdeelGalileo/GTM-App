<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 15:48:10
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_clientDivisionUpdate.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9045498565a95c40a156ba7-27857245%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c72ad61f5143f3f3b5949b857c642da3d2c34730' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_clientDivisionUpdate.tpl',
      1 => 1519124682,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9045498565a95c40a156ba7-27857245',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'divisionArray' => 0,
    'value' => 0,
    'clientDivisionData' => 0,
    'qbClassNamesArray' => 0,
    'outputArray' => 0,
    'clientQbRefUpdateId' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a95c40a181e77_28053522',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95c40a181e77_28053522')) {function content_5a95c40a181e77_28053522($_smarty_tpl) {?><script type="text/javascript">$(document).ready(function(){$('.client_qb_ref_qb_id').chosen({ width:"100%"});});</script><div class="row" ><div class="col-md-12"><div class="box box-primary"><div class="box-body"><div class="row"><div class="form-group col-sm-3"><label >Division</label><select class="form-control client_qb_ref_division_id" id="client_qb_ref_division_id"><option value="">--- Select Division ---</option><?php if ($_smarty_tpl->tpl_vars['divisionArray']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['divisionArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['division_id'];?>
" <?php if ($_smarty_tpl->tpl_vars['clientDivisionData']->value['client_qb_ref_division_id']==$_smarty_tpl->tpl_vars['value']->value['division_id']){?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
</option><?php } ?><?php }?></select></div><div class="form-group col-sm-3"><label >Client QB Class</label><select class="form-control client_qb_ref_qb_class" id="client_qb_ref_qb_class"><option value="">--- Select Qb Class ---</option><?php if ($_smarty_tpl->tpl_vars['qbClassNamesArray']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['qbClassNamesArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['qb_cls_ref_id'];?>
" <?php if ($_smarty_tpl->tpl_vars['clientDivisionData']->value['client_qb_ref_qb_class']==$_smarty_tpl->tpl_vars['value']->value['qb_cls_ref_id']){?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['value']->value['qb_cls_ref_class_name'];?>
</option><?php } ?><?php }?></select></div><div class="form-group col-sm-3"><label >QB Associated Client</label><select class="form-control client_qb_ref_qb_id" id="client_qb_ref_qb_id"><option value="">--- Select QB Associated Client ---</option><?php if ($_smarty_tpl->tpl_vars['outputArray']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['outputArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><option <?php if ($_smarty_tpl->tpl_vars['value']->value->Id==$_smarty_tpl->tpl_vars['clientDivisionData']->value['client_qb_ref_qb_id']){?>selected="selected"<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['value']->value->Id;?>
"><?php echo $_smarty_tpl->tpl_vars['value']->value->DisplayName;?>
</option><?php } ?><?php }?></select></div></div><button type="button" class="btn btn-default pull-right margin clientUpdateCancel">Cancel</button><button type="button" class="btn btn-info pull-right margin addClientSave">Done</button></div></div></div><input type="hidden" name="clientQbRefUpdateId" id="clientQbRefUpdateId" class="clientQbRefUpdateId" value="<?php echo $_smarty_tpl->tpl_vars['clientQbRefUpdateId']->value;?>
"></div>

<script>
  $(function () {

    //Date picker
    $('.datepicker').datepicker({
      autoclose: true,
	  format: "mm/dd/yyyy"
    });
	
 $('#client_qb_ref_division_id').chosen({ width:"100%"});
 $('#client_qb_ref_qb_class').chosen({ width:"100%"});
	
  });
</script>
	  <?php }} ?>