<?php
    class client extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'client');
        $this->params = $params;
    }

	/*
	function to add or update client table
	@param client array
	return single row of data
	*/
	 function addClient($params = array()) {
		$qry = 'CALL addClient(%d,%d,"%s","%s","%s","%s","%s","%s","%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['clientUpateId'],$params['client_name'],$params['client_street'],$params['client_city'],$params['client_state'],$params['client_zipcode'],$params['client_country'],DB_DATE_TIME,$params['client_record_status'],$params['client_qb_associated_reference']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get client by id
    * return result of array
    */
    function getClientById($params = array()){
        $qry = 'CALL getClientById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['clientUpateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get client by id
    * return result of array
    */
    function getClientsByUserId($params = array()){
        $qry = 'CALL getClientsByUserId(%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to get all clients
    * return result of array
    */
    function getAllClients(){
        $qry = 'CALL getAllClients()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
	function to get clients list
	@param client array
	return client arary
	*/ 
	function getClientList($params = array()){
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
		$qry = 'CALL getClientList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['clientFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['clientIdFilter'],$params['recordStatus']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['clientList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
		
	/*
    * Function to delete client By Id
    * return result of single row
    */
    function deleteClient($params = array()){
        $qry = 'CALL deleteClient(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['clientDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>