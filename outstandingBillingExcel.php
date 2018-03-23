<?php
	require_once('header.php');

	require_once dirname(__FILE__) . '/library/PHPExcel/Classes/PHPExcel.php';
	
	
	//$demo = str_replace("%20"," ",$_GET['serviceTypeFilter']);
	//echo rawurldecode($_GET['serviceTypeFilter']);exit;
	//echo $_SERVER['QUERY_STRING'];
	//exit;
	//echo str_replace('&serviceTypeFilter='.$_GET['serviceTypeFilter'], '', $_SERVER['QUERY_STRING']);
	//exit;
	
	$billingObj = getObject('billing');
	$billTaskList = $billingObj->getOutstandingBillingList($params);

	if($billTaskList['billTaskList']){
		
		$objPHPExcel = new PHPExcel();
		PHPExcel_Settings::setZipClass(PHPExcel_Settings::PCLZIP);
		$objPHPExcel = PHPExcel_IOFactory::load(ROOT_PATH."OutStandingBillingTemplate.xlsx");
		$objPHPExcel->setActiveSheetIndex(0);
		
		$excelArray=array();
		$totalVal=0;
		$grandTotal=0;
		$consRate=0;
		foreach($billTaskList['billTaskList'] as $key => $value){
			$excelArray[$key]['userName'] = $value['userName'];
			$excelArray[$key]['userLName'] = $value['userLName'];
			$excelArray[$key]['marshaCode'] = $value['marshaCode'];
			$excelArray[$key]['divisionCode'] = $value['divisionCode'];
			if($value['contentDue'] !== '0000-00-00'){
				$excelArray[$key]['contentDue'] = date("m-d-Y", strtotime($value['contentDue']));
			}
			else{
				$excelArray[$key]['contentDue'] = "";
			}
			$excelArray[$key]['servTypeName'] = $value['servTypeName'];
			if($value['cons_rate_per_unit']){
				$consRate=$value['cons_rate_per_unit'];
			}
			else{
				$consRate=$value['servTypeFreeLRate'];
			}
			
			$excelArray[$key]['consRate'] = $consRate;
			$excelArray[$key]['unitNo'] = $value['unitNo'];
			$totalVal =  $value['unitNo'] * $consRate;
			$excelArray[$key]['totalVal'] = "$".$totalVal;
			$grandTotal= $grandTotal + $totalVal;
			$excelArray[$key]['tire'] = $value['tire'];
		}
		
		
		// Fill worksheet from values in array
		$objPHPExcel->getActiveSheet()->fromArray($excelArray, null, 'A2');
		
		$highestRow = $objPHPExcel->setActiveSheetIndex(0)->getHighestRow();
		$highestColumn = $objPHPExcel->setActiveSheetIndex(0)->getHighestColumn();
		$highestRow = $highestRow+1;
		
		$objPHPExcel->getActiveSheet()->setTitle("Title");
		
		$objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('H'.$highestRow, 'Grand Total');
			
	    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('I'.$highestRow, "$".$grandTotal);
		
		// Rename worksheet
		$objPHPExcel->getActiveSheet()->setTitle('Invoice');

		// Set AutoSize for name and email fields
		$objPHPExcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
		$objPHPExcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
		
		$fileName='OutStandingBillingTemplate_'.date('m-d-Y_hia').'.csv';
		
		 header('Content-type: text/csv');
		 header('Content-Disposition: attachment;filename='.$fileName);
		 header('Cache-Control: max-age=0');
		
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
		$objWriter->save('php://output');
	
	}

 ?>