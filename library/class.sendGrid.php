<?php
class mailTracks {
	
	public function sendGridMail($sendGridParams)
		{ 
			require_once( ROOT_PATH.'/library/sendgrid/sendgrid.php');
			$sendgrid = new SendGrid($sendGridParams['api_user'],$sendGridParams['api_key'], array("turn_off_ssl_verification" => true));
			$email = new SendGrid\Email();
			$email->addTo($sendGridParams['to'])
				  ->setFrom($sendGridParams['from'])
				  ->setFromName($sendGridParams['fromname'])
				  ->setSubject($sendGridParams['subject'])
				  ->setHtml($sendGridParams['html'])
				  ->setText(strip_tags($sendGridParams['html']));
			if($sendGridParams['cc']){
				$email->addCc($sendGridParams['cc']);
			}
			if($sendGridParams['bcc']){
				$email->addBcc($sendGridParams['bcc']);
			}
			try{
				$result = $sendgrid->send($email);
			} catch(Exception $ex){
				return false;
			}
		}

		/*public function sendGridMail($sendGridParams)
		{ 
			$request = 'http://sendgrid.com/api/mail.send.json';
			$session = curl_init($request);
			curl_setopt ($session, CURLOPT_POST, true);
			curl_setopt ($session, CURLOPT_POSTFIELDS, $sendGridParams);
			curl_setopt($session, CURLOPT_HEADER, false);
			curl_setopt($session, CURLOPT_RETURNTRANSFER, true);
			 
			$response = curl_exec($session);
			curl_close($session);
			 
			print_r($response);
		}*/

}
?>