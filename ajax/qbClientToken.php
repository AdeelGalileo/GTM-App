<?php
require_once('header.php');	
$qbClientTokenObj = getObject('qbClientToken');


//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientQbTokenUpateId']=$params['clientQbTokenUpateId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['qb_client_token_client_id']=$params['qb_client_token_client_id'];
	$inputArray['qb_client_token_client_secret']=$params['qb_client_token_client_secret'];
	$inputArray['qb_client_token_qbo_real_id']=$params['qb_client_token_qbo_real_id'];
	$inputArray['qb_client_token_base_url']=$params['qb_client_token_base_url'];
	$inputArray['qb_client_token_refresh_token']=$params['qb_client_token_refresh_token'];
	$inputArray['qb_client_token_access_token']=$params['qb_client_token_access_token'];
	$result = $qbClientTokenObj->updateQbClientToken($inputArray);
	echo array2json(array('success'=>true,'message'=>QB_CLIENT_TOKEN_UPDATED_SUCCESSFULLY));
	exit;
}


?> 