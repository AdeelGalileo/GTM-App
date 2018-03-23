<?php
class privacyPolicyApi{
	
	public function addPolicy($record)
	{
		if(defined('get_magic_quotes_gpc')) {
			if (get_magic_quotes_gpc()) {
				$record = array_map('stripslashes', $record);
			}
		}
		$record = array_map('htmlentities', $record);
		
		$soapMessage = <<<MSG
	<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
	  <soap12:Body>
		<PrivacyPolicy xmlns="http://tempuri.org/">
			<Company>{$record['privacy_company']}</Company>
			<Address1>{$record['privacy_address']}</Address1>
			<City>{$record['privacy_city']}</City>
			<State>{$record['privacy_state']}</State>
			<Country>{$record['privacy_country']}</Country>
			<PolicyContent>{$record['privacy_textarea']}</PolicyContent>
			<ClientID>{$record['privacy_clientId']}</ClientID>
			<URL>{$record['privacy_URL']}</URL>
		</PrivacyPolicy>
	  </soap12:Body>
	</soap12:Envelope>
MSG;
		$soapMessage = '<?xml version="1.0" encoding="utf-8" ?>'."\n".$soapMessage;
		$headers = array(
			'Content-Type:application/soap+xml; charset=utf-8',
			'Content-Length: '.strlen($soapMessage),
		);
				
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, EMAIL_SERVICE_URL);
		curl_setopt($ch, CURLOPT_POST, TRUE);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $soapMessage);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($ch, CURLOPT_TIMEOUT, 120);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		
		if (($result = curl_exec($ch)) === FALSE) {
			curl_close($ch);
			return false;
		} else {
			curl_close($ch);
		}
		return true;
	}
}
?>