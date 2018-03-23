<?php
class getConsultantBySkillModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		$skillsObj = getObject('skills');
		$params['formStatus']=FORM_COMPLETE;
		$consultantList = $skillsObj->getConsultantBySkill($params);
		$taskManagerContentObj = getObject('taskManagerContent');
		$smarty->assign('consultantList', $consultantList);
		
		$inputArray['userId']=$params['userId'];
		$inputArray['taskContentId']=$params['taskContentId'];
		$taskContentData = $taskManagerContentObj->getTaskManagerContentById($inputArray);
		$smarty->assign('taskContentData', $taskContentData);
	
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>