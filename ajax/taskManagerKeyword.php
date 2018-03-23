<?php
require_once('header.php');	
$taskManagerKeywordObj = getObject('taskManagerKeyword');
$alertObj = getObject('alert');
//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordUpdateId']=0;
	$inputArray['marshaCodeData']=$params['marshaCodeData'];
	$inputArray['task_keyword_service_type_id']=$params['task_keyword_service_type_id'];
	$inputArray['noPagesData']=$params['noPagesData'];
	$inputArray['boxAddedDateData']=convertDateToYMD($params['boxAddedDateData']);
	$inputArray['linkDbFileData']=$params['linkDbFileData'];
	$inputArray['priorityData']=$params['priorityData'];
	$inputArray['setupDueData']=convertDateToYMD($params['setupDueData']);
	$inputArray['setupCompleteData']=$params['setupCompleteData'];
	if($params['setupCompleteData']){
		$inputArray['taskDateData']=convertDateToYMD($params['taskCompletedDate']);
	}
	$inputArray['userIdData']=$params['userIdData'];
	$inputArray['task_is_sub_task']=$params['task_is_sub_task'];
	$inputArray['notesData']=$params['notesData'];
	$inputArray['task_keyword_tire']=$params['task_keyword_tire'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $taskManagerKeywordObj->addTaskManagerKeyword($inputArray);
	
	if($_SESSION['userRole'] == USER_ROLE_ADMIN){
		if($params['taskCloneStatusId']){
			if($params['task_is_sub_task']){
				$subTaskIpArray=array();
				$subTaskIpArray['taskRecordId']=$params['taskRecordId'];
				$subTaskCloneData = $taskManagerKeywordObj->getSubTaskCloneCommonId($subTaskIpArray);
				$taskCloneCommonId = $subTaskCloneData['task_clone_common_id'];
			}
			else{
				$taskCloneCommonId = $taskManagerKeywordObj->getMaxTaskCloneCommonId();
			}
			
			if($params['task_keyword_service_type_id'] == SERVICE_TYPE_KEYWORD_SETUP_ID){
				$isMainTask=1;
			}
			else{
				$isMainTask=0;
			}
			
			$inputCloneArray['userId']=$params['userId'];
			$inputCloneArray['taskCloneTaskId']=$result;
			$inputCloneArray['taskCloneCommonId']=$taskCloneCommonId;
			$inputCloneArray['isMainTask']=$isMainTask;
			$taskManagerKeywordObj->addTaskManagerKeywordClone($inputCloneArray);
		}
	}
	
	echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_CREATED_SUCCESSFULLY,'taskRecordId'=>$result));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordUpdateId']=$params['taskKeywordUpdateId'];
	$inputArray['marshaCodeData']=$params['marshaCodeData'];
	$inputArray['task_keyword_service_type_id']=$params['task_keyword_service_type_id'];
	$inputArray['noPagesData']=$params['noPagesData'];
	$inputArray['boxAddedDateData']=convertDateToYMD($params['boxAddedDateData']);
	$inputArray['linkDbFileData']=$params['linkDbFileData'];
	$inputArray['priorityData']=$params['priorityData'];
	$inputArray['setupDueData']=convertDateToYMD($params['setupDueData']);
	$inputArray['setupCompleteData']=$params['setupCompleteData'];
	if($params['setupCompleteData']){
		$inputArray['taskDateData']=convertDateToYMD($params['taskCompletedDate']);
	}
	$inputArray['userIdData']=$params['userIdData'];
	$inputArray['task_is_sub_task']=$params['task_is_sub_task'];
	$inputArray['notesData']=$params['notesData'];
	$inputArray['task_keyword_tire']=$params['task_keyword_tire'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $taskManagerKeywordObj->addTaskManagerKeyword($inputArray);
	if($_SESSION['userRole'] == USER_ROLE_ADMIN){
		if($params['taskCloneStatusId']){
			
			if($params['task_keyword_service_type_id'] == SERVICE_TYPE_KEYWORD_SETUP_ID){
				$isMainTask=1;
			}
			else{
				$isMainTask=0;
			}
			
			$taskCloneCommonId = $taskManagerKeywordObj->getMaxTaskCloneCommonId();
			$inputCloneArray['userId']=$params['userId'];
			$inputCloneArray['taskCloneTaskId']=$result;
			$inputCloneArray['taskCloneCommonId']=$taskCloneCommonId;
			$inputCloneArray['isMainTask']=$isMainTask;
			$taskManagerKeywordObj->addTaskManagerKeywordClone($inputCloneArray);
		}
	}
	echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_UPDATED_SUCCESSFULLY,'taskRecordId'=>$result));
	exit;
}

if($params['taskKeywordDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordDeleteId']=$params['taskKeywordDeleteId'];
	$taskManagerKeywordObj->deleteTaskManagerKeyword($inputArray);
	echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_DELETED_SUCCESSFULLY));
	exit;
}	
	
if($params['taskKeywordComplete']){
	
	if($params['attrIsSubTask'] == 1){
		$inputStatusArray['taskKeywordCompId']=$params['taskKeywordCompId'];
		$taskKeywordSetupStatusData = $taskManagerKeywordObj->getIfKeywordSetupComplete($inputStatusArray);
		if($taskKeywordSetupStatusData['task_keyword_setup_complete'] == 0){
			echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_UPDATE_DISABLE_MSG));
			exit;
		}
	}
	
	$inputArray=$inputAdminArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordCompId']=$params['taskKeywordCompId'];
	$inputArray['taskKeywordCompVal']=$params['taskKeywordCompVal'];
	$taskManagerKeywordObj->updateTaskKeywordComplete($inputArray);
	echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_UPDATED_SUCCESSFULLY));
	if($params['taskKeywordCompVal'] == 1){
		$notificationInpArray=array();
		$notificationInpArray['sessionClientId']=$params['sessionClientId'];
		$notificationInpArray['userId']=$params['userId'];
		$notificationInpArray['notificationModuleId']=NOTIFICATION_MODULE_TASK_KEYWORD_ID;
		$emails = $alertObj->getNotificationEmails($notificationInpArray);
		if($emails){
			$fromEmail=NOTIFICATION_EMAIL;
			$toEmail= getSingleArray($emails, 'notification_email');
			$subject="Task Keyword Complete";
			$smarty->assign('taskKeywordData', $params);
			$message = $smarty->fetch('taskKeywordCompleteNotification.tpl');
			sendMail($fromEmail, $toEmail, $subject, $message); 
		}
		
	}
	//Trigger the admin complete when the task complete by the consultant
	$inputArray['taskKeywordAdminNotes']="";
	$taskManagerKeywordObj->updateTaskKeywordAdminComplete($inputArray);
	exit;
}

if($params['changeKeywordPriority']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskPriorityId']=$params['taskPriorityId'];
	$inputArray['taskPriorityVal']=$params['taskPriorityVal'];
	$taskManagerKeywordObj->updateTaskKeywordPriority($inputArray);
	echo array2json(array('success'=>true,'message'=>PRIRORITY_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['taskKeywordAdminComplete']){
	$inputArray=$inputCompArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordCompId']=$params['taskKeywordCompId'];
	$inputArray['taskKeywordCompVal']=$params['taskKeywordCompVal'];
	$inputArray['taskKeywordAdminNotes']="";
	$taskManagerKeywordObj->updateTaskKeywordAdminComplete($inputArray);
	$inputCompArray['userId']=$params['userId'];
	$inputCompArray['taskKeywordCompId']=$params['taskKeywordCompId'];
	$inputCompArray['taskKeywordCompVal']=1;
	$taskManagerKeywordObj->updateTaskKeywordComplete($inputCompArray);
	echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['taskKeywordAdminReassign']){
	$inputArray=$inputReassignArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskKeywordCompId']=$params['taskKeywordCompId'];
	$inputArray['taskKeywordCompVal']=$params['taskKeywordCompVal'];
	$inputArray['taskKeywordAdminNotes']=$params['taskKeywordAdminNotes'];
	$inputArray['task_keyword_user_id_reassign']=$params['task_keyword_user_id_reassign'];
	$taskManagerKeywordObj->updateTaskKeywordAdminComplete($inputArray);
	$inputReassignArray['userId']=$params['userId'];
	$inputReassignArray['taskKeywordCompId']=$params['taskKeywordCompId'];
	$inputReassignArray['taskKeywordCompVal']=0;
	$taskManagerKeywordObj->updateTaskKeywordComplete($inputReassignArray);
	echo array2json(array('success'=>true,'message'=>TASK_KEYWORD_REASSIGN_SUCCESSFULLY));
	exit;
}
?> 