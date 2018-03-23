<?php
session_start();
error_reporting(E_ALL^E_NOTICE);

$site_path = realpath(dirname(dirname(__FILE__)));

define('ROOT_PATH', $site_path.'/');

@ini_set('max_execution_time', 300);

require_once(ROOT_PATH.'includes/global.inc.php');
require_once(ROOT_PATH.'includes/commonSettings.php');
require_once(ROOT_PATH.'includes/pathConfig.php');
require_once(ROOT_PATH.'includes/functions.inc.php');
require_once(ROOT_PATH.'includes/modules.php');
//require_once(ROOT_PATH.'includes/facebook/config.php');

//Set or Reset Debug mode
$debug = 0;

$params = $_REQUEST;

$params = array_merge($params, $_SESSION);

$cronEmailSeries = 0;

if(get_magic_quotes_gpc()){
	//$params = array_map('stripslashes', $params);
	$params = voidSlashes($params);
}

function voidSlashes($arr)
{
	foreach($arr as $key=>$value){
		if(is_array($value)){
			$arr[$key] = voidSlashes($value);
		} else {
			$arr[$key] = stripslashes($value);
		}
	}
	return $arr;
}
//set_error_handler('ErrorHandler');

function ErrorHandler($errno, $errstr, $errfile, $errline)
{
	$currentUrl = currentPageURL();
	$msg = "Error In URL: {$currentUrl}<br />";
	switch ($errno) {
		case E_USER_ERROR:
			$msg .= "<b>ERROR</b> [$errno] $errstr<br />\n";
			$msg .= "  Fatal error on line $errline in file $errfile";
			$msg .= ", PHP " . PHP_VERSION . " (" . PHP_OS . ")<br />\n";
			//sendMail('admin@leadna.com', array('bks@usaweb.net', 'sk@usaweb.net', 'bm@usaweb.net', 'kl@usaweb.net'), 'Leads Error', $msg);
			/* Error on web page show 404 Not Found Page */
			/*
			if($_SERVER['SERVER_NAME']){
				header('HTTP/1.1 404 Not Found');
				require_once(SMARTY_PATH.DS.'Smarty.class.php');
				$smarty =  new Smarty();
				$smarty->template_dir = TEMPLATE_PATH.DS;
				$smarty->compile_dir  = SITE_PATH.DS.'templates_c'.DS;
				$smarty->assign('disableMenu', 1);
				$smarty->display('NotFound.tpl');
			}*/
			echo $msg;
			exit;
			break;
		case E_USER_WARNING:
			$msg .= "<b>User WARNING</b> [$errno] $errstr<br />\n";
			break;	
		case E_USER_NOTICE:
			$msg .= "<b>My NOTICE</b> [$errno] $errstr<br />\n";
			break;
		default:
			$msg .= "Unknown error type: [$errno] $errstr<br />\n";
			break;
	}
}

function shutdownFunction() { 
	$error = error_get_last();
	$errHistory = debug_back_trace();
	global $cronEmailSeries;
    if ($error['type'] == E_ERROR || $error['type'] == E_PARSE || $error['type'] == E_COMPILE_ERROR) {
        $errStr = $error['message'];
		$errFile = $error['file'];
		$errLine = $error['line'];
		$msg .= "<b>ERROR</b>$errStr<br />\n";
		$msg .= " line $errLine in file $errFile";
		$msg .= ", PHP " . PHP_VERSION . " (" . PHP_OS . ")<br />\n";
		if($cronEmailSeries != 0){
			$msg .= "Email Cron Error at: " .$cronEmailSeries . "<br />\n";
		}
		if($errHistory){
			foreach($errHistory as $err){
				$msg .= '<hr>';
				$msg .= 'Error in File: '.$err['file']. ' at Line: '. $err['line'];
			}
		}
		echo $msg;
		//sendMail('admin@leadna.com', array('bks@usaweb.net', 'bm@usaweb.net', 'kl@usaweb.net', 'sk@usaweb.net'), 'Leads Fatal Error', $msg);
		if($_SERVER['SERVER_NAME']){
			header('HTTP/1.1 404 Not Found');
			require_once(SMARTY_PATH.DS.'Smarty.class.php');
			$smarty =  new Smarty();
			$smarty->template_dir = TEMPLATE_PATH.DS;
			$smarty->compile_dir  = SITE_PATH.DS.'templates_c'.DS;
			$smarty->assign('disableMenu', 1);
			$smarty->display('NotFound.tpl');
		}
    } 
}

//register_shutdown_function('shutdownFunction');

/* Library files */
require_once(ROOT_PATH.'library/class.table.php');
//require_once(ROOT_PATH.'library/class.mail.php');
require_once(ROOT_PATH.'library/class.page.php');
require_once(ROOT_PATH.'library/class.cache.php');
/* Database functions */
require_once(ROOT_PATH.'library/class.database.'.$dbType.'.php');
require_once(ROOT_PATH.'includes/messages.php');

/* Create Database object */
$db = database::getInstance($host,$user,$pass,$name);

require_once(ROOT_PATH.'timeZone.php');
//Get UTC Time.
define('UTC_DATE_TIME', getUTCDateTime());

$params['cache'] = new cache();
?>