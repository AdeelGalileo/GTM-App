<?php
/*****************************************************************************************************
 ** Function Name : getObject
 ** Objective : Gets the Object Method based on the requested class it uses single ton method
 ****************************************************************************************************/
function getObject($className='', $folder=''){
	loadClass($className, $folder);
	return getInstance($className);
}

/*****************************************************************************************************
 ** Function Name : loadClass
 ** Objective : used to require the mentioned class
 ** Parameters : $className : string
 ****************************************************************************************************/
function loadClass($className='', $folder=''){
	$className = ($folder ? $folder.'/' : '').$className.'.php';
	$classFile = CONTROLLER_PATH.'/'.$className;
	
	if(file_exists($classFile)){
		require_once($classFile);
	}else{
		// Dont Delete For Reference - throw new ClassNotFoundException($message);
		//echo $className.' : Class Not Found, set ClassPath';
		trigger_error($className.' : Class Not Found, set ClassPath', E_USER_ERROR);
		exit;
	}
}

/*****************************************************************************************************
 ** Function Name : getInstance
 ** Objective : This function is used to implement the singleton object for the class
 **             It will check whether the object for this class is already exists or not
 **             It will return the object, if exists, else it will create and return.
 ** Parameters : $className : string
 ** Return Value : Object
 ****************************************************************************************************/
function &getInstance ($class){
	static $instances = array();  // array of instance names
 	global $db, $params;
	if (!array_key_exists($class, $instances)) {
		   // instance does not exist, so create it
		   $instances[$class] = new $class($db);
	} // if
	$instance =& $instances[$class];
	//$params['userId'] = $params['channelUserId'] ? $params['channelUserId'] : $params['userId'];
	//Change the parameter
	$instance->setParams($params);
	return $instance;
}

/* Function to check spammers */
function checkSpammers()
{
	if(!$_SERVER['HTTP_REFERER']) return true;
	if(!stristr($_SERVER['HTTP_REFERER'], $_SERVER['SERVER_NAME'])){
		setMessage('It is a spam request');
		setRedirect(ROOT_HTTP_PATH.'/index.php');
	}
	return true;
}

function checkAdminSpammers()
{
	if(!$_SERVER['HTTP_REFERER']) return true;
	if(!stristr($_SERVER['HTTP_REFERER'], $_SERVER['SERVER_NAME'])){
		setMessage('It is a spam request');
		setRedirect(ADMIN_ROOT_PATH.'/index.php');
	}
	return true;
}

/* Function to check value is empty or not */
function checkEmpty($value)
{
	return (trim($value) == '');
}
/* Function to check given email is valid */
function validateEmail($value)
{
	$regex= "/^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,8}$/";
	return (preg_match($regex, $value));
}
/* Function to get IP Address*/
function getRealIpAddr()
{
	if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
	  $ip = $_SERVER['HTTP_CLIENT_IP'];
	} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   { //to check ip is pass from proxy
	  $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	} elseif (!empty($_SERVER['HTTP_FORWARDED_FOR']))  {
	  $ip = $_SERVER['HTTP_FORWARDED_FOR'];
	} elseif (!empty($_SERVER['HTTP_X_FORWARDED'])) {
	  $ip = $_SERVER['HTTP_X_FORWARDED'];
	} elseif (!empty($_SERVER['HTTP_FORWARDED'])) {
	  $ip = $_SERVER['HTTP_FORWARDED'];
	} else {
	  $ip = $_SERVER['REMOTE_ADDR'];
	}
	return $ip;
}
//Function to replace the array contents in a template string
function replaceContent($inputArray, $content){	
	$inputArray['siteUrl'] = ROOT_HTTP_PATH;
	$inputArray = array_change_key_case($inputArray, CASE_LOWER);
	/*@extract($inputArray);
	$rslt = preg_replace("/{([\w]*?)}/e", "$$1", $content);
	return $rslt;*/
	 $message = preg_replace_callback("/{([\w]*?)}/", function($m) use($inputArray) {
		 $var = strtolower($m[1]);
	 return ($inputArray[$var]); }
	 , $content);
	return $message;
}

