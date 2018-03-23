<?php
require_once('header.php');
if($params['userId']){
	$authorization->logout();
	setRedirect(ROOT_HTTP_PATH.'/logout.php');
} else {
	$authorization->logout();
	setMessage(MSG_LOGOUT_SUCCESS);
	setRedirect(ROOT_HTTP_PATH.'/index.php?msg=1');
}