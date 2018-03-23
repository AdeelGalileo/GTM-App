<?php
class taskManagerContentUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['taskContentId']){
			
			$adminPersonnelObj = getObject('adminPersonnel');
			$taskManagerContentObj = getObject('taskManagerContent');
			
			$inputArray['userId']=$params['userId'];
			$inputArray['taskContentId']=$params['taskContentId'];
			$taskContentData = $taskManagerContentObj->getTaskManagerContentById($inputArray);
			$smarty->assign('taskContentData', $taskContentData);
			$smarty->assign('taskContentId', $params['taskContentId']);
			
			$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
			$userArray = $adminPersonnelObj->getUsersByRole($userIpArray);
			$smarty->assign('userArray', $userArray);
			$clientEntityObj = getObject('clientEntity');
			$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
			$smarty->assign('marshaCodesArray', $marshaCodesArray);
			
			$serviceTypeObj = getObject('serviceType');
			
			if($_SESSION['userRole'] == USER_ROLE_ADMIN){
				//$serviceTypeArray = $serviceTypeObj->getAllServiceTypes();
				$inputArray['sessionClientId']=$params['sessionClientId'];
				$inputArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
				$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
			}
			else{
				$inputServiceArray['userId']=$params['userId'];
				$inputServiceArray['sessionClientId']=$params['sessionClientId'];
				$serviceTypeArray = $serviceTypeObj->getAllServiceTypesByUser($inputServiceArray);
			}
			
			$smarty->assign('serviceTypeArray', $serviceTypeArray);
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent, 'pagination'=>$pagination, 'totalRecords'=>$totalRecords, 'totalPages' => $totalPages);
	}
}
?>