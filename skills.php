<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=array();
//$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$skillArray = generateSelectOption($skillArray,0);
$smarty->assign('skillArray', $skillArray);
$serviceTypeObj = getObject('serviceType');

/*$rolesArray = $adminPersonnelObj->getAllUserRoles();
$smarty->assign('rolesArray', $rolesArray);
$serviceTypeArray = $serviceTypeObj->getAllServiceTypes();
$smarty->assign('serviceTypeArray', $serviceTypeArray);
$serviceTypeIpArray['sessionClientId']=$params['sessionClientId'];
$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByClient($serviceTypeIpArray);
$smarty->assign('serviceTypeArray', $serviceTypeArray);
*/
/*
$inputArray['sessionClientId']=$params['sessionClientId'];
$inputArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
$smarty->assign('serviceTypeArray', $serviceTypeArray);
*/

$serviceTypeIpArray['sessionClientId']=$params['sessionClientId'];
$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByClient($serviceTypeIpArray);
$smarty->assign('serviceTypeArray', $serviceTypeArray);

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Skills');
$smarty->display('skills.tpl');
require_once('footer.php');
?>