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

if($_POST['userEmail']){
	//Check the form is submitted from valid url
	$register = getObject('adminPersonnel');
	$userData = $register->checkUserEmailExists($_POST['userEmail']);
	$success = false;
	if(!$userData) {
		$message = MSG_EMAIL_NOT_EXISTS;
	} else {
		$userId = $userData['user_id'];
		$activationLink  = substr(md5(uniqid(rand(),1)),0,6);
		$dateExpire=date('Y-m-d', strtotime(DB_DATE. ' + 2 days'));
		$resetLink = ROOT_HTTP_PATH."/resetLink.php?user_id=".$userId."&user_activation_link=".$activationLink;
		$register->updateActivationLink($userId, $activationLink, $dateExpire);
		$mailInfo['firstName'] = $userData['user_fname'];
		$mailInfo['lastName'] = $userData['user_lname'];
		$mailInfo['resetLink'] = $resetLink;
		$smarty->assign('mailInfo', $mailInfo);
		
		$fromEmail=NOTIFICATION_EMAIL;
		$toEmail= $userData['user_email'];
		$subject="Forgotten Password";
		$smarty->assign('mailInfo', $mailInfo);
		$message = $smarty->fetch('forgotPasswordTemplate.tpl');
		$result = sendMail($fromEmail, $toEmail, $subject, $message); 
		$message = FORGET_PASSWORD_SENT;
		setErrorMessage('sessionOutError', $message);
		setRedirect('index.php');
		exit;
	
	}
	setErrorMessage('sessionOutError', $message);
	setRedirect('index.php');
}


$smarty->display('forgotPassword.tpl');

?>