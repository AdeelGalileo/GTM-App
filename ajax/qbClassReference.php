<?php
require_once('header.php');	
$qbClassReferenceObj = getObject('qbClassReference');


//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['qb_cls_ref_class_id']=$params['qb_cls_ref_class_id'];
	$inputArray['qb_cls_ref_class_name']=$params['qb_cls_ref_class_name'];
	$result = $qbClassReferenceObj->addQbClassReference($inputArray);
	echo array2json(array('success'=>true,'message'=>QB_CLASS_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['classQbRefUpateId']=$params['classQbRefUpateId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['qb_cls_ref_class_id']=$params['qb_cls_ref_class_id'];
	$inputArray['qb_cls_ref_class_name']=$params['qb_cls_ref_class_name'];
	$result = $qbClassReferenceObj->addQbClassReference($inputArray);
	echo array2json(array('success'=>true,'message'=>QB_CLASS_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['classQbRefDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['classQbRefDeleteId']=$params['classQbRefDeleteId'];
	$qbClassReferenceObj->deleteQbClassReference($inputArray);
	echo array2json(array('success'=>true,'message'=>QB_CLASS_DELETED_SUCCESSFULLY));
	exit;
}

?> 