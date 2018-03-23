<?php
    class modulesList extends table {
    public $params;

    /* Construct the table */
    function __construct($db, $params = array()) {
        parent::__construct($db, 'modules');
        $this->params = $params;
    }
	
	
	/*
    * Function to get all modules
    * return result of array
    */
    function getModules($params = array()){
        $qry = 'CALL getModules()';
        $qry = $this->db->prepareQuery($qry);
        $rslt = $this->db->getResultSet($qry);
		return $rslt;
    }
	
	/*
    * Function to getModuleDescByModuleId
    * return single row of data
    */
    function getModuleByModuleId($params = array()){
        $qry = 'CALL getModuleByModuleId(%d)';
        $qry = $this->db->prepareQuery($qry,$params['modulesIp']);
        $rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
	
}
?>