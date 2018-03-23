<?php
require_once('header.php');	
$clientObj = getObject('client');

if($params['createClientSession']){
	$inputArray=array();
	unset($_SESSION['sessionClientId']);
	$_SESSION['sessionClientId'] = $params['sessionDataClientId'];
	$_SESSION['sessionClientName'] = $params['sessionClientName'];
	echo array2json(array('success'=>true,'message'=>SET_CLIENT));
	exit;
}

//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['client_name']=$params['client_name'];
	$inputArray['client_street']=$params['client_street'];
	$inputArray['client_city']=$params['client_city'];
	$inputArray['client_state']=$params['client_state'];
	$inputArray['client_zipcode']=$params['client_zipcode'];
	$inputArray['client_country']=$params['client_country'];
	$inputArray['client_qb_associated_reference']=$params['client_qb_associated_reference'];
	$result = $clientObj->addClient($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientUpateId']=$params['clientUpateId'];
	$inputArray['client_name']=$params['client_name'];
	$inputArray['client_street']=$params['client_street'];
	$inputArray['client_city']=$params['client_city'];
	$inputArray['client_state']=$params['client_state'];
	$inputArray['client_zipcode']=$params['client_zipcode'];
	$inputArray['client_country']=$params['client_country'];
	$inputArray['client_qb_associated_reference']=$params['client_qb_associated_reference'];
	$inputArray['client_record_status']=$params['client_record_status'];
	$result = $clientObj->addClient($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['clientDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientDeleteId']=$params['clientDeleteId'];
	$clientObj->deleteClient($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_DELETED_SUCCESSFULLY));
	exit;
}

?> 