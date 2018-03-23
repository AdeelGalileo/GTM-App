<?php
    class form extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'form');
        $this->params = $params;
    }

	/*
	function to add or update form table
	@param form array
	return single row of data
	*/
	 function addForm($params = array()) {
		$qry = 'CALL addForm(%d,%d,%d,%d,"%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['formUpdateId'],$params['form_user_id'],$params['form_first_name'],$params['form_last_name'],$params['form_email'],$params['form_contact_no'],$params['form_street'],$params['form_city'],
		$params['form_state'],$params['form_zipcode'],$params['form_country'],$params['newW9Form'],$params['newResumeForm'],$params['newAchForm'],$params['newAgreementForm'],$params['form_notes'],$params['form_needed'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		
		$formIpArray['formUserId'] = $params['form_user_id'];
		$formIpArray['sessionClientId']=$params['sessionClientId'];
		$data = $this->getFormStatus($formIpArray);
		if((!empty($data['form_w_nine'])) && (!empty($data['form_ach'])) && (!empty($data['form_consultant_agree']))){
			$formIpUpdateArray['userId'] = $params['userId'];
			$formIpUpdateArray['userFormId']=$params['form_user_id'];
			$adminPersonnelObj = getObject('adminPersonnel');
			$adminPersonnelObj->updateUserForm($formIpUpdateArray);
		}
		
		return $rslt;
    }
	
	
	/*
    * Function to get form by id
    * return result of array
    */
    function getFormById($params = array()){
        $qry = 'CALL getFormById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['formUpdateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get forms by user id
    * return result of array
    */
    function getFormsByUserId($params = array()){
        $qry = 'CALL getFormsByUserId(%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	
	
	/*
	function to get form list
	@param client array
	return client arary
	*/ 
	function getFormList($params = array()){
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
		$qry = 'CALL getFormList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['formFilterBy'],$params['filterRoleId'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId']);
		
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['formList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
		
	/*
    * Function to delete client By Id
    * return result of single row
    */
    function deleteForm($params = array()){
        $qry = 'CALL deleteForm(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['formDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get forms by user id
    * return result of array
    */
    function getFormStatus($params = array()){
        $qry = 'CALL getFormStatus(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['sessionClientId'],$params['formUserId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
}
?>