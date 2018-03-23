<?php
require_once('header.php');	
$skillsObj = getObject('skills');

//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['cons_user_id']=$params['cons_user_id'];
	$inputArray['cons_service_type_id']=implode(",",$params['cons_service_type_id']);
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $skillsObj->addConsultantSkill($inputArray);
	echo array2json(array('success'=>true,'message'=>SKILL_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['skillUpdateId']=$params['skillUpdateId'];
	$inputArray['cons_user_id']=$params['cons_user_id'];
	$inputArray['cons_service_type_id']=implode(",",$params['cons_service_type_id']);
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $skillsObj->addConsultantSkill($inputArray);
	echo array2json(array('success'=>true,'message'=>SKILL_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['skillDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['skillDeleteId']=$params['skillDeleteId'];
	$skillsObj->deleteSkill($inputArray);
	echo array2json(array('success'=>true,'message'=>SKILL_DELETED_SUCCESSFULLY));
	exit;
}

?> 