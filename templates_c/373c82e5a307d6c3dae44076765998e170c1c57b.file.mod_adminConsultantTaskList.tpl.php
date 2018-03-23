<?php /* Smarty version Smarty-3.1.11, created on 2018-02-28 11:59:56
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_adminConsultantTaskList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:18516613975a96e00d001fb0-47401877%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '373c82e5a307d6c3dae44076765998e170c1c57b' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_adminConsultantTaskList.tpl',
      1 => 1519124679,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18516613975a96e00d001fb0-47401877',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'currentTabActive' => 0,
    'params' => 0,
    'codeLabelData' => 0,
    'taskList' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a96e00d050719_56576260',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a96e00d050719_56576260')) {function content_5a96e00d050719_56576260($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_date_format')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.date_format.php';
?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Tasks </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="taskPageListing" id="taskPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php if ((($_SESSION['userRole']==@USER_ROLE_ADMIN)&&($_smarty_tpl->tpl_vars['currentTabActive']->value=='tabId_1'))){?><button type="button" class="btn btn-primary pull-right margin moveToQb"><i class="fa fa-share"></i> Move to QB</button><div class="moveMultipleQb pull-right margin" <?php if ((($_smarty_tpl->tpl_vars['params']->value['taskKeyFilterBy']==3)&&($_smarty_tpl->tpl_vars['params']->value['writerId']>1))){?> style="display:block;" <?php }else{ ?> style="display:none;"  <?php }?> > <input type="checkbox" id="ckbCheckAll" class="ckbCheckAll"/>&nbsp;Select All</div><?php }?><?php }?></div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllTask"><th id="marshaCodes"><a class="" href="javascript:void(0)" id="marshaCode"><?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
</a></th><th id="divisionCodes"><a class="" href="javascript:void(0)" id="divisionCode">Division</a></th><th id="servTypeNames"><a class="" href="javascript:void(0)" id="servTypeName">Service Type</a></th><th id="TaskTypeVals"><a class="" href="javascript:void(0)" id="TaskTypeVal">Task Type</a></th><th id="tires"><a class="" href="javascript:void(0)" id="tire">Tier</a></th><th style="color:#337ab7;">Link to File</a></th><th id="dateAddedToBoxs"><a class="" href="javascript:void(0)" id="dateAddedToBox">Date added to box</a></th><th id="contentDues"><a class="" href="javascript:void(0)" id="contentDue">Task Due Date</a></th><th id="prioritys"><a class="" href="javascript:void(0)" id="priority">Priority</a></th><th id="userNames"><a class="" href="javascript:void(0)" id="userName">First Name</a></th><th id="userLNames"><a class="" href="javascript:void(0)" id="userLName">Last Name</a></th><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><th id="isCompleteds"><a class="" href="javascript:void(0)" id="isCompleted">Completed</a></th><?php }else{ ?><th id="isCompleteds"><a class="" href="javascript:void(0)" id="isCompleted">Completed</a></th><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><th style="color:#337ab7;" >Admin Notes</th><?php }?><?php if ((($_SESSION['userRole']==@USER_ROLE_ADMIN)&&($_smarty_tpl->tpl_vars['currentTabActive']->value=='tabId_1'))){?><th style="color:#337ab7;" class="adminReviewCls">Admin Review</th><th style="color:#337ab7;" class="moveToCls">Move to Qb</th><?php }?></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['taskList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['taskList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['marshaCode'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['divisionCode'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['servTypeName'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['TaskTypeVal'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['tire'];?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['linkToFile']){?><a href="<?php echo $_smarty_tpl->tpl_vars['value']->value['linkToFile'];?>
" title="<?php echo $_smarty_tpl->tpl_vars['value']->value['linkToFile'];?>
" target="_blank"><i class="fa fa-link" aria-hidden="true"></i></a><?php }?></td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['dateAddedToBox'],@CALENDAR_DATE_FORMAT);?>
</td><td><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['value']->value['contentDue'],@CALENDAR_DATE_FORMAT);?>
</td><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><td><input type="checkbox" <?php if ($_smarty_tpl->tpl_vars['value']->value['priority']==1){?>checked<?php }?> taskType="<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
" id="changePriority_<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
_<?php echo $_smarty_tpl->tpl_vars['value']->value['taskId'];?>
" name="changePriority" class="changePriority"/></td><?php }else{ ?><td><?php if ($_smarty_tpl->tpl_vars['value']->value['priority']==1){?>Yes<?php }else{ ?>No<?php }?></td><?php }?><td><?php echo $_smarty_tpl->tpl_vars['value']->value['userName'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['userLName'];?>
</td><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><td><input type="checkbox" <?php if ($_smarty_tpl->tpl_vars['value']->value['isCompleted']==1){?>checked<?php }?> taskType="<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
" id="completeTask_<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
_<?php echo $_smarty_tpl->tpl_vars['value']->value['taskId'];?>
" name="completeTask" class="taskCompleteAction"/></td><?php }else{ ?><td><?php if ($_smarty_tpl->tpl_vars['value']->value['isCompleted']==1){?>Yes<?php }else{ ?>No<?php }?></td><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><td><?php echo $_smarty_tpl->tpl_vars['value']->value['adminNotes'];?>
 </td><?php }?><?php if ((($_SESSION['userRole']==@USER_ROLE_ADMIN)&&($_smarty_tpl->tpl_vars['currentTabActive']->value=='tabId_1'))){?><td style="width:200px !important" class="adminSelectTaskCls"><?php if ($_smarty_tpl->tpl_vars['value']->value['isQbProcess']==0){?><select class="form-control taskCompleteAdminAction" taskType="<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
" id="completeAdminTask_<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
_<?php echo $_smarty_tpl->tpl_vars['value']->value['taskId'];?>
" name="taskCompleteAdminAction"><option value="">--- Select Review ---</option><option value="1" <?php if ($_smarty_tpl->tpl_vars['value']->value['adminComplete']==1){?>selected<?php }?>>Complete</option><option value="2" <?php if ($_smarty_tpl->tpl_vars['value']->value['adminComplete']==2){?>selected<?php }?>>Re-Assign</option></select><?php }else{ ?>Submitted<?php }?></td><?php if ($_smarty_tpl->tpl_vars['value']->value['adminComplete']==1&&$_smarty_tpl->tpl_vars['value']->value['isQbProcess']==0){?><td><input type="checkbox" consultantId="<?php echo $_smarty_tpl->tpl_vars['value']->value['user_id'];?>
"  taskType="<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
" id="qbTransfer_<?php echo $_smarty_tpl->tpl_vars['value']->value['TaskType'];?>
_<?php echo $_smarty_tpl->tpl_vars['value']->value['taskId'];?>
_<?php echo $_smarty_tpl->tpl_vars['value']->value['unitNo'];?>
" name="qbTransfer" class="chkqbTransfer qbTransfer"/></td><?php }elseif($_smarty_tpl->tpl_vars['value']->value['adminComplete']==1&&$_smarty_tpl->tpl_vars['value']->value['isQbProcess']==1){?><td>Moved</td><?php }else{ ?><td></td><?php }?><?php }?></tr><?php } ?><?php }else{ ?><tr class=""><td colspan ="12" class="noRecords"><?php echo @LBL_NO_RECORDS;?>
</td></tr><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Tasks </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="taskPageListingNew" id="taskPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div><?php if ((($_SESSION['userRole']==@USER_ROLE_ADMIN)&&($_smarty_tpl->tpl_vars['currentTabActive']->value=='tabId_1'))){?><button type="button" class="btn btn-primary pull-right margin moveToQb"><i class="fa fa-share"></i> Move to QB</button><?php }?></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>