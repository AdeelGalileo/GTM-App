<?php
    class consultantRate extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'consultant_rate');
        $this->params = $params;
    }

	/*
	function to add or update consultant_rate table
	@param form array
	return single row of data
	*/
	 function addConsultantRate($params = array()) {
		$qry = 'CALL addConsultantRate(%d,%d,%d,%d,"%s",%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['rateUpdateId'],$params['cons_rate_user_id'],$params['cons_rate_per_unit'],$params['cons_rate_service_type_id'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	
	
	/*
    * Function to get consultant Rate by id
    * return result of array
    */
    function getConsultantRateById($params = array()){
        $qry = 'CALL getConsultantRateById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['rateUpdateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
	function to get rate list
	@param rate array
	return rate arary
	*/ 
	function getConsultantRateList($params = array()){
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
		$qry = 'CALL getConsultantRateList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['rateFilterBy'],$params['filterRoleId'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['consultantRateList'] = $recordSet[1];
		}
		return $rslt;
	}
	
		
	/*
    * Function to delete consultant rate By Id
    * return result of single row
    */
    function deleteConsultantRate($params = array()){
        $qry = 'CALL deleteConsultantRate(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['rateDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
}
?>