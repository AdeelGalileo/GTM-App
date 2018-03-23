<?php
    require_once('header.php');
	ini_set('memory_limit', '512M');
	ini_set('post_max_size', '256M');
	ini_set('upload_max_filesize', '128M');
	ini_set('max_execution_time', '0');
    header("access-control-allow-origin: *");
	
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

    if($_POST['save']){
        $catType = 2;	
        $_SESSION['impBusinessType'] = $businessCat = $params['ChooseType'];	

        if($params['ChooseType']){
            $_SESSION['strChooseType'] = $params['ChooseType'];
            $moduleTemplateID = $leadObj->getModuleTemplateIDByType($params['ChooseType']);
            $modTemplateId = $moduleTemplateID[0]['ModuleTemplateID'];
        }
        $leadRate = $params['leadType'];
        $leadStage = $params['leadStage'];	
        $leadOwner = $params['OwnerID'];
        if(isset($params['category_name']) && $params['category_name']!=''){
            $categoryObj = getObject('category');
            $categoryId = $categoryObj->addCategory($params['category_name'], $catType, $businessCat);
            $_SESSION['impCategoryName'] = $params['category_name'];
            $redirectPage = 'importCSV.php';
        } else {
            $categoryId = $params['category_id'];
            $categoryObj = getObject('category');
            $catInfo = $categoryObj->getCategoryInfo($categoryId);
            $catName = $catInfo['category_name'];
            if($catInfo['category_type'] == 1){
                $catName = 'Web_'.$catName;
            } else if($catInfo['category_type'] == 3){
                $catName = 'Campaign_'.$catName;
            }
            $_SESSION['impCategoryName'] = $catName;
            $redirectPage = 'importType.php';
        }
        $_SESSION['impCategory']= $categoryId;
        $importOption = $params['importOpt'];
        $importCsvObj = getObject('importCsv');
        $importCsvId = $importCsvObj->saveImportCsv($businessCat, $categoryId, $_SESSION['newCSVFile'], $modTemplateId, $leadRate, $leadStage, $leadOwner, $importOption);
        $_SESSION['importCsvId'] = $importCsvId;
        setRedirect($redirectPage);
        //setRedirect('importCSV.php');
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

	$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
	$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
	$smarty->assign('pageLink', ROOT_HTTP_PATH.'/importWizard.php');
	$smarty->assign('lastPage', 'Import Wizard');
	require_once('footer.php');
  
?>