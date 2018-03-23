<?php
    class taskManagerContent extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'task_content');
        $this->params = $params;
    }

	
	
	/*
	function to add or update task_content table
	@param user array
	return single row of data
	*/
	 function addTaskManagerContent($params = array()) {
		$qry = 'CALL addTaskManagerContent(%d,%d,%d,%d,"%s",%d,"%s","%s","%s","%s",%d,"%s",%d,%d,"%s","%s","%s",%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskContentUpdateId'],$params['marshaCodeData'],$params['serviceTypeIdData'],$params['tireData'],$params['priorityData'],$params['addedBoxData'],$params['dueData'],$params['revReqData'],$params['revComData'],$params['isCompleteData'],$params['projComData'],$params['writerIdData'],$params['noUnitsData'],$params['linkToFileData'],$params['notesData'],DB_DATE_TIME,$params['sessionClientId'],$params['task_content_upload_link']);
		
		$rslt = $this->db->getSingleRow($qry);
		
		if($_SESSION['userRole'] == USER_ROLE_ADMIN){
		
			$adminPersonnelObj = getObject('adminPersonnel');
			$inputArray=array();
			$inputArray['taskId']=$rslt['taskContentId'];
			$inputArray['taskType']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
			$userData = $adminPersonnelObj->getUserIdByTaskId($inputArray);
			if($userData){
				$alertNotificationInpArray=array();
				$alertNotificationInpArray['userId']=$params['userId'];
				$alertNotificationInpArray['notificationUpdateId']=0;
				$alertNotificationInpArray['alert_notification_module_user_id']=$userData['moduleUserId'];
				$alertNotificationInpArray['alert_notification_module_id']=NOTIFICATION_MODULE_TASK_CONTENT_ID;
				$alertNotificationInpArray['alert_notification_email']=$userData['user_email'];
				$alertNotificationInpArray['sessionClientId']=$params['sessionClientId'];
				$alertNotificationInpArray['alert_notification_task_id']=$rslt['taskContentId'];
				$alertNotificationInpArray['alert_notification_message']=ALERT_NOTIFICATION_TASK_CONTENT_ADMIN_ASSIGN;
				$alertObj = getObject('alert');
				$alertNotificationId = $alertObj->addAlertNotification($alertNotificationInpArray);
				
				if($params['taskContentUpdateId']==0){
					$fromEmail=NOTIFICATION_EMAIL;
					$subject="New Task Content - Assigned";
					$smarty = new Smarty();
					$smarty->template_dir = TEMPLATE_PATH.DS;
					$smarty->compile_dir = SITE_PATH.DS.'templates_c'.DS; 
					$params['alertNotificationId']=$alertNotificationId;
					$params['taskRecordCreatedId']=$rslt['taskContentId'];
					$params['taskUserFname']=$userData['user_fname'];
					$params['taskUserLname']=$userData['user_lname'];
					$params['taskCreatedType']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
					$smarty->assign('taskCreatedData', $params);
					$message = $smarty->fetch('taskAssignEmailTemplate.tpl');
					sendMail($fromEmail, $userData['user_email'], $subject, $message); 
				}
				
			}
		
		}
		
		/* if task complete set admin complete also*/
		if($params['isCompleteData']){
			$inputAdminArray=array();
			$inputAdminArray['userId']=$params['userId'];
			$inputAdminArray['taskContentCompId']=$rslt['taskContentId'];
			$inputAdminArray['taskContentCompVal']=1;
			$this->updateTaskContentAdminComplete($inputAdminArray);
		}
		
		return $rslt;
    }
	
	
	/*
	function to get task manager keyword list
	@param task manager keyword array
	return task manager keyword arary
	*/ 
	function getTaskManagerContentList($params = array()){
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
		$qry = 'CALL getTaskManagerContentList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'], $params['divisionId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['taskManagerContentList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to get Task Manager Keyword By Id
    * return result of single row
    */
    function getTaskManagerContentById($params = array()){
        $qry = 'CALL getTaskManagerContentById(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskContentId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get Task Manager Content By Id
    * return result of single row
    */
    function deleteTaskManagerContent($params = array()){
        $qry = 'CALL deleteTaskManagerContent(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskContentDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
	function to get task manager keyword list for consultant
	@param task manager keyword array
	return task manager keyword arary
	*/ 
	function getConsultantTaskManagerContentList($params = array()){
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
		$qry = 'CALL getConsultantTaskManagerContentList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$params['isCompleteData']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['taskManagerContentList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to update complete field in Task Manager table content By Id
    * return result of single row
    */
    function updateTaskContentComplete($params = array()){
		if($params['taskContentCompVal'] == 1){
			$completedDate = DB_DATE;
		}
		else{
			$completedDate = "";
		}
        $qry = 'CALL updateTaskContentComplete(%d,%d,%d,"%s","%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskContentCompId'],$params['taskContentCompVal'],DB_DATE_TIME,$completedDate);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to update admin complete or review field in Task Manager table content By Id
    * return result of single row
    */
    function updateTaskContentAdminComplete($params = array()){
        $qry = 'CALL updateTaskContentAdminComplete(%d,%d,%d,"%s","%s",%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskContentCompId'],$params['taskContentCompVal'],DB_DATE_TIME,$params['taskContentAdminNotes'],$params['task_content_user_id_reassign']);
        $rslt = $this->db->getSingleRow($qry);
		
		$adminPersonnelObj = getObject('adminPersonnel');
		$inputArray=array();
		$inputArray['taskId']=$params['taskContentCompId'];
		$inputArray['taskType']=ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
		$userData = $adminPersonnelObj->getUserIdByTaskId($inputArray);
		if($userData){
			$alertNotificationInpArray=array();
			$alertNotificationInpArray['userId']=$params['userId'];
			$alertNotificationInpArray['notificationUpdateId']=0;
			$alertNotificationInpArray['alert_notification_module_user_id']=$userData['moduleUserId'];
			$alertNotificationInpArray['alert_notification_module_id']=NOTIFICATION_MODULE_TASK_CONTENT_ID;
			$alertNotificationInpArray['alert_notification_email']=$userData['user_email'];
			$alertNotificationInpArray['sessionClientId']=$this->params['sessionClientId'];
			$alertNotificationInpArray['alert_notification_task_id']=$params['taskContentCompId'];
			
			if($params['taskContentCompVal'] == 2){
				$alertNotificationInpArray['alert_notification_message']=ALERT_NOTIFICATION_TASK_CONTENT_ADMIN_REASSIGN_MSG;
				$taskDataMessage=TASK_CONTENT_REASSIGN_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX;
			}
			else{
				$alertNotificationInpArray['alert_notification_message']=ALERT_NOTIFICATION_TASK_CONTENT_ADMIN_COMPLETE_MSG;
				$taskDataMessage=TASK_CONTENT_COMPLETE_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX;
			}
			
			$alertObj = getObject('alert');
			$alertObj->addAlertNotification($alertNotificationInpArray);
			
			if($params['taskContentCompVal']>0){
				$taskAlertIp=array();
				$taskAlertIp['sessionClientId']=$this->params['sessionClientId'];
				$taskAlertIp['notificationModuleId']=TASK_CONTENT_ALERT_FOR_CONSULTANT;
				$taskAlertsData = $alertObj->checkTaskAlert($taskAlertIp);
				
				if(($userData['user_email']) && ($taskAlertsData)){
					$taskData=$this->getTaskManagerContentByIdForAlert($params['taskContentCompId']);
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
    function getTaskManagerContentByIdForAlert($taskId){
        $qry = 'CALL getTaskManagerContentByIdForAlert(%d)';
        $qry = $this->db->prepareQuery($qry,$taskId);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
	function to get task manager keyword list for consultant
	@param task manager keyword array
	return task manager keyword arary
	*/ 
	function getAdminConsultantTaskList($params = array()){
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
		$qry = 'CALL getAdminConsultantTaskList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$params['isCompleteData'],$params['divisionId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['taskList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to update priority field in Task content table Keyword By Id
    * return result of single row
    */
    function updateTaskContentPriority($params = array()){
        $qry = 'CALL updateTaskContentPriority(%d,%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskPriorityId'],$params['taskPriorityVal'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
}
?>