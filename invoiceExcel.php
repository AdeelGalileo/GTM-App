<?php
	require_once('header.php');

	require_once dirname(__FILE__) . '/library/PHPExcel/Classes/PHPExcel.php';
	
	$invoiceObj = getObject('invoice');
	
	//$demo = str_replace("%20"," ",$_GET['serviceTypeFilter']);
	//echo str_replace('&serviceTypeFilter='.$_GET['serviceTypeFilter'], '', $_SERVER['QUERY_STRING']);
	//exit;
	//echo rawurldecode($_GET['serviceTypeFilter']);exit;
	//echo $_SERVER['QUERY_STRING'];
	//exit;
	
	$invoiceTaskList = $invoiceObj->getInvoiceTaskList($params);

	if($invoiceTaskList['invoiceTaskList']){
		
		$objPHPExcel = new PHPExcel();
		PHPExcel_Settings::setZipClass(PHPExcel_Settings::PCLZIP);
		$objPHPExcel = PHPExcel_IOFactory::load(ROOT_PATH."SubmittedInvoiceTemplate.xlsx");
		$objPHPExcel->setActiveSheetIndex(0);
		
		$excelArray=array();
		$totalVal=0;
		$grandTotal=0;
		foreach($invoiceTaskList['invoiceTaskList'] as $key => $value){
			$excelArray[$key]['invoice_reference_user_fname'] = $value['invoice_reference_user_fname'];
			$excelArray[$key]['invoice_reference_user_lname'] = $value['invoice_reference_user_lname'];
			$excelArray[$key]['invoice_reference_marsha_code'] = $value['invoice_reference_marsha_code'];
			$excelArray[$key]['invoice_reference_division_code'] = $value['invoice_reference_division_code'];
			$excelArray[$key]['invoice_reference_service_type_name'] = $value['invoice_reference_service_type_name'];
			$excelArray[$key]['invoice_reference_rate_per_unit'] = $value['invoice_reference_rate_per_unit'];
			$excelArray[$key]['invoice_reference_no_of_units'] = $value['invoice_reference_no_of_units'];
			$totalVal =  $value['invoice_reference_no_of_units'] * $value['invoice_reference_rate_per_unit'];
			$excelArray[$key]['totalVal'] = "$".$totalVal;
			$grandTotal= $grandTotal + $totalVal;
			$excelArray[$key]['invoice_reference_tire'] = $value['invoice_reference_tire'];
			$excelArray[$key]['invoice_reference_created_on'] = date("m-d-Y", strtotime($value['invoice_reference_created_on']));
			$excelArray[$key]['invoice_reference_doc_number'] = $value['invoice_reference_doc_number'];
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
		
		$fileName='submittedInvoice_'.date('m-d-Y_hia').'.csv';
		
		 header('Content-type: text/csv');
		 header('Content-Disposition: attachment;filename='.$fileName);
		 header('Cache-Control: max-age=0');
		
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
		$objWriter->save('php://output');
	
	}

 ?>