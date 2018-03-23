<?php
include('quickBook/config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Item;


class serviceTypeUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['serviceTypeId']){
			
			$serviceTypeObj = getObject('serviceType');
			
			$inputArray['userId']=$params['userId'];
			$inputArray['serviceTypeId']=$params['serviceTypeId'];
			$serviceType = $serviceTypeObj->getServiceTypeById($inputArray);
			$smarty->assign('serviceType', $serviceType);
			$smarty->assign('serviceTypeId', $params['serviceTypeId']);
			

			$qbClientTokenObj = getObject('qbClientToken');
			$tokenIpArray=array();
			$tokenIpArray['clientQbTokenUpateId']=QB_TOKEN_DEFAULT_ID;
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

			
				$dataCount = $dataService->Query("SELECT COUNT(*) FROM item");
				$entities = $dataService->Query("Select Name,Id FROM item STARTPOSITION 1 MAXRESULTS ".$dataCount);
				$error = $dataService->getLastError();
				if ($error != null) {
					$outputArray[]=$error->getHttpStatusCode();
					$outputArray[]=$error->getOAuthHelperError();
					$outputArray[]=$error->getResponseBody();
				}
				else {
					$outputArray=$entities;
				}
			}
			catch(Exception $e) {
				$outputArray[]=$e->getMessage();
			}

			$smarty->assign('outputArray', $outputArray);
			
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>