//Function to replace the array contents in a template string
function replaceContentWithPercentage($inputArray, $content){	
	$inputArray['siteUrl'] = ROOT_HTTP_PATH;
	$inputArray = array_change_key_case($inputArray, CASE_LOWER);
	/*@extract($inputArray);
	$rslt = preg_replace("/{([\w]*?)}/e", "$$1", $content);
	return $rslt;*/
	 $message = preg_replace_callback("/%([\w]*?)%/", function($m) use($inputArray) {
		 $var = strtolower($m[1]);
	 return ($inputArray[$var]); }
	 , $content);
	return $message;
}

/* Set the error message in session with given error code*/
function setErrorMessage($errCode, $errMsg)
{
	if(!isset($_SESSION['error']))
	{
		$_SESSION['error'] = array();	
	}
	$_SESSION['error'][$errCode] = $errMsg;
}
/* Set redirect to the page*/
function setRedirect($url, $isSecure = false)
{
	if(!stristr( $url, 'http')){
		$url = ROOT_HTTP_PATH.'/'.$url;
	}
	if(SSL_REDIRECT === TRUE){
		$isSecure=true;	
	}
	if($isSecure) {
		$url = str_replace('http://', 'https://', $url);
	} else {
		$url = str_replace('https://', 'http://', $url);
	}
	if($_POST['ajaxMode']){
		echo array2json(array('redirect' => $url));
	} else if($_GET['iframe']){
		echo '<script type="text/javascript">window.parent.location ="'.$url.'"</script>';	
	} else if($_GET['ajaxMode']){
		echo '<script type="text/javascript">window.location ="'.$url.'"</script>';
	} else {
		header('location: '. $url);
	}
	exit;
}
/* Set redirect to the page with crypt*/
function setRedirectEn($url)
{
 $url = base64_decode($url);
 setRedirect($url);
}
/* Clear the error */
function clearErrorMessage($errCode = '')
{
	if(isset($_SESSION['error'])){
		if($errCode) {
			unset($_SESSION['error'][$errCode]);
		} else {
			unset($_SESSION['error']);	
		}
	}
	unset($_SESSION['successMsg']);
}
/* Function Set Message*/
function setMessage($message)
{
	$_SESSION['successMsg'] = $message;
	return true;
}

/* Get the error message */
function getErrorMessage($errCode = '')
{
	if(isset($_SESSION['error'])){
		if($errCode) {
			return ($_SESSION['error'][$errCode]);
		} else {
			return ($_SESSION['error']);	
		}
	}
	return false;
}

//File Upload Error
function fileUploadErrorMessage($error_code)
{
    switch ($error_code) {
        case UPLOAD_ERR_INI_SIZE:
            return 'The uploaded file exceeds the upload_max_filesize directive in php.ini';
        case UPLOAD_ERR_FORM_SIZE:
            return 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form';
        case UPLOAD_ERR_PARTIAL:
            return 'The uploaded file was only partially uploaded';
        case UPLOAD_ERR_NO_FILE:
            return 'No file was uploaded';
        case UPLOAD_ERR_NO_TMP_DIR:
            return 'Missing a temporary folder';
        case UPLOAD_ERR_CANT_WRITE:
            return 'Failed to write file to disk';
        case UPLOAD_ERR_EXTENSION:
            return 'File upload stopped by extension';
        default:
            return 'Unknown upload error';
    }
} 

//Function to make the upload file as safe file
function safeFile($fileName)
{
	//skip the special characters other than dot(.) and _
	$find = array('/[^a-z0-9\_\.]/i', '/[\_]+/');
	$repl = array('_', '_');
	$fileName = preg_replace ($find, $repl, $fileName);
	return (strtolower($fileName));
}
//Function to make the upload file as safe file
function safeTemplateFile($fileName)
{
	//skip the special characters other than dot(.) and _
	$find = array('/[^a-z0-9\_]/i', '/[\_]+/');
	$repl = array('_', '_');
	$fileName = preg_replace ($find, $repl, $fileName);
	return ($fileName);
}
/* Get Total Records in a result set */
function getTotalRecords($result)
{
	if(is_array($result)){
		return isset($result[0]['totalRows']) ? $result[0]['totalRows'] : count($result);
	} else {
		return 0;
	}
}

