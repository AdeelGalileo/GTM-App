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
	
	$adminPersonnelObj = getObject('adminPersonnel');
	$taskManagerContentObj = getObject('taskManagerContent');

	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentId']=$params['taskId'];
	$taskContentData = $taskManagerContentObj->getTaskManagerContentById($inputArray);
	$smarty->assign('taskContentData', $taskContentData);
	$smarty->assign('taskId', $params['taskId']);

	$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
	$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
	$smarty->assign('userArray', $userArray);
	$clientEntityObj = getObject('clientEntity');
	$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
	$smarty->assign('marshaCodesArray', $marshaCodesArray);

	$serviceTypeObj = getObject('serviceType');

	if($_SESSION['userRole'] == USER_ROLE_ADMIN){
		$serviceTypeArray = $serviceTypeObj->getAllServiceTypes();
	}
	else{
		$inputServiceArray['userId']=$params['userId'];
		$inputServiceArray['sessionClientId']=$params['sessionClientId'];
		$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByUser($inputServiceArray);
	}
			
	$smarty->assign('serviceTypeArray', $serviceTypeArray);

	$alertObj = getObject('alert');
	$inputReadArray['userId']=$params['userId'];
	$inputReadArray['alertNotificationId']=$params['alertNotificationId'];
	$alertObj->updateAlertNotificationIsRead($inputReadArray);

}

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Task Manager Keyword');
$smarty->display('viewTaskContent.tpl');
require_once('footer.php');
?>