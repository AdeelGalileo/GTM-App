<?php
class skillUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['skillUpateId']){
			
			$adminPersonnelObj = getObject('adminPersonnel');
			$userIpArray=array();
			$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
			$smarty->assign('userArray', $userArray);
			
			$serviceTypeObj = getObject('serviceType');
			/*$serviceTypeArray = $serviceTypeObj->getAllServiceTypes();
			$serviceTypeIpArray['sessionClientId']=$params['sessionClientId'];
			$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByClient($serviceTypeIpArray);
			$smarty->assign('serviceTypeArray', $serviceTypeArray);
			$inputSerArray['sessionClientId']=$params['sessionClientId'];
			$inputSerArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
			$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputSerArray);
			$smarty->assign('serviceTypeArray', $serviceTypeArray);*/
			
			$serviceTypeIpArray['sessionClientId']=$params['sessionClientId'];
			$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByClient($serviceTypeIpArray);
			$smarty->assign('serviceTypeArray', $serviceTypeArray);
			
			$skillsObj = getObject('skills');
			$inputArray['userId']=$params['userId'];
			$inputArray['skillUpateId']=$params['skillUpateId'];
			$skillData = $skillsObj->getConsultantSkillById($inputArray);
			$smarty->assign('consultantSkillData', $skillData['consultantSkillData']);
			$smarty->assign('consultantSkillItems', $skillData['consultantSkillItems']);
			if($skillData['consultantSkillItems']){
				$smarty->assign('service_type_existing_id', explode(",",$skillData['consultantSkillItems']['service_type_id']));
			}
			
		
			
			$smarty->assign('skillUpateId', $params['skillUpateId']);
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>