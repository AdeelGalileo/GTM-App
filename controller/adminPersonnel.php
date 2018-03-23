<?php
    class adminPersonnel extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'user');
        $this->params = $params;
    }

	/*
    * Function to check User Email Exist
    * $params: UserEmail
    * return single row of data
    */
    function checkUserEmailExist($params = array()){
        $qry = 'CALL checkUserEmailExist("%s")';
        $qry = $this->db->prepareQuery($qry,$params['userEmailData']);
        $rslt = $this->db->getSingleRow($qry);
		if($rslt['userExist'] == 1){
			return true;
		}
		else{
			return false;
		}
    }
	
	/*
    * Function to check User Email Exist for update the email id
    * $params: UserEmail
    * return single row of data
    */
    function checkUserEmailExistForUpdate($params = array()){
        $qry = 'CALL checkUserEmailExistForUpdate("%s",%d)';
        $qry = $this->db->prepareQuery($qry,$params['userEmailData'],$params['userUpdateId']);
        $rslt = $this->db->getSingleRow($qry);
		if($rslt['userExist'] == 1){
			return true;
		}
		else{
			return false;
		}
    }
	
	
	 function checkUserEmailExists($userEmail) {
            $qry = 'SELECT user_id, user_fname, user_lname, user_email FROM '. $this->table .' WHERE LOWER(user_email) = "%s" AND user_record_status IN (0)';
            $qry = $this->db->prepareQuery($qry, strtolower(trim($userEmail)));
            $rslt = $this->db->getSingleRow($qry);
            if($rslt) {
                return $rslt;
            } else {
                return false;
            }
        }

	
	/* Function to update the activationLink */
    function updateActivationLink($userId, $activationLink, $dateExpire) {
		$qry = 'CALL updateActivationLink(%d,"%s","%s")';
		$qry = $this->db->prepareQuery($qry,$userId,$activationLink,$dateExpire);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
   }
   
    /* Function to update the activationLink */
    function checkActivationLink($userId, $activationLink) {
		$qry = 'CALL checkActivationLink(%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$userId,$activationLink);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
   }
   
     /* Function to update the activationLink */
    function updateUserPassword($userId, $userPassword) {
		$qry = 'CALL updateUserPassword(%d,"%s","%s")';
		$qry = $this->db->prepareQuery($qry,$userId,md5($userPassword),DB_DATE);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
   }
	
	/*
    * Function to get all roles
    * return result of array
    */
    function getAllUserRoles($params = array()){
        $qry = 'CALL getAllUserRoles()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to get all roles
    * return result of array
    */
    function getUserById($userId){
        $qry = 'CALL getUserById(%d)';
        $qry = $this->db->prepareQuery($qry,$userId);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
	function to add or update user table
	@param user array
	return single row of data
	*/
	 function addAdminPersonnel($params = array()) {
		$qry = 'CALL addAdminPersonnel(%d,%d,"%s","%s",%d,"%s","%s","%s",%d)';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['userUpdateId'],$params['userFirstNameData'],$params['userLastNameData'],$params['userRoleData'],$params['userEmailData'],md5($params['userPasswordData']),DB_DATE_TIME,$params['user_qb_ref_id']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
	function to get user list
	@param userRole
	return user list arary
	*/ 
	function getUserList($params = array()){
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
		$qry = 'CALL getUserList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userRole'],$params['userFilter'],$params['userId'],$fromDate, $toDate, $start, $limit, $sorting,$params['filterRoleId'],$params['formFilter']);
		
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['userList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to get user list by role
    * return result of array
    */
    function getUsersByRole($params = array()){
        $qry = 'CALL getUsersByRole(%d)';
        $qry = $this->db->prepareQuery($qry,$params['userRoleIp']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to user By Id
    * return result of single row
    */
    function deleteAdminPersonnel($params = array()){
        $qry = 'CALL deleteAdminPersonnel(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['userDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to user form status
    * return result of single row
    */
    function updateUserForm($params = array()){
        $qry = 'CALL updateUserForm(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['userFormId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get user list by role & form status
    * return result of array
    */
    function getUsersByForm($params = array()){
        $qry = 'CALL getUsersByForm(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userRoleIp'],$params['formStatus']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
		/*
    * Function to get user list by role & form status & task user id for clone the task
    * return result of array
    */
    function getUsersByFormForClone($params = array()){
        $qry = 'CALL getUsersByFormForClone(%d,%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userRoleIp'],$params['formStatus'],$params['taskUserId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to get user by task reference
    * return result of single row
    */
    function getUserIdByTaskId($params = array()){
        $qry = 'CALL getUserIdByTaskId(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['taskId'],$params['taskType']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get user list by role & form status
    * return result of array
    */
    function getUsersForForm($params = array()){
        $qry = 'CALL getUsersForForm()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
}
?>