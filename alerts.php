<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=array();
$userIpArray['userRoleIp']=USER_ROLE_ADMIN;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$modulesObj = getObject('modulesList');
$modulesArray = $modulesObj->getModules();
$smarty->assign('modulesArray', $modulesArray);

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Alerts');
$smarty->display('alerts.tpl');
require_once('footer.php');
?>