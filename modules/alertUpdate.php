<?php
class alertUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['alertId']){
			
			$alertObj = getObject('alert');
			$adminPersonnelObj = getObject('adminPersonnel');
			
			$inputArray['userId']=$params['userId'];
			$inputArray['alertId']=$params['alertId'];
			$alertData = $alertObj->getAlertById($inputArray);
			$smarty->assign('alertData', $alertData);
			$smarty->assign('alertId', $params['alertId']);
			
			$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
			$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
			$smarty->assign('userArray', $userArray);
			
			$modulesObj = getObject('modulesList');
			$modulesArray = $modulesObj->getModules();
			$smarty->assign('modulesArray', $modulesArray);
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>