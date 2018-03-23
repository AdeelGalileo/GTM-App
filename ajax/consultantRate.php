<?php
require_once('header.php');	
$consultantRateObj = getObject('consultantRate');

//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['cons_rate_user_id']=$params['cons_rate_user_id'];
	$inputArray['cons_rate_service_type_id']=$params['cons_rate_service_type_id'];
	$inputArray['cons_rate_per_unit']=$params['cons_rate_per_unit'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $consultantRateObj->addConsultantRate($inputArray);
	echo array2json(array('success'=>true,'message'=>CONSULTANT_RATE_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['rateUpdateId']=$params['rateUpdateId'];
	$inputArray['cons_rate_user_id']=$params['cons_rate_user_id'];
	$inputArray['cons_rate_service_type_id']=$params['cons_rate_service_type_id'];
	$inputArray['cons_rate_per_unit']=$params['cons_rate_per_unit'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $consultantRateObj->addConsultantRate($inputArray);
	echo array2json(array('success'=>true,'message'=>CONSULTANT_RATE_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['rateDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['rateDeleteId']=$params['rateDeleteId'];
	$consultantRateObj->deleteConsultantRate($inputArray);
	echo array2json(array('success'=>true,'message'=>CONSULTANT_RATE_DELETED_SUCCESSFULLY));
	exit;
}

?> 