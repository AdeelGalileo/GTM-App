<?php
error_reporting(E_ALL);
require_once('includes/includes.php');
$fromEmail=NOTIFICATION_EMAIL;
$toEmail= "vasanth@sam.ai";
$subject=WELCOME_EMAIL;
$message ="test";
sendMail1($fromEmail, $toEmail, $subject, $message);


function sendMail1($fromEmail, $toEmail, $subject, $message, $bccEmail = '', $sender='', $ccEmail='',$attachment = '')
{
	
	echo $fromEmail;
	echo "<br/>";
	echo $toEmail;
	require_once(ROOT_PATH.'/library/phpMailer/PHPMailerAutoload.php');
	$mail = new PHPMailer();
	if($_SERVER['SERVER_NAME'] == 'localhost'){
		$mail->SMTPDebug = true;
		$mail->isMail();
	} else {
		$mail->SMTPDebug = true;
		$mail->isMail();
	}
	
	$sender = ($sender) ? $sender : NOTIFICATION_NAME;
	$mail->setFrom($fromEmail, $sender);
	$mail->Subject = $subject;
	$mail->msgHTML($message);
	//$mail->Body = $message;
	if(is_array($toEmail)){
		foreach($toEmail as $email) {
			$mail->addAddress($email);
		}
	} else {
		$mail->addAddress($toEmail);
	}
	if(is_array($ccEmail)) {
		foreach($ccEmail as $email) {
			$mail->AddCC($email);
		}
	} else if($ccEmail){
		$mail->AddCC($ccEmail);
	}
	if(is_array($bccEmail)) {
		foreach($bccEmail as $email) {
			$mail->AddBCC($email);
		}
	} else if($bccEmail){
		$mail->AddBCC($bccEmail);
	}
	if(!empty($attachment)) {
	    $mail->AddAttachment($attachment);
	}
	if($mail->send()){
		echo "success";
		return true;
	}
	
	printInfo($mail->ErrorInfo);
	
	return false;
}