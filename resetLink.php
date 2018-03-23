<?php
require_once('includes/includes.php');

require_once(SMARTY_PATH.DS.'Smarty.class.php');
$smarty =  new Smarty();
$smarty->template_dir = TEMPLATE_PATH.DS;
$smarty->compile_dir  = SITE_PATH.DS.'templates_c'.DS;

if($_SESSION['userId']){
	$authorization = getObject('authorization');
	if($authorization->checkLogin()){
		setMessage(MSG_ALREADY_LOGGED_IN);
		setRedirect('dashboard.php');
	}
}

if(($_GET['user_id']) && ($_GET['user_activation_link'])){
	$userId = $_GET['user_id'];
	$activationLink = $_GET['user_activation_link'];
	$register = getObject('adminPersonnel');
	$userLinkData = $register->checkActivationLink($userId, $activationLink);
	
	if($userLinkData){
			
		if(strtotime($userLinkData['user_activation_link_expire']) < strtotime(DB_DATE)){
			setMessage(ACTIVATION_CODE_EXPIRED);
			setRedirect('index.php');
		}
		
		$smarty->assign('userLinkData', $userLinkData);
		$smarty->display('resetPassword.tpl');
	}
	else{
		setMessage(ACTIVATION_CODE_INVALID);
		setRedirect('index.php');
	}
}



?>