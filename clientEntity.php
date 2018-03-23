<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$filterByClientArray = generateSelectOption($filterByClientArray,0);
$smarty->assign('filterByClientArray', $filterByClientArray);


$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', $codeLabelData);
$smarty->display('clientEntity.tpl');
require_once('footer.php');
?>