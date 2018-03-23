<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:46:48
         compiled from "/home/galileotechmedia/public_html/app/templates/module/mod_userList.tpl" */ ?>
<?php /*%%SmartyHeaderCode:16634522215a959988179461-64962726%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6e35fed9a395a8f7b890fcc0f9c9d9177ed27fb2' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/module/mod_userList.tpl',
      1 => 1519124705,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '16634522215a959988179461-64962726',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'totalRecords' => 0,
    'recCountOptions' => 0,
    'userList' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a9599881a95e2_74468374',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a9599881a95e2_74468374')) {function content_5a9599881a95e2_74468374($_smarty_tpl) {?><div class="row-fluid"><div class="p-t-15 p-b-15"> <?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomation"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?> <?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
 <?php }?></span> Users </span><div class="pull-left m-r-10"> <span class="inBlock pull-left p-r-10 p-t-10 p-l-10">Displaying</span><select name="userPageListing" id="userPageListing" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAuto"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span></div></div><?php }?> </div><div class="clear P10"></div></div><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="clear">&nbsp;</div><?php }?><table class="table table-bordered table-striped"><thead><tr class="bg-blueL" id="overAllUser"><th id="user_fnames"><a class="" href="javascript:void(0)" id="user_fname">First Name</a></th><th id="user_lnames"><a class="" href="javascript:void(0)" id="user_lname">Last Name</a></th><th id="user_emails"><a class="" href="javascript:void(0)" id="user_email">Email</a></th><th id="user_form_completeds"><a class="" href="javascript:void(0)" id="user_form_completed">Forms Completed</a></th><th id="user_role_names"><a class=""  href="javascript:void(0)" id="user_role_name">Role</a></th><th style="color:#337ab7;">Action</th></tr></thead><tbody><?php if ($_smarty_tpl->tpl_vars['userList']->value){?><?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['userList']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?><tr class=""><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_fname'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_lname'];?>
</td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_email'];?>
</td><td><?php if ($_smarty_tpl->tpl_vars['value']->value['user_form_completed']==1){?>Yes<?php }else{ ?>No<?php }?></td><td><?php echo $_smarty_tpl->tpl_vars['value']->value['user_role_name'];?>
</td><td><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><a href="<?php echo @ROOT_HTTP_PATH;?>
/adminPersonnel.php?userUpdateId=<?php echo $_smarty_tpl->tpl_vars['value']->value['user_id'];?>
" title="Update User"><i class="fa fa-pencil"></i></a><a href="javascript:void(0)" class="userDeleteAction m-l-10" id="userDeleteId_<?php echo $_smarty_tpl->tpl_vars['value']->value['user_id'];?>
" title="Delete"><i class="fa fa-trash"></i></a><?php }?></td></tr><?php } ?><?php }?></tbody></table><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value>0){?><div class="row-fluid"><div class="col-sm-12 P0"> <span class="blue bold p-t-10 pull-left" style="margin-right:5px; font-size: 15px;"> <span id="totalAutomationNew"><?php if ($_smarty_tpl->tpl_vars['totalRecords']->value==''){?>0<?php }else{ ?><?php echo $_smarty_tpl->tpl_vars['totalRecords']->value;?>
<?php }?></span> Users </span><div class="pull-left m-r-10"> <span class="inBlock p-r-10 p-t-10 p-l-10 pull-left">Displaying</span><select name="userPageListingNew" id="userPageListingNew" class="form-control P5 pull-left" style="width:60px !important;"><?php echo $_smarty_tpl->tpl_vars['recCountOptions']->value;?>
</select></div><div class="pull-left m-r-10"><div class="pull-left p-r-10 p-t-10">On Page</div><div class="grayBg box-rounded inBlock"> <span id="paginationAutoNew"><?php echo $_smarty_tpl->getSubTemplate ("paginationNew.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
</span> </div></div></div><div class="clear"></div></div><?php }?><input type="hidden" id="currPageAutoID" value="" name="currPageAutoID" /><div class="clear"></div>
<?php }} ?>