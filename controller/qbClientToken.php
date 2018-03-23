<?php
    class qbClientToken extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'qb_client_token');
        $this->params = $params;
    }

	/*
	function to update qb_client_token table
	@param client array
	return single row of data
	*/
	 function updateQbClientToken($params = array()) {
		$qry = 'CALL updateQbClientToken(%d,%d,%d,"%s","%s","%s","%s","%s","%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['clientQbTokenUpateId'],$params['qb_client_token_client_id'],$params['qb_client_token_client_secret'],$params['qb_client_token_qbo_real_id'],$params['qb_client_token_base_url'],$params['qb_client_token_refresh_token'],$params['qb_client_token_access_token'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
	function to update qb_client_token table
	@param client array
	return single row of data
	*/
	 function updateQbClientRefreshToken($params = array()) {
		$qry = 'CALL updateQbClientRefreshToken(%d,%d,"%s","%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['clientQbTokenUpateId'],$params['qb_client_token_refresh_token'],$params['qb_client_token_access_token'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get qb_client_token by id
    * return result of array
    */
    function getQbClientTokenById($params = array()){
        $qry = 'CALL getQbClientTokenById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['clientQbTokenUpateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	

	/*
	function to get qb_client_token list
	@param client array
	return client arary
	*/ 
	function getQbClientTokenList($params = array()){
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
		$qry = 'CALL getQbClientTokenList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['clientFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['qbClientTokenList'] = $recordSet[1];
		}
		
		
		return $rslt;
	}
	
	
}
?>