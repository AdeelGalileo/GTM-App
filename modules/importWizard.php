<?php
class importWizardModule {
	function display($db = '', $params = array()) {
		global $smarty, $keywordHeaderArray;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		$importCsvObj = getObject('importCsv');
		$inputArray=array();
		$inputArray['importType']=$params['importType'];
		$inputArray['importOption']=$params['importOption'];
		$inputArray['importKeywordStatus']=CSV_STATUS_INCOMPLETE;
		$inputArray['importKeywordDate']=$params['importKeywordDate'];
		$inputArray['csvFileName']=$_SESSION['newCSVFile'];
		$inputArray['userId']=$params['userId'];
		$inputArray['sessionClientId']=$params['sessionClientId'];
        $importCsvId = $importCsvObj->addCsvImport($inputArray);
        $_SESSION['importCsvId'] = $importCsvId;
		if($importCsvId){
			$fileName = ROOT_PATH.'upload/csv/'.$_SESSION['newCSVFile'];
			$dataArray = file($fileName);
			$recCount = count($dataArray);
			if($recCount) {
				$lastRec = $dataArray[$recCount-1];
				if(!$lastRec) {
					$empty = array_pop($dataArray);
					--$recCount;
				}
			}
			
			
			if($params['importOption'] > 0){
				$_SESSION['uniqueFieldName'] = $params['unqiueField'];
			} else {
				$_SESSION['uniqueFieldName'] = '';
			}
			
			if($_SESSION['uniqueFieldName']){
				$requiredFields = array($_SESSION['uniqueFieldName']);
			} else {
				$requiredFields = array();
			}
			array_push($requiredFields, 'MARSHA');
			sort($requiredFields);
			$reqFieldJSArray = '"'.implode('","', $requiredFields).'"';
			$smarty->assign('reqFieldJSArray', $reqFieldJSArray);
					
			$record = array();
			$fieldCount = 0;
			//Display 10 records on first screen
			$fp = fopen($fileName, 'r');
			for($cnt = 0 ; $cnt < 2 && $cnt < $recCount; $cnt++){
				$record[] = fgetcsv($fp); //explode('"', $dataArray[$cnt]);
				$fieldCount = count($record[0]);
			}
			fclose($fp);

			ini_set('auto_detect_line_endings',FALSE);
			
			$fieldsArr = array();
			if($params['importType'] == IMPORT_TYPE_KEYWORD){
				foreach($keywordHeaderArray as $fieldName => $fieldValue){
					$fieldsArr[$fieldValue] = $fieldValue;
				}
			}
			$fieldOptions = generateSelectOption($fieldsArr, '', 0);
			$smarty->assign('importOption', $params['importOption']);
			$smarty->assign('fieldCount', $fieldCount);
			$smarty->assign('fieldOptions', $fieldOptions);
			$smarty->assign('recCount', $recCount);
			$smarty->assign('record', $record);
			
			$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);	
		}
		else{
			$moduleContent ="";
		}
		
		
		return array('content' => $moduleContent);
	}
}
?>