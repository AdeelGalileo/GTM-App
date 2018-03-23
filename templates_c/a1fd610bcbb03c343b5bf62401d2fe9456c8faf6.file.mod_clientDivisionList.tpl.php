<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 15:40:06
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_clientDivisionList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1955938855a95c226d8d095-11668724%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a1fd610bcbb03c343b5bf62401d2fe9456c8faf6' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_clientDivisionList.tpl',
      1 => 1519124681,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1955938855a95c226d8d095-11668724',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'clientQbRefList' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a95c226dbd4f2_60941891',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95c226dbd4f2_60941891')) {function content_5a95c226dbd4f2_60941891($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Client Division</span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="clientPageListing" id="clientPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllClient"><th id="division_codes"><a class="" href="javascript:void(0)" id="division_code">Division</a></th><th id="client_qb_ref_qb_ids"><a class="" href="javascript:void(0)" id="client_qb_ref_qb_id">QB Id</a></th><th id="qb_cls_ref_class_names"><a class="" href="javascript:void(0)" id="qb_cls_ref_class_name">QB Class</a></th><th id="client_qb_ref_created_ons"><a class="" href="javascript:void(0)" id="client_qb_ref_created_on">Created On</a></th><th style="color:#337ab7;">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['clientQbRefList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['clientQbRefList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['client_qb_ref_qb_id'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['qb_cls_ref_class_name'];?>
</td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['client_qb_ref_created_on'],@CALENDAR_DATE_FORMAT);?>
</td><td><a href="javascript:void(0)" class="clientUpdateAction m-l-10" id="clientId_<?php echo $_smarty_tpl->tpl_vars['value']->value['client_qb_ref_id'];?>
" title="Update"><i class="fa fa-pencil"></i></a><a href="javascript:void(0)" class="clientDeleteAction m-l-10" id="clientId_<?php echo $_smarty_tpl->tpl_vars['value']->value['client_qb_ref_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a></td></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="6" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Clients Division</span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="clientPageListingNew" id="clientPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>