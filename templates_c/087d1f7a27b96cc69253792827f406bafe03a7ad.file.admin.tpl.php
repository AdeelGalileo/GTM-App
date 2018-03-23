<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:11:16
         compiled from "/home/galileotechmedia/public_html/app/templates/admin.tpl" */ ?>
<?php /*%%SmartyHeaderCode:14652419915a959134309319-14083708%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '087d1f7a27b96cc69253792827f406bafe03a7ad' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/admin.tpl',
      1 => 1519124468,
      2 => 'file',
    ),
    '41538d9441808e226a518678a3b17c5d1a196a4e' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout.tpl',
      1 => 1519124486,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '14652419915a959134309319-14083708',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'lastPage' => 0,
    'pageLink' => 0,
    'messages' => 0,
    'content' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a95913433f2d4_40329175',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a95913433f2d4_40329175')) {function content_5a95913433f2d4_40329175($_smarty_tpl) {?><!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title><?php echo $_smarty_tpl->tpl_vars['SiteTitle']->value;?>
 - Admin</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><meta name="description" content=""><?php echo $_smarty_tpl->getSubTemplate ("layout/script.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

      
   </head>
  <body class="skin-blue sidebar-mini sidebar-collapse">
<div class="wrapper">
      <?php echo $_smarty_tpl->getSubTemplate ("layout/body_header_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
<?php echo $_smarty_tpl->getSubTemplate ("layout/left_menu.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>
<div class="content-wrapper"><section class="content-header"><h1><?php echo $_smarty_tpl->tpl_vars['lastPage']->value;?>
</h1><ol class="breadcrumb"><li><a href="<?php echo @ROOT_HTTP_PATH;?>
/dashboard.php"><i class="fa fa-dashboard"></i> Home</a></li><?php if ($_smarty_tpl->tpl_vars['pageLink']->value){?><li><?php echo $_smarty_tpl->tpl_vars['pageLink']->value;?>
</li><?php }?><li class="active"><?php echo $_smarty_tpl->tpl_vars['lastPage']->value;?>
</li></ol></section><div id="Messages" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;<?php }?>"><div id="inner_message"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div></div><div id="MessagesAuto" style="<?php if (!$_smarty_tpl->tpl_vars['messages']->value){?>display:none;z-index:99999999;<?php }?>"><div id="inner_Auto" class="text-center"><?php echo $_smarty_tpl->tpl_vars['messages']->value;?>
</div></div><section class="content">
      	<div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/userManager.php">
		  <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-user"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">User Manager</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        
        <!-- /.col -->
		  <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/clients.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-user"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Clients</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		 <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/skills.php">
		  <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-tasks"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Skills</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/forms.php">
		  <div class="info-box bg-aqua">
            <span class="info-box-icon"><i class="fa fa-files-o"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Forms</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		</div>
		
		<hr style="border-top: 1px solid #fff;">
		<div class="row">
      
        <!-- /.col -->
       
        <!-- /.col -->
		
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
         <a href="<?php echo @ROOT_HTTP_PATH;?>
/alerts.php">
		  <div class="info-box bg-red">
            <span class="info-box-icon"><i class="fa fa-bell"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Alerts Setup</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
		  <div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/consultantRate.php">
		  <div class="info-box bg-green">
            <span class="info-box-icon"><i class="fa fa-usd"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Bill Rate Override</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/serviceTypes.php">
		  <div class="info-box bg-green">
            <span class="info-box-icon"><i class="fa fa-cogs"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Service Types</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/qbClientToken.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-wrench"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Quick Book Setup</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
      </div>
	  <hr style="border-top: 1px solid #fff;">
		<div class="row">
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/division.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-list"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Division</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/clientEntity.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-tags"></i></span>

            <div class="info-box-content">
              <span class="info-box-text"><?php echo $_smarty_tpl->tpl_vars['codeLabelData']->value;?>
</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/qbClassReference.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-cog"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Qb Class</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		<div class="col-md-3 col-sm-6 col-xs-12">
          <a href="<?php echo @ROOT_HTTP_PATH;?>
/clientDivision.php">
		  <div class="info-box bg-yellow">
            <span class="info-box-icon"><i class="fa fa-users"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Client Class</span>
            </div>
            <!-- /.info-box-content -->
          </div>
		  </a>
          <!-- /.info-box -->
        </div>
		
		
		
		
	  </div>
	 
</section></div><?php echo $_smarty_tpl->getSubTemplate ("layout/body_footer_content.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	</div>
   </body>
</html><?php }} ?>