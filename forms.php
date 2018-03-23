<?php
require_once('header.php');

$adminPersonnelObj = getObject('adminPersonnel');
$userIpArray=array();
//$userIpArray['userRoleIp']=USER_ROLE_CONSULTANT;
$userArray = $adminPersonnelObj->getUsersForForm();
$smarty->assign('userArray', $userArray);

$formFilterArray = generateSelectOption($formFilterArray,0);
$smarty->assign('formFilterArray', $formFilterArray);

$rolesArray = $adminPersonnelObj->getAllUserRoles();
$smarty->assign('rolesArray', $rolesArray);

if($_FILES['w9Form']){
	if($_FILES['w9Form']['error'] == 0) {
		$fileName = date('Y_m_d_H_i').'_'.basename($_FILES['w9Form']['name']);
		$upload = @move_uploaded_file($_FILES['w9Form']['tmp_name'], ROOT_PATH.'upload/forms/w9/'.$fileName);
		if($upload) {
			$_SESSION['newW9Form']  = $fileName;
		} else {
			$error = UPLOAD_AUTHORIZE_ERROR;
		}
	} else {
		$error = fileUploadErrorMessage($_FILES['w9Form']['error']);
	}
	exit;
}

if($_FILES['resumeForm']){
	if($_FILES['resumeForm']['error'] == 0) {
		$fileName = date('Y_m_d_H_i').'_'.basename($_FILES['resumeForm']['name']);
		$upload = @move_uploaded_file($_FILES['resumeForm']['tmp_name'], ROOT_PATH.'upload/forms/resume/'.$fileName);
		if($upload) {
			$_SESSION['newResumeForm']  = $fileName;
		} else {
			$error = UPLOAD_AUTHORIZE_ERROR;
		}
	} else {
		$error = fileUploadErrorMessage($_FILES['resumeForm']['error']);
	}
	exit;
}

if($_FILES['achForm']){
	if($_FILES['achForm']['error'] == 0) {
		$fileName = date('Y_m_d_H_i').'_'.basename($_FILES['achForm']['name']);
		$upload = @move_uploaded_file($_FILES['achForm']['tmp_name'], ROOT_PATH.'upload/forms/achForm/'.$fileName);
		if($upload) {
			$_SESSION['newAchForm']  = $fileName;
		} else {
			$error = UPLOAD_AUTHORIZE_ERROR;
		}
	} else {
		$error = fileUploadErrorMessage($_FILES['achForm']['error']);
	}
	exit;
}

if($_FILES['agreementForm']){
	if($_FILES['agreementForm']['error'] == 0) {
		$fileName = date('Y_m_d_H_i').'_'.basename($_FILES['agreementForm']['name']);
		$upload = @move_uploaded_file($_FILES['agreementForm']['tmp_name'], ROOT_PATH.'upload/forms/agreement/'.$fileName);
		if($upload) {
			$_SESSION['newAgreementForm']  = $fileName;
		} else {
			$error = UPLOAD_AUTHORIZE_ERROR;
		}
	} else {
		$error = fileUploadErrorMessage($_FILES['agreementForm']['error']);
	}
	exit;
}


 if($params['downloadForms']){
		$formFile = $params['downloadForms'];
		$formType = $params['formType'];
		$formPath="w9";
		if($formType == 1){
			$formPath="w9";
		}
		elseif($formType == 2){
			$formPath="resume";
		}
		elseif($formType == 3){
			$formPath="achForm";
		}
		elseif($formType == 4){
			$formPath="agreement";
		}
        $file = SITE_PATH.DS.'/upload/forms/'.$formPath.'/'.$formFile;
		if(file_exists($file)){
			$ext = strtolower(pathinfo($formFile, PATHINFO_EXTENSION));
			switch ($ext) {
				case "pdf":
				header('Content-Type: application/pdf');
				break;
				case "jpeg":
				header('Content-Type: application/jpeg');
				break;
				case "jpg":
				header('Content-Type: application/jpeg');
				break;
				case "png":
				header('Content-Type: application/png');
				break;
				case "doc":
				header('Content-Type: application/octet-stream');
				break;
				case "docx":
				header('Content-Type: application/octet-stream');
				break;
			}
			header("Content-disposition: attachment; filename=\"" . basename($file) . "\""); 
			readfile($file); 
			exit;
		}
 }


$strPageName = pathinfo($_SERVER["SCRIPT_FILENAME"]);
$smarty->assign('strCurrPage', str_replace('.php','',$strPageName['basename']));
$pageLinkTitle="Admin";
$smarty->assign('pageLink', '<a href="'.ROOT_HTTP_PATH.'/admin.php">'.$pageLinkTitle.'</a>');
$smarty->assign('lastPage', 'Forms');
$smarty->display('forms.tpl');
require_once('footer.php');
?>