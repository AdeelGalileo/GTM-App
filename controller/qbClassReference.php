<?php
    class qbClassReference extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'qb_class_reference');
        $this->params = $params;
    }

	/*
	function to add or update qb_class_reference table
	@param client array
	return single row of data
	*/
	 function addQbClassReference($params = array()) {
		$qry = 'CALL addQbClassReference(%d,%d,%d,"%s","%s","%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['classQbRefUpateId'],$params['qb_cls_ref_class_id'],$params['qb_cls_ref_class_name'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	/*
    * Function to get qb_class_reference by id
    * return result of array
    */
    function getQbClassReferenceById($params = array()){
        $qry = 'CALL getQbClassReferenceById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['classQbRefUpateId']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get qb_class_reference by id
    * return result of array
    */
    function getQbClassReferenceByClientId($params = array()){
        $qry = 'CALL getQbClassReferenceByClientId(%d)';
        $qry = $this->db->prepareQuery($qry,$params['sessionClientId']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
	function to get qb_class_reference list
	@param client array
	return client arary
	*/ 
	function getQbClassReferenceList($params = array()){
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
		$qry = 'CALL getQbClassReferenceList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['clientFilterBy'],$params['userRole'],$fromDate, $toDate, $start, $limit, $sorting,$params['sessionClientId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['qbClassRefList'] = $recordSet[1];
		}
		
		
		return $rslt;
	}
	
		
	/*
    * Function to delete qb_class_reference By Id
    * return result of single row
    */
    function deleteQbClassReference($params = array()){
        $qry = 'CALL deleteQbClassReference(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['classQbRefDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
}
?>