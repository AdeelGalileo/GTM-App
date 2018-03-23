<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=$clientEntity=array();
$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
$smarty->assign('userArray', $userArray);

$invoiceFilterArray = generateSelectOption($invoiceFilterArray,0);
$smarty->assign('invoiceFilterArray', $invoiceFilterArray);

$serviceTypeObj = getObject('serviceType');
$serviceTypeIpArray['sessionClientId']=$params['sessionClientId'];
$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByClient($serviceTypeIpArray);
$smarty->assign('serviceTypeArray', $serviceTypeArray);

$clientEntityObj = getObject('clientEntity');
$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
$smarty->assign('marshaCodesArray', $marshaCodesArray);

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
//$pageLinkTitle="Admin";
//$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Invoice');
$smarty->display('invoice.tpl');
require_once('footer.php');
?>