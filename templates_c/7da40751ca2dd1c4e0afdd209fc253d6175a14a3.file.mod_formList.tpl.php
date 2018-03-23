<?php /* Smarty version Smarty-3.1.11, created on 2018-03-07 17:20:09
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_formList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2971556405aa06599cbb4e4-54697391%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7da40751ca2dd1c4e0afdd209fc253d6175a14a3' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_formList.tpl',
      1 => 1519124689,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2971556405aa06599cbb4e4-54697391',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'formList' => 0,
    'value' => 0,
    'formFilePath' => 0,
    'form1' => 0,
    'form2' => 0,
    'form3' => 0,
    'form4' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5aa06599cfebc3_97950090',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5aa06599cfebc3_97950090')) {function content_5aa06599cfebc3_97950090($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Forms </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="formPageListing" id="formPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllForm"><th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th><th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th><th id="user_role_names"><a class="" href="javascript:void(0)" id="user_role_name">Role</a></th><th style="color:#337ab7;">W9</a></th><th style="color:#337ab7;">Resume</a></th><th style="color:#337ab7;">ACH Form</a></th><th style="color:#337ab7;">Consultant Agreement</a></th><th id="form_created_ons"><a class="" href="javascript:void(0)" id="form_created_on">Created On</a></th><th style="color:#337ab7;">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['formList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['formList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_name'];?>
</td><td><?php $_smarty_tpl->tpl_vars["form1"] = new Smarty_variable((($_smarty_tpl->tpl_vars['formFilePath']->value).('w9/')).($_smarty_tpl->tpl_vars['value']->value['form_w_nine']), null, 0);?><?php if (file_exists($_smarty_tpl->tpl_vars['form1']->value)&&!empty($_smarty_tpl->tpl_vars['value']->value['form_w_nine'])){?><a href="<?php echo @ROOT_HTTP_PATH;?>
/forms.php?downloadForms=<?php echo $_smarty_tpl->tpl_vars['value']->value['form_w_nine'];?>
&formType=1" class="m-l-10" id="w9_<?php echo $_smarty_tpl->tpl_vars['value']->value['form_id'];?>
" title="W9"><i class="fa fa-download"></i></a><?php }?></td><td><?php $_smarty_tpl->tpl_vars["form2"] = new Smarty_variable((($_smarty_tpl->tpl_vars['formFilePath']->value).('resume/')).($_smarty_tpl->tpl_vars['value']->value['form_resume']), null, 0);?><?php if (file_exists($_smarty_tpl->tpl_vars['form2']->value)&&!empty($_smarty_tpl->tpl_vars['value']->value['form_resume'])){?><a href="<?php echo @ROOT_HTTP_PATH;?>
/forms.php?downloadForms=<?php echo $_smarty_tpl->tpl_vars['value']->value['form_resume'];?>
&formType=2" class="m-l-10" id="res_<?php echo $_smarty_tpl->tpl_vars['value']->value['form_id'];?>
" title="Resume"><i class="fa fa-download"></i></a><?php }?></td><td><?php $_smarty_tpl->tpl_vars["form3"] = new Smarty_variable((($_smarty_tpl->tpl_vars['formFilePath']->value).('achForm/')).($_smarty_tpl->tpl_vars['value']->value['form_ach']), null, 0);?><?php if (file_exists($_smarty_tpl->tpl_vars['form3']->value)&&!empty($_smarty_tpl->tpl_vars['value']->value['form_ach'])){?><a href="<?php echo @ROOT_HTTP_PATH;?>
/forms.php?downloadForms=<?php echo $_smarty_tpl->tpl_vars['value']->value['form_ach'];?>
&formType=3" class="m-l-10" id="ach_<?php echo $_smarty_tpl->tpl_vars['value']->value['form_id'];?>
" title="ACH Form"><i class="fa fa-download"></i></a><?php }?></td><td><?php $_smarty_tpl->tpl_vars["form4"] = new Smarty_variable((($_smarty_tpl->tpl_vars['formFilePath']->value).('agreement/')).($_smarty_tpl->tpl_vars['value']->value['form_consultant_agree']), null, 0);?><?php if (file_exists($_smarty_tpl->tpl_vars['form4']->value)&&!empty($_smarty_tpl->tpl_vars['value']->value['form_consultant_agree'])){?><a href="<?php echo @ROOT_HTTP_PATH;?>
/forms.php?downloadForms=<?php echo $_smarty_tpl->tpl_vars['value']->value['form_consultant_agree'];?>
&formType=4" class="m-l-10" id="agreement_<?php echo $_smarty_tpl->tpl_vars['value']->value['form_id'];?>
" title="Consultant Agreement"><i class="fa fa-download"></i></a><?php }?></td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['form_created_on'],@CALENDAR_DATE_FORMAT);?>
</td><td><a href="javascript:void(0)" class="formUpdateAction m-l-10" attrFormUserId="<?php echo $_smarty_tpl->tpl_vars['value']->value['form_user_id'];?>
" id="formId_<?php echo $_smarty_tpl->tpl_vars['value']->value['form_id'];?>
" title="Update"><i class="fa fa-pencil"></i></a><a href="javascript:void(0)" class="formDeleteAction m-l-10" id="formId_<?php echo $_smarty_tpl->tpl_vars['value']->value['form_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a></td></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="13" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Forms </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="formPageListingNew" id="formPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>