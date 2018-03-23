<?php
require_once('header.php');

if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
	$smarty->assign('lastPage', 'Consultants');
	$smarty->assign('formUploadPending', true);
	$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
	$smarty->display('formPendingMessage.tpl');
	exit;
}

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$modulesObj = getObject('modulesList');
$modulesArray = $modulesObj->getModules();
$smarty->assign('modulesArray', $modulesArray);

$adminConsultantArray = generateSelectOption($adminConsultantArray,0);
$smarty->assign('adminConsultantArray', $adminConsultantArray);

$adminConsultantBillingArray = generateSelectOption($adminConsultantBillingArray,0);
$smarty->assign('adminConsultantBillingArray', $adminConsultantBillingArray);

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
if($_SESSION['userRole'] == USER_ROLE_ADMIN){
	$pageLinkTitle="Admin";
	$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
}

$smarty->assign('lastPage', 'Consultants');
$smarty->display('adminConsultant.tpl');
require_once('footer.php');
?>