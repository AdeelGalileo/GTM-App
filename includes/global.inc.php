<?php
session_start();
/*** error reporting on ***/
error_reporting(E_ALL^E_NOTICE^E_WARNING);

$host = 'localhost';
$user = 'galileotechmedia_app';
$pass = 'KLOcfyV~%EN7';
$name = 'galileotechmedia_app';

$dbType = 'mysql';
if($_SERVER['SERVER_NAME']) {
	define('ROOT_HTTP_PATH', 'https://'.$_SERVER['SERVER_NAME']);
} else {
	define('ROOT_HTTP_PATH', 'https://app.galileotechmedia.com');
}

define('SSL_REDIRECT', false);