<?php
class tracker{
	
	public function getTrackInfo($emailId, $clientId, $userId=0)
	{ 
		$soapMessage = <<<MSG
			<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
		  <soap12:Body>
			<FindTrackCount xmlns="http://tempuri.org/">
			  <Email>{$emailId}</Email>
			  <ClientID>{$clientId}</ClientID>
			  <UserID>{$userId}</UserID>
			</FindTrackCount>
		  </soap12:Body>
		</soap12:Envelope>
MSG;
		$soapMessage = '<?xml version="1.0" encoding="utf-8" ?>'."\n".$soapMessage;
		$headers = array(
			'Content-Type:application/soap+xml; charset=utf-8',
			'Content-Length: '.strlen($soapMessage),
		);
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, TRACK_SERVICE_URL);
		curl_setopt($ch, CURLOPT_POST, TRUE);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $soapMessage);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt($ch, CURLOPT_TIMEOUT, 120);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		
		if (($result = curl_exec($ch)) === FALSE) {
			curl_close($ch);
			//echo 'Error'. curl_errno($ch). '<<>>'. curl_error($ch);
			return false;
		} else {
			curl_close($ch);
			$result = preg_replace("/(<\/?)(\w+):([^>]*>)/", "$1$2$3", $result); //Replace : in xml tags
			$xmlDoc = simplexml_load_string($result);
			$xmlDoc->registerXPathNamespace('temp', 'http://tempuri.org/');
			$json = json_encode($xmlDoc);
			$responseArray = json_decode($json, true);
			$resultArr = $responseArray['soapBody']['FindTrackCountResponse']['FindTrackCountResult']['diffgrdiffgram']['NewDataSet'];
			return $resultArr;
		}
		
	}
}
?>