<?php
class webinar {


	public function checkAuthentication($oAuthUrl)
	{
		$cmp = curl_init();
        curl_setopt($cmp, CURLOPT_URL, $oAuthUrl);
        curl_setopt($cmp, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($cmp, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($cmp, CURLOPT_HEADER, 0);
        curl_setopt($cmp, CURLOPT_VERBOSE, 1);
		curl_setopt ($cmp, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt ($cmp, CURLOPT_SSL_VERIFYHOST, 0);
		
		$rsltCamp = curl_exec($cmp);
		$output = json_decode($rsltCamp);
		curl_close($cmp);
		return $output;
	}

	public function createWebinar($url, $data, $token)
	{
	
		$ch = curl_init();
		$data_string = stripcslashes(json_encode($data)); 
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
		$headers = array(
			"Content-Type: application/json",
			"Accept: application/json",
			"Authorization: OAuth oauth_token=$token",
			"Content-Length: " . strlen($data_string)
		);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, true); 
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
		$result = curl_exec($ch);
		/*if(curl_error($ch)){
			echo 'Error in curl: '. curl_errno($ch). ' <<>> '. curl_error($ch);
		}*/
		$arr = json_decode($result);
		return $arr;
	}


	public function getHistoryWebinar($url, $token)
	{
		$cmp = curl_init();
		curl_setopt($cmp, CURLOPT_URL, $url);
		curl_setopt($cmp, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($cmp, CURLOPT_FOLLOWLOCATION, 1);
			$headers = array(
				"Content-Type: application/json",
				"Accept: application/json",
				"Authorization: OAuth oauth_token=$token"
			);
		curl_setopt($cmp, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($cmp, CURLOPT_VERBOSE, 1);
		curl_setopt ($cmp, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt ($cmp, CURLOPT_SSL_VERIFYHOST, 0);
		
		$rsltCamp = curl_exec($cmp);
		if (version_compare(PHP_VERSION, '5.4.0', '>=')) {
			$output = json_decode ($rsltCamp, false, 512, JSON_BIGINT_AS_STRING);
			
		} else {
			$json2 = fixJson ($rsltCamp);
			$output = json_decode ($json2);
		}
		curl_close($cmp);
		return $output;		
	}

}
?>