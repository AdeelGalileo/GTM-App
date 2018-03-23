<?php
class taskManagerKeywordUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['taskKeywordId']){
			
			$adminPersonnelObj = getObject('adminPersonnel');
			$taskManagerKeywordObj = getObject('taskManagerKeyword');
			
			$inputArray['userId']=$params['userId'];
			$inputArray['taskKeywordId']=$params['taskKeywordId'];
			$taskKeywordData = $taskManagerKeywordObj->getTaskManagerKeywordById($inputArray);
			$smarty->assign('taskKeywordData', $taskKeywordData);
			$smarty->assign('taskKeywordId', $params['taskKeywordId']);
			
			$disableEdit=false;
			//if($_SESSION['userRole'] == USER_ROLE_CONSULTANT){
				if($taskKeywordData['task_clone_id'] > 0 && $taskKeywordData['task_clone_task_id'] > 0 && $taskKeywordData['task_clone_is_main_task'] == 0){
					$inputStatusArray['userId']=$params['userId'];
					$inputStatusArray['task_clone_task_id']=$taskKeywordData['task_clone_task_id'];
					$inputStatusArray['task_clone_common_id']=$taskKeywordData['task_clone_common_id'];
					$taskKeywordSetupStatusData = $taskManagerKeywordObj->getKeywordSetupStatus($inputStatusArray);
					if($taskKeywordSetupStatusData['task_keyword_setup_complete'] == 0){
						$disableEdit=true;
					}
				}
			//}
			$smarty->assign('disableEdit', $disableEdit);
			
			$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
			$userIpArray['formStatus']=FORM_COMPLETE;
			$userArray = $adminPersonnelObj->getUsersByForm($userIpArray);
			$smarty->assign('userArray', $userArray);
			$clientEntityObj = getObject('clientEntity');
			$marshaCodesArray = $clientEntityObj->getMarshaCodes($clientEntity);
			$smarty->assign('marshaCodesArray', $marshaCodesArray);
			
			$serviceTypeObj = getObject('serviceType');
			$inputArray['sessionClientId']=$params['sessionClientId'];
			$inputArray['serviceTaskTypeId']=ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
			$serviceTypeArray = $serviceTypeObj->getServiceTypeByTaskType($inputArray);
			$smarty->assign('serviceTypeArray', $serviceTypeArray);
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent, 'pagination'=>$pagination, 'totalRecords'=>$totalRecords, 'totalPages' => $totalPages);
	}
}
?>