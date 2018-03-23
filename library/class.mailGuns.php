<?php
class mailSendUseMailGun{
	
	public function sendMailGuns($mailGunParams)
	{
			$mailGunApi = 'key-1pvbhu78ezmdyil0bf9co7zswpyxdto8';
			$mg_version = 'api.mailgun.net/v2/';
			$mg_domain = "Sandbox8703.Mailgun.Org";

			$requestURL = "https://".$mg_version.$mg_domain."/messages";
			
			
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
			
			curl_setopt ($ch, CURLOPT_MAXREDIRS, 3);
			curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, false);
			curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt ($ch, CURLOPT_VERBOSE, 0);
			curl_setopt ($ch, CURLOPT_HEADER, 1);
			curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, 10);
			curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0);
			curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
			
			curl_setopt($ch, CURLOPT_USERPWD, 'api:' . $mailGunApi);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			
			curl_setopt($ch, CURLOPT_POST, true); 
			//curl_setopt($curl, CURLOPT_POSTFIELDS, $params); 
			curl_setopt($ch, CURLOPT_HEADER, false); 
			
			//curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
			curl_setopt($ch, CURLOPT_URL, $requestURL);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $mailGunParams);
							
							
					  
			$result = curl_exec($ch);
			curl_close($ch);
			//$res = json_decode($result,TRUE);
			//print '<pre>';
			//print_r($res);
	}
	
	
	public function addUnsubscribes($mailGunParams)
	{
			$mailGunApi = 'key-1pvbhu78ezmdyil0bf9co7zswpyxdto8';
			$mg_version = 'api.mailgun.net/v2/';
			$mg_domain = "Sandbox8703.Mailgun.Org";

			$requestURL = "https://".$mg_version.$mg_domain."/unsubscribes";
			
			
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
			
			curl_setopt ($ch, CURLOPT_MAXREDIRS, 3);
			curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, false);
			curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt ($ch, CURLOPT_VERBOSE, 0);
			curl_setopt ($ch, CURLOPT_HEADER, 1);
			curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, 10);
			curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0);
			curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
			
			curl_setopt($ch, CURLOPT_USERPWD, 'api:' . $mailGunApi);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			
			curl_setopt($ch, CURLOPT_POST, true); 
			//curl_setopt($curl, CURLOPT_POSTFIELDS, $params); 
			curl_setopt($ch, CURLOPT_HEADER, false); 
			
			//curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
			curl_setopt($ch, CURLOPT_URL, $requestURL);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $mailGunParams);
							
							
					  
			$result = curl_exec($ch);
			curl_close($ch);
			//$res = json_decode($result,TRUE);
			//print '<pre>';
			//print_r($res);
	}
}
?>