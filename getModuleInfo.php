<?php
require_once('header.php');

if(!$params['module']){
	setRedirect(ROOT_HTTP_PATH.'/index.php');
}

$authorization = getObject('authorization');

if(!$authorization->checkLogin()){
	setRedirect(ROOT_HTTP_PATH.'/index.php');
}

$params['ajaxMode']  = true;

$subModule = $params['subModule'] ? $params['subModule'] : '';

$modules = $module->getModule($params['module'], $subModule);

echo array2json(array('message' => $modules));

exit;

?>