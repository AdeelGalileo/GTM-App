<?php
class modules {
	protected $db;
	/* Get the controller for the page */
	function __construct($db)
	{
		$this->db = $db;
	}
	function loadModules($moduleArr, $dirName='')
	{
		$moduleDetailArr = array();
		for($cnt = 0; $cnt < count($moduleArr); $cnt++)
		{
			$moduleDetailArr[] = $this->getModule($moduleArr[$cnt],  $dirName);
		}
		if(count($moduleArr) > 1){
			return implode('', $moduleDetailArr);
		} else {
			return $moduleDetailArr[0];
		}
	}
	function getModule($module, $dirName='')
	{
		global $params;
		if($dirName){
			require_once(SITE_PATH.'/modules/'.$dirName.'/'.$module.'.php');
		} else {
			require_once(SITE_PATH.'/modules/'.$module.'.php');
		}
		$moduleCode = $this->camelize($module);
		$moduleClass = $moduleCode.'Module';
		$moduleObj = new $moduleClass($this->db, $params);
		$moduleContent = $moduleObj->display($this->db, $params);
		return $moduleContent;
	}
	function camelize($moduleName)
	{
		$moduleName = preg_replace_callback('/\_(.)/', create_function('$matches', 'return strtoupper($matches[1]);'), $moduleName);
		return $moduleName;
	}
	function __destruct()
	{
		unset($this->db);
	}
}
?>