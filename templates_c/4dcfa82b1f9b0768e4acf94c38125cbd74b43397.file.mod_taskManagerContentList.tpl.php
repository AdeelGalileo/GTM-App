<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:53:08
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_taskManagerContentList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:13777409995a959b0411a219-79786277%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4dcfa82b1f9b0768e4acf94c38125cbd74b43397' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_taskManagerContentList.tpl',
      1 => 1519124702,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '13777409995a959b0411a219-79786277',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'codeLabelData' => 0,
    'taskManagerContentList' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959b04164c70_90570919',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959b04164c70_90570919')) {function content_5a959b04164c70_90570919($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Task Manager Content </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="taskPageListing" id="taskPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllTask"><th id="client_entity_marsha_codes"><a class="" href="javascript:void(0)" id="client_entity_marsha_code"><?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
</a></th><th id="division_codes"><a class="" href="javascript:void(0)" id="division_code">Division</a></th><th id="serv_type_names"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th><th id="task_content_tires"><a class="" href="javascript:void(0)" id="task_content_tire">TIER</a></th><th id="task_content_no_of_unitss"><a class="" href="javascript:void(0)" id="task_content_no_of_units"># Pages</a></th><th id="task_content_added_box_dates"><a class="" href="javascript:void(0)" id="task_content_added_box_date">Start Date</a></th><th id="task_content_link_to_files"><a class="" href="javascript:void(0)" id="task_content_link_to_file">Source Link</a></th><th id="task_content_prioritys"><a class="" href="javascript:void(0)" id="task_content_priority">Priority</a></th><th id="task_content_due_dates"><a class="" href="javascript:void(0)" id="task_content_due_date">Tactic Due</a></th><th style="color:#337ab7;">Completed</a></th><th id="task_content_proj_com_dates"><a class="" href="javascript:void(0)" id="task_content_proj_com_date">Date Completed</a></th><th id="task_content_upload_links"><a class="" href="javascript:void(0)" id="task_content_upload_link">Upload Link</a></th><th id="task_content_rev_reqs"><a class="" href="javascript:void(0)" id="task_content_rev_req">Date Revision Requested</a></th><th id="task_content_rev_coms"><a class="" href="javascript:void(0)" id="task_content_rev_com">1st Revision Complete</a></th><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th><th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><th style="color:#337ab7;">Admin Notes</th><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><th style="color:#337ab7;">Admin Review</th><?php }?><th style="color:#337ab7;">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['taskManagerContentList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['taskManagerContentList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class="<?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_admin_complete']==2){?> statusBgColor <?php }else{ ?> <?php }?>"><td><?php echo $_smarty_tpl->tpl_vars['value']->value['client_entity_marsha_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_tire'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_no_of_units'];?>
</td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_content_added_box_date'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_link_to_file']){?><a href="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_link_to_file'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_link_to_file'];?>
" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a><?php }?></td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_priority']==1){?>Yes<?php }else{ ?>No<?php }?></td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_content_due_date'],@CALENDAR_DATE_FORMAT);?>
</td><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_admin_complete']!=1){?><input type="checkbox" attrCode="<?php echo $_smarty_tpl->tpl_vars['value']->value['client_entity_marsha_code'];?>
" attrDivCode="<?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
" attrUser="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
" attrServiceTypeName="<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
" <?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_is_complete']==1){?>checked<?php }?> id="completeTask_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_id'];?>
" name="completeTask" class="taskContentCompleteAction"/><?php }?></td><?php }else{ ?><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_is_complete']==1){?>Yes<?php }else{ ?>No<?php }?></td><?php }?><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_content_proj_com_date'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_upload_link']){?><a href="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_upload_link'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_upload_link'];?>
" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a><?php }?></td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_content_rev_req'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_rev_com']==1){?>Yes<?php }else{ ?>No<?php }?></td><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 </td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
 </td><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><td><?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_admin_notes'];?>
 </td><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN&&$_smarty_tpl->tpl_vars['value']->value['task_content_qb_process']==0&&$_smarty_tpl->tpl_vars['value']->value['task_content_qb_inv_process']==0){?><td style="width:150px !important"><select style="width:100px !important" class="form-control taskContentCompleteAdminAction" currentServiceTypeId="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_service_type_id'];?>
" currentUserId="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_user_id'];?>
" id="completeAdminTask_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_id'];?>
" name="taskContentCompleteAdminAction"><option value="">--- Select Review ---</option><option value="1" <?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_admin_complete']==1){?>selected<?php }?>>Complete</option><option value="2" <?php if ($_smarty_tpl->tpl_vars['value']->value['task_content_admin_complete']==2){?>selected<?php }?>>Re-Assign</option></select></td><?php }elseif($_SESSION['userRole']==@USER_ROLE_ADMIN){?><td></td><?php }?><td><a href="javascript:void(0)" class="taskContentUpdateAction m-l-10" id="taskContentId_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_id'];?>
" title="Update"><i class="fa fa-pencil"></i></a><a href="javascript:void(0)" class="taskContentDeleteAction m-l-10" id="taskContentId_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_content_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a></td></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="20" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Task Manager Content </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="taskPageListingNew" id="taskPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>