<?php
	require_once('header.php');

	require_once dirname(__FILE__) . '/library/PHPExcel/Classes/PHPExcel.php';
	
	$billingObj = getObject('billing');
	$billTaskList = $billingObj->getBillingTaskList($params);

	if($billTaskList['billTaskList']){
		
		$objPHPExcel = new PHPExcel();
		PHPExcel_Settings::setZipClass(PHPExcel_Settings::PCLZIP);
		$objPHPExcel = PHPExcel_IOFactory::load(ROOT_PATH."SubmittedBillingTemplate.xlsx");
		$objPHPExcel->setActiveSheetIndex(0);
		
		$excelArray=array();
		$totalVal=0;
		$grandTotal=0;
		$consRate=0;
		foreach($billTaskList['billTaskList'] as $key => $value){
			$excelArray[$key]['billing_reference_user_fname'] = $value['billing_reference_user_fname'];
			$excelArray[$key]['billing_reference_user_lname'] = $value['billing_reference_user_lname'];
			$excelArray[$key]['billing_reference_marsha_code'] = $value['billing_reference_marsha_code'];
			$excelArray[$key]['billing_reference_division_code'] = $value['billing_reference_division_code'];
			$excelArray[$key]['billing_reference_service_type_name'] = $value['billing_reference_service_type_name'];
			$excelArray[$key]['billing_reference_rate_per_unit'] = $value['billing_reference_rate_per_unit'];
			$excelArray[$key]['billing_reference_no_of_units'] = $value['billing_reference_no_of_units'];
			$totalVal =  $value['billing_reference_no_of_units'] *  $value['billing_reference_rate_per_unit'];
			$excelArray[$key]['totalVal'] = "$".$totalVal;
			$grandTotal= $grandTotal + $totalVal;
			$excelArray[$key]['billing_reference_tire'] = $value['billing_reference_tire'];
			$excelArray[$key]['billing_reference_created_on'] = date("m-d-Y", strtotime($value['billing_reference_created_on']));
			$excelArray[$key]['billing_reference_doc_number'] = $value['billing_reference_doc_number'];
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
		
		$fileName='SubmittedBillingTemplate_'.date('m-d-Y_hia').'.csv';
		
		 header('Content-type: text/csv');
		 header('Content-Disposition: attachment;filename='.$fileName);
		 header('Cache-Control: max-age=0');
		
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'CSV');
		$objWriter->save('php://output');
	
	}

 ?>