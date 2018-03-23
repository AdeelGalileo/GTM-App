<?php
include('../quickBook/config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Bill;

class createBillQbModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		$outputArray=array();
		$qbSuccess =false;
		$taskDataBillingReference = $params['taskDataBillingReference'];
		if($taskDataBillingReference){
		
			$qbClientTokenObj = getObject('qbClientToken');
			$tokenIpArray=array();
			$tokenIpArray['clientQbTokenUpateId']=1;
			$tokenDataArray = $qbClientTokenObj->getQbClientTokenById($tokenIpArray);
		
			$dataService = DataService::Configure(array(
				'auth_mode' => $tokenDataArray['qb_client_token_auth_mode'],
				'ClientID' => $tokenDataArray['qb_client_token_client_id'],
				'ClientSecret' => $tokenDataArray['qb_client_token_client_secret'],
				'accessTokenKey' => $tokenDataArray['qb_client_token_access_token'],
				'refreshTokenKey' => $tokenDataArray['qb_client_token_refresh_token'],
				'QBORealmID' => $tokenDataArray['qb_client_token_qbo_real_id'],
				'baseUrl' => $tokenDataArray['qb_client_token_base_url']
			));
			
			$dataService->setLogLocation("/Users/hlu2/Desktop/newFolderForLog");

			$dataService->throwExceptionOnError(true);
			
			$OAuth2LoginHelper = $dataService->getOAuth2LoginHelper();

			$accessToken = $OAuth2LoginHelper->refreshToken();

			$dataService->updateOAuth2Token($accessToken);
			
			$billArray = $billItemArray=$SalesItemLineDetail=$itemRef=$ItemRefVal=$classRef=$classRefVal=$vendorRef=array();
			
			foreach($taskDataBillingReference as $refKey => $refVal){
				$ItemRefVal[$refKey]['value']=$refVal['serv_type_qb_id'];
				$ItemRefVal[$refKey]['name']=$refVal['serv_type_name'];
				$itemRef['ItemRef']=$ItemRefVal[$refKey];
				
				$classRefVal[$refKey]['value']=$refVal['qb_cls_ref_class_id'];
				$classRefVal[$refKey]['name']=$refVal['qb_cls_ref_class_name'];
				
				$classRef['ClassRef']=$classRefVal[$refKey];
				
				if($refVal['cons_rate_per_unit']){
					$ratePerUnit = $refVal['cons_rate_per_unit'];
				}
				else{
					$ratePerUnit = $refVal['servTypeFreeLRate'];
				}
				
				$billItemArray['Amount']=$ratePerUnit*$refVal['billQty'];
				$billItemArray['DetailType']="ItemBasedExpenseLineDetail";
				$billItemArray['ItemBasedExpenseLineDetail']=array('ItemRef'=>$itemRef['ItemRef'], 'ClassRef'=>$classRef['ClassRef'], 'UnitPrice' => $ratePerUnit, 'Qty' => $refVal['billQty']);
				$billArray ['Line'][$refKey] =$billItemArray;
				$vendorRef['value']=$refVal['user_qb_ref_id'];
				$billArray ['VendorRef']=$vendorRef;
			}
			
			//Add a new Bill
			
			try {
				$theResourceObj = Bill::create($billArray);
				$resultingObj = $dataService->Add($theResourceObj);
				
				
				$error = $dataService->getLastError();
				if ($error != null) {
					$outputArray[]=$error->getHttpStatusCode();
					$outputArray[]=$error->getOAuthHelperError();
					$outputArray[]=$error->getResponseBody();
				}
				else {
					$resultingObj->Id;
					$xmlBody = XmlObjectSerializer::getPostXmlFromArbitraryEntity($resultingObj, $urlResource);
					$outputArray[]=$xmlBody;
					$qbSuccess = true;
					$billingRefUpdateArray=array();
					$billingObj = getObject('billing');
					foreach($taskDataBillingReference as $refKey => $refVal){
						$billingRefUpdateArray['userId']=$params['userId'];
						$billingRefUpdateArray['taskId']=$refVal['taskId'];
						$billingRefUpdateArray['taskType']=$refVal['TaskType'];
						$billingRefUpdateArray['billingReference']=$resultingObj->Id;
						$billingRefUpdateArray['sessionClientId']=$params['sessionClientId'];
						$billingObj->updateQbBillingReference($billingRefUpdateArray);
					}
					
				}
			}
			catch(Exception $e) {
					$outputArray[]=$e->getMessage();
			}
			
		}
		
		$smarty->assign('outputArray', $outputArray);
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent , 'qbSuccess' => $qbSuccess ,'outputArray' =>$outputArray);
	}
}
?>