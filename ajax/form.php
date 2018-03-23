<?php
require_once('header.php');	
$formObj = getObject('form');

//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['form_user_id']=$params['form_user_id'];
	$inputArray['form_first_name']=$params['form_first_name'];
	$inputArray['form_last_name']=$params['form_last_name'];
	$inputArray['form_email']=$params['form_email'];
	$inputArray['form_contact_no']=$params['form_contact_no'];
	$inputArray['form_street']=$params['form_street'];
	$inputArray['form_city']=$params['form_city'];
	$inputArray['form_state']=$params['form_state'];
	$inputArray['form_zipcode']=$params['form_zipcode'];
	$inputArray['form_country']=$params['form_country'];
	$inputArray['newW9Form']=$params['newW9Form'];
	$inputArray['newResumeForm']=$params['newResumeForm'];
	$inputArray['newAchForm']=$params['newAchForm'];
	$inputArray['newAgreementForm']=$params['newAgreementForm'];
	$inputArray['form_notes']=$params['form_notes'];
	$inputArray['form_needed']=$params['form_needed'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $formObj->addForm($inputArray);
	unset($_SESSION['newW9Form'],$_SESSION['newResumeForm'],$_SESSION['newAchForm'],$_SESSION['newAgreementForm']);
	echo array2json(array('success'=>true,'message'=>FORM_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['formUpdateId']=$params['formUpdateId'];
	$inputArray['form_user_id']=$params['form_user_id'];
	$inputArray['form_first_name']=$params['form_first_name'];
	$inputArray['form_last_name']=$params['form_last_name'];
	$inputArray['form_email']=$params['form_email'];
	$inputArray['form_contact_no']=$params['form_contact_no'];
	$inputArray['form_street']=$params['form_street'];
	$inputArray['form_city']=$params['form_city'];
	$inputArray['form_state']=$params['form_state'];
	$inputArray['form_zipcode']=$params['form_zipcode'];
	$inputArray['form_country']=$params['form_country'];
	$inputArray['newW9Form']=$params['newW9Form'];
	$inputArray['newResumeForm']=$params['newResumeForm'];
	$inputArray['newAchForm']=$params['newAchForm'];
	$inputArray['newAgreementForm']=$params['newAgreementForm'];
	$inputArray['form_notes']=$params['form_notes'];
	$inputArray['form_needed']=$params['form_needed'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $formObj->addForm($inputArray);
	unset($_SESSION['newW9Form'],$_SESSION['newResumeForm'],$_SESSION['newAchForm'],$_SESSION['newAgreementForm']);
	echo array2json(array('success'=>true,'message'=>FORM_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['formDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['formDeleteId']=$params['formDeleteId'];
	$formObj->deleteForm($inputArray);
	echo array2json(array('success'=>true,'message'=>FORM_DELETED_SUCCESSFULLY));
	exit;
}

?> 