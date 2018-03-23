<?php
require_once('header.php');

if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
	$smarty->assign('lastPage', 'Task Manager Keyword');
	$smarty->assign('formUploadPending', true);
	$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
	$smarty->display('formPendingMessage.tpl');
	exit;
}

if($params['taskId']){
	
	$taskManagerKeywordObj = getObject('taskManagerKeyword');
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordId']=$params['taskId'];
	$taskKeywordData = $taskManagerKeywordObj->getTaskManagerKeywordById($inputArray);
	$smarty->assign('taskKeywordData', $taskKeywordData);
	$smarty->assign('taskId', $params['taskId']);
	
	$clientEntityObj = getObject('clientEntity');
	$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
	$smarty->assign('marshaCodesArray', $marshaCodesArray);
	
	$serviceTypeObj = getObject('serviceType');
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['serviceTaskTypeId']=1;
	$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
	$smarty->assign('serviceTypeArray', $serviceTypeArray);

	$alertObj = getObject('alert');
	$inputReadArray['userId']=$params['userId'];
	$inputReadArray['alertNotificationId']=$params['alertNotificationId'];
	$alertObj->updateAlertNotificationIsRead($inputReadArray);
	

}

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Task Manager Keyword');
$smarty->display('viewTaskKeyword.tpl');
require_once('footer.php');
?>