<?php
class weatherCheck {
	public function getByLatitude($latitude, $longitude)
	{
		$basicurl=sprintf('http://api.wunderground.com/api/e0a023fa4e8b2e11/conditions/alert/q/%s,%s.json', $latitude, $longitude);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $basicurl);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER , 1); 
		$json_reply =curl_exec($ch);
		curl_close($ch);
		
		$result=json_decode($json_reply);
		return $result->current_observation;
	}

}
?>