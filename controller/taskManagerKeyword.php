<?php
    class taskManagerKeyword extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'task_keyword');
        $this->params = $params;
    }

	
	
	/*
	function to add or update task_keyword table
	@param user array
	return single row of data
	*/
	 function addTaskManagerKeyword($params = array()) {
		$qry = 'CALL addTaskManagerKeyword(%d,%d,%d,"%s","%s","%s","%s","%s",%d,"%s",%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskKeywordUpdateId'],$params['marshaCodeData'],$params['noPagesData'],$params['notesData'],$params['task_keyword_tire'],$params['boxAddedDateData'],$params['setupDueData'],$params['setupCompleteData'],$params['dueData'],$params['submittedData'],$params['userIdData'],$params['linkDbFileData'],$params['taskDateData'],$params['priorityData'],$params['sessionClientId'],DB_DATE_TIME,$params['task_is_sub_task'],$params['task_keyword_service_type_id']);
		$rslt = $this->db->getSingleRow($qry);
		
		/*Alert send to the consultant if task created by the admin*/
		if($_SESSION['userRole'] == USER_ROLE_ADMIN){
		
			$adminPersonnelObj = getObject('adminPersonnel');
			$inputArray=array();
			$inputArray['taskId']=$rslt['taskRecordId'];
			$inputArray['taskType']=ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
			$userData = $adminPersonnelObj->getUserIdByTaskId($inputArray);
			if($userData){
				$alertNotificationInpArray=array();
				$alertNotificationInpArray['userId']=$params['userId'];
				$alertNotificationInpArray['notificationUpdateId']=0;
				$alertNotificationInpArray['alert_notification_module_user_id']=$userData['moduleUserId'];
				$alertNotificationInpArray['alert_notification_module_id']=NOTIFICATION_MODULE_TASK_KEYWORD_ID;
				$alertNotificationInpArray['alert_notification_email']=$userData['user_email'];
				$alertNotificationInpArray['sessionClientId']=$params['sessionClientId'];
				$alertNotificationInpArray['alert_notification_task_id']=$rslt['taskRecordId'];
				$alertNotificationInpArray['alert_notification_message']=ALERT_NOTIFICATION_TASK_KEYWORD_ADMIN_ASSIGN;
				$alertObj = getObject('alert');
				$alertNotificationId = $alertObj->addAlertNotification($alertNotificationInpArray);
				
				if($params['taskKeywordUpdateId']==0){
					$fromEmail=NOTIFICATION_EMAIL;
					$subject="New Task Keyword - Assigned";
					$smarty = new Smarty();
					$smarty->template_dir = TEMPLATE_PATH.DS;
					$smarty->compile_dir = SITE_PATH.DS.'templates_c'.DS; 
					$params['alertNotificationId']=$alertNotificationId;
					$params['taskRecordCreatedId']=$rslt['taskRecordId'];
					$params['taskUserFname']=$userData['user_fname'];
					$params['taskUserLname']=$userData['user_lname'];
					$params['taskCreatedType']=ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
					$smarty->assign('taskCreatedData', $params);
					$message = $smarty->fetch('taskAssignEmailTemplate.tpl');
					sendMail($fromEmail, $userData['user_email'], $subject, $message); 
				}
				
			
			}
			
		
		}
		
		/* if task complete set admin complete also*/
		if($params['setupCompleteData']){
			$inputAdminArray=array();
			$inputAdminArray['userId']=$params['userId'];
			$inputAdminArray['taskKeywordCompId']=$rslt['taskRecordId'];
			$inputAdminArray['taskKeywordCompVal']=1;
			$this->updateTaskKeywordAdminComplete($inputAdminArray);
		}
		
		return $rslt['taskRecordId'];
    }
	
	
	/*
	function to add or update task_clone table
	@param user array
	return single row of data
	*/
	 function addTaskManagerKeywordClone($params = array()) {
		$qry = 'CALL addTaskManagerKeywordClone(%d,%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskCloneTaskId'],$params['taskCloneCommonId'],DB_DATE_TIME,$params['isMainTask']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
	function to add or update task_keyword table from the source csv file
	@param user array
	return single row of data
	*/
	 function addTaskManagerKeywordForCsv($params = array()) {
		$qry = 'CALL addTaskManagerKeywordForCsv(%d,%d,%d,"%s","%s","%s","%s","%s",%d,"%s",%d,%d,"%s","%s",%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskKeywordUpdateId'],$params['marshaCodeData'],$params['noPagesData'],$params['notesData'],$params['boxLocationData'],$params['boxAddedDateData'],$params['setupDueData'],$params['setupCompleteData'],$params['dueData'],$params['submittedData'],$params['userIdData'],$params['linkDbFileData'],$params['taskDateData'],$params['sessionClientId'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
	function to get task manager keyword list
	@param task manager keyword array
	return task manager keyword arary
	*/ 
	function getTaskManagerKeywordList($params = array()){
		$start = 0;
		$limit = 50;
		$page = ($params['page']) ? $params['page']  : 1;
		if($params['fromDate']!='' && $params['toDate'] !='') {
			$fromDate = convertDateToYMD($params['fromDate']);
			$toDate   = convertDateToYMD($params['toDate']);
		}
		if($params['recCount']){
			$limit = (int) $params['recCount'];
			$start = ($page-1)* $limit;
		}
		$sortBy = 'DESC';
		$sorting="";
        if($params['orderId'] && $params['sortId'] == 1) {
            $sortOrder = $params['orderId'];
            $sortBy = 'ASC';
			$sorting= $sortOrder.' '.$sortBy;
        } elseif($params['orderId'] && $params['sortId'] == 2) {
            $sortOrder = $params['orderId'];
            $sortBy = 'DESC';
			$sorting= $sortOrder.' '.$sortBy;
        }
		$qry = 'CALL getTaskManagerKeywordList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId'],$params['divisionId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['taskManagerKeywordList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to get Task Manager Keyword By Id
    * return result of single row
    */
    function getTaskManagerKeywordById($params = array()){
        $qry = 'CALL getTaskManagerKeywordById(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskKeywordId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to delete Task Manager Keyword By Id
    * return result of single row
    */
    function deleteTaskManagerKeyword($params = array()){
        $qry = 'CALL deleteTaskManagerKeyword(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskKeywordDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to update complete field in Task Manager table Keyword By Id
    * return result of single row
    */
    function updateTaskKeywordComplete($params = array()){
        $qry = 'CALL updateTaskKeywordComplete(%d,%d,%d,"%s","%s")';
		if($params['taskKeywordCompVal'] == 1){
			$completedDate = DB_DATE;
		}
		else{
			$completedDate = "";
		}
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskKeywordCompId'],$params['taskKeywordCompVal'],DB_DATE_TIME,$completedDate);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to update admin complete or review field in Task Manager table Keyword By Id
    * return result of single row
    */
    function updateTaskKeywordAdminComplete($params = array()){
        $qry = 'CALL updateTaskKeywordAdminComplete(%d,%d,%d,"%s","%s",%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskKeywordCompId'],$params['taskKeywordCompVal'],DB_DATE_TIME,$params['taskKeywordAdminNotes'],$params['task_keyword_user_id_reassign']);
        $rslt = $this->db->getSingleRow($qry);
		
		$adminPersonnelObj = getObject('adminPersonnel');
		$inputArray=array();
		$inputArray['taskId']=$params['taskKeywordCompId'];
		$inputArray['taskType']=ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
		$userData = $adminPersonnelObj->getUserIdByTaskId($inputArray);
		if($userData){
			$alertNotificationInpArray=array();
			$alertNotificationInpArray['userId']=$params['userId'];
			$alertNotificationInpArray['notificationUpdateId']=0;
			$alertNotificationInpArray['alert_notification_module_user_id']=$userData['moduleUserId'];
			$alertNotificationInpArray['alert_notification_module_id']=NOTIFICATION_MODULE_TASK_KEYWORD_ID;
			$alertNotificationInpArray['alert_notification_email']=$userData['user_email'];
			$alertNotificationInpArray['sessionClientId']=$this->params['sessionClientId'];
			$alertNotificationInpArray['alert_notification_task_id']=$params['taskKeywordCompId'];
			
			if($params['taskKeywordCompVal'] == 2){
				$alertNotificationInpArray['alert_notification_message']=ALERT_NOTIFICATION_TASK_KEYWORD_ADMIN_REASSIGN_MSG;
				$taskDataMessage=TASK_KEYWORD_REASSIGN_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX;
			}
			else{
				$alertNotificationInpArray['alert_notification_message']=ALERT_NOTIFICATION_TASK_KEYWORD_ADMIN_COMPLETE_MSG;
				$taskDataMessage=TASK_KEYWORD_COMPLETE_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX;
			}
			
			$alertObj = getObject('alert');
			$alertObj->addAlertNotification($alertNotificationInpArray);
			
			if($params['taskKeywordCompVal']>0){
				$taskAlertIp=array();
				$taskAlertIp['sessionClientId']=$this->params['sessionClientId'];
				$taskAlertIp['notificationModuleId']=TASK_KEYWORD_ALERT_FOR_CONSULTANT;
				$taskAlertsData = $alertObj->checkTaskAlert($taskAlertIp);
				if(($userData['user_email']) && ($taskAlertsData)){
					$taskData=$this->getTaskManagerKeywordByIdForAlert($params['taskKeywordCompId']);
					$fromEmail=NOTIFICATION_EMAIL;
					$subject=$alertNotificationInpArray['alert_notification_message'];
					$smarty = new Smarty();
					$smarty->template_dir = TEMPLATE_PATH.DS;
					$smarty->compile_dir = SITE_PATH.DS.'templates_c'.DS; 
					$smarty->assign('taskData', $taskData);
					$smarty->assign('taskDataMessage', $taskDataMessage);
					$message = $smarty->fetch('taskNotificationToConsultant.tpl');
					sendMail($fromEmail, $userData['user_email'], $subject, $message); 
				}
			}
			
		}
		
		return $rslt;
    }
	
	/*
    * Function to update priority field in Task Manager table Keyword By Id
    * return result of single row
    */
    function getTaskManagerKeywordByIdForAlert($taskId){
        $qry = 'CALL getTaskManagerKeywordByIdForAlert(%d)';
        $qry = $this->db->prepareQuery($qry,$taskId);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to update priority field in Task Manager table Keyword By Id
    * return result of single row
    */
    function updateTaskKeywordPriority($params = array()){
        $qry = 'CALL updateTaskKeywordPriority(%d,%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskPriorityId'],$params['taskPriorityVal'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
	function to get  task count
	@param rate array
	return rate arary
	*/ 
	function getTaskCount($params = array()){
		if($params['fromDate']!='' && $params['toDate'] !='') {
			$fromDate = convertDateToYMD($params['fromDate']);
			$toDate   = convertDateToYMD($params['toDate']);
		}
		$qry = 'CALL getTaskCount(%d,%d,%d,"%s","%s",%d,%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['filterBy'],$params['userRole'],$fromDate, $toDate,$params['writerId'],$params['sessionClientId'], $params['isComplete']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['total'];
	}
	
	
	/*
    * Function to getMaxTaskCloneCommonId
    * return result of single row
    */
    function getMaxTaskCloneCommonId(){
        $qry = 'CALL getMaxTaskCloneCommonId()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt['commonId'];
    }
	
	/*
    * Function to getSubTaskCloneCommonId
    * return result of single row
    */
    function getSubTaskCloneCommonId($params = array()){
        $qry = 'CALL getSubTaskCloneCommonId(%d)';
        $qry = $this->db->prepareQuery($qry,$params['taskRecordId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to getKeywordSetupStatus
    * return result of single row
    */
    function getKeywordSetupStatus($params = array()){
        $qry = 'CALL getKeywordSetupStatus(%d,%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['task_clone_task_id'],$params['task_clone_common_id']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to getKeywordSetup if complete to update the task by consultant
    * return result of single row
    */
    function getIfKeywordSetupComplete($params = array()){
        $qry = 'CALL getIfKeywordSetupComplete(%d)';
        $qry = $this->db->prepareQuery($qry,$params['taskKeywordCompId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>