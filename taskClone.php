<?php
require_once('header.php');

if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
	$smarty->assign('lastPage', 'Task Manager Keyword');
	$smarty->assign('formUploadPending', true);
	$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
	$smarty->display('formPendingMessage.tpl');
	exit;
}

if($params['taskRecordId']){
	$taskManagerKeywordObj = getObject('taskManagerKeyword');
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordId']=$params['taskRecordId'];
	$taskKeywordData = $taskManagerKeywordObj->getTaskManagerKeywordById($inputArray);
	$smarty->assign('taskKeywordData', $taskKeywordData);
	$smarty->assign('taskRecordId', $params['taskRecordId']);
	
	$adminPersonnelObj = getObject('adminPersonnel');
	$userIpArray=array();
	$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
	$userIpArray['formStatus']=FORM_COMPLETE;
	$userIpArray['taskUserId']=$taskKeywordData['task_keyword_user_id'];
	$userArray = $adminPersonnelObj->getUsersByFormForClone($userIpArray);
	$smarty->assign('userArray', $userArray);
	
	$serviceTypeObj = getObject('serviceType');
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
	$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
	$smarty->assign('serviceTypeArray', $serviceTypeArray);
	
}


$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Task Cone');
$smarty->display('taskClone.tpl');
require_once('footer.php');
?>