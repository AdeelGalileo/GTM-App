<?php
    class serviceType extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'service_type');
        $this->params = $params;
    }
	
	
	/*
	function to add or update service_type
	@param service_type array
	return single row of data
	*/
	 function addServiceType($params = array()) {
		$qry = 'CALL addServiceType(%d,%d,"%s","%s","%s",%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['servTypeUpdateId'],$params['serv_type_name'],$params['serv_type_gal_rate'],$params['serv_type_freel_rate'],$params['sessionClientId'],DB_DATE_TIME,$params['serv_type_qb_id'],$params['serv_type_task_type']);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get Alert By Id
    * return result of single row
    */
    function getServiceTypeById($params = array()){
        $qry = 'CALL getServiceTypeById(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['serviceTypeId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to delete service type By Id
    * return result of single row
    */
    function deleteServiceType($params = array()){
        $qry = 'CALL deleteServiceType(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['serviceTypeDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get all service types
    * return result of array
    */
    function getAllServiceTypes($params = array()){
        $qry = 'CALL getAllServiceTypes()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to get all service types
    * return result of array
    */
    function getAllServiceTypesByUser($params = array()){
        $qry = 'CALL getAllServiceTypesByUser(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to get all service types
    * return result of array
    */
    function getServiceTypeByTaskType($params = array()){
        $qry = 'CALL getServiceTypeByTaskType(%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['sessionClientId'],$params['serviceTaskTypeId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get all service types
    * return result of array
    */
    function getAllServiceTypesByClient($params = array()){
        $qry = 'CALL getAllServiceTypesByClient(%d)';
        $qry = $this->db->prepareQuery($qry,$params['sessionClientId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
	function to get service types list
	@param service types array
	return service types arary
	*/ 
	function getServiceTypesList($params = array()){
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
		$qry = 'CALL getServiceTypesList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['serviceFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId'], $params['searchByServiceTypeId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['serviceTypesList'] = $recordSet[1];
		}
		
		return $rslt;
	}
	
}
?>