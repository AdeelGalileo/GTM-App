<?php
require_once('header.php');	
$billingObj = getObject('billing');
$numberOfUnit = 1;
$billingTotal = 0;

//For Billing Qb transfer

if($params['qbTransfer'] == 1){
	$inputArray=$billingInputArray=$billingTaskRefInputArray=$taskDataBillingReference=array();
	
	$qbTransferIds = $params['qbTransferIds'];
	
	if($qbTransferIds){
		
		$qbBillInpArray=$qbBillKeywordIpArray=$qbBillContentIpArray=array();
		foreach($qbTransferIds as $key => $qbTransferIdVal){
			$individualTaskData = explode("_", $qbTransferIdVal);
			if($individualTaskData[0] == ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID){
				$qbBillInpArray['taskKeywordIds'][] = $individualTaskData[1];
			}
			elseif($individualTaskData[0] == ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID){
				$qbBillInpArray['taskContentIds'][] = $individualTaskData[1];
			}
		}
		
		$taskKeywordIds=0;
		$taskContentIds=0;
		if($qbBillInpArray){
			foreach($qbBillInpArray as $key => $val){
				if($key == 'taskKeywordIds'){
					$taskKeywordIds = implode(",",$val);
				}
				elseif($key == 'taskContentIds'){
					$taskContentIds = implode(",",$val);
				}
			}
		}
	
		$qbBillKeywordIpArray['taskIds'] = $taskKeywordIds;
		$qbBillKeywordIpArray['taskType'] = ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
		$qbBillKeywordDataArray=$billingObj->getTaskDataForQbBilling($qbBillKeywordIpArray);
		
		$qbBillContentIpArray['taskIds'] = $taskContentIds;
		$qbBillContentIpArray['taskType'] = ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
		$qbBillContentDataArray=$billingObj->getTaskDataForQbBilling($qbBillContentIpArray);
		
		$combineArray=array_merge($qbBillKeywordDataArray,$qbBillContentDataArray);

		$refBilTypeArr = array();
		foreach($combineArray as $value){
			$refId = $value['qb_cls_ref_id'];
			if(!array_key_exists($refId, $refBilTypeArr)){
				$refBilTypeArr[$refId] = array();
				$refBilTypeArr[$refId]['sum'] = 0;
			}
			$refBilTypeArr[$refId]['sum'] += $value['sumRate'];
			$refBilTypeArr[$refId]['user_qb_ref_id'] = $value['user_qb_ref_id'];
			$refBilTypeArr[$refId]['qb_cls_ref_class_id'] = $value['qb_cls_ref_class_id'];
			$refBilTypeArr[$refId]['qb_cls_ref_class_name'] = $value['qb_cls_ref_class_name'];
		}
		
		$billingInputArray['userId']=$params['userId'];
		$billingInputArray['sessionClientId']=$params['sessionClientId'];
		$billingInputArray['billingInvoiceId']=0;
		$billingInputArray['billingTotal']=0;
		$billingInputArray['billingQbProcessed']=0;
		$billingInputArray['billingQbReferenceNumber']="";
		
		$billingIdData = $billingObj->addBilling($billingInputArray);
		
		foreach($qbTransferIds as $key => $qbTransferIdVal){
			$individualTaskData = explode("_", $qbTransferIdVal);
			$inputArray[$key]['taskType'] = $individualTaskData[0];
			$inputArray[$key]['taskId'] = $individualTaskData[1];
			$inputArray[$key]['billQty'] = $individualTaskData[2];
			$taskDataBillingReference[]=$billingObj->getTaskDataForBillingReference($inputArray[$key]['taskId'],$inputArray[$key]['taskType'],$inputArray[$key]['billQty']);
		}
		
		if($taskDataBillingReference){
			foreach($taskDataBillingReference as $refKey => $refVal){
				
				$numberOfUnit = $refVal['billQty'];
				if($refVal['cons_rate_per_unit']){
					$ratePerUnit = $refVal['cons_rate_per_unit'];
				}
				else{
					$ratePerUnit = $refVal['servTypeFreeLRate'];
				}
				
				$billingTotal += $numberOfUnit * $ratePerUnit;
				
				$billingObj->addBillingTaskReference($billingIdData,$refVal['client_name'],$refVal['user_fname'],$refVal['user_lname'],$refVal['taskId'],$refVal['user_id'],$refVal['client_id'],$refVal['TaskType'],$refVal['client_entity_marsha_code'],$refVal['division_code'],$refVal['serv_type_name'],$ratePerUnit,$numberOfUnit,$refVal['tire'],$params['userId'],$refVal['serv_type_qb_id']);
				//$params['quantity'] = $numberOfUnit;
				//$params['vendor_ref'] = 60;
				
			}
			$params['refBilTypeArr'] =$refBilTypeArr;
			$params['taskDataBillingReference'] =$taskDataBillingReference;
			$getBillingResponse = $module->getModule('createBillQb');
		}
		
		$billingInputArray['userId']=$params['userId'];
		$billingInputArray['sessionClientId']=$params['sessionClientId'];
		$billingInputArray['billingUpdateId']=$billingIdData;
		$billingInputArray['billingInvoiceId']=0;
		$billingInputArray['billingTotal']=$billingTotal;
		$billingInputArray['billingQbProcessed']=1;
		$billingInputArray['billingQbReferenceNumber']="";
		
		$billingIdData = $billingObj->addBilling($billingInputArray);
		
	}
	
	if($getBillingResponse['qbSuccess']){
		echo array2json(array('success'=>true,'message'=>MOVE_TO_QB_SUCCESSFULLY));
	}
	else{
		echo array2json(array('success'=>true,'message'=>$getBillingResponse['outputArray']));
	}
	exit;
}

