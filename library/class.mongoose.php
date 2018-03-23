<?php
class callTracks {
	public function checkCalls($request, $url)
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch,CURLOPT_TIMEOUT,30);
		curl_setopt($ch,CURLOPT_POST,1);
		curl_setopt($ch,CURLOPT_POSTFIELDS, $request);
		curl_setopt($ch,CURLOPT_HTTPHEADER,array('Content-type:text/xml'));
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
		$contents = curl_exec ($ch);
		$contents = preg_replace("/<!ENTITY [^>)]+>/", "", $contents);
		$contents = preg_replace("/<!DOCTYPE [^>)]+>/", "", $contents);
		$result = simplexml_load_string($contents);	
		print '<pre>';
		print_r($result);	
		//exit;
		curl_close($ch);
		return $result;
	}


	public function createCampaign($campUrl)
	{
		$cmp = curl_init();
        curl_setopt($cmp, CURLOPT_URL, $campUrl);
        curl_setopt($cmp, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($cmp, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($cmp, CURLOPT_HEADER, 0);
        curl_setopt($cmp, CURLOPT_VERBOSE, 1);
		
		$rsltCamp = curl_exec ($cmp);
		$output = simplexml_load_string($rsltCamp);
		curl_close($cmp);
		return $output;	
	}

}
?>