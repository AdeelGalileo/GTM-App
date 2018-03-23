<?php
	require_once('header.php');

	require_once dirname(__FILE__) . '/library/PHPExcel/Classes/PHPExcel.php';
	
	$invoiceObj = getObject('invoice');
	
	//$demo = str_replace("%20"," ",$_GET['serviceTypeFilter']);
	//echo rawurldecode($_GET['serviceTypeFilter']);exit;
	//echo $_SERVER['QUERY_STRING'];
	//exit;
	//echo str_replace('&serviceTypeFilter='.$_GET['serviceTypeFilter'], '', $_SERVER['QUERY_STRING']);
	//exit;
	
	$invoiceTaskList = $invoiceObj->getOutstandingInvoiceList($params);

	if($invoiceTaskList['invoiceTaskList']){
		
		$objPHPExcel = new PHPExcel();
		PHPExcel_Settings::setZipClass(PHPExcel_Settings::PCLZIP);
		$objPHPExcel = PHPExcel_IOFactory::load(ROOT_PATH."OutStandingInvoiceTemplate.xlsx");
		$objPHPExcel->setActiveSheetIndex(0);
		
		$excelArray=array();
		$totalVal=0;
		$grandTotal=0;
		foreach($invoiceTaskList['invoiceTaskList'] as $key => $value){
			$excelArray[$key]['userName'] = $value['userName'];
			$excelArray[$key]['userLName'] = $value['userLName'];
			$excelArray[$key]['marshaCode'] = $value['marshaCode'];
			$excelArray[$key]['divisionCode'] = $value['divisionCode'];
			$excelArray[$key]['servTypeName'] = $value['servTypeName'];
			$excelArray[$key]['servTypeGalRate'] = $value['servTypeGalRate'];
			$excelArray[$key]['unitNo'] = $value['unitNo'];
			$totalVal =  $value['unitNo'] * $value['servTypeGalRate'];
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
            ->setCellValue('G'.$highestRow, 'Grand Total');
			
	    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('H'.$highestRow, "$".$grandTotal);
		
		// Rename worksheet
		$objPHPExcel->getActiveSheet()->setTitle('Invoice');

		// Set AutoSize for name and email fields
		$objPHPExcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
		$objPHPExcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
		
		$fileName='outstandingInvoice_'.date('m-d-Y_hia').'.csv';
		
		 header('Content-type: text/csv');
		 header('Content-Disposition: attachment;filename='.$fileName);
		 header('Cache-Control: max-age=0');
		
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
		$objWriter->save('php://output');
	
	}

 ?>