$invoiceObj = getObject('invoice');
$invoiceTotal = 0;
if($params['qbTransferForInvoice'] == 1){
	$inpArray=$invoiceInputArray=$taskDataInvoiceReference=array();
	
	$qbTransferIds = $params['qbTransferIds'];
	if($qbTransferIds){
		
		
		$qbInvoiceInpArray=$qbInvoiceKeywordIpArray=$qbInvoiceContentIpArray=array();
		foreach($qbTransferIds as $key => $qbTransferIdVal){
			$individualTaskData = explode("_", $qbTransferIdVal);
			if($individualTaskData[0] == ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID){
				$qbInvoiceInpArray['taskKeywordIds'][] = $individualTaskData[1];
			}
			elseif($individualTaskData[0] == ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID){
				$qbInvoiceInpArray['taskContentIds'][] = $individualTaskData[1];
			}
		}
		
		$taskKeywordIds=0;
		$taskContentIds=0;
		if($qbInvoiceInpArray){
			foreach($qbInvoiceInpArray as $key => $val){
				if($key == 'taskKeywordIds'){
					$taskKeywordIds = implode(",",$val);
				}
				elseif($key == 'taskContentIds'){
					$taskContentIds = implode(",",$val);
				}
			}
		}
	
		$qbInvoiceKeywordIpArray['taskIds'] = $taskKeywordIds;
		$qbInvoiceKeywordIpArray['taskType'] = ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID;
		$qbInvoiceKeywordDataArray=$invoiceObj->getTaskDataForQbInvoice($qbInvoiceKeywordIpArray);
		
		$qbInvoiceContentIpArray['taskIds'] = $taskContentIds;
		$qbInvoiceContentIpArray['taskType'] = ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID;
		$qbInvoiceContentDataArray=$invoiceObj->getTaskDataForQbInvoice($qbInvoiceContentIpArray);
		
		$combineArray=array_merge($qbInvoiceKeywordDataArray,$qbInvoiceContentDataArray);

		$refInvoiceTypeArr = array();
		foreach($combineArray as $value){
			$refId = $value['serv_type_id'];
			if(!array_key_exists($refId, $refInvoiceTypeArr)){
				$refInvoiceTypeArr[$refId] = array();
				$refInvoiceTypeArr[$refId]['sum'] = 0;
			}
			$refInvoiceTypeArr[$refId]['sum'] += $value['qtyRate'];
			$refInvoiceTypeArr[$refId]['serv_type_qb_id'] = $value['serv_type_qb_id'];
			$refInvoiceTypeArr[$refId]['serv_type_name'] = $value['serv_type_name'];
			$refInvoiceTypeArr[$refId]['invQty'] = $value['invQty'];
			$refInvoiceTypeArr[$refId]['serv_type_gal_rate'] = $value['serv_type_gal_rate'];
			$refInvoiceTypeArr[$refId]['client_qb_ref_qb_id'] = $value['client_qb_ref_qb_id'];
			$refInvoiceTypeArr[$refId]['qb_cls_ref_class_id'] = $value['qb_cls_ref_class_id'];
			$refInvoiceTypeArr[$refId]['qb_cls_ref_class_name'] = $value['qb_cls_ref_class_name'];
		}
		
		
		$invoiceInputArray['userId']=$params['userId'];
		$invoiceInputArray['sessionClientId']=$params['sessionClientId'];
		$invoiceInputArray['invoiceTotal']=0;
		$invoiceInputArray['invoiceQbProcessed']=0;
		$invoiceInputArray['invoiceQbReferenceNumber']="";
		
		$invoiceIdData = $invoiceObj->addInvoice($invoiceInputArray);
		
		foreach($qbTransferIds as $key => $qbTransferIdVal){
			$individualTaskData = explode("_", $qbTransferIdVal);
			$inpArray[$key]['taskType'] = $individualTaskData[0];
			$inpArray[$key]['taskId'] = $individualTaskData[1];
			$inpArray[$key]['invQty'] = $individualTaskData[2];
			$taskDataInvoiceReference[]=$invoiceObj->getTaskDataForInvoiceReference($inpArray[$key]['taskId'],$inpArray[$key]['taskType'],$inpArray[$key]['invQty']);
		}
		
		if($taskDataInvoiceReference){
			foreach($taskDataInvoiceReference as $refKey => $refVal){
				$numberOfUnit = $refVal['invQty'];
				$ratePerUnit  = $refVal['servTypeGalRate'];
				$invoiceTotal += $numberOfUnit * $ratePerUnit;
				
				$invoiceObj->addInvoiceTaskReference($invoiceIdData,$refVal['client_name'],$refVal['user_fname'],$refVal['user_lname'],$refVal['taskId'],$refVal['user_id'],$refVal['client_id'],$refVal['TaskType'],$refVal['client_entity_marsha_code'],$refVal['division_code'],$refVal['serv_type_name'],$ratePerUnit,$numberOfUnit,$refVal['tire'],$params['userId'],$refVal['serv_type_qb_id']);
			}
			$params['refInvoiceTypeArr'] =$refInvoiceTypeArr;
			$params['taskDataInvoiceReference'] =$taskDataInvoiceReference;
			$getInvoiceResponse = $module->getModule('createInvoiceQb');
		}
		
		$invoiceInputArray['userId']=$params['userId'];
		$invoiceInputArray['sessionClientId']=$params['sessionClientId'];
		$invoiceInputArray['invoiceUpdateId']=$invoiceIdData;
		$invoiceInputArray['invoiceTotal']=$invoiceTotal;
		$invoiceInputArray['invoiceQbProcessed']=1;
		$invoiceInputArray['invoiceQbReferenceNumber']="";
		
		$invoiceIdData = $invoiceObj->addInvoice($invoiceInputArray);
		
	}
	
	if($getInvoiceResponse['qbSuccess']){
		echo array2json(array('success'=>true,'message'=>MOVE_TO_QB_SUCCESSFULLY));
	}
	else{
		echo array2json(array('success'=>true,'message'=>$getInvoiceResponse['outputArray']));
	}
	exit;
}

?> 