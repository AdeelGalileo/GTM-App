<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:10:41
         compiled from "/home/galileotechmedia/public_html/app/templates/layout/body_header_content.tpl" */ ?>
<?php /*%%SmartyHeaderCode:18786821355a9591111f9133-59978729%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '3e9428fe5b87f814747bb8a49f6d57e79f884f5c' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/layout/body_header_content.tpl',
      1 => 1519124674,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18786821355a9591111f9133-59978729',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'clientData' => 0,
    'value' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a9591111ff1c6_03284009',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a9591111ff1c6_03284009')) {function content_5a9591111ff1c6_03284009($_smarty_tpl) {?>   <script type="text/javascript">
   $(document).ready(function(){
	   $('#sessionClientId').chosen({ width:"100%"});
	   $('body').on('change', '.sessionClientId', function(){
		var sessionClientId = $( this ).val();
		var sessionClientName = $('option:selected', this).attr('attrClientName');
		if(sessionClientId==''){
				return false;
		 }
		 $.ajax({
				url: 'ajax/client.php?rand='+Math.random(),
				dataType: 'json',
				 data: { createClientSession:1, sessionDataClientId: sessionClientId, sessionClientName: sessionClientName },
				 success: function(response) {
						checkResponseRedirect(response);
						showMessage(response.message);
						location.reload();
				}	
		   });
	   });
	   
	   getAlertNotificationCount();
	   
	   setInterval(function(){ getAlertNotificationCount(); }, 10000);
	   
	   
   });
   
   
   function getAlertNotificationCount(){
	  
      $.ajax({
          url: 'getModuleInfo.php?rand='+Math.random(),
          type:'post',
          dataType: 'json',
          data : { module: 'alertNotificationCount' },
          success: function(response) {
              checkResponseRedirect(response);
				$('.alertNotificationCount').html("");
				$('.alertNotificationCount').html(response.message.content);
          }
      });	 
   }	
   
   </script> 
  <header class="main-header">
    <!-- Logo -->
    <a href="javascript:void(0);" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini text-black">GTM</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><img src="dist/img/galileo.png" width="113"/></span>
    </a>
   
	
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
	
		 
      <!-- Sidebar toggle button-->
       <div class="col-sm-1">
	   <a href="javascript:void(0);" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
	  </div>
	   <div class="col-sm-3 m-t-10">
			
				<select class="form-control sessionClientId" id="sessionClientId">
					 
					 <?php if ($_smarty_tpl->tpl_vars['clientData']->value){?>
						 <?php  $_smarty_tpl->tpl_vars['value'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['value']->_loop = false;
 $_smarty_tpl->tpl_vars['key'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['clientData']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['value']->key => $_smarty_tpl->tpl_vars['value']->value){
$_smarty_tpl->tpl_vars['value']->_loop = true;
 $_smarty_tpl->tpl_vars['key']->value = $_smarty_tpl->tpl_vars['value']->key;
?>
							<option attrClientName="<?php echo $_smarty_tpl->tpl_vars['value']->value['client_name'];?>
" value="<?php echo $_smarty_tpl->tpl_vars['value']->value['client_id'];?>
" <?php if ($_SESSION['sessionClientId']==$_smarty_tpl->tpl_vars['value']->value['client_id']){?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['value']->value['client_name'];?>
</option>
						 <?php } ?>
					 <?php }?>
				</select>
		    
		 </div>
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="<?php echo @ROOT_HTTP_PATH;?>
/alertNotifications.php">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning"><div class="alertNotificationCount">0</div></span>
            </a>
          </li>
		  <li class="dropdown tasks-menu">
            <a href="<?php echo @ROOT_HTTP_PATH;?>
/logout.php" class="dropdown-toggle" >
              <i class="fa fa-power-off"></i> &nbsp;Sign out
            </a>
            
          </li>
         
        </ul>
      </div>
    </nav>
  </header><?php }} ?>