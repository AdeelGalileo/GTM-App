<?php
    class invoice extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'invoice');
        $this->params = $params;
    }

	/*
	function to add or update invoice table
	@param invoice array
	return single row of data
	*/
	 function addInvoice($params = array()) {
		$qry = 'CALL addInvoice(%d,%d,%d,"%s","%s",%d,"%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['invoiceUpdateId'],$params['invoiceTotal'],DB_DATE,$params['invoiceQbProcessed'],$params['invoiceQbReferenceNumber'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['invoiceId'];
    }
	
	/*
    * Function to get task for invoice reference
    * return result of array
    */
    function getTaskDataForInvoiceReference($taskId,$taskType,$invQty){
        $qry = 'CALL getTaskDataForInvoiceReference(%d,%d,%d)';
        $qry = $this->db->prepareQuery($qry,$taskId,$taskType,$invQty);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get task data for qb invoice
    * return result of array
    */
    function getTaskDataForQbInvoice($params = array()){
        $qry = 'CALL getTaskDataForQbInvoice("%s",%d)';
        $qry = $this->db->prepareQuery($qry,$params['taskIds'],$params['taskType']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	
	/*
	function to add  invoice task reference table
	@param task reference array
	return single row of data
	*/
	 function addInvoiceTaskReference($refInvoiceId,$refClientName,$refUserFname,$refUserLname,$refTaskId,$refTaskUserId,$refTaskClientId,$refTaskType,$refMarshaCode,$refDivisionCode,$refServiceTypeName,$refRatePerUnit,$refNoOfUnits,$refTire,$refUserId,$qbServiceRefId) {
		$qry = 'CALL addInvoiceTaskReference(%d,"%s","%s","%s",%d,%d,%d,%d,"%s","%s","%s","%s",%d,"%s",%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry,$refInvoiceId,$refClientName,$refUserFname,$refUserLname,$refTaskId,$refTaskUserId,$refTaskClientId,$refTaskType,$refMarshaCode,$refDivisionCode,$refServiceTypeName,$refRatePerUnit,$refNoOfUnits,$refTire,$refUserId,DB_DATE_TIME,$qbServiceRefId);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['invoiceRefId'];
    }
	
	
	/*
	function to get invoice task list
	@param rate array
	return rate arary
	*/ 
	function getInvoiceTaskList($params = array()){
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
		$qry = 'CALL getInvoiceTaskList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d,"%s","%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$params['divisionId'],$params['serviceTypeFilter'],$params['locationCodeFilter'],$params['invNoFilter']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['invoiceTaskList'] = $recordSet[1];
		}
		return $rslt;
	}
	
	/*
	function to get outstanding invoice task list
	@param rate array
	return rate arary
	*/ 
	function getOutstandingInvoiceList($params = array()){
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
		//if($sortOrder == 'cons_rate_per_unit'){
			//$sorting= 'cons_rate_per_unit '.$sortBy.' , ' . 'servTypeGalRate '.$sortBy;
		//}
		
		$qry = 'CALL getOutstandingInvoiceList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d,"%s","%s")';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['taskKeyFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$params['divisionId'],$params['serviceTypeFilter'],$params['locationCodeFilter']);
		
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['invoiceTaskList'] = $recordSet[1];
		}
		return $rslt;
	}
	
	/*
	function to get billing task list
	@param rate array
	return rate arary
	*/ 
	function getInvoiceCount($params = array()){
		if($params['fromDate']!='' && $params['toDate'] !='') {
			$fromDate = convertDateToYMD($params['fromDate']);
			$toDate   = convertDateToYMD($params['toDate']);
		}
		$qry = 'CALL getInvoiceCount(%d,%d,%d,"%s","%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['billFilterBy'],$params['userRole'],$fromDate, $toDate,$params['writerId'],$params['sessionClientId']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['total'];
	}
	
	
	/*
    * Function to update complete field in Task Manager table Keyword By Id
    * return result of single row
    */
    function updateQbInvoiceReference($params = array()){
        $qry = 'CALL updateQbInvoiceReference(%d,%d,%d,%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['taskId'],$params['taskType'],$params['sessionClientId'],$params['invoiceReference'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>