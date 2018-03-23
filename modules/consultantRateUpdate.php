<?php
class consultantRateUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['rateUpdateId']){
			
			
			
			$consultantRateObj = getObject('consultantRate');
			$inputArray['userId']=$params['userId'];
			$inputArray['rateUpdateId']=$params['rateUpdateId'];
			$rateData = $consultantRateObj->getConsultantRateById($inputArray);
			$smarty->assign('rateData', $rateData);
			
			$smarty->assign('rateUpdateId', $params['rateUpdateId']);
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>