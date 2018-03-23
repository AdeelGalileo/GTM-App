<?php
class importCsv extends table{
	public $params;
	
	function __construct($db, $params = array()){
		parent::__construct($db, 'import_csv');
		$this->params = $params;
	}
	/* Function to add import csv details 
	 * @params: $csvFileName - string
	 * @params: $userId - int
	 * @result: $importCsvId - int
	 */
	function addCsvImport($params = array())
	{
		$qry = 'CALL addCsvImport("%s", %d, %d, "%s", %d, %d, %d, "%s")';
		$qry = $this->db->prepareQuery($qry, $params['csvFileName'],$params['importOption'], $params['importType'], $params['importKeywordDate'], $params['importKeywordStatus'],$params['userId'],$params['sessionClientId'], DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		$importCsvId = $rslt['importCsvID'];
		return $importCsvId;
	}
	
	/**
	 * function to update skip rows column of import row
	 * @params: $csvImportId - int
	 * @params: $hasHeader - int
	 * @params: $status - int
	 * @params: $importOpt - int
	 * @return: boolean
	 */
	function updateCsvImport($csvImportId, $hasHeader, $status, $importOpt)
	{
		$qry = 'CALL updateCsvImport(%d, %d, %d, %d)';
		$qry = $this->db->prepareQuery($qry, $csvImportId, $hasHeader, $status, $importOpt);
		$rslt = $this->db->multiQuery($qry);
		return true;
	}
	/**
	 * Function to add import fields
	 * @params: $importId - int
	 * @params: $fieldId - int
	 * @params: $fieldName - string
	 * @params: $userId - int
	 * @params: $clientId - int
	 * @params: $isUnique - int
	 * @result: $csvFieldId - int
	 */
	function addCsvImportFields($importId, $fieldId, $fieldName, $userId, $clientId, $isUnique)
	{
		$qry = 'CALL addCsvImportFields(%d, %d, "%s", %d, %d, %d)';
		$qry = $this->db->prepareQuery($qry, $importId, $fieldId, $fieldName, $userId, $clientId, $isUnique);
		$rslt = $this->db->getSingleRow($qry);
		$csvFieldId = $rslt['csvFieldId'];
		return $csvFieldId;
	}
	/**
	 * Function to get csv files with status
	 * @params: $status - int
	 * @return: array of files in given status
	 */
	function getCsvImportFiles($status=0)
	{
		$qry = 'CALL getCsvImportFiles(%d)';
		$qry = $this->db->prepareQuery($qry, $status);
		$rslt = $this->db->getResultSet($qry);
		return $rslt;
	}
	/**
	 * Funciton to get import csv fields
	 * @params: $importId - int
	 * @result: array of fields
	 */
	function getCsvImportFields($importId)
	{
		$qry = 'CALL getCsvImportFields(%d)';
		$qry = $this->db->prepareQuery($qry, $importId);
		$rslt = $this->db->getResultSet($qry);
		return $rslt;
	}
	/**
	 * Function to get unique field for importing
	 * @params: $importId: int
	 * @return: Arry of unique field for the import
	 */
	function getCsvImportUniqueField($importId)
	{
		$qry = 'CALL getCsvImportUniqueField(%d)';
		$qry = $this->db->prepareQuery($qry, $importId);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt;
	}
	/**
	 * Function to get existing keywords for given field
	 * @params: $fieldName: string
	 * @params: $userId: int
	 * @params: $clientId: int
	 * @return: Array of task keywords.
	 */
	 function getCsvExistingKeywordByFieldName($fieldName, $userId, $clientId)
	 {
	 	$qry = 'CALL getCsvExistingKeywordByFieldName("%s", %d, %d)';
		if($fieldName=='MARSHA'){
			$fieldName="task_keyword_marsha_code";
		}
		$qry = $this->db->prepareQuery($qry, $fieldName, $userId, $clientId);
		$rslt = $this->db->getResultSet($qry);
		return $rslt;
	 }
	 /**
	  * Function to get existing fields by custom field
	  * @params: $moduleFieldId - int
	  * @params: $clientId: int
	  * @result: Array of leads 
	  */
	 function getCsvExistingLeadByCustomField($moduleFieldId, $categoryId, $clientId)
	 {
	 	$qry = 'CALL getCsvExistingLeadByCustomField(%d, %d, %d)';
	    $qry = $this->db->prepareQuery($qry, $moduleFieldId, $categoryId, $clientId);
		$rslt = $this->db->getResultSet($qry);
		return $rslt;
	 }
	 /**
	 * Function to import csv files
	 * @params: $importCsvFile : array
	 * @params: $insertRecord: array
	 * @result: boolean
	 */
	function importCsvKeyWord($importCsvFile, $insertRecord, $importOption=0)
	{	
	
		$taskManagerKeywordObj = getObject('taskManagerKeyword');
		$clientEntityObj = getObject('clientEntity');
		
		foreach($insertRecord as $dataLine => $record){
			
			$inputArray['userId']=$record['userId'];
			$inputArray['taskKeywordUpdateId']=$record['taskKeywordUpdateId'];
			$inputArray['marshaCodeData']=$clientEntityObj->geMarshaIdByMarshaCode($record['MARSHA']);
			$inputArray['noPagesData']=$record['Sig + (# of Pages TBD)'];
			$inputArray['foundProgData']=$record['FOUNDATIONS PROGRAM'];
			$inputArray['expandSeoData']=$record['EXPANDED SEO'];
			$inputArray['outletMarkData']=$record['Outlet Marketing Bundle'];
			$inputArray['notesData']=$record['Notes'];
			$inputArray['boxLocationData']=$record['BOX Location'];
			$inputArray['boxAddedDateData']=(!empty($record['Date Added to BOX'])) ? convertDateToYMD($record['Date Added to BOX']) : "";
			$inputArray['linkDbFileData']=$record['linkDbFileData'];
			$inputArray['setupDueData']=(!empty($record['Keyword Set Up Due'])) ? convertDateToYMD($record['Keyword Set Up Due']) : "";
			$inputArray['setupUplboxData']=$record['Keyword Set Up and Uploaded to Box'];
			$inputArray['comDueData']=(!empty($record['Keywords completed Due Date'])) ? convertDateToYMD($record['Keywords completed Due Date']) : "";
			$inputArray['completedData']=(!empty($record['completedData'])) ? convertDateToYMD($record['completedData']) : "";
			$inputArray['taskDateData']=$record['taskDateData'];
			$inputArray['userIdData']=$record['userIdData'];
			$inputArray['sessionClientId']=$record['sessionClientId'];

			$taskManagerKeywordObj->addTaskManagerKeywordForCsv($inputArray);
			
			if($record['MARSHA'] =='' && $record['Sig + (# of Pages TBD)'] =='' && $record['FOUNDATIONS PROGRAM'] =='' && $record['EXPANDED SEO'] ==''
				&& $record['Outlet Marketing Bundle'] == '' && 
				$record['Notes'] == '' && $record['BOX Location'] == '' && $record['Date Added to BOX'] == '' && $record['Keyword Set Up Due'] == '' 
				&& $record['Keyword Set Up and Uploaded to Box'] == '' && $record['Keywords completed Due Date'] == ''){
				continue;
			}
			
		}
		
	}
	/**
	 * Function to get csv import by id
	 * @params: $importCsvId - int
	 * @result: array of information about csv file
	 */
	function getCsvImportById($importCsvId)
	{
		$qry = 'CALL getCsvImportFileById(%d)';
		$qry = $this->db->prepareQuery($qry,$importCsvId);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt; 
	}
	/**
	 * Function to update Custom field value 
	 * @params: $leadId - int
	 * @params: $moduleFieldId - int
	 * @params: $customFieldValue - string
	 * @params: $updateMode - int
	 * @params: $clientId - int
	 * @return: boolean
	 */
	function saveLeadCustomFieldValue($leadID, $moduleFieldID, $customFieldValue, $updateMode, $clientId)
	{
		if($moduleFieldID == 0) return;
		$qry = 'CALL saveLeadCustomFieldValue(%d, %d, "%s", %d, %d)';
		$qry = $this->db->prepareQuery($qry, $leadID, $moduleFieldID, $customFieldValue, $updateMode, $clientId);
		$rslt = $this->db->multiQuery($qry);
		return true;
	}
	/**
	 * Function to save social contact
	 * @params: $contactId - int
	 * @params: $clientId - int
	 * @params: $socialName - string
	 * @params: $socialUrl - string
	 * @params: $sysTime - string
	 */
	function saveContactSocial($contactId, $clientId, $socialName, $socialUrl, $sysTime)
	{
		$qry = 'CALL saveContactSocial(%d, %d, "%s", "%s", "%s")';
		$qry = $this->db->prepareQuery($qry, $contactId, $clientId, $socialName, $socialUrl, $sysTime);
		$rslt = $this->db->multiQuery($qry);
		return true;
	}
	/**
	 * Function to update import status of csv file
	 * @params: $csvImportId - int
	 * @params: $status - int
	 * @return: boolean
	 */
	function updateCsvStatus($csvImportId, $status, $sysTime='')
	{
		if(!$sysTime) $sysTime = DB_DATE_TIME;
		$qry = 'CALL updateCsvStatus(%d, %d, "%s")';
		$qry = $this->db->prepareQuery($qry, $csvImportId, $status, $sysTime);
		$rslt = $this->db->multiQuery($qry);
		return true;
	}
	/**
	 * Function to get csv import files for client
	 * @params: $clientId - int
	 * @return: array of imported files
	 */
	function getCsvImportFilesForClient($clientId)
	{
		$qry = 'CALL getCsvImportFilesForClient(%d)';
		$qry = $this->db->prepareQuery($qry, $clientId);
		$rslt = $this->db->getResultSet($qry);
		return $rslt;
	}
	/**
	 * Function to get import completed csv files for notification
	 * @params: $clientId - int
	 * @status: $staus - int
	 * @return: array of completed imports
	 */
	function getCsvImportComplete($clientId, $status, $userId=0)
	{
		$userId = $userId ? $userId : $params['userId'];
		$qry = 'CALL getCsvImportComplete(%d, %d)';
		$qry = $this->db->prepareQuery($qry, $clientId, $status);
		$rslt = $this->db->getResultSet($qry);
		return $rslt;
	}
	/**
	 * Function to update email status based on existing list
	 * @params: $clientId - int
	 * @params: $folderId - int
	 * @return: boolean
	 */
	function updateEmailStatusForFolder($clientId, $folderId)
	{
		$qry = 'CALL updateEmailStatusForNewFolder(%d, %d)';
		$qry = $this->db->prepareQuery($qry, $clientId, $folderId);
		$recSet = $this->db->multiQuery($qry);
		return true;
	}
}
?>