<?php
require_once('header.php');
$adminPersonnelObj = getObject('adminPersonnel');
$rolesArray = $adminPersonnelObj->getAllUserRoles();
$smarty->assign('rolesArray', $rolesArray);
$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Admin Personnel');

include('quickBook/config.php');

use QuickBooksOnline\API\Core\ServiceContext;
use QuickBooksOnline\API\DataService\DataService;
use QuickBooksOnline\API\PlatformService\PlatformService;
use QuickBooksOnline\API\Core\Http\Serialization\XmlObjectSerializer;
use QuickBooksOnline\API\Facades\Vendor;

if($params['userUpdateId']){
	$userData = $adminPersonnelObj->getUserById($params['userUpdateId']);
	$smarty->assign('userData', $userData);
	$smarty->assign('userUpdateId', $params['userUpdateId']);
	if(!$userData){
		exit;
	}

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
	
		$dataCount = $dataService->Query("SELECT COUNT(*) FROM vendor");
		$entities = $dataService->Query("Select DisplayName,GivenName,Id FROM vendor STARTPOSITION 1 MAXRESULTS ".$dataCount);
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
	
	$smarty->assign('outputArray', $outputArray);
	$smarty->assign('outputErrorArray', $outputErrorArray);
	
	$smarty->display('adminUpdatePersonnel.tpl');
}
else{
	$smarty->display('adminPersonnel.tpl');
}
require_once('footer.php');
?>