/* Make a single dimension array from a two dimensional array for a given key */
function getSingleArray($resultArray, $dbKey, $asString = false, $seperator = ',')
{
	$singleArr = array();
	if(!empty($resultArray)){
		foreach($resultArray as $key => $value){
			//Check for the single dimension array
			if(!is_array($value)){
				$singleArr[] = 	$resultArray[$dbKey];
				break;
			}
			if(isset($value[$dbKey]))
				$singleArr[] = $value[$dbKey];
		}
	} else {
		if($asString) {
			return '';
		}
		return $singleArr;
	}
	if($asString) {
		return implode($seperator, $singleArr);
	} else {
		return $singleArr;
	}
}
/* Convert array to json format */
function array2json($arr) {
    if(function_exists('json_encode')) return json_encode($arr); //Lastest versions of PHP already has this functionality.
    $parts = array();
    $is_list = false;

    //Find out if the given array is a numerical array
    $keys = array_keys($arr);
    $max_length = count($arr)-1;
    if(($keys[0] == 0) and ($keys[$max_length] == $max_length)) {//See if the first key is 0 and last key is length - 1
        $is_list = true;
        for($i=0; $i<count($keys); $i++) { //See if each key correspondes to its position
            if($i != $keys[$i]) { //A key fails at position check.
                $is_list = false; //It is an associative array.
                break;
            }
        }
    }

    foreach($arr as $key=>$value) {
        if(is_array($value)) { //Custom handling for arrays
            if($is_list) $parts[] = array2json($value); /* :RECURSION: */
            else $parts[] = '"' . $key . '":' . array2json($value); /* :RECURSION: */
        } else {
            $str = '';
            if(!$is_list) $str = '"' . $key . '":';

            //Custom handling for multiple data types
            if(is_numeric($value)) $str .= $value; //Numbers
            elseif($value === false) $str .= 'false'; //The booleans
            elseif($value === true) $str .= 'true';
            else $str .= '"' . addslashes($value) . '"'; //All other things
            // :TODO: Is there any more datatype we should be in the lookout for? (Object?)

            $parts[] = $str;
        }
    }
    $json = implode(',',$parts);
    
    if($is_list) return '[' . $json . ']';//Return numerical JSON
    return '{' . $json . '}';//Return associative JSON
}

/* Generate Select option from array */
function generateSelectOption($srcArr='', $optionSelected='', $optionValue='', $optionSkip='') {
	$optionsToDisplay = "";
	if(!$srcArr) return;
	if(!is_array($srcArr)) return;
	foreach ($srcArr as $srcArrKey => $srcArrValue) {
		$optValue = ($optionValue) ?  $srcArrValue : $srcArrKey;
		if($optionSkip == $optValue) continue;
		$optionsToDisplay .= '<option value ="'. $optValue .'" ';
		if (is_array($optionSelected)) {
			if (in_array($optValue, $optionSelected)) {				
				$optionsToDisplay .= "selected ";
			}
		} else if ($optValue == $optionSelected && $optionSelected!='') {
			$optionsToDisplay .= "selected ";
		}
		$optionsToDisplay .= ">".$srcArrValue."</option>";
	}
	return $optionsToDisplay;
}

/* Generate DB Select Options */
function generateDBSelectOption($srcArr='', $keyField, $valueField, $optionSelected='', $optionSkip = '') {
	$optionsToDisplay = "";
	if(!$srcArr) return $optionsToDisplay;
	foreach ($srcArr as $srcArrKey => $srcArrValue) {
		if($optionSkip == $srcArrValue[$keyField]) continue;
		$optionsToDisplay .= '<option value ="'. $srcArrValue[$keyField] .'" ';
		if (is_array($optionSelected)) {
			if (in_array($srcArrValue[$keyField], $optionSelected) ) {				
				$optionsToDisplay .= 'selected="selected" ';
			}
		} else if ($srcArrValue[$keyField] == $optionSelected) {
			$optionsToDisplay .= 'selected="selected" ';
		}
		$optionsToDisplay .= ">".$srcArrValue[$valueField]."</option>";
	}
	return $optionsToDisplay;
}

function addUrlParams($url, $params = array())
{
	$pageUrl = $url;
	if(empty($params))
		return $url;
	$pos = strpos($url, '?');
	$existingParams  = array();
	if ($pos !== false &&  $pos >= 0){
		//Get the existing parameters
		$urlArray = explode('?', $url);
		$oldParams = explode('&', $urlArray[1]);
		$pageUrl = $urlArray[0];
		foreach($oldParams as $key => $value)
		{
			list($urlParam, $urlValue) = explode('=', $value);
			//Check the parameter in given parameter list
			if(!array_key_exists($urlParam, $params)){
				$existingParams[$urlParam] = $urlValue;
			}
		}
	}
	$urlParams = array();
	
	if(!empty($existingParams))
		$params = array_merge($existingParams, $params);
	foreach($params as $key => $value)
	{
		array_push($urlParams, $key .'='.urlencode($value));
	}
	$uri = implode('&', $urlParams);
	$pageUrl .= '?'.$uri;
	return $pageUrl;
}

function generateDateArray($fromDate, $totalDays, $includeFromDate = true)
{
	$incStr = "+1 DAY";	
	$fromDateVal = is_numeric($fromDate) ? $fromDate : strtotime($fromDate);
	if($includeFromDate) {
		$dateArr[] = $fromDateVal;
		$dayCnt = 1;
	} else {
		$dayCnt = 0;
	}
	for(; $dayCnt < $totalDays; $dayCnt++) {
		$fromDateVal = strtotime($incStr, $fromDateVal);
		$dateArr[] = $fromDateVal;
	}
	return $dateArr;
}

function generatePreviousDateArray($fromDate, $totalDays, $includeFromDate = true)
{
	$incStr = "+1 DAY";	
	$fromDateVal = is_numeric($fromDate) ? $fromDate : strtotime($fromDate);
	$fromDateVal = ($includeFromDate) ? $fromDateVal : strtotime('-1 Day', $fromDateVal);
	$fromDateVal = strtotime("-{$totalDays} DAY", $fromDateVal);
	for($dayCnt = 0; $dayCnt < $totalDays; $dayCnt++) {
		$fromDateVal = strtotime($incStr, $fromDateVal);
		$dateArr[] = $fromDateVal;
	}
	return $dateArr;
}

function convertSecondToTime($seconds = 0)
{
	if($seconds){
		$minutes = $seconds % 3600;
		$hours = ($seconds - $minutes) / 3600;
		$seconds = $minutes % 60;
		$minutes = ($minutes - $seconds) / 60;
	} else {
		$hours = $minutes = $seconds = 0;
		return '-';
	}

	/*
	if($hours==0 && $minutes == 0){
		$time = sprintf('%02d:%02d:%02d', $hours, $minutes, $seconds);
	} else {
		$time = sprintf('%02d:%02d', $hours, $minutes);
	}
	*/
	$time = sprintf('%02d:%02d:%02d', $hours, $minutes, $seconds);
	return $time;
}

/* Function to get variable name*/
function getVariableName($string) {
    //Strip any unwanted characters
    $string = preg_replace("/[^a-zA-Z0-9_\s-]/", "_", $string);
    //Clean multiple dashes or whitespaces
    $string = preg_replace("/[\s-]+/", "_", $string);
    return $string;
}

/* Function to strip multiple spaces*/
function cleanVariable($variableName)
{
	//Strip any unwanted characters
    $variableName = preg_replace("/[^a-zA-Z0-9_\s-]/", "", $variableName);
	//Clean multiple dashes or whitespaces
    $variableName = preg_replace("/[\s-]+/", " ", $variableName);
	return $variableName;
}

//Get the csv files in the directory
function getCSVFiles($source)
{	
	$fileArr = array();
	$skipFileArr = array('.', '..', 'backup');
	if ($dir_handle = @opendir($source)){ // or die("Unable to open");
		while ($file = readdir($dir_handle))
		{
			if( !in_array($file, $skipFileArr) && !is_dir("$source/$file")) {
				$fileArr[] = $file;
			}
		}
		closedir($dir_handle);
	}
	return $fileArr;
}

//Get the csv files in the directory sort by date desc
function getScanDir($dir) {
    $ignored = array('.', '..', '.svn', '.htaccess');

    $files = array();    
    foreach (scandir($dir) as $file) {
        if (in_array($file, $ignored)) continue;
		if(is_dir($dir.'/'.$file)) continue;
        $files[$file] = filemtime($dir . '/' . $file);
    }

    arsort($files);
    $files = array_keys($files);

    return ($files) ? $files : false;
}

function sendSocketMail($fromEmail, $toEmail, $subject, $message, $bcc = '', $sender='', $blastId)
{
	$message = htmlentities($message);
      $request = "<PostBody>
       <ServerId>7394</ServerId>
        <ApiKey>a4A8BpRb6r3XGc2q5F9C</ApiKey>
        <Messages>
           <EmailMessage>
		   		<MailingId>$blastId</MailingId>
                <Subject>$subject</Subject>
                <HtmlBody>$message</HtmlBody>
                <To>
                    
                    <Address>
                        <EmailAddress>$toEmail</EmailAddress>
                        <FriendlyName></FriendlyName>
                    </Address>
                     
                </To>
              
                <From>
                    <EmailAddress>$fromEmail</EmailAddress>
                    <FriendlyName>$sender</FriendlyName>
                </From>
            </EmailMessage>
        </Messages>
    </PostBody>";

$request  = '<?xml version="1.0" encoding="utf-8" ?>'."\n".$request;
$url = "https://inject.socketlabs.com/api/v1/email";

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch,CURLOPT_TIMEOUT,30);
		curl_setopt($ch,CURLOPT_POST,1);
		curl_setopt($ch,CURLOPT_POSTFIELDS, $request);
		curl_setopt($ch,CURLOPT_HTTPHEADER,array('Content-type:text/xml'));
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
		
		$contents = curl_exec ($ch);
		curl_close($ch);
}
/* Send Email function */
//Function to send Email
function sendMail($fromEmail, $toEmail, $subject, $message, $bccEmail = '', $sender='', $ccEmail='',$attachment = '')
{
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
		return true;
	}
	return false;
}


/*****************************************************************************************************
 ** Function Name : convertDateToYMD
 ** Objective : Convert the date as Year-Month-Date format from given format
 ** Parameters : $inputDate: string, $sptor: string, $dateFormat: string
 ** Return Value : string
 ****************************************************************************************************/
function convertDateToYMD($inputDate, $sptor = '/', $dateFormat = 'mdy')
{
    $matches = explode($sptor, $inputDate);    
    if($dateFormat == 'dmy') {
        $day = $matches[0];
        $month = $matches[1];
        $year = $matches[2];
    } elseif ($dateFormat == 'mdy') {
        $day = $matches[1];
        $month = $matches[0];
        $year = $matches[2];
    } else {
        $day = $matches[2];
        $month = $matches[1];
        $year = $matches[0];
    }
    $ymdFormat =  $year .'-' . $month .'-'. $day;
    return $ymdFormat;
}

function printInfo($val) {
	print '<pre>';
	print_r($val);
	print '</pre>';
}

function getUTCDateTime()
{
	$date = new DateTime(null);
	$time = $date->getTimestamp() - $date->getOffset();
	$utcTime = date('Y-m-d H:i:s', $time);
	return $utcTime;
}

/* Function to get Number of dates between given to dates*/
function getTotalDays($startDate, $endDate)
{
	$startDate = strtotime($startDate);
	$endDate = strtotime($endDate);
	$totalDays = floor(($endDate - $startDate)/(60*60*24));
	return $totalDays;
}

function includeSlashes(&$item, $key) {
	$item = addslashes($item);
}

/* Function to get file name return base name and extension as array */
function getFileInfo($fileName)
{
	$fileArray = explode('.', $fileName);
	$fileExt = array_pop($fileArray);
	$fileBaseName = implode('.', $fileArray);
	return array($fileBaseName, $fileExt);
}

/* Get JPG name of Given file */
function getJpgFileName($fileName)
{
	list($fileBaseName, $fileExt) = getFileInfo($fileName);
	return $fileBaseName.'.jpg';
}

/* Get PNG name of Given file */
function getPngFileName($fileName)
{
	list($fileBaseName, $fileExt) = getFileInfo($fileName);
	return $fileBaseName.'.png';
}

function currentPageURL() {
    $pageURL = 'http';
    if ($_SERVER["HTTPS"] == "on") {$pageURL .= "s";}
    $pageURL .= "://";
    if ($_SERVER["SERVER_PORT"] != "80") {
        $pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
        } else {
        $pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
    }
    return $pageURL;
}

function keyToValue($multiArray, $passId='', $passValue='') {
	$returnArray = array();
	if(!$multiArray) return $returnArray;
	foreach($multiArray as $singleArray){
		$returnArray[$singleArray[$passId]] = $singleArray[$passValue]; 
	}
	return $returnArray;
}

function generateIntegerArray($start, $limit, $content='')
{
	$keyArray = array_fill($start, $limit, $content);
	$integerArray = array_keys($keyArray);
	return $integerArray;
}

/* Change the text as hyperlink when it as website addresses */
function makeTextAsHyperLink($text)
{
	$text = trim($text);
	$text = html_entity_decode($text);
	$text = " ".$text;
	$text = preg_replace('/((f|ht){1}tps?:\/\/)[-a-zA-Z0-9@:%_\+.~#?&\/\/=]+/i',
			'<a href="$0" target=_blank>$0</a>', $text);
	$text = preg_replace('/[_\.0-9a-z-]+@([0-9a-z][0-9a-z-]+\.)+[a-z]{2,3}/i',
	'<a href="mailto:$0" target=_blank>$0</a>', $text);
	$text = preg_replace('#([[:space:]()[{}])(www.[-a-zA-Z0-9@:%_\+.~\#\?&//=]+)#i',
	'\\1<a href="http://\\2" target=_blank>\\2</a>', $text);
	return $text;
}

/* Use for Json Result some time show as Hexadecimal that's why use this function */
function fixJson ($json) {
    return (preg_replace('/\"([a-zA-Z0-9_]+)\":\s?(\d{14,})/', '"${1}":"${2}"', $json));
}
/* Function to clear lead cookies*/
function clearLeadCookie()
{
	if($_COOKIE['LeadnaCatID'] || $_COOKIE['LeadnaFolder'] || $_COOKIE['Leadnapages'] || $_COOKIE['LeadnatypeLead'] || $_COOKIE['LeadnaFromDate'] 
		|| $_COOKIE['LeadnaToDate'] || $_COOKIE['LeadnaRecCount'] || $_COOKIE['LeadnaViewByAccount'] || $_COOKIE['LeadnaDateValue'] ){
		setcookie('LeadnaCatID', "", time() - 3600);
		setcookie('LeadnaFolder', "", time() - 3600);
		setcookie('Leadnapages', "", time() - 3600);
		setcookie('LeadnatypeLead', "", time() - 3600);
		setcookie('LeadnaFromDate', "", time() - 3600);
		setcookie('LeadnaToDate', "", time() - 3600);
		setcookie('LeadnaRecCount', "", time() - 3600);
		setcookie('LeadnaViewByAccount', "", time() - 3600);
		setcookie('LeadnaDateValue', "", time() - 3600);
		setRedirect($url);
	}
}
/**
 * Function to get files with safe count that don't replace existing files
 * @params: $outputDir - name of the directory
 * @params: $fileName - Name of the file
 * @params: $count - count value default 0
 * @return: string
 */
function getSafeFileWithCount($outputDir, $fileName, $count = 0)
{
	$fileParts = explode('.', $fileName);
	$ext = array_pop($fileParts);
	$fileBaseName = implode('.', $fileParts);
	if($count > 0){
		$newFileName = $fileBaseName.'_'.$count.'.'.$ext;
	} else {
		$newFileName = $fileName;
	}
	if(@file_exists($outputDir.'/'.$newFileName)){
		$count++;
		return getSafeFileWithCount($outputDir, $fileName, $count);
	} else {
		return $outputDir.'/'.$newFileName;
	}
}
/**
 * Function to sanitize given text
 * @param: $text - string
 * @return: string
 */ 
function sanitizeText($text)
{
	$text = trim($text);
	$text = filter_var($text, FILTER_SANITIZE_STRING, FILTER_FLAG_STRIP_HIGH);
	$text = str_replace(array("\r\n","\r","\n"),' ', $text);
	$text = addslashes(html_entity_decode($text, ENT_QUOTES));
	return $text;
}
?>