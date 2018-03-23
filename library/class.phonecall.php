<?php
class callDetail {
	public function checkCurl($url, $userName, $password, $format="json")
	{
		$ch = curl_init ($url);
		
		
		
	curl_setopt ($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
	curl_setopt ($ch, CURLOPT_USERPWD, "$userName:$password");
	curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt ($ch, CURLOPT_HTTPGET, 1);
	curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		$output = curl_exec ($ch);
		if($format == "json"){
			$result = json_decode($output);
		} else {
			$result = simplexml_load_string($output);
		}
		$info = curl_getinfo($ch);
		//print_r($info);
		if(curl_error($ch)){
			echo 'Error: '.  curl_errno($ch).' <<>> '. curl_error($ch);
		}
		curl_close($ch);
		unset($ch);
		return $result;	
	}
	
}
?>