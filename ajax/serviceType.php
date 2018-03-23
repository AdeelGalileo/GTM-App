<?php
require_once('header.php');	
$serviceTypeObj = getObject('serviceType');
//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['serv_type_name']=$params['serv_type_name'];
	$inputArray['serv_type_qb_id']=$params['serv_type_qb_id'];
	$inputArray['serv_type_task_type']=$params['serv_type_task_type'];
	$inputArray['serv_type_gal_rate']=$params['serv_type_gal_rate'];
	$inputArray['serv_type_freel_rate']=$params['serv_type_freel_rate'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$serviceTypeObj->addServiceType($inputArray);
	echo array2json(array('success'=>true,'message'=>SERVICE_TYPE_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['servTypeUpdateId']=$params['servTypeUpdateId'];
	$inputArray['serv_type_name']=$params['serv_type_name'];
	$inputArray['serv_type_qb_id']=$params['serv_type_qb_id'];
	$inputArray['serv_type_task_type']=$params['serv_type_task_type'];
	$inputArray['serv_type_gal_rate']=$params['serv_type_gal_rate'];
	$inputArray['serv_type_freel_rate']=$params['serv_type_freel_rate'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$serviceTypeObj->addServiceType($inputArray);
	echo array2json(array('success'=>true,'message'=>SERVICE_TYPE_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['serviceTypeDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['serviceTypeDeleteId']=$params['serviceTypeDeleteId'];
	$serviceTypeObj->deleteServiceType($inputArray);
	echo array2json(array('success'=>true,'message'=>SERVICE_TYPE_DELETED_SUCCESSFULLY));
	exit;
}	
	
?> 