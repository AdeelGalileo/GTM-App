<?php
$dirName = dirname(dirname(__FILE__));
require_once ($dirName.'/includes/includes.php');
@ini_set('max_execution_time', 0);
@ini_set('memory_limit', '-1');
ini_set('auto_detect_line_endings',TRUE);
$runStatus = getObject('cronJobs');

//date_default_timezone_set('UTC');

$isRun = $runStatus->getMarketingStatus(1);

if($isRun['cronIsRun'] ==1) {
	echo 'Cron is already running';
	exit;
}
$runStatus->updateStartRunning(1);

$importCsvObj = getObject('importCsv');	
$importCsvFileArr = $importCsvObj->getCsvImportFiles(CSV_STATUS_QUEUE);
foreach($importCsvFileArr as $importCsvFile){
	$importId = $importCsvFile['ic_id'];
	$clientId = $importCsvFile['ic_client_id'];
	$userId = $importCsvFile['ic_user_id'];
	$taskKeywordDate = $importCsvFile['ic_import_keyword_date'];
	
	$params['clientId'] = $clientId;
	$skipFirstRow = $importCsvFile['ic_skip_header'];
	$importOption = $importCsvFile['ic_import_opt'];
	$importCsvObj->updateCsvStatus($importId, CSV_STATUS_IN_PROCESS);
	$fileName = ROOT_PATH.'upload/csv/'.$importCsvFile['ic_file_name'];
	$csvImportFields = $importCsvObj->getCsvImportFields($importId);
	$uniqueFieldList = $importCsvObj->getCsvImportUniqueField($importId);
	
	if($uniqueFieldList){
		$uniqueFieldName = $uniqueFieldList['icf_field_name'];
		$uniqueFieldKey = $uniqueFieldList['icf_field_id'];
		
		$taskKeywordRecord = array();
		$taskKeywordList = $importCsvObj->getCsvExistingKeywordByFieldName($uniqueFieldName, $userId, $clientId);
		
		if($taskKeywordList){
			foreach($taskKeywordList as $taskKeywordListVal){
				if($uniqueFieldName=='MARSHA'){
					//$uniqueFieldName="task_keyword_marsha_code";
					$taskKeywordRecord[$taskKeywordListVal['task_keyword_id']] = strtolower($taskKeywordListVal['client_entity_marsha_code']);
				}
				else{
					$taskKeywordRecord[$taskKeywordListVal['task_keyword_id']] = strtolower($taskKeywordListVal[$uniqueFieldName]);
				}
				
			}
		}
	}
	
	$recordLst = array();
	$dataLine = 0;
	$fp = fopen($fileName, 'r');
	while(($csvRecord = fgetcsv($fp, 4096)) !== FALSE) {
		$dataLine++;
		if($dataLine == 1 && $skipFirstRow) continue;
		foreach($csvImportFields as  $fieldList){
			$fieldKey = $fieldList['icf_field_id'];
			$fieldName = $fieldList['icf_field_name'];
			if($fieldName=='MARSHA'){
				//$fieldName="task_keyword_marsha_code";
			}
			$value = trim($csvRecord[$fieldKey]);
			$insertRecord[$dataLine][$fieldName] = $value;
			/* Check the task already exists for unique value */
			
			if($uniqueFieldName == $fieldName){
				
				if($taskKeywordRecord && $value && $insertId = array_search(strtolower($value), $taskKeywordRecord)){
					$insertRecord[$dataLine]['taskKeywordUpdateId'] = $insertId;
					$insertRecord[$dataLine]['userId'] = $userId;
					$insertRecord[$dataLine]['sessionClientId'] = $clientId;
					$insertRecord[$dataLine]['userIdData'] = 13;
					$insertRecord[$dataLine]['taskDateData'] = $taskKeywordDate;
				} else {
					$insertRecord[$dataLine]['taskKeywordUpdateId'] = 0;
					$insertRecord[$dataLine]['userId'] = $userId;
					$insertRecord[$dataLine]['sessionClientId'] = $clientId;
					$insertRecord[$dataLine]['userIdData'] = 13;
					$insertRecord[$dataLine]['taskDateData'] = $taskKeywordDate;
				}
			}
			
		}

		if(!$uniqueFieldName) {
				$insertRecord[$dataLine]['userId'] = $userId;
				$insertRecord[$dataLine]['sessionClientId'] = $clientId;
				$insertRecord[$dataLine]['userIdData'] = 13;
				$insertRecord[$dataLine]['taskDateData'] = $taskKeywordDate;
		} else if($insertRecord[$dataLine]['task_keyword_id']){
			if($importOption == IMPORT_APPEND){
				unset($insertRecord[$dataLine]);
			} else if($importOption == IMPORT_REPLACE){
				
			}
		}
		
		
	}
	fclose($fp);
	$importCsvObj = getObject('importCsv');
	$importCsvObj->importCsvKeyWord($importCsvFile, $insertRecord, $customRecord, $importOption);
	$importCsvObj->updateCsvStatus($importId, CSV_STATUS_COMPLETE);
	//sendMail(NOTIFICATION_EMAIL, $importCsvFile['user_email'], 'Import Completed', $message, '', NOTIFICATION_NAME);
}
ini_set('auto_detect_line_endings',FALSE);
$runStatus->updateStopRunning(1);