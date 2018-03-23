<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:12:24
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_taskManagerKeywordList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:7956473395a959178ecdfe6-33357291%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e673ecffce0bf0dee976cae61679a848dc697297' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_taskManagerKeywordList.tpl',
      1 => 1519124703,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '7956473395a959178ecdfe6-33357291',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'codeLabelData' => 0,
    'taskManagerKeywordList' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959178f1b053_29858777',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959178f1b053_29858777')) {function content_5a959178f1b053_29858777($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Task Manager Keywords </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="taskPageListing" id="taskPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllTask"><th id="client_entity_marsha_codes" style="width:50px !important"><a class="" href="javascript:void(0)" id="client_entity_marsha_code"><?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
</a></th><th id="division_codes"><a class="" href="javascript:void(0)" id="division_code">Division</a></th><th id="serv_type_names" style="width:50px !important"><a class="" href="javascript:void(0)" id="serv_type_name">Service Type</a></th><th id="task_keyword_tires" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_tire">Tier</a></th><th id="task_keyword_no_of_pagess" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_no_of_pages"># Pages</a></th><th id="task_keyword_added_box_dates"><a class="" href="javascript:void(0)" id="task_keyword_added_box_date">Start Date</a></th><th id="task_keyword_link_db_files" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_link_db_file">Source Link</a></th><th id="task_keyword_prioritys"><a class="" href="javascript:void(0)" id="task_keyword_priority">Priority</a></th><th id="task_keyword_setup_due_dates" style="width:50px !important"><a class="" href="javascript:void(0)" id="task_keyword_setup_due_date">Tactic Due</a></th><th style="color:#337ab7;" style="width:50px !important">Complete</a></th><th id="task_keyword_dates"><a class="" href="javascript:void(0)" id="task_keyword_date">Date Complete</a></th><th style="color:#337ab7;" style="width:50px !important">Notes</a></th><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th><th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><th style="color:#337ab7;">Admin Notes</th><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><th style="color:#337ab7;">Admin Review</th><?php }?><th style="color:#337ab7;width:75px !important">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['taskManagerKeywordList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['taskManagerKeywordList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class="<?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_admin_complete']==2){?> statusBgColor <?php }else{ ?> <?php }?>"><td><?php echo $_smarty_tpl->tpl_vars['value']->value['client_entity_marsha_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_tire'];?>
</td><td style="width:50px !important"><?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_no_of_pages'];?>
</td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_keyword_added_box_date'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_link_db_file']){?><a href="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_link_db_file'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_link_db_file'];?>
" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a><?php }?></td><td style="width:50px !important"><?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_priority']==1){?>Yes<?php }else{ ?>No<?php }?></td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_keyword_setup_due_date'],@CALENDAR_DATE_FORMAT);?>
</td><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><td><?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_admin_complete']!=1){?><input type="checkbox" attrIsSubTask="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_is_sub_task'];?>
" attrCode="<?php echo $_smarty_tpl->tpl_vars['value']->value['client_entity_marsha_code'];?>
" attrDivCode="<?php echo $_smarty_tpl->tpl_vars['value']->value['division_code'];?>
" attrUser="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 <?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
" attrServiceTypeName="<?php echo $_smarty_tpl->tpl_vars['value']->value['serv_type_name'];?>
" <?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_setup_complete']==1){?>checked<?php }?> id="completeTask_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_id'];?>
" name="completeTask" class="taskKeywordCompleteAction"/><?php }?></td><?php }else{ ?><td style="width:50px !important"><?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_setup_complete']==1){?>Yes<?php }else{ ?>No<?php }?></td><?php }?><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['task_keyword_date'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_notes'];?>
 </td><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
 </td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
 </td><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><td><?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_admin_notes'];?>
 </td><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN&&$_smarty_tpl->tpl_vars['value']->value['task_keyword_qb_process']==0&&$_smarty_tpl->tpl_vars['value']->value['task_keyword_qb_inv_process']==0){?><td style="width:100px !important"><select style="width:100px !important" class="form-control taskKeywordCompleteAdminAction" currentUserId="<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_user_id'];?>
" id="completeAdminTask_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_id'];?>
" name="taskKeywordCompleteAdminAction" style="width:100px !important;"><option value="">--- Select Review ---</option><option value="1" <?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_admin_complete']==1){?>selected<?php }?>>Complete</option><option value="2" <?php if ($_smarty_tpl->tpl_vars['value']->value['task_keyword_admin_complete']==2){?>selected<?php }?>>Re-Assign</option></select></td><?php }elseif($_SESSION['userRole']==@USER_ROLE_ADMIN){?><td></td><?php }?></td><td><a href="javascript:void(0)" class="taskKeywordUpdateAction p-r-10" id="taskKeywordId_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_id'];?>
" title="Update"><i class="fa fa-pencil"></i></a><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN&&$_smarty_tpl->tpl_vars['value']->value['task_keyword_service_type_id']==@SERVICE_TYPE_KEYWORD_SETUP_ID&&$_smarty_tpl->tpl_vars['value']->value['task_is_sub_task']==0){?><a href="javascript:void(0)" class="taskKeywordClone" id="taskKeywordClone_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_id'];?>
" title="Task Clone"><i class="fa fa-clone"></i></a><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><a href="javascript:void(0)" class="taskKeywordDeleteAction m-l-10" id="taskKeywordId_<?php echo $_smarty_tpl->tpl_vars['value']->value['task_keyword_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a><?php }?></td></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="20" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Task Manager Keywords </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="taskPageListingNew" id="taskPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>