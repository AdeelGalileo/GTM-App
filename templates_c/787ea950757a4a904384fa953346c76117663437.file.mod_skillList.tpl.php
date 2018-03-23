<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:10:41
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_skillList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:10403148125a959111d5ca93-14103659%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '787ea950757a4a904384fa953346c76117663437' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_skillList.tpl',
      1 => 1519663234,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '10403148125a959111d5ca93-14103659',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'consultantSkillList' => 0,
    'value' => 0,
    'consultantSkillListItems' => 0,
    'valueItem' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959111d6fb75_81773809',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959111d6fb75_81773809')) {function content_5a959111d6fb75_81773809($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Skills </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="skillPageListing" id="skillPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllSkill"><th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th><th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th><th style="color:#337ab7;">Skills</a></th><th id="cons_created_ons"><a class="" href="javascript:void(0)" id="cons_created_on">Created On</a></th><th style="color:#337ab7;">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['consultantSkillList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['consultantSkillList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
</td><td><?php if ($_smarty_tpl->tpl_vars['consultantSkillListItems']->value){?><?php  $_smarty_tpl->tpl_vars['valueItem'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['valueItem']->_loop = false;
 $_smarty_tpl->tpl_vars['keyItem'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['consultantSkillListItems']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['valueItem']->key => $_smarty_tpl->tpl_vars['valueItem']->value){
$_smarty_tpl->tpl_vars['valueItem']->_loop = true;
 $_smarty_tpl->tpl_vars['keyItem']->value = $_smarty_tpl->tpl_vars['valueItem']->key;
?><?php if ($_smarty_tpl->tpl_vars['valueItem']->value['cons_skill_id']==$_smarty_tpl->tpl_vars['value']->value['cons_skill_id']){?><?php echo $_smarty_tpl->tpl_vars['valueItem']->value['service_type'];?>
<?php }?><?php } ?><?php }?></td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['cons_created_on'],@CALENDAR_DATE_FORMAT);?>
</td><td><a href="javascript:void(0)" class="skillUpdateAction m-l-10" id="skillId_<?php echo $_smarty_tpl->tpl_vars['value']->value['cons_skill_id'];?>
" title="Update"><i class="fa fa-pencil"></i></a><a href="javascript:void(0)" class="skillDeleteAction m-l-10" id="skillId_<?php echo $_smarty_tpl->tpl_vars['value']->value['cons_skill_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a></td></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="5" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Skills </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="skillPageListingNew" id="skillPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>