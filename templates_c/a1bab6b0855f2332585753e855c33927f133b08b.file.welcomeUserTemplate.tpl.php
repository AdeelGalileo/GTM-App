<?php /* Smarty version Smarty-3.1.11, created on 2018-02-27 12:51:14
         compiled from "/home/galileotechmedia/public_html/app/templates/welcomeUserTemplate.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1336333215a959a92ac6e48-28791138%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a1bab6b0855f2332585753e855c33927f133b08b' => 
    array (
      0 => '/home/galileotechmedia/public_html/app/templates/welcomeUserTemplate.tpl',
      1 => 1519124506,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1336333215a959a92ac6e48-28791138',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'mailInfo' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_5a959a92ae88a1_52792863',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5a959a92ae88a1_52792863')) {function content_5a959a92ae88a1_52792863($_smarty_tpl) {?><table bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" align="center" width="615" style="max-width:615px;margin:0 auto;background:#fff;">
<tbody>
<tr>
<td width="100%" style="width:100%">
<!-- Header -->
	<table class="cpcontrol" border="0" cellpadding="0" cellspacing="0" style="width: 100%; background:#fafafa; background-color:#fafafa;" width="100%" data-background-color="#fafafa" bgcolor="#fafafa;">
        <tbody><tr>
            <td valign="top" style="padding-top:20px;padding-bottom:0px;">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="code" style="width: 100%">
                    <tbody>
					<tr>
					<td valign="top">
							<table align="center" width="600" border="0" cellpadding="0" cellspacing="0" style="width: 600px;">
							<tbody>
							<tr>
                            <td valign="top" style="vertical-align: top;padding-top:0; padding-right:18px; padding-bottom:9px; padding-left:18px;">
                                <div class="ceditable">
									<p style="text-align: center;margin:0px !important;">
										<img   alt="" style="max-width:100%" width="" src="<?php echo @ROOT_HTTP_PATH;?>
/dist/img/galileo.png" class=""></p>
								</div>
                            </td>
							</tr>
							</tbody>
							</table>
				   </td> 
				   </tr>
                    </tbody>
					</table>
                <div class="cp-controls" style="display: block;">
                    <i class="fa fa-arrows cp-handel"></i><i class="fa fa-plus cp-copy"></i><i class="fa fa-wrench  cp-settings">
                    </i><i class="fa fa-times cp-delete"></i>
                </div>
            </td>
        </tr>
    </tbody></table>

	<!-- PAragraph -->
	

<table class="cpcontrol" border="0" cellpadding="0" cellspacing="0" style="width:100%;background-color:#fafafa" width="100%" bgcolor="#fafafa">
        <tbody><tr>
            <td valign="top" style="padding:9px">
                <table class="code" align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="width:100%">
                    <tbody>
					<tr>
                        <td valign="top" align="center" width="100%" style="width:100%;padding-right: 9px; padding-left: 9px; padding-top: 0; padding-bottom: 0;">
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
								Dear <?php echo $_smarty_tpl->tpl_vars['mailInfo']->value['userFirstNameData'];?>
 <?php echo $_smarty_tpl->tpl_vars['mailInfo']->value['userLastNameData'];?>
, Welcome to <?php echo @NOTIFICATION_NAME;?>

							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
								You've joined the <?php echo @NOTIFICATION_NAME;?>
. Here are your account details
							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
								User Name : <?php echo $_smarty_tpl->tpl_vars['mailInfo']->value['userEmailData'];?>

							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
								Password : <?php echo $_smarty_tpl->tpl_vars['mailInfo']->value['userPasswordData'];?>

							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
							<a href="<?php echo @ROOT_HTTP_PATH;?>
" target="new">
								Sign In
							</a>
							</p>
                        </td>
                    </tr>
                </tbody>
				</table>
                  <div class="cp-controls" style="display: block;">
                            <i class="fa fa-arrows cp-handel"></i><i class="fa fa-plus cp-copy"></i><i class="fa fa-wrench  cp-settings">
                            </i><i class="fa fa-times cp-delete"></i>
                        </div>
            </td>
        </tr>  
  

    </tbody></table>
  

</td>
							</tr>
							</tbody>
							</table><?php }} ?>