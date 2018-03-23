<?php
require_once('header.php');	
$clientDivsionObj = getObject('clientDivision');


//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['client_qb_ref_division_id']=$params['client_qb_ref_division_id'];
	$inputArray['client_qb_ref_qb_id']=$params['client_qb_ref_qb_id'];
	$inputArray['client_qb_ref_qb_class']=$params['client_qb_ref_qb_class'];
	$result = $clientDivsionObj->addClientDivision($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_DIVISION_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientQbRefUpdateId']=$params['clientQbRefUpdateId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['client_qb_ref_division_id']=$params['client_qb_ref_division_id'];
	$inputArray['client_qb_ref_qb_id']=$params['client_qb_ref_qb_id'];
	$inputArray['client_qb_ref_qb_class']=$params['client_qb_ref_qb_class'];
	$result = $clientDivsionObj->addClientDivision($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_DIVISION_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['clientQbRefDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['clientQbRefDeleteId']=$params['clientQbRefDeleteId'];
	$clientDivsionObj->deleteClientDivision($inputArray);
	echo array2json(array('success'=>true,'message'=>CLIENT_DIVISION_DELETED_SUCCESSFULLY));
	exit;
}

?> 