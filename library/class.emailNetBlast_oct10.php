<?php
class emailNetBlast{
	
	public function addEmailBlast($record)
	{
		require_once(SMARTY_PATH.DS.'Smarty.class.php');
		$smarty =  new Smarty();
		$smarty->template_dir = TEMPLATE_PATH.DS;
		$smarty->compile_dir  = SITE_PATH.DS.'templates_c'.DS;
		
		if(defined('get_magic_quotes_gpc')) {
			if (get_magic_quotes_gpc()) {
				$record = array_map('stripslashes', $record);
			}
		}
		
		$blastDate = $record['is_schedule'] ? $record['scheduleTime'] : $record['created_on'];
		$blastSchedule = $record['is_schedule'] ? 1 : 0;
		$message = $record['blast_message'];
		//$message = iconv("UTF-8", "ISO-8859-1//IGNORE", $message);
		$exCount = $record['exclude_count'] ? $record['exclude_count'] : 0;
		$privacyObj = getObject('privacyPolicy');
		$timeZoneObj = getObject('timeZone');
		$clientTimeZone = $timeZoneObj->dynamicallyChangeZone($record['clientId']);
		$privacyDetail = $privacyObj->getPrivacys($record['clientId']);
		/*Get Send grid keys */
		$vendorObj = getObject('emailVendor');
		$vendorInfo = $vendorObj->getEmailVendorInfo($record['clientId']);
		
		if($record['event_id']){
			$eventObj = getObject('eventsLead');
                        $clientLogoObj = getObject('clientLogo');
                        $socialUrlInfo = $clientLogoObj->getClientLogo($record['clientId']);
                        
			$eventDetail = $eventObj->getEventForEmailTemplate($record['event_id'], $record['clientId']);
			$startDate = date('M d,Y', strtotime($eventDetail['evnt_StartDate'])).' at '.date('g:i A', strtotime($eventDetail['evnt_StartDate']));
			$endDate = date('M d,Y', strtotime($eventDetail['evnt_EndDate'])).' at '.date('g:i A', strtotime($eventDetail['evnt_EndDate']));
			
			$location = $eventDetail['evnt_Name'].', '.$eventDetail['evnt_Address1'].', '.$eventDetail['evnt_City'].', '.$eventDetail['evnt_State'].', '.$eventDetail['evnt_State'].', '.$eventDetail['evnt_Zip'].', '.$eventDetail['evnt_Country'];
			
			
             $smarty->assign('socialUrlInfo', $socialUrlInfo);
                        
			if($eventDetail['evnt_TypeIs']==1) {
			$smarty->assign('organizerName', $record['blast_from']);
				$smarty->assign('organizerEmail', $record['blast_email_from']);
				$smarty->assign('eventDetail', $eventDetail);	
				$smarty->assign('blastMessage', $record['blast_message']);	
				$tmpPrivacyContent = $smarty->fetch('webinarEvent.tpl');
				$registerNow = '<a href="https://attendee.gotowebinar.com/register/'.$eventDetail['evnt_webinarKey'].'" target="_blank">Register</a>';
			} elseif($eventDetail['evnt_TypeIs']==2){
				$smarty->assign('organizerName', $record['blast_from']);
				$smarty->assign('organizerEmail', $record['blast_email_from']);
				$smarty->assign('eventDetail', $eventDetail);	
				$smarty->assign('blastMessage', $record['blast_message']);
                if($eventDetail['evnt_timeZone_id']>0){
					$smarty->assign('clientTimeZone', $eventDetail['abbreviation']);
				}
				else{
					$smarty->assign('clientTimeZone', $clientTimeZone['abbreviation']);
				}
				$tmpPrivacyContent = $smarty->fetch('manualEvent.tpl');
				
          $registerNow = '<a href="https://love.officeinteractive.com/eventAccept.php?eventLinkId=[Email]&mailId=[clientId]&contactId={LeadID}&blastId='.base64_encode($record['blast_id']).'" style="padding-right:40px;">Accept</a>
        <a href="https://love.officeinteractive.com/eventAccept.php?eventLinkId=[Email]&mailId=[clientId]&contactId={LeadID}&blastId='.base64_encode($record['blast_id']).'" style="margin-right:40px;">Maybe</a>
          <a href="https://love.officeinteractive.com/eventAccept.php?eventLinkId=[Email]&mailId=[clientId]&contactId={LeadID}&blastId='.base64_encode($record['blast_id']).'">Decline</a>';
			} 
		$templateFinal = str_replace('{RegisterLink}', $registerNow, $tmpPrivacyContent);
		
		$privacyContent = '<table border="0" align="center" cellpadding="0" cellspacing="0" style="max-width:615px;width:100%;color:#666666;font-size: 10pt;font-family: Arial,sans-serif;">
							  <tr>
								<td style="color:#666666;font-size: 10pt;font-family:Arial,sans-serif; text-align:center;">
								  <p style="margin:0px"><br></p>
								  We respect your privacy. Please read our online <a href="'.$privacyDetail['privacy_URL'].'" target="blank">Privacy Statement</a>.<br>
								  If you would like to unsubscribe, please <a href="https://love.officeinteractive.com/mandrillSubscribtion.php?unSubScribeId=[Email]&mailId=[clientId]&blastId='.base64_encode($record['blast_id']).'"> Click Here</a></td>
							  </tr>
							  <tr>
								<td style="color:#666666;font-size: 10pt;font-family:Arial,sans-serif;">'.$privacyDetail['privacy_textarea'].'</td>
							  </tr>
							</table>';

} else {	
        if($record['view_online']==1){
                $browserView = '<p style="font-size:10px; text-align:center; font-family:Arial,Verdana;"><br/>Having trouble viewing this email? <a href="https://love.officeinteractive.com/onlineView.php?viewerId=[clientId]&viewerIs={LeadID}&contentIs='.base64_encode($record['blast_id']).'&viewerTitle='.base64_encode($record['blast_subject']).'">View online</a></p>';
        }else{
				$browserView = '<p style="font-size:7px;line-height:1; text-align:center; font-family:Arial,Verdana;">&nbsp;</p>';
		}

                $privacyContent = '<table border="0" align="center" cellpadding="0" cellspacing="0" style="max-width:615px;width:100%;color:#666666;font-size: 10pt;font-family: Arial,sans-serif;">
							  <tr>
								<td style="color:#666666;font-size: 10pt;font-family: Arial,sans-serif; text-align:center;">
								  <p style="margin:0px"><br></p>
								  We respect your privacy. Please read our online <a href="'.$privacyDetail['privacy_URL'].'" target="blank">Privacy Statement</a>.<br>
								  If you would like to unsubscribe, please <a href="https://love.officeinteractive.com/mandrillSubscribtion.php?unSubScribeId=[Email]&mailId=[clientId]&blastId='.base64_encode($record['blast_id']).'"> Click Here</a>
								  <a href="javascript:void(0);" style="display:none;"><img src=""https://love.officeinteractive.com/images/placeholder.png?viewerId=[clientId]&viewerIs={LeadID}"></a>
</td>
							  </tr>
							  <tr>
								<td style="color:#666666;font-size: 10pt;font-family:Arial,sans-serif;">'.$privacyDetail['privacy_textarea'].'</td>
							  </tr>
							</table>';
	}
	
		$message = str_replace('{AccountLogo}', '<img src="{AccountLogo}" />', $message);
		$message = str_replace('{RegisterLink}', '', $message);
		$message = str_replace('{C}', '', $message);
		$message = str_replace('{}', '', $message);

		if($record['event_id']){
			//$templateFinal = htmlentities(mb_convert_encoding($templateFinal,"UTF-8"));
			$templateFinal = htmlentities($templateFinal);
		} else {
			$templateFinal = $message;
			//$templateFinal = htmlentities(mb_convert_encoding($templateFinal,"UTF-8"));
			$templateFinal = htmlentities($templateFinal);
		}
		
		//$browserView = 	htmlentities(mb_convert_encoding($browserView,"UTF-8"));
		$browserView = 	htmlentities($browserView);
		
		if($record['disable_privacy']==1){
			$privacyContent = "";
		}
		else{
			//$privacyContent = 	htmlentities(mb_convert_encoding($privacyContent,"UTF-8"));
			$privacyContent = 	htmlentities($privacyContent);
		}
		//$blastCustomCss = htmlentities(mb_convert_encoding($record['blast_custom_css'],"UTF-8"));
		$blastCustomCss = htmlentities($record['blast_custom_css']);
		
		
		if($record['disable_background']==1){
			$outLookStyle = '<!--[if (gte mso 9)|(IE)]>
			<table bgcolor="#fff" width="615" style=" background: #fff; border: 0px; " align="center" cellpadding="0" cellspacing="0" border="0">
			<tr><td><![endif]-->';
			$outLookStyleEnd ='<!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->';
			$templateFinal = '<html><head><style> @media screen and (max-width:525px) { div { width:100% !important;  } table{ width:100% !important;margin-left:0px !important;margin-right:0px !important; }   img {  max-width:100% !important; } }  img { padding:0px !important;margin:0px !important; } p{ padding:0px !important;margin:0 0 10px 0px !important; clear:both !important; } h1,h2,h3,h4,h5,h6{ clear:both !important; } table { mso-table-lspace:-1pt; mso-table-rspace:-1pt; } td, p , a, h1, h2, h3, h4, h5, h6 { font-family: Century Gothic, sans-serif; }  td { font-size:16px; } '.$blastCustomCss.' </style></head>
			<table align="center" border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="" style="table-layout:fixed"> <tbody> <tr> <td align="center"> <center style="width:100%">
			'.$browserView.'
			<table bgcolor="#fff" border="0" cellpadding="0" cellspacing="0"  align="center" width="615" class="removeTable" style="max-width:615px;margin:0 auto;background: #fff; border: 2px solid #fff; "><tr class="removeTable"><td width="100%" class="removeTable" style="width:100%;">
			'.$outLookStyle. $templateFinal . $outLookStyleEnd. '
			</td></tr></table>
			'.$privacyContent.'
			</center></html>';
		}
		else{
			$outLookStyle = '<!--[if (gte mso 9)|(IE)]>
			<table bgcolor="#fff" width="615" style="background: #fff; border: 2px solid rgba(0,0,0,0.1); " align="center" cellpadding="0" cellspacing="0" border="0">
			<tr><td><![endif]-->';
			$outLookStyleEnd ='<!--[if (gte mso 9)|(IE)]></td></tr></table><![endif]-->';
			$templateFinal = '<html><head><style> @media screen and (max-width:525px) { div { width:100% !important;  } table{ width:100% !important;margin-left:0px !important;margin-right:0px !important; }  img {  max-width:100% !important; } }  img { padding:0px !important;margin:0px !important; } p{ padding:0px !important;margin:0 0 10px 0px !important; clear:both !important; } h1,h2,h3,h4,h5,h6{ clear:both !important; } table { mso-table-lspace:-1pt; mso-table-rspace:-1pt; } td, p, a, h1, h2, h3, h4, h5, h6 { font-family: Century Gothic, sans-serif; }  td { font-size:16px; } '.$blastCustomCss.' </style></head>
			<table align="center" border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#eee" style="background-color:#eee;table-layout:fixed"> <tbody> <tr> <td align="center"> <center style="width:100%">
			'.$browserView.'
			<table bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" align="center" width="615" class="removeTable" style="max-width:615px;margin:0 auto;background: #fff; border: 2px solid rgba(0,0,0,0.1); "><tr class="removeTable"><td width="100%" class="removeTable" style="width:100%;">
			'.$outLookStyle. $templateFinal . $outLookStyleEnd. '
			</td></tr></table>
			'.$privacyContent.'
			</center></td></tr></tbody></table></html>';
		}
		
		$vendorInfo = array_map('htmlentities', $vendorInfo);
		//$subject = iconv("UTF-8", "ISO-8859-1//IGNORE", $record['blast_subject']);
		$subject = $record['blast_subject'];
		$subject = str_replace('{C}', '', $subject);
		//$subject = htmlentities(mb_convert_encoding($subject, "UTF-8"));
		$subject = htmlentities($subject);
		//$title = iconv("UTF-8", "ISO-8859-1//IGNORE", $record['blast_title']);
		$title = $record['blast_title'];
		//$title = htmlentities(mb_convert_encoding($title, "UTF-8"));
		$title = htmlentities($title);
		//$fromName = iconv("UTF-8", "ISO-8859-1//IGNORE", $record['blast_from']);
		$fromName = $record['blast_from'];
		//$fromName = htmlentities(mb_convert_encoding($fromName, "UTF-8"));
		$fromName = htmlentities($fromName);
                
		foreach($record as $key => $value){
			//$record[$key] = htmlentities(mb_convert_encoding($value,"UTF-8"));
			$record[$key] = htmlentities($value);
		}
		
		$soapMessage = <<<MSG
	<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
	  <soap12:Body>
		<SaveEmailBlast xmlns="http://tempuri.org/">
		  <BlastID>{$record['blast_id']}</BlastID>
		  <BlastTitle>{$title}</BlastTitle>
		  <FromName>{$fromName}</FromName>
		  <FromEmail>{$record['blast_email_from']}</FromEmail>
		  <EmailContent>{$templateFinal}</EmailContent>
		  <EmailSubject>{$subject}</EmailSubject>
		  <UserID>{$record['created_by']}</UserID>
		  <ClientID>{$record['clientId']}</ClientID>
		  <BlastTotal>{$record['blast_total']}</BlastTotal>
		  <BlastStatus>{$record['blast_status']}</BlastStatus>
		  <BlastDate>{$blastDate}</BlastDate>
		  <isMerge>{$record['is_merge']}</isMerge>
		  <ExcludeCount>{$exCount}</ExcludeCount>
		  <IsscheduleBlast>{$blastSchedule}</IsscheduleBlast>
		  <isMandrill>{$vendorInfo['ev_is_mandrill']}</isMandrill>
		  <MandrillKey>{$vendorInfo['ev_mandrill_key']}</MandrillKey>
		  <SendGridUserName>{$vendorInfo['ev_user_name']}</SendGridUserName>
		  <SendGridPassword>{$vendorInfo['ev_password']}</SendGridPassword>
		</SaveEmailBlast>
	  </soap12:Body>
	</soap12:Envelope>
MSG;
		$soapMessage = '<?xml version="1.0" encoding="utf-8" ?>'."\n".$soapMessage;
		$headers = array(
			'Content-Type:application/soap+xml; charset=utf-8',
			'Content-Length: '.strlen($soapMessage),
		);
		//$blastTypeArr = array(0, 1, 2, 4);
		//if(in_array($record['blast_type'], $blastTypeArr)){
			$emailBlastProcessObj = getObject('emailBlastProcess');
			$processId = $emailBlastProcessObj->addEmailBlastProcess($record['blast_id'], $title, $subject, $templateFinal,	$fromName, 
				$record['blast_email_from'], $record['created_by'], $record['clientId'], $record['blast_total'], 
				$record['blast_status'], $record['is_merge'], $record['blast_type'], $blastDate, $blastSchedule, 
				$vendorInfo['ev_is_mandrill'], $vendorInfo['ev_mandrill_key'], $vendorInfo['ev_user_name'], $vendorInfo['ev_password'], $exCount);
			//$processRun = exec(' php '. ROOT_PATH.'cron/processEmailBlast.php');
			return true;
		//}
		$ch = curl_init();
		if($record['blast_type'] == 4){
			curl_setopt($ch, CURLOPT_URL, 'http://leadnaemailblast.officeinteractive.com/CampaignBlast/service.asmx');
		}else if($record['blast_type'] == 3) {
			curl_setopt($ch, CURLOPT_URL, 'http://leadnaEmailBlast.officeinteractive.com/service.asmx');
		} else {
			curl_setopt($ch, CURLOPT_URL, EMAIL_SERVICE_URL);
		}
		curl_setopt($ch, CURLOPT_POST, TRUE);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $soapMessage);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($ch, CURLOPT_TIMEOUT, 120);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		
		if (($result = curl_exec($ch)) === FALSE) {
			//echo 'Curl Error'. curl_errno($ch). '<<>> Error: '. curl_error($ch);
			curl_close($ch);
			//exit;
			return false;
		} else {
			/*echo 'Curl Result: ';
			printInfo($result);
			echo '<hr>';*/
			curl_close($ch);
		}
		return true;
	}
}
?>