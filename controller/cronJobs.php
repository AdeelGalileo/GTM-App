<?php
class cronJobs extends table
{
	public $params;
	/* Construct the table */
	function __construct($db, $params = array())
	{
		parent::__construct($db, 'cron_jobs');
		$this->params = $params;
	}
	

	function getMarketingStatus($cronId)
	{
		$qry = 'SELECT cronIsRun FROM '.$this->table .' WHERE cronId ='.$cronId;
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
	}


	function updateStartRunning($cronId)
	{
		$record['cronId'] = $cronId;
		$record['cronIsRun'] = 1;
		$this->updateRecord($record, 'cronId');
		return true;
	}


	function updateStopRunning($cronId)
	{
		$record['cronId'] = $cronId;
		$record['cronIsRun'] = 0;
		$this->updateRecord($record, 'cronId');
		return true;
	}
	
	/*
	function to add refresh token error
	@param error message
	return single row of data
	*/
	 function addRefreshTokenError($errorMessage) {
		$qry = 'CALL addRefreshTokenError("%s","%s")';
		$qry = $this->db->prepareQuery($qry,$errorMessage,DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
    }
	
	
}
?>