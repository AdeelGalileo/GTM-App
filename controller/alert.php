<?php
    class alert extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'notification');
        $this->params = $params;
    }

	
	
	/*
	function to add or update notification table
	@param user array
	return single row of data
	*/
	 function addAlert($params = array()) {
		$qry = 'CALL addAlert(%d,%d,%d,%d,"%s",%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['notificationUpdateId'],$params['notification_user_id'],$params['notification_module_id'],$params['notification_email'],$params['sessionClientId'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
		/*
	function to add or update notification table
	@param user array
	return single row of data
	*/
	 function addAlertNotification($params = array()) {
		$qry = 'CALL addAlertNotification(%d,%d,%d,%d,"%s",%d,"%s",%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['notificationUpdateId'],$params['alert_notification_module_user_id'],$params['alert_notification_module_id'],$params['alert_notification_email'],$params['sessionClientId'],DB_DATE_TIME,$params['alert_notification_task_id'],$params['alert_notification_message']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['alertNotificationId'];
    }
	
	
	/*
	function to get notification list
	@param notification array
	return notification arary
	*/ 
	function getAlertList($params = array()){
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
		$qry = 'CALL getAlertList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['alertList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to get Alert By Id
    * return result of single row
    */
    function getAlertById($params = array()){
        $qry = 'CALL getAlertById(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['alertId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to delete Task Manager Keyword By Id
    * return result of single row
    */
    function deleteAlert($params = array()){
        $qry = 'CALL deleteAlert(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['alertDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
	function to get  task count
	@param rate array
	return rate arary
	*/ 
	function getAlertCount($params = array()){
		if($params['fromDate']!='' && $params['toDate'] !='') {
			$fromDate = convertDateToYMD($params['fromDate']);
			$toDate   = convertDateToYMD($params['toDate']);
		}
		$qry = 'CALL getAlertCount(%d,%d,%d,"%s","%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['filterBy'],$params['userRole'],$fromDate, $toDate,$params['writerId'],$params['sessionClientId']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['total'];
	}
	
	/*
    * Function to get notification emails by modules
    * return result of array
    */
    function getNotificationEmails($params = array()){
        $qry = 'CALL getNotificationEmails(%d,%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['notificationModuleId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
	function to get alert notification  count
	@param rate array
	return rate arary
	*/ 
	function getAlertNotificationCount($params = array()){
		$qry = 'CALL getAlertNotificationCount(%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'],$params['sessionClientId']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['total'];
	}
	
	
	/*
	function to get alert notification list
	@param notification array
	return notification arary
	*/ 
	function getAlertNotifications($params = array()){
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
		$qry = 'CALL getAlertNotifications(%d,%d,%d,"%s","%s",%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['alertNotificationList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	
	/*
    * Function to update alert notification is read
    * return result of single row
    */
    function updateAlertNotificationIsRead($params = array()){
        $qry = 'CALL updateAlertNotificationIsRead(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['alertNotificationId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to check alert
    * return result of single row
    */
    function checkTaskAlert($params = array()){
        $qry = 'CALL checkTaskAlert(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['sessionClientId'],$params['notificationModuleId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	
}
?>