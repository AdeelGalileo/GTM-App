<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:10:41
         compiled from "/home/galileotechmedia/public_html/app/templates/layout/left_menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:3468109205a959111200056-83076961%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4b331a926124c5251ce937602732ed2cf611b54f' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout/left_menu.tpl',
      1 => 1519146596,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '3468109205a959111200056-83076961',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a95911120ca94_53065825',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95911120ca94_53065825')) {function content_5a95911120ca94_53065825($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_truncate')) include '/home/galileotechmedia/public_html/app/includes/smarty/plugins/modifier.truncate.php';
?><!-- Left side column. contains the logo and sidebar --><aside class="main-sidebar"><!-- sidebar: style can be found in sidebar.less --><section class="sidebar"><!-- Sidebar user panel --><div class="user-panel"><div class="pull-left image"><img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image"></div><div class="pull-left info"><p title="<?php echo $_SESSION['userName'];?>
"><?php echo smarty_modifier_truncate($_SESSION['userName'],"15");?>
</p></div></div><!-- search form --><!--<form action="#" method="get" class="sidebar-form"><div class="input-group"><input type="text" name="q" class="form-control" placeholder="Search..."><span class="input-group-btn"><button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button></span></div></form>--><!-- /.search form --><!-- sidebar menu: : style can be found in sidebar.less --><ul class="sidebar-menu" data-widget="tree"><!--<li class="header">MAIN NAVIGATION</li>--><li class="active"><a href="<?php echo @ROOT_HTTP_PATH;?>
/dashboard.php"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN||$_SESSION['userRole']==@USER_ROLE_PROJECT_MANAGER){?><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/importWizard.php"><i class="fa fa-files-o"></i> <span>Import Wizard</span></a></li><?php }?><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/taskManagerKeyword.php"><i class="fa fa-file-text-o"></i> <span>Task Manager Keyword <br>Research</span></a></li><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/taskManagerContent.php"><i class="fa fa-file-text"></i> <span>Task Manager Content</span></a></li><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/adminConsultant.php"><i class="fa fa-commenting"></i> <span>Task Review & Billing</span></a></li><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/admin.php"><i class="fa fa-users"></i> <span>Admin</span></a></li><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_CONSULTANT){?><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/adminConsultant.php"><i class="fa fa-commenting"></i> <span>Task Review & Billing</span></a></li><?php }?><?php if ($_SESSION['userRole']==@USER_ROLE_ADMIN){?><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/invoice.php"><i class="fa fa-newspaper-o"></i> <span>Invoice</span></a></li><?php }?></ul></section><!-- /.sidebar --></aside><?php }} ?>