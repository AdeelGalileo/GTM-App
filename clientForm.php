<?php
require_once('header.php');
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('pageLink', ROOT_HTTP_PATH.'/clientForm.php');
$smarty->assign('lastPage', 'Client Form');
$smarty->display('clientForm.tpl');
require_once('footer.php');
?>