<?php
class module extends table {
	public $params;
	/* Construct the table */
	function __construct($db, $params = array()){
		parent::__construct($db, 'Module');
		$this->params = $params;
	}
	/* Save Configuration */
	function saveConfig($xmlConfig, $templateId){
		$record['ModuleTemplateID'] = $templateId;
		$record['xmlConfig'] 		= $xmlConfig;
		$this->updateRecord($record, 'ModuleTemplateID');
		return true;
	}
	/* Function to add new module for the new client */
	function addModule($clientId, $businessType=''){
		$qry = 'INSERT INTO '.$this->table.' (ModuleID, ModuleName, TemplateName, xmlConfig, RecordStatus, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, ClientID, BusinessType) 
				SELECT ModuleID, ModuleName, TemplateName, xmlConfig, RecordStatus, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, %d, %d FROM model_module LIMIT 1';
		$qry  = $this->db->prepareQuery($qry, $clientId, $businessType);
		$templateId = $this->db->insertDataId($qry);
		return $templateId;
	}
	/* Function to get module template */
	function getModuleTemplate($clientId){	
		$params = $this->params;
		if(isset($_REQUEST['btype'])){
			$type = $_REQUEST['btype'];
		} elseif($params['btype']){
			$type = $params['btype'];
		} else {
			$type = 1;
		}

		$qry  = 'SELECT ModuleTemplateID FROM '. $this->table . ' WHERE ClientID = %d AND BusinessType IN(0, %d) ';
		$qry  = $this->db->prepareQuery($qry, $clientId, $type);
		$rslt = $this->db->getSingleRow($qry);
		return $rslt['ModuleTemplateID'];
	}
}
?>