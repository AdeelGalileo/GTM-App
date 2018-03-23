<?php
include('../quickBook/config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Invoice;

class createInvoiceQbModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		$outputArray=array();
		
		$refInvoiceTypeArr = $params['refInvoiceTypeArr'];
		$taskDataInvoiceReference = $params['taskDataInvoiceReference'];
		$qbSuccess =false;
		if($refInvoiceTypeArr){
			
			$qbClientTokenObj = getObject('qbClientToken');
			$tokenIpArray=array();
			$tokenIpArray['clientQbTokenUpateId']=1;
			$tokenDataArray = $qbClientTokenObj->getQbClientTokenById($tokenIpArray);
			
			try {
			
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
			
			$invoiceArray = $invoiceItemArray=$SalesItemLineDetail=$itemRef=$ItemRefVal=$classRef=$classRefVal=$customerRef=array();
			
			foreach($refInvoiceTypeArr as $refKey => $refVal){
				$ItemRefVal[$refKey]['value']=$refVal['serv_type_qb_id'];
				$ItemRefVal[$refKey]['name']=$refVal['serv_type_name'];
				
				$classRefVal[$refKey]['value']=$refVal['qb_cls_ref_class_id'];
				$classRefVal[$refKey]['name']=$refVal['qb_cls_ref_class_name'];
				
				$classRef['ClassRef']=$classRefVal[$refKey];
				
				$itemRef['ItemRef']=$ItemRefVal[$refKey];
				$invoiceItemArray['Amount']=$refVal['sum'];
				$invoiceItemArray['DetailType']="SalesItemLineDetail";
				$invoiceItemArray['SalesItemLineDetail']=array('ItemRef'=>$itemRef['ItemRef'],'ClassRef'=>$classRef['ClassRef'], 'UnitPrice' => $refVal['serv_type_gal_rate'], 'Qty' => $refVal['invQty']);
				$invoiceArray ['Line'][$refKey] =$invoiceItemArray;
				$customerRef['value']=$refVal['client_qb_ref_qb_id'];
				$invoiceArray['CustomerRef']=$customerRef;
			}
			
			//Add a new Invoice
			
				
				$theResourceObj = Invoice::create($invoiceArray);
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
					$invoiceRefUpdateArray=array();
					$invoiceObj = getObject('invoice');
					foreach($taskDataInvoiceReference as $refKey => $refVal){
						$invoiceRefUpdateArray['userId']=$params['userId'];
						$invoiceRefUpdateArray['taskId']=$refVal['taskId'];
						$invoiceRefUpdateArray['taskType']=$refVal['TaskType'];
						$invoiceRefUpdateArray['invoiceReference']=$resultingObj->DocNumber;
						$invoiceRefUpdateArray['sessionClientId']=$params['sessionClientId'];
						$invoiceObj->updateQbInvoiceReference($invoiceRefUpdateArray);
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