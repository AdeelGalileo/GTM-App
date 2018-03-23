<?php
    class clientDivision extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'client_qb_reference');
        $this->params = $params;
    }

	/*
	function to add or update client_qb_reference table
	@param client array
	return single row of data
	*/
	 function addClientDivision($params = array()) {
		$qry = 'CALL addClientDivision(%d,%d,%d,%d,%d,%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['clientQbRefUpdateId'],$params['client_qb_ref_division_id'],$params['client_qb_ref_qb_id'],$params['client_qb_ref_qb_class'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get client_qb_reference by id
    * return result of array
    */
    function getClientDivisionById($params = array()){
        $qry = 'CALL getClientDivisionById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['clientQbRefUpdateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	
	/*
	function to get client_qb_reference list
	@param client array
	return client arary
	*/ 
	function getClientDivisionList($params = array()){
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
		$qry = 'CALL getClientDivisionList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['clientFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['clientQbRefList'] = $recordSet[1];
		}
		
		
		return $rslt;
	}
	
		
	/*
    * Function to delete client_qb_reference By Id
    * return result of single row
    */
    function deleteClientDivision($params = array()){
        $qry = 'CALL deleteClientDivision(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['clientQbRefDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>