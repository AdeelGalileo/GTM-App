<?php
require_once('header.php');
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Quick Book Token Setup');
$smarty->display('qbClientToken.tpl');
require_once('footer.php');
?>