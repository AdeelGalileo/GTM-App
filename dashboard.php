<?php
require_once('header.php');
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$billingCountInputArray=$invoiceCountInputArray=$pendingTaskInputArray=$completedTaskInputArray=$alertCountInputArray=array();

$billingObj = getObject('billing');
$billingCountInputArray['userId']=$params['userId'];
$billingCountInputArray['userRole']=$params['userRole'];
$billingCountInputArray['sessionClientId']=$params['sessionClientId'];
$billingCount = $billingObj->getBillingCount($billingCountInputArray);
$smarty->assign('billingCount', $billingCount);


$invoiceObj = getObject('invoice');
$invoiceCountInputArray['userId']=$params['userId'];
$invoiceCountInputArray['userRole']=$params['userRole'];
$invoiceCountInputArray['sessionClientId']=$params['sessionClientId'];
$invoiceCount = $invoiceObj->getInvoiceCount($invoiceCountInputArray);
$smarty->assign('invoiceCount', $invoiceCount);


$taskObj = getObject('taskManagerKeyword');
$pendingTaskInputArray['userId']=$params['userId'];
$pendingTaskInputArray['userRole']=$params['userRole'];
$pendingTaskInputArray['sessionClientId']=$params['sessionClientId'];
$pendingTaskInputArray['isComplete']=2;
$pendingTaskCount = $taskObj->getTaskCount($pendingTaskInputArray);
$smarty->assign('pendingTaskCount', $pendingTaskCount);

$completedTaskInputArray['userId']=$params['userId'];
$completedTaskInputArray['userRole']=$params['userRole'];
$completedTaskInputArray['sessionClientId']=$params['sessionClientId'];
$completedTaskInputArray['isComplete']=1;
$completedTaskCount = $taskObj->getTaskCount($completedTaskInputArray);
$smarty->assign('completedTaskCount', $completedTaskCount);

$alertObj = getObject('alert');
$alertCountInputArray['userId']=$params['userId'];
$alertCountInputArray['userRole']=$params['userRole'];
$alertCountInputArray['sessionClientId']=$params['sessionClientId'];
$alertCount = $alertObj->getAlertCount($alertCountInputArray);
$smarty->assign('alertCount', $alertCount);

$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Dashboard');
$smarty->display('dashboard.tpl');
require_once('footer.php');
?>