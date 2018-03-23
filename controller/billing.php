<?php
    class billing extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'billing');
        $this->params = $params;
    }

	/*
	function to add or update billing table
	@param billing array
	return single row of data
	*/
	 function addBilling($params = array()) {
		$qry = 'CALL addBilling(%d,%d,%d,%d,"%s","%s",%d,"%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['billingUpdateId'],$params['billingInvoiceId'],$params['billingTotal'],DB_DATE,$params['billingQbProcessed'],$params['billingQbReferenceNumber'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['billingId'];
    }
	
	/*
    * Function to get consultant Rate by id
    * return result of array
    */
    function getTaskDataForBillingReference($taskId,$taskType,$billQty){
        $qry = 'CALL getTaskDataForBillingReference(%d,%d,%d)';
        $qry = $this->db->prepareQuery($qry,$taskId,$taskType,$billQty);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get task data for qb billing
    * return result of array
    */
    function getTaskDataForQbBilling($params = array()){
        $qry = 'CALL getTaskDataForQbBilling("%s",%d)';
        $qry = $this->db->prepareQuery($qry,$params['taskIds'],$params['taskType']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
	function to add  billing task reference table
	@param task reference array
	return single row of data
	*/
	 function addBillingTaskReference($refBillingId,$refClientName,$refUserFname,$refUserLname,$refTaskId,$refTaskUserId,$refTaskClientId,$refTaskType,$refMarshaCode,$refDivisionCode,$refServiceTypeName,$refRatePerUnit,$refNoOfUnits,$refTire,$refUserId,$qbServiceRefId) {
		$qry = 'CALL addBillingTaskReference(%d,"%s","%s","%s",%d,%d,%d,%d,"%s","%s","%s","%s",%d,"%s",%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry,$refBillingId,$refClientName,$refUserFname,$refUserLname,$refTaskId,$refTaskUserId,$refTaskClientId,$refTaskType,$refMarshaCode,$refDivisionCode,$refServiceTypeName,$refRatePerUnit,$refNoOfUnits,$refTire,$refUserId,DB_DATE_TIME,$qbServiceRefId);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['billingRefId'];
    }
	
	
	/*
	function to get billing task list
	@param rate array
	return rate arary
	*/ 
	function getBillingTaskList($params = array()){
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
		
		$divisionText="";
		if($params['divisionId'] && $params['divisionId'] == 1) {
			$divisionText="EU";
		}
		elseif($params['divisionId'] && $params['divisionId'] == 2){
			$divisionText="Non EU";
		}
		
		$qry = 'CALL getBillingTaskList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['billFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$divisionText,$params['divisionId'],$params['qbBillingId']);
		
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['billTaskList'] = $recordSet[1];
		}
		return $rslt;
	}
	
	/*
	function to get outstanding billing task list
	@param rate array
	return rate arary
	*/ 
	function getOutstandingBillingList($params = array()){
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
		if($sortOrder == 'cons_rate_per_unit'){
			$sorting= 'cons_rate_per_unit '.$sortBy.' , ' . 'servTypeFreeLRate '.$sortBy;
		}
		
		$qry = 'CALL getOutstandingBillingList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['billFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$params['divisionId']);
		
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['billTaskList'] = $recordSet[1];
		}
		return $rslt;
	}
	
	/*
	function to get billing task list
	@param rate array
	return rate arary
	*/ 
	function getBillingCount($params = array()){
		if($params['fromDate']!='' && $params['toDate'] !='') {
			$fromDate = convertDateToYMD($params['fromDate']);
			$toDate   = convertDateToYMD($params['toDate']);
		}
		$qry = 'CALL getBillingCount(%d,%d,%d,"%s","%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['billFilterBy'],$params['userRole'],$fromDate, $toDate,$params['writerId'],$params['sessionClientId']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['total'];
	}
	
	/*
    * Function to update qb reference number
    * return result of single row
    */
    function updateQbBillingReference($params = array()){
        $qry = 'CALL updateQbBillingReference(%d,%d,%d,%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskId'],$params['taskType'],$params['sessionClientId'],$params['billingReference'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>