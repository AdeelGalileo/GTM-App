<?php
require_once('header.php');	
$taskManagerContentObj = getObject('taskManagerContent');
$alertObj = getObject('alert');
//For Insert
if($params['actionOperand'] == 1){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentUpdateId']=0;
	$inputArray['marshaCodeData']=$params['marshaCodeData'];
	$inputArray['serviceTypeIdData']=$params['serviceTypeIdData'];
	$inputArray['tireData']=$params['tireData'];
	$inputArray['priorityData']=$params['priorityData'];
	$inputArray['addedBoxData']=convertDateToYMD($params['addedBoxData']);
	$inputArray['dueData']=convertDateToYMD($params['dueData']);
	$inputArray['revReqData']=convertDateToYMD($params['revReqData']);
	$inputArray['revComData']=$params['revComData'];
	$inputArray['isCompleteData']=$params['isCompleteData'];
	if($params['isCompleteData']){
		//$inputArray['projComData']=DB_DATE;
		$inputArray['projComData']=convertDateToYMD($params['task_content_proj_com_date']);
	}
	$inputArray['writerIdData']=$params['writerIdData'];
	$inputArray['noUnitsData']=$params['noUnitsData'];
	$inputArray['linkToFileData']=$params['linkToFileData'];
	$inputArray['task_content_upload_link']=$params['task_content_upload_link'];
	$inputArray['notesData']=$params['notesData'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $taskManagerContentObj->addTaskManagerContent($inputArray);
	echo array2json(array('success'=>true,'message'=>TASK_CONTENT_CREATED_SUCCESSFULLY));
	exit;
}

//For Update
if($params['actionOperand'] == 2){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentUpdateId']=$params['taskContentUpdateId'];
	$inputArray['marshaCodeData']=$params['marshaCodeData'];
	$inputArray['serviceTypeIdData']=$params['serviceTypeIdData'];
	$inputArray['tireData']=$params['tireData'];
	$inputArray['priorityData']=$params['priorityData'];
	$inputArray['addedBoxData']=convertDateToYMD($params['addedBoxData']);
	$inputArray['dueData']=convertDateToYMD($params['dueData']);
	$inputArray['revReqData']=convertDateToYMD($params['revReqData']);
	$inputArray['revComData']=$params['revComData'];
	$inputArray['isCompleteData']=$params['isCompleteData'];
	if($params['isCompleteData']){
		//$inputArray['projComData']=DB_DATE;
		$inputArray['projComData']=convertDateToYMD($params['task_content_proj_com_date']);
	}
	$inputArray['writerIdData']=$params['writerIdData'];
	$inputArray['noUnitsData']=$params['noUnitsData'];
	$inputArray['linkToFileData']=$params['linkToFileData'];
	$inputArray['task_content_upload_link']=$params['task_content_upload_link'];
	$inputArray['notesData']=$params['notesData'];
	$inputArray['sessionClientId']=$params['sessionClientId'];
	$result = $taskManagerContentObj->addTaskManagerContent($inputArray);
	echo array2json(array('success'=>true,'message'=>TASK_CONTENT_UPDATED_SUCCESSFULLY));
	exit;
}
	
if($params['taskContentDelete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentDeleteId']=$params['taskContentDeleteId'];
	$result = $taskManagerContentObj->deleteTaskManagerContent($inputArray);
	echo array2json(array('success'=>true,'message'=>TASK_CONTENT_DELETED_SUCCESSFULLY));
	exit;
}	

if($params['taskContentComplete']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentCompId']=$params['taskContentCompId'];
	$inputArray['taskContentCompVal']=$params['taskContentCompVal'];
	$taskManagerContentObj->updateTaskContentComplete($inputArray);
	echo array2json(array('success'=>true,'message'=>TASK_CONTENT_UPDATED_SUCCESSFULLY));
	if($params['taskContentCompVal'] == 1){
		$notificationInpArray=array();
		$notificationInpArray['sessionClientId']=$params['sessionClientId'];
		$notificationInpArray['userId']=$params['userId'];
		$notificationInpArray['notificationModuleId']=NOTIFICATION_MODULE_TASK_CONTENT_ID;
		$emails = $alertObj->getNotificationEmails($notificationInpArray);
		if($emails){
			$fromEmail=NOTIFICATION_EMAIL;
			$toEmail= getSingleArray($emails, 'notification_email');
			$subject="Task Content Complete";
			$smarty->assign('taskContentData', $params);
			$message = $smarty->fetch('taskContentCompleteNotification.tpl');
			sendMail($fromEmail, $toEmail, $subject, $message); 
		}
	}
	$inputArray['taskContentAdminNotes']="";
	$taskManagerContentObj->updateTaskContentAdminComplete($inputArray);
	exit;
}

if($params['changeContentPriority']){
	$inputArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskPriorityId']=$params['taskPriorityId'];
	$inputArray['taskPriorityVal']=$params['taskPriorityVal'];
	$taskManagerContentObj->updateTaskContentPriority($inputArray);
	echo array2json(array('success'=>true,'message'=>PRIRORITY_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['taskContentAdminComplete']){
	$inputArray=$inputCompArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentCompId']=$params['taskContentCompId'];
	$inputArray['taskContentCompVal']=$params['taskContentCompVal'];
	$inputArray['taskContentAdminNotes']="";
	$taskManagerContentObj->updateTaskContentAdminComplete($inputArray);
	$inputCompArray['userId']=$params['userId'];
	$inputCompArray['taskContentCompId']=$params['taskContentCompId'];
	$inputCompArray['taskContentCompVal']=1;
	$taskManagerContentObj->updateTaskContentComplete($inputCompArray);
	echo array2json(array('success'=>true,'message'=>TASK_CONTENT_UPDATED_SUCCESSFULLY));
	exit;
}

if($params['taskContentAdminReassign']){
	$inputArray=$inputReassignArray=array();
	$inputArray['userId']=$params['userId'];
	$inputArray['taskContentCompId']=$params['taskContentCompId'];
	$inputArray['taskContentCompVal']=$params['taskContentCompVal'];
	$inputArray['taskContentAdminNotes']=$params['taskContentAdminNotes'];
	$inputArray['task_content_user_id_reassign']=$params['task_content_user_id_reassign'];
	$taskManagerContentObj->updateTaskContentAdminComplete($inputArray);
	$inputReassignArray['userId']=$params['userId'];
	$inputReassignArray['taskContentCompId']=$params['taskContentCompId'];
	$inputReassignArray['taskContentCompVal']=0;
	$taskManagerContentObj->updateTaskContentComplete($inputReassignArray);
	echo array2json(array('success'=>true,'message'=>TASK_CONTENT_REASSIGN_SUCCESSFULLY));
	exit;
}

?> 