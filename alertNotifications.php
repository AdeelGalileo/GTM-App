<?php
require_once('header.php');
/*
if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
	$smarty->assign('lastPage', 'Task Manager Keyword');
	$smarty->assign('formUploadPending', true);
	$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
	$smarty->display('formPendingMessage.tpl');
	exit;
}
*/
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Notifications');
$smarty->display('alertNotifications.tpl');
require_once('footer.php');
?>