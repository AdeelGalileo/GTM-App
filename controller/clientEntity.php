<?php
    class clientEntity extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'client_entity');
        $this->params = $params;
    }

	/*
	function to add or update client_entity table
	@param client array
	return single row of data
	*/
	 function addClientEntity($params = array()) {
		$qry = 'CALL addClientEntity(%d,%d,%d,"%s","%s","%s","%s","%s","%s","%s",%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['clientEntityUpdateId'],$params['client_entity_marsha_code'],$params['client_entity_hotel_name'],$params['client_entity_street'],$params['client_entity_city'],$params['client_entity_state'],$params['client_entity_zipcode'],$params['client_entity_country'],$params['client_entity_division_id'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get client_entity by id
    * return result of array
    */
    function getClientEntityById($params = array()){
        $qry = 'CALL getClientEntityById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['clientEntityUpdateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to getDivisionByMarshaCode
    * return single row of data
    */
    function getDivisionByMarshaCode($params = array()){
        $qry = 'CALL getDivisionByMarshaCode(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userIdIp'],$params['marshaCodeIp']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get all roles
    * return result of array
    */
    function getMarshaCodes($params = array()){
        $qry = 'CALL getMarshaCodes(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$this->params['userId'], $this->params['sessionClientId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get marsha id by marsha code
    * return single row of data
    */
    function geMarshaIdByMarshaCode($marshaCode){
        $qry = 'CALL geMarshaIdByMarshaCode("%s")';
        $qry = $this->db->prepareQuery($qry,$marshaCode);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt['client_entity_id'];
    }
	
	
	/*
	function to get client entity list
	@param client entity array
	return client entity arary
	*/ 
	function getClientEntityList($params = array()){
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
		$qry = 'CALL getClientEntityList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['clientFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId'],$params['divisionId']);
		
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['clientEntityList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
			
	/*
    * Function to delete client_entity By Id
    * return result of single row
    */
    function deleteClientEntity($params = array()){
        $qry = 'CALL deleteClientEntity(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['clientEntityDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
}
?>