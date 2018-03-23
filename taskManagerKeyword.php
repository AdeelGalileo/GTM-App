<?php
require_once('header.php');

if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
	$smarty->assign('lastPage', 'Task Manager Keyword');
	$smarty->assign('formUploadPending', true);
	$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
	$smarty->display('formPendingMessage.tpl');
	exit;
}

$serviceTypeObj = getObject('serviceType');
$inputArray['sessionClientId']=$params['sessionClientId'];
$inputArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
$smarty->assign('serviceTypeArray', $serviceTypeArray);

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=$clientEntity=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userIpArray['formStatus']=FORM_COMPLETE;

$userArray = $adminPersonnelObj->getUsersByForm($userIpArray);
$smarty->assign('userArray', $userArray);
$filterByArray = generateSelectOption($filterByArray,0);
$smarty->assign('filterByArray', $filterByArray);

$clientEntityObj = getObject('clientEntity');
$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
$smarty->assign('marshaCodesArray', $marshaCodesArray);


$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Task Manager Keyword');
$smarty->display('taskManagerKeyword.tpl');
require_once('footer.php');
?>