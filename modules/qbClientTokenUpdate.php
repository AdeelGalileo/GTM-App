<?php
class qbClientTokenUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['clientQbTokenUpateId']){
			
			$qbClientTokenObj = getObject('qbClientToken');
			$inputArray['clientQbTokenUpateId']=$params['clientQbTokenUpateId'];
			$qbClientTokenData = $qbClientTokenObj->getQbClientTokenById($inputArray);
			$smarty->assign('qbClientTokenData', $qbClientTokenData);
			$smarty->assign('clientQbTokenUpateId', $params['clientQbTokenUpateId']);
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>