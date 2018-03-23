<?php
$site_path = realpath(dirname(dirname(__FILE__)));
/* Define the physical path for the site */
define('DS', DIRECTORY_SEPARATOR);
define('SITE_PATH', $site_path);
define('CONTROLLER_PATH', $site_path.DS.'controller');
define('INCLUDE_PATH', $site_path.DS.'includes');
define('SMARTY_PATH', $site_path.DS.'includes'.DS.'smarty');
define('TEMPLATE_PATH',  $site_path.DS.'templates');
define('IMAGE_PATH', SITE_PATH.DS.'images');
define('CACHE_PATH', SITE_PATH.DS.'cache');
/* Define the HTTP path for the site. */
define('IMAGE_HTTP_PATH', ROOT_HTTP_PATH.'/images');
?>