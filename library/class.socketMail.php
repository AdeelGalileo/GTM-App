<?php
class socketMailTrack {

	public function socketFunction($userName, $password, $url)
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_USERPWD, "$userName:$password");
		curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		
		$output = curl_exec($ch);
		$result = simplexml_load_string($output);
		curl_close($ch);
		return $result;
	}
}
?>