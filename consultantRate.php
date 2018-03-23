<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=$serviceTypeIpArray=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$rateArray = generateSelectOption($rateArray,0);
$smarty->assign('rateArray', $rateArray);

$rolesArray = $adminPersonnelObj->getAllUserRoles();
$smarty->assign('rolesArray', $rolesArray);

$serviceTypeIpArray['sessionClientId']=$params['sessionClientId'];
$serviceTypeObj = getObject('serviceType');
$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByClient($serviceTypeIpArray);
$smarty->assign('serviceTypeArray', $serviceTypeArray);

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Bill Rate');
$smarty->display('consultantRate.tpl');
require_once('footer.php');
?>