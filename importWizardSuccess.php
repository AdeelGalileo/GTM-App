<?php
require_once('header.php');

 if($_SESSION['importSuccessMsg']){
	$smarty->assign('importSuccessMsg', $params['importSuccessMsg']);
	unset($_SESSION['importSuccessMsg']);
}
	
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
//$smarty->assign('pageLink', ROOT_HTTP_PATH.'/importWizard.php');
$smarty->assign('lastPage', 'Import Wizard Success');
$smarty->display('importWizardSuccess.tpl');
require_once('footer.php');
?>