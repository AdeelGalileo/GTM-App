<?php
require_once('header.php');

if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
	$smarty->assign('lastPage', 'Task Manager Content');
	$smarty->assign('formUploadPending', true);
	$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
	$smarty->display('formPendingMessage.tpl');
	exit;
}

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=$clientEntity=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);
$filterByContentArray = generateSelectOption($filterByContentArray,0);
$smarty->assign('filterByContentArray', $filterByContentArray);

$clientEntityObj = getObject('clientEntity');
$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
$smarty->assign('marshaCodesArray', $marshaCodesArray);

$serviceTypeObj = getObject('serviceType');

if($_SESSION['userRole'] == USER_ROLE_ADMIN){
	//$serviceTypeArray = $serviceTypeObj->getAllServiceTypes();
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$inputArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
	$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
}
else{
	$inputArray['userId']=$params['userId'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByUser($inputArray);
}

$smarty->assign('serviceTypeArray', $serviceTypeArray);


$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Task Manager Content');
$smarty->display('taskManagerContent.tpl');
require_once('footer.php');
?>