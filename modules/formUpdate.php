<?php
class formUpdateModule {
	function display($db = '', $params = array()) {
		global $smarty;
		$tplName = str_replace('.php', '.tpl', basename(__FILE__));
		
		unset($_SESSION['newW9Form'],$_SESSION['newResumeForm'],$_SESSION['newAchForm'],$_SESSION['newAgreementForm']);		
		
		if($params['formUpdateId']){
			
			$formObj = getObject('form');
			$inputArray['userId']=$params['userId'];
			$inputArray['formUpdateId']=$params['formUpdateId'];
			$formData = $formObj->getFormById($inputArray);
			
			if($formData['form_user_id'] == $params['attrFormUserId']){
				if(!empty($formData['form_w_nine'])){
					$_SESSION['newW9Form']  = $formData['form_w_nine'];
				}
				if(!empty($formData['form_resume'])){
					$_SESSION['newResumeForm']  = $formData['form_resume'];
				}
				if(!empty($formData['form_ach'])){
					$_SESSION['newAchForm']  = $formData['form_ach'];
				}
				if(!empty($formData['form_consultant_agree'])){
					$_SESSION['newAgreementForm']  = $formData['form_consultant_agree'];
				}
			}
			else{
				unset($_SESSION['newW9Form'],$_SESSION['newResumeForm'],$_SESSION['newAchForm'],$_SESSION['newAgreementForm']);		
			}
			
			$smarty->assign('formData', $formData);
			$smarty->assign('formUpdateId', $params['formUpdateId']);
		}
		
		$moduleContent = $smarty->fetch(TEMPLATE_PATH.'/module/mod_'.$tplName);		
		return array('content' => $moduleContent);
	}
}
?>