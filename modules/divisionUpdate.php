<?php
class divisionUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['divisionUpdateId']){
			$divisionObj = getObject('division');
			$inputArray['sessionClientId']=$params['sessionClientId'];
			$inputArray['divisionUpdateId']=$params['divisionUpdateId'];
			$divisionData = $divisionObj->getDivisionById($inputArray);
			$smarty->assign('divisionData', $divisionData);
			$smarty->assign('divisionUpdateId', $params['divisionUpdateId']);
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>