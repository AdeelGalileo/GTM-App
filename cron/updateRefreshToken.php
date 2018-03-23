<?php
$dirName = dirname(dirname(__FILE__));
require_once ($dirName.'/includes/includes.php');
@ini_set('max_execution_time', 0);
@ini_set('memory_limit', '-1');
$runStatus = getObject('cronJobs');


$isRun = $runStatus->getMarketingStatus(2);


if($isRun['cronIsRun'] ==1) {
	echo 'Cron is already running';
	exit;
}
$runStatus->updateStartRunning(1);

$qbClientTokenObj = getObject('qbClientToken');
$inputArray['clientQbTokenUpateId']=1;
$qbClientTokenData = $qbClientTokenObj->getQbClientTokenById($inputArray);



try {
	
	$apiUrl="https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer";
	
	$curl = curl_init($apiUrl);
	curl_setopt($curl, CURLOPT_POST, TRUE);
	curl_setopt($curl, CURLOPT_POSTFIELDS,
			"grant_type=refresh_token&refresh_token=".$qbClientTokenData['qb_client_token_current_refresh_token']);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded','Authorization: Basic '. base64_encode("".$qbClientTokenData['qb_client_token_client_id'].":".$qbClientTokenData['qb_client_token_client_secret']."")));
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($curl, CURLOPT_TIMEOUT, 120);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	
	$server_output = curl_exec($curl);
	$result = json_decode($server_output);
	
	if ($result->error) {
		$runStatus->addRefreshTokenError($result->error);
		curl_close($curl);
	} else {
		$inputArray=array();
		$inputArray['userId']=$qbClientTokenData['qb_client_token_created_by'];
		$inputArray['clientQbTokenUpateId']=$qbClientTokenData['qb_client_token_id'];
		$inputArray['qb_client_token_refresh_token']=$result->refresh_token;
		$inputArray['qb_client_token_access_token']=$result->access_token;
		if((!empty($inputArray['qb_client_token_refresh_token'])) && (!empty($inputArray['qb_client_token_access_token']))){
			$qbClientTokenObj->updateQbClientRefreshToken($inputArray);
		}
		curl_close($curl);
		clearstatcache();
	}
}
catch(Exception $e) {
	$runStatus->addRefreshTokenError($e->getMessage());
}

	
$runStatus->updateStopRunning(1);
?>