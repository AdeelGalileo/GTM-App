<?php
include('quickBook/config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Customer;

class clientDivisionUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty, $recCountArr;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		if($params['clientQbRefUpdateId']){
			
			$qbClassReferenceObj = getObject('qbClassReference');
			$classQbRefIpArray=array();
			$classQbRefIpArray['sessionClientId']=$params['sessionClientId'];
			$qbClassNamesArray = $qbClassReferenceObj->getQbClassReferenceByClientId($classQbRefIpArray);
			$smarty->assign('qbClassNamesArray', $qbClassNamesArray);
			
			$clientDivsionObj = getObject('clientDivision');
			

			$inputArray['clientQbRefUpdateId']=$params['clientQbRefUpdateId'];
			$clientDivisionData = $clientDivsionObj->getClientDivisionById($inputArray);
			$smarty->assign('clientDivisionData', $clientDivisionData);
			$smarty->assign('clientQbRefUpdateId', $params['clientQbRefUpdateId']);
			
			
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

			
				$dataCount = $dataService->Query("SELECT COUNT(*) FROM customer");
				$entities = $dataService->Query("Select Id, DisplayName FROM customer STARTPOSITION 1 MAXRESULTS ".$dataCount);
				$error = $dataService->getLastError();
				if ($error != null) {
					$outputErrorArray[]=$error->getHttpStatusCode();
					$outputErrorArray[]=$error->getOAuthHelperError();
					$outputErrorArray[]=$error->getResponseBody();
				}
				else {
					$outputArray=$entities;
				}
			}
			catch(Exception $e) {
					$outputErrorArray[]=$e->getMessage();
			}
			
			$smarty->assign('outputErrorArray', $outputErrorArray);
			$smarty->assign('outputArray', $outputArray);
			
			
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>