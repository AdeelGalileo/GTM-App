<?php
class clientEntityUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['clientEntityUpdateId']){
			
			
			$clientEntityObj = getObject('clientEntity');
			
			$clientDivsionObj = getObject('clientDivision');

			$inputArray['clientEntityUpdateId']=$params['clientEntityUpdateId'];
			$clientEntityData = $clientEntityObj->getClientEntityById($inputArray);
			$smarty->assign('clientEntityData', $clientEntityData);
			$smarty->assign('clientEntityUpdateId', $params['clientEntityUpdateId']);
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>