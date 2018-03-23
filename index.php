<?php
require_once('header.php');

if($params['ajaxMode']){
    exit;
}
if($params['msg']){
	$msg = $params['msg'];
	switch($msg)
	{
		case 1: setMessage(MSG_LOGOUT_SUCCESS); break;
		case 2: setMessage(MSG_LOGIN_SESSION_TIMEOUT); break;
		case 3: setMessage(MSG_LOGIN_ANOTHER_SYSTEM); break;
		case 4: setMessage(MSG_ENSURE_SECURITY); break;
		default: setMessage(MSG_LOGOUT_SUCCESS);
	}
	setRedirect(ROOT_HTTP_PATH.'/index.php');
}


if(!stristr( $url, 'https')){
	//$url = 'https://'.$_SERVER['SERVER_NAME'];
	//setRedirect($url);
}

if($authorization->checkLogin()){
	setRedirect(ROOT_HTTP_PATH.'/dashboard.php');
}

if($_POST['login']) {
	
	checkAdminSpammers();
	$remember = $params['remember'] ? $params['remember'] : 0;
	$loggedIn = $authorization->login($_POST['userEmail'], $_POST['userPassword'], $remember);
	if($loggedIn){
		$redirectUrl = $_SESSION['redirectUrl'] ? $_SESSION['redirectUrl'] : '';
		
		if($redirectUrl){
			unset($_SESSION['redirectUrl']);
			setRedirect($redirectUrl);
		}
		setRedirect(ROOT_HTTP_PATH.'/dashboard.php');
	} else {
		setMessage(INVALID_USERNAME);
		setRedirect(ROOT_HTTP_PATH.'/index.php');
	}
}

$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$smarty->display('index.tpl');
require_once('footer.php');
?>