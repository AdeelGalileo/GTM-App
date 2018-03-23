<?php
    class skills extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'consultant_skill');
        $this->params = $params;
    }

	/*
	function to add or update consultant_skill table
	@param form array
	return single row of data
	*/
	 function addConsultantSkill($params = array()) {
		$qry = 'CALL addConsultantSkill(%d,%d,%d,%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$params['userId'],$params['sessionClientId'],$params['skillUpdateId'],$params['cons_user_id'],DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		$this->addConsultantSkillItems($rslt['skillId'],$params['cons_service_type_id']);
		return $rslt;
    }
	
	
	/*
	function to add or update consultant_skill_items table
	@param form array
	return single row of data
	*/
	 function addConsultantSkillItems($skillId,$serviceTypeIds) {
		$qry = 'CALL addConsultantSkillItems(%d,"%s")';
		$qry = $this->db->prepareQuery($qry,$skillId,$serviceTypeIds);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get consultant skill by id
    * return result of array
    */
    function getConsultantSkillById($params = array()){
        $qry = 'CALL getConsultantSkillById(%d)';
        $qry = $this->db->prepareQuery($qry,$params['skillUpateId']);
        $recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[0];
		if($rslt){
			$rslt['consultantSkillData'] = $recordSet[0][0];
			$rslt['consultantSkillItems'] = $recordSet[1][0];
			
		}
		return $rslt;
    }
	
	
	/*
	function to get skill list
	@param skill array
	return skill arary
	*/ 
	function getConsultantSkillList($params = array()){
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
		$qry = 'CALL getConsultantSkillList(%d,%d,%d,"%s","%s",%d,%d,"%s",%d,%d,%d)';
		$qry = $this->db->prepareQuery($qry, $params['userId'], $params['skillFilterBy'],$params['filterRoleId'],$fromDate, $toDate, $start, $limit, $sorting,$params['writerId'],$params['sessionClientId'],$params['skillFilterSkillId']);
		$recordSet = $this->db->multiQuery($qry);
		$rslt = $recordSet[1];
		if($rslt){
			$rslt[0]['totalRows'] = $recordSet[0][0]['total'];
			$rslt['consultantSkillList'] = $recordSet[1];
			$rslt['consultantSkillListItems'] = $recordSet[2];
		}
		return $rslt;
	}
	
		
	/*
    * Function to delete consultant skill By Id
    * return result of single row
    */
    function deleteSkill($params = array()){
        $qry = 'CALL deleteSkill(%d,%d,"%s")';
        $qry = $this->db->prepareQuery($qry,$params['userId'],$params['skillDeleteId'],DB_DATE_TIME);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	/*
    * Function to get consultant by skill
    * return result of array
    */
    function getConsultantBySkill($params = array()){
        $qry = 'CALL getConsultantBySkill(%d,%d,%d)';
        $qry = $this->db->prepareQuery($qry,$params['serviceIdIp'],$params['sessionClientId'],$params['formStatus']);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
}
?>