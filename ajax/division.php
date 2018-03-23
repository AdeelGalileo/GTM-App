<?php
require_once('header.php');	
$divisionObj = getObject('division');


//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['division_code']=$params['division_code'];
	$inputArray['division_name']=$params['division_name'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $divisionObj->addDivision($inputArray);
	echo array2json(array('success'=>true,'message'=>DIVISION_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['divisionUpdateId']=$params['divisionUpdateId'];
	$inputArray['division_code']=$params['division_code'];
	$inputArray['division_name']=$params['division_name'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $divisionObj->addDivision($inputArray);
	echo array2json(array('success'=>true,'message'=>DIVISION_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['divisionDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['divisionDeleteId']=$params['divisionDeleteId'];
	$divisionObj->deleteDivision($inputArray);
	echo array2json(array('success'=>true,'message'=>DIVISION_DELETED_SUCCESSFULLY));
	exit;
}

?> 