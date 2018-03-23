<table bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" align="center" width="615" style="max-width:615px;margin:0 auto;background:#fff;">
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
										<img   alt="" style="max-width:100%" width="" src="{$smarty.const.ROOT_HTTP_PATH}/dist/img/galileo.png" class=""></p>
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
								Dear {$mailInfo.userFirstNameData} {$mailInfo.userLastNameData}, Welcome to {$smarty.const.NOTIFICATION_NAME}
							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
								You've joined the {$smarty.const.NOTIFICATION_NAME}. Here are your new account email. Use the old password to login.
							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
								User Name : {$mailInfo.userEmailData}
							</p>
							<p style="font-family:Century Gothic, sans-serif; text-align:center;  letter-spacing: 0px; line-height: 1.3; font-size:13px;
							margin:3px;color:#222;">
							<a href="{$smarty.const.ROOT_HTTP_PATH}" target="new">
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
							</table>