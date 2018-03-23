<?php
require_once('header.php');
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Consultant Bill');
$smarty->display('consultantBill.tpl');
require_once('footer.php');
?>