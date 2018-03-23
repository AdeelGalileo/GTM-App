<?php
class alertNotificationCountModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		$alertObj = getObject('alert');
		$alertNotificationArray['userId']=$params['userId'];
		$alertNotificationArray['sessionClientId']=$params['sessionClientId'];
		$alertNotificationCount = $alertObj->getAlertNotificationCount($alertNotificationArray);
		$smarty->assign('alertNotificationCount', $alertNotificationCount);
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>