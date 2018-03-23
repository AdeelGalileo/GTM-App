<?php
    class division extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'division');
        $this->params = $params;
    }

	
	/*
	function to add or update division table
	@param client array
	return single row of data
	*/
	 function addDivision($params = array()) {
		$qry = 'CALL addDivision(%d,%d,%d,"%s","%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['divisionUpdateId'],$params['division_code'],$params['division_name'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	
	/*
    * Function to get division by id
    * return result of array
    */
    function getDivisionById($params = array()){
        $qry = 'CALL getDivisionById(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['sessionClientId'],$params['divisionUpdateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get all divisions
    * return result of array
    */
    function getAllDivsions($params = array()){
        $qry = 'CALL getAllDivsions()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to get division by client id
    * return result of single row
    */
    function getDivisionByClientId(){
        $qry = 'CALL getDivisionByClientId(%d)';
        $qry = $this->db->prepareQuery($qry,$this->params['sessionClientId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	
		/*
	function to get division list
	@param client array
	return client arary
	*/ 
	function getDivisionList($params = array()){
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
		$qry = 'CALL getDivisionList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['clientFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['divisionList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
	/*
    * Function to delete client_qb_reference By Id
    * return result of single row
    */
    function deleteDivision($params = array()){
        $qry = 'CALL deleteDivision(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['divisionDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>