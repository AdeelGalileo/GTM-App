<?php
class uiMessageModule {
	function display($db = '', $params = array())
	{
		global $smarty;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		$message = '';
		if($_SESSION['error']) {
			$message .= implode('<br />', $_SESSION['error']);
		}
		if($_SESSION['successMsg']){
			$message .= (($message) ?'<br />' : ''). $_SESSION['successMsg'];
		}
		$message = trim(ucfirst($message), '.');
		$smarty->assign('message',$message);
		//Clear the error messages and success messages
		clearErrorMessage();
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);
		return $moduleContent;
	}
}
?>