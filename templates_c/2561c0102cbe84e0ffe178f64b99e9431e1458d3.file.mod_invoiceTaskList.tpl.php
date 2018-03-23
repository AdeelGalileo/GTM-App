<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 15:39:36
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_invoiceTaskList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:7181994055a95c20849f532-78843043%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2561c0102cbe84e0ffe178f64b99e9431e1458d3' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_invoiceTaskList.tpl',
      1 => 1519124692,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '7181994055a95c20849f532-78843043',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'codeLabelData' => 0,
    'invoiceTaskList' => 0,
    'value' => 0,
    'grandTotal' => 0,
    'totalVal' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a95c2084d87b2_20740111',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95c2084d87b2_20740111')) {function content_5a95c2084d87b2_20740111($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalInvoiceTask"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Invoices </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="invoicePageListing" id="invoicePageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationInvoiceAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php if ((($_SESSION['userRole']==@USER_ROLE_ADMIN))){?><button type="button" class="btn btn-primary pull-right margin exportSubmittedData"><i class="fa fa-download"></i> Export</button><?php }?><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllInvoice"><th id="invoice_reference_user_fnames"><a class="" href="javascript:void(0)" id="invoice_reference_user_fname">First Name</a></th><th id="invoice_reference_user_lnames"><a class="" href="javascript:void(0)" id="invoice_reference_user_lname">Last Name</a></th><th id="invoice_reference_marsha_codes"><a class="" href="javascript:void(0)" id="invoice_reference_marsha_code"><?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
</a></th><th id="invoice_reference_division_codes"><a class="" href="javascript:void(0)" id="invoice_reference_division_code">Division</a></th><th id="invoice_reference_service_type_names"><a class="" href="javascript:void(0)" id="invoice_reference_service_type_name">Service Type</a></th><th id="invoice_reference_rate_per_units"><a class="" href="javascript:void(0)" id="invoice_reference_rate_per_unit">Rate Per Unit</a></th><th id="invoice_reference_no_of_unitss"><a class="" href="javascript:void(0)" id="invoice_reference_no_of_units">No of Units</a></th><th style="color:#337ab7;">Total</th><th id="invoice_reference_tires"><a class="" href="javascript:void(0)" id="invoice_reference_tire">Box Folder</a></th><th id="invoice_reference_created_ons"><a class="" href="javascript:void(0)" id="invoice_reference_created_on">Invoice Date</a></th><th id="invoice_reference_doc_numbers"><a class="" href="javascript:void(0)" id="invoice_reference_doc_number">QB Id</a></th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['invoiceTaskList']->value){?><?php $_smarty_tpl->tpl_vars['totalVal'] = new Smarty_variable(0, null, 0);?><?php $_smarty_tpl->tpl_vars['grandTotal'] = new Smarty_variable(0, null, 0);?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['invoiceTaskList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_user_fname'];?>
 </td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_user_lname'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_marsha_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_division_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_service_type_name'];?>
</td><td align="right">$<?php echo number_format($_smarty_tpl->tpl_vars['value']->value['invoice_reference_rate_per_unit'],'2');?>
</td><?php $_smarty_tpl->tpl_vars['totalVal'] = new Smarty_variable($_smarty_tpl->tpl_vars['value']->value['invoice_reference_no_of_units']*$_smarty_tpl->tpl_vars['value']->value['invoice_reference_rate_per_unit'], null, 0);?><?php $_smarty_tpl->tpl_vars['grandTotal'] = new Smarty_variable($_smarty_tpl->tpl_vars['grandTotal']->value+$_smarty_tpl->tpl_vars['totalVal']->value, null, 0);?><td align="right"><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_no_of_units'];?>
</td><td align="right">$<?php echo number_format($_smarty_tpl->tpl_vars['totalVal']->value,'2');?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_tire'];?>
</td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['invoice_reference_created_on'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['invoice_reference_doc_number'];?>
</td></tr><?php } ?><tr class=""><td colspan="6"></td><td align="right"><strong>Grand Total</strong></td><td align="right">$<?php echo number_format($_smarty_tpl->tpl_vars['grandTotal']->value,'2');?>
</td><td></td><td></td><td></td></tr><?php }else{ ?><tr class=""><td colspan ="13" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalInvoiceTaskNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Invoices </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="invoicePageListingNew" id="invoicePageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationInvoiceAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div><?php if ((($_SESSION['userRole']==@USER_ROLE_ADMIN))){?><button type="button" class="btn btn-primary pull-right margin exportSubmittedData"><i class="fa fa-download"></i> Export</button><?php }?></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoInvoiceID" value="" name="currPageAutoInvoiceID" /><div class="clear"></div>
<?php }} ?>