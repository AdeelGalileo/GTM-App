<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$modulesObj = getObject('modulesList');
$modulesArray = $modulesObj->getModules();
$smarty->assign('modulesArray', $modulesArray);

$filterByContentConsultantArray = generateSelectOption($filterByContentConsultantArray,0);
$smarty->assign('filterByContentConsultantArray', $filterByContentConsultantArray);

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
//$pageLinkTitle="Admin";
//$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Consultant');
$smarty->display('consultant.tpl');
require_once('footer.php');
?>