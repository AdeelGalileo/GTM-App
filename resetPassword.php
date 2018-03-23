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

if(($_POST['userPassword']) && ($_POST['userConfirmPassword'])){
	$userPassword = $_POST['userPassword'];
	$user_id_hidden = $_POST['user_id_hidden'];
	$user_activation_link_hidden = $_POST['user_activation_link_hidden'];
	$register = getObject('adminPersonnel');
	$userLinkData = $register->checkActivationLink($user_id_hidden, $user_activation_link_hidden);
	if($userLinkData){
		if(strtotime($userLinkData['user_activation_link_expire']) < strtotime(DB_DATE)){
			setMessage(ACTIVATION_CODE_EXPIRED);
			setRedirect('index.php');
		}
		$register->updateUserPassword($user_id_hidden,$userPassword);
		setMessage(PASSWORD_UPDATED_SUCCESSFULLY);
		setRedirect('index.php');
	}
	else{
		setMessage(ACTIVATION_CODE_INVALID);
		setRedirect('index.php');
	}
}



?>