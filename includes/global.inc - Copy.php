<?php
session_start();
/*** error reporting on ***/
error_reporting(E_ALL^E_NOTICE^E_WARNING);

$host = 'mariadb-158.wc2.phx1.stabletransit.com';
$user = '466649_galileo';
$pass = 'dWR{P8$S';
$name = '466649_galileo';

$dbType = 'mysql';
if($_SERVER['SERVER_NAME']) {
	define('ROOT_HTTP_PATH', 'http://'.$_SERVER['SERVER_NAME']);
} else {
	define('ROOT_HTTP_PATH', 'http://galileo.usawebdept.com');
}

define('SSL_REDIRECT', false);
