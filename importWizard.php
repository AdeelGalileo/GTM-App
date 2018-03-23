<?php
	require_once('header.php');
	
	if($_SESSION['userRole'] == USER_ROLE_CONSULTANT && $_SESSION['userFormComplete']==0){
		$smarty->assign('lastPage', 'Import Wizard');
		$smarty->assign('formUploadPending', true);
		$smarty->assign('formUploadPendingMsg', ERR_FORMS_REQUIRED);
		$smarty->display('formPendingMessage.tpl');
		exit;
	}
	
	ini_set('memory_limit', '512M');
	ini_set('post_max_size', '256M');
	ini_set('upload_max_filesize', '128M');
	ini_set('max_execution_time', '0');
	
	
    if($_FILES['csvFile']){
        if($_FILES['csvFile']['error'] == 0) {
            $fileName = date('Y_m_d_H_i').'_'.basename($_FILES['csvFile']['name']);
            $upload = @move_uploaded_file($_FILES['csvFile']['tmp_name'], ROOT_PATH.'upload/csv/'.$fileName);
            if($upload) {
                $_SESSION['newCSVFile']  = $fileName;
            } else {
                $error = UPLOAD_AUTHORIZE_ERROR;
            }
        } else {
            $error = fileUploadErrorMessage($_FILES['csvFile']['error']);
        }
        exit;
    }

    
    if($params['sampleFile']){
        $file = SITE_PATH.DS.'/upload/report/Keyword_Delivery_Schedule.csv';
        if (file_exists($file)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename='.basename($file));
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            ob_clean();
            flush();
            readfile($file);
            exit;
        }
    }
	
	if($params['saveImportCsv']){
        $importOption = $params['importOpt'];
        $importCsvObj = getObject('importCsv');
        $importCsvId = $importCsvObj->saveImportCsv($_SESSION['newCSVFile']);
        $_SESSION['importCsvId'] = $importCsvId;
		$redirectPage = 'importType.php';
        setRedirect($redirectPage);
    }
	
	if($params['saveData']){
		
		$importCsvObj = getObject('importCsv');	
		@ini_set('max_execution_time', 0);
		$skipFirstRow = false;
		if($params['firstRow']) $skipFirstRow = true;
		$uniqueField = $params['uniqueFieldName'];
		//Get all lines from csv file
		$dataLine = 0;
		foreach($params['field'] as $fieldKey => $fieldName){
			$isUnique = 0;
			if(!$fieldName) {
				if($uniqueField == $fieldName) $uniqueField  = 0; 
				continue;
			}
			if($params['importOpt'] == 0) {
				$isUnique = 0;
			} else if($uniqueField === $fieldName) {
				$isUnique = 1;
			}
			
			
			$importFieldId = $importCsvObj->addCsvImportFields($params['importCsvId'], $fieldKey, $fieldName, $params['userId'], $params['sessionClientId'], $isUnique);
		}
		$importCsvObj->updateCsvImport($params['importCsvId'], $skipFirstRow, CSV_STATUS_QUEUE, $params['importOpt']);
		$_SESSION['importSuccessMsg'] = IMPORT_CSV_IN_QUEUE;
		$redirectPage = 'importWizardSuccess.php';
		setRedirect($redirectPage);
		unset($_SESSION['strChooseType']);
		unset($_SESSION['newCSVFile']);
	}

	$fieldsArr = array();
	foreach($keywordHeaderUpdateArray as $fieldName => $fieldValue){
		$fieldsArr[$fieldValue] = $fieldValue;
	}
	$fieldOptions = generateSelectOption($fieldsArr, '', 0);
	$smarty->assign('fieldOptions', $fieldOptions);
	
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->assign('lastPage', 'Import Wizard');
$smarty->display('importWizard.tpl');
require_once('footer.php');
?>