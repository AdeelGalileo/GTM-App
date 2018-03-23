<?php
require_once('header.php');	
$modulesListObj = getObject('modulesList');
//For Insert
if($params['getModuleByModuleId'] == 1){
	$inputArray=array();
	$inputArray['modulesIp']=$params['modulesIp'];
	$result =  $modulesListObj->getModuleByModuleId($inputArray);
	echo array2json(array('success'=>true,'message'=>$result));
	exit;
}


	
?> 