<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:13:21
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_skillUpdate.tpl" */ ?>
<?php /*%%SmartyHeaderCode:11919837365a9591b1537d19-54423404%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '561fdd4b71e36ac8c55d746b630443aa67350570' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_skillUpdate.tpl',
      1 => 1519751407,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '11919837365a9591b1537d19-54423404',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'userArray' => 0,
    'consultantSkillData' => 0,
    'value' => 0,
    'serviceTypeArray' => 0,
    'service_type_existing_id' => 0,
    'exVal' => 0,
    'skillUpateId' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a9591b1562af3_38162741',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a9591b1562af3_38162741')) {function content_5a9591b1562af3_38162741($_smarty_tpl) {?><script>
  $(function () {
	  
	<?php if ($_SESSION['sessionClientId']==@MARRIOTT_CLIENT_ID){?>  
	
   
   <?php }?>
   
  });
</script>

<div class="row" ><div class="col-md-12"><div class="box box-primary"><div class="box-body"><div class="row"><div class="form-group col-sm-4"><label >Consultant</label><p><?php if ($_smarty_tpl->tpl_vars['userArray']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['userArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><?php if ($_smarty_tpl->tpl_vars['consultantSkillData']->value['cons_user_id']==$_smarty_tpl->tpl_vars['value']->value['user_id']){?><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
<?php }?><?php } ?><?php }?></p></div><div class="form-group col-sm-6"><label >Skills</label><select class="form-control cons_service_type_id" multiple data-placeholder="Choose a Skills" id="cons_service_type_id"><option value="">--- Select Skills ---</option><?php if ($_smarty_tpl->tpl_vars['serviceTypeArray']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['serviceTypeArray']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><option value="<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_id'];?>
"<?php  $_smarty_tpl->tpl_vars['exVal'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['exVal']->_loop = false;
 $_smarty_tpl->tpl_vars['exKey'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['service_type_existing_id']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['exVal']->key => $_smarty_tpl->tpl_vars['exVal']->value){
$_smarty_tpl->tpl_vars['exVal']->_loop = true;
 $_smarty_tpl->tpl_vars['exKey']->value = $_smarty_tpl->tpl_vars['exVal']->key;
?><?php if ($_smarty_tpl->tpl_vars['exVal']->value==$_smarty_tpl->tpl_vars['value']->value['serv_type_id']){?>selected<?php }?><?php } ?>  ><?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
 </option><?php } ?><?php }?></select></div></div><button type="button" class="btn btn-default pull-right margin skillUpdateCancel">Cancel</button><button type="button" class="btn btn-info pull-right margin addSkillSave">Done</button></div></div></div></div><input type="hidden" name="skillUpateId" id="skillUpateId" class="skillUpateId" value="<?php echo $_smarty_tpl->tpl_vars['skillUpateId']->value;?>
"><input type="hidden" name="cons_user_id" id="cons_user_id" class="cons_user_id" value="<?php echo $_smarty_tpl->tpl_vars['consultantSkillData']->value['cons_user_id'];?>
">

<script>
  $(function () {
	
   $('#cons_service_type_id').chosen({ width:"100%"});
  
  });
</script>
	  <?php }} ?>