<?php
    ob_start();
    require_once('includes/includes.php');
    ini_set('memory_limit', '-1');
    //Get the Smarty class
    require_once(SMARTY_PATH.DS.'Smarty.class.php');
    $smarty =  new Smarty();
    $smarty->template_dir = TEMPLATE_PATH.DS;
    $smarty->compile_dir = SITE_PATH.DS.'templates_c'.DS;
    //$smarty->setDefaultModifiers(array('escape'));
	
	if(!stristr( $url, 'https') && SSL_REDIRECT){
		$url = ROOT_HTTP_PATH.'/'.$_SERVER['REQUEST_URI'];
		setRedirect($url);
	}

    //Include Authorization Class
    $authorization = getObject('authorization');

    if(!$authorization->checkLogin() && basename($_SERVER['PHP_SELF']) !='index.php'){
        if(stristr($url, 'getModuleInfo.php') === false || stristr($url, 'iframe') === false || stristr($url, 'ajax') === false){
            $_SESSION['redirectUrl'] = $url;
        }
        setRedirect(ROOT_HTTP_PATH.'/index.php');
    }  

    //Modules
    $module = new modules($db);
    //Load Message modules
    $messages = $module->loadModules(array('uiMessage'));
    $smarty->assign('messages', $messages);
    $smarty->assign('SiteTitle', 'Galileo');
	
	if(!isset($_SESSION['sessionClientId'])) {
		$_SESSION['sessionClientId'] = 1;
		$_SESSION['sessionClientName'] = "Marriott";
	}
	
	$clientObj = getObject('client');
	$clientData = $clientObj->getAllClients();
	$smarty->assign('clientData', $clientData);
	
	if($_SESSION['sessionClientId'] == MARRIOTT_CLIENT_ID){
		define('ERR_MARSHA_CODE', 'Location Code Required');
		$codeLabelData = MARRIOTT_CODE_LABEL;
		$smarty->assign('codeLabelData', MARRIOTT_CODE_LABEL);
		
	}
	elseif($_SESSION['sessionClientId'] == STARWOOD_CLIENT_ID){
		define('ERR_MARSHA_CODE', 'CLIENT Code Required');
		$codeLabelData = STARWOOD_CODE_LABEL;
		$smarty->assign('codeLabelData', STARWOOD_CODE_LABEL);
	}
	else{
		define('ERR_MARSHA_CODE', 'CLIENT Code Required');
		$codeLabelData = STARWOOD_CODE_LABEL;
		$smarty->assign('codeLabelData', STARWOOD_CODE_LABEL);
	}
	
	$divisionObj = getObject('division');
	$divisionArray = $divisionObj->getDivisionByClientId();
	$smarty->assign('divisionArray', $divisionArray);
	
 
?>