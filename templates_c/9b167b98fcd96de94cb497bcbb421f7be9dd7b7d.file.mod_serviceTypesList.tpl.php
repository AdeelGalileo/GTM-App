<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:11:21
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_serviceTypesList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:3773780535a9591395dc010-92713027%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9b167b98fcd96de94cb497bcbb421f7be9dd7b7d' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_serviceTypesList.tpl',
      1 => 1519124699,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '3773780535a9591395dc010-92713027',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'serviceTypesList' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a95913960df50_43393391',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95913960df50_43393391')) {function content_5a95913960df50_43393391($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Service Types </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="serviceTypePageListing" id="serviceTypePageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllServiceType"><th id="serv_type_names"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th><th style="color:#337ab7;">Task Type</th><th id="serv_type_gal_rates"><a class="" href="javascript:void(0)" id="serv_type_gal_rate">Invoice Rate</a></th><th id="serv_type_freel_rates"><a class="" href="javascript:void(0)" id="serv_type_freel_rate">Bill Rate</a></th><th id="serv_type_created_ons"><a class="" href="javascript:void(0)" id="serv_type_created_on">Created</a></th><th style="color:#337ab7;">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['serviceTypesList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['serviceTypesList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['serv_type_task_type']==1){?>Task Keyword<?php }elseif($_smarty_tpl->tpl_vars['value']->value['serv_type_task_type']==2){?>Task Content<?php }?></td><td>$<?php echo number_format($_smarty_tpl->tpl_vars['value']->value['serv_type_gal_rate'],'2');?>
</td><td>$<?php echo number_format($_smarty_tpl->tpl_vars['value']->value['serv_type_freel_rate'],'2');?>
</td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['serv_type_created_on'],@CALENDAR_DATE_FORMAT);?>
</td><td><a href="javascript:void(0)" class="serviceTypeUpdateAction" id="serviceTypeId_<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_id'];?>
" title="Update"><i class="fa fa-pencil"></i></a><a href="javascript:void(0)" class="serviceTypeDeleteAction m-l-10" id="serviceTypeId_<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a></td></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="6" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Service Types </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="serviceTypePageListingNew" id="serviceTypePageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>