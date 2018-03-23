<?php
require_once('header.php');	
$adminPersonnelObj = getObject('adminPersonnel');

if($params['checkUserEmailExist']){
	$inputArray=array();
	$inputArray['userEmailData']=$params['userEmailData'];
	$result = $adminPersonnelObj->checkUserEmailExist($inputArray);
	if($result){
		echo array2json(array('success'=>true,'message'=>1));
	}
	else{
		echo array2json(array('success'=>true,'message'=>0));
	}
	exit;
}

if($params['checkUserEmailExistForUpdate']){
	$inputArray=array();
	$inputArray['userEmailData']=$params['userEmailData'];
	$inputArray['userUpdateId']=$params['userUpdateId'];
	$result = $adminPersonnelObj->checkUserEmailExistForUpdate($inputArray);
	if($result){
		echo array2json(array('success'=>true,'message'=>1));
	}
	else{
		echo array2json(array('success'=>true,'message'=>0));
	}
	exit;
}

if($params['addAdminPersonnel']){
	$inputArray=array();
	$inputArray['userFirstNameData']=$params['userFirstNameData'];
	$inputArray['userLastNameData']=$params['userLastNameData'];
	$inputArray['userRoleData']=$params['userRoleData'];
	$inputArray['userEmailData']=$params['userEmailData'];
	$inputArray['user_qb_ref_id']=$params['user_qb_ref_id'];
	$inputArray['userPasswordData']=$params['userPasswordData'];
	$inputArray['userId']=$params['userId'];
	$result = $adminPersonnelObj->addAdminPersonnel($inputArray);
	
	$fromEmail=NOTIFICATION_EMAIL;
	$toEmail= $params['userEmailData'];
	$subject=WELCOME_EMAIL;
	$smarty->assign('mailInfo', $inputArray);
	$message = $smarty->fetch('welcomeUserTemplate.tpl');
	sendMail($fromEmail, $toEmail, $subject, $message);
	
	echo array2json(array('success'=>true,'message'=>USER_CREATED_SUCCESSFULLY));
	exit;
}

if($params['updateAdminPersonnel']){
	$inputArray=array();
	$inputArray['userFirstNameData']=$params['userFirstNameData'];
	$inputArray['userLastNameData']=$params['userLastNameData'];
	$inputArray['userRoleData']=$params['userRoleData'];
	$inputArray['userEmailData']=$params['userEmailData'];
	$inputArray['user_qb_ref_id']=$params['user_qb_ref_id'];
	$inputArray['userUpdateId']=$params['userUpdateId'];
	$inputArray['userId']=$params['userId'];
	$result = $adminPersonnelObj->addAdminPersonnel($inputArray);
	
	if((strtolower($params['userEmailData'])) !== (strtolower($params['userEmailExist']))){
		$fromEmail=NOTIFICATION_EMAIL;
		$toEmail= $params['userEmailData'];
		$subject=WELCOME_EMAIL_UPDATE;
		$smarty->assign('mailInfo', $inputArray);
		$message = $smarty->fetch('welcomeUserEmailUpdateTemplate.tpl');
		sendMail($fromEmail, $toEmail, $subject, $message);
	}
	
	echo array2json(array('success'=>true,'message'=>USER_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['deleteAdminPersonnel']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['userDeleteId']=$params['userDeleteId'];
	$result = $adminPersonnelObj->deleteAdminPersonnel($inputArray);
	echo array2json(array('success'=>true,'message'=>USER_DELETED_SUCCESSFULLY));
	exit;
}	
	
if($params['getUserById']){
	$result = $adminPersonnelObj->getUserById($params['userDataId']);
	echo array2json(array('success'=>true,'message'=>$result));
	exit;
}		
?> 