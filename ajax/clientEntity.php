<?php
require_once('header.php');	
$clientEntityObj = getObject('clientEntity');

if($params['getDivisionByMarshaCode']){
	$inputArray=array();
	$inputArray['marshaCodeIp']=$params['marshaCodeIp'];
	$result = $clientEntityObj->getDivisionByMarshaCode($inputArray);
	echo array2json(array('success'=>true,'message'=>$result));
	exit;
}


//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['client_entity_division_id']=$params['client_entity_division_id'];
	$inputArray['client_entity_marsha_code']=$params['client_entity_marsha_code'];
	$inputArray['client_entity_hotel_name']=$params['client_entity_hotel_name'];
	$inputArray['client_entity_street']=$params['client_entity_street'];
	$inputArray['client_entity_city']=$params['client_entity_city'];
	$inputArray['client_entity_state']=$params['client_entity_state'];
	$inputArray['client_entity_zipcode']=$params['client_entity_zipcode'];
	$inputArray['client_entity_country']=$params['client_entity_country'];
	$result = $clientEntityObj->addClientEntity($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_ENTITY_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientEntityUpdateId']=$params['clientEntityUpdateId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['client_entity_division_id']=$params['client_entity_division_id'];
	$inputArray['client_entity_marsha_code']=$params['client_entity_marsha_code'];
	$inputArray['client_entity_hotel_name']=$params['client_entity_hotel_name'];
	$inputArray['client_entity_street']=$params['client_entity_street'];
	$inputArray['client_entity_city']=$params['client_entity_city'];
	$inputArray['client_entity_state']=$params['client_entity_state'];
	$inputArray['client_entity_zipcode']=$params['client_entity_zipcode'];
	$inputArray['client_entity_country']=$params['client_entity_country'];
	$result = $clientEntityObj->addClientEntity($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_ENTITY_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['clientEntityDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientEntityDeleteId']=$params['clientEntityDeleteId'];
	$clientEntityObj->deleteClientEntity($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_ENTITY_DELETED_SUCCESSFULLY));
	exit;
}

?> 