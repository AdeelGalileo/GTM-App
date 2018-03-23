<?php
require_once('header.php');	
$alertObj = getObject('alert');
//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['notification_user_id']=$params['notification_user_id'];
	$inputArray['notification_module_id']=$params['notification_module_id'];
	$inputArray['notification_email']=$params['notification_email'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$alertObj->addAlert($inputArray);
	echo array2json(array('success'=>true,'message'=>ALERT_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['notificationUpdateId']=$params['notificationUpdateId'];
	$inputArray['notification_user_id']=$params['notification_user_id'];
	$inputArray['notification_module_id']=$params['notification_module_id'];
	$inputArray['notification_email']=$params['notification_email'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$alertObj->addAlert($inputArray);
	echo array2json(array('success'=>true,'message'=>ALERT_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['alertDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['alertDeleteId']=$params['alertDeleteId'];
	$alertObj->deleteAlert($inputArray);
	echo array2json(array('success'=>true,'message'=>ALERT_DELETED_SUCCESSFULLY));
	exit;
}	
	
?> 