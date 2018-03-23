<?php
require_once(ROOT_PATH.'/library/mencrypt.php');
class authorization extends table
{
    public $db;
    public $userId;
    public $sessionId;
    public $domain;
    public $encObj;

    function __construct($db)
    {
        parent::__construct($db, 'user_session');
        $this->domain = $_SERVER['SERVER_NAME'];
        $this->encObj = new mencrypt(USER_ENCRYPT_KEY);
    }
    
    function login($userName, $userPassword, $remember = false)
    {
        if(trim($userName) == '' && trim($userPassword) == '') 
                return false;
        $password = md5($userPassword);
        $loggedIn = $this->getUserInfo($userName, md5($userPassword));

        if($loggedIn) {
			if($remember){
				setcookie('userId', $this->encObj->encrypt($this->userId), time()+ (7*24*60*60), '/', $this->domain);
				setcookie('keepLogin', 1, time()+ (7*24*60*60), '/', $this->domain);
			} else {
				setcookie('userId', $this->encObj->encrypt($this->userId), time()+ (24*60*60), '/', $this->domain);
				setcookie('keepLogin', 0, time()+ (7*24*60*60), '/', $this->domain);
			}
			return true;

        } 
        return false;		
    }
	
    function logout($isDelete = false)
	{
		$record['session_key'] = $_SESSION['userSessionId'];
		$record['modified_on'] = UTC_DATE_TIME;
		$record['session_login_status'] = STATUS_LOGGED_OUT;
		$this->updateRecord($record, 'session_key');
		$this->resetSession();
		if($isDelete){
		   setMessage(MSG_ACCOUNT_DELETED);
		   setRedirect('index.php');  
		} else {
		   setMessage(MSG_LOGOUT_SUCCESS);
		   setRedirect('index.php?msg=1');
		}
		return true;
	}
	function resetSession()
	{
		//Reset the user sessions
		session_destroy();
		$_SESSION = [];
		session_start();
		$_SESSION['logout'] = true;
        //Reset the cookies
		if(isset($_SERVER['HTTP_COOKIE'])){
			$cookies = explode(';', $_SERVER['HTTP_COOKIE']);
			foreach($cookies as $cookie){
				$parts = explode('=', $cookie);
				$name = trim($parts[0]);
				setcookie($name, '', time()-3600);
				setcookie($name, '', time()-3600, '/', $this->domain);
			}
			$_COOKIE = [];
		}
	}
	/* Function check login session time */
	function checkSessionStatus()
	{
		if($_SESSION['userId']){
			$sessionTime = ini_get('session.gc_maxlifetime');
			//$sessionTime = 5*60;
			$currentSessionTime = strtotime(UTC_DATE_TIME) - strtotime($_SESSION['lastAccessTime']);//$rslt['remainTime'];
			$remainTime = $sessionTime - $currentSessionTime;
			$remainMinute = (int)($remainTime/60);
			$remainSeconds = $remainTime % 60;
			if($remainMinute > 5){
				return array('showMesg'=>false);
			}
			return array('showMesg'=>'true','min'=>$remainMinute, 'sec'=>$remainSeconds);
		} else {
			return array('showMesg'=>false);
		}
	}
	/* Check user login for public site */
	function checkLogin()
	{
		global $fileName;
		if($_SESSION['logout'] == true){ return false; }
		$loggedIn = true;
		if($_SESSION['userId']){
			
			/* Check the user is currently logged in */
			$qry = "SELECT session_user_id, modified_on, session_login_status FROM user_session 
					WHERE session_user_id = {$_SESSION['userId']} 
				 	AND session_login_type =".LOGIN_USER." AND session_key = '{$_SESSION['userSessionId']}'";
			$rslt = $this->db->getSingleRow($qry);
			// Update the access time
			if($rslt && $rslt['session_login_status'] == STATUS_LOGGED_IN) {
				$record['session_key'] = $_SESSION['userSessionId'];
				$record['modified_on'] = UTC_DATE_TIME;
				$_SESSION['lastAccessTime'] = UTC_DATE_TIME;
				$this->updateRecord($record, 'session_key');
				return true;
			} else {
				if($rslt['session_login_status'] == STATUS_LOGGED_IN_ANOTHER_SYSTEM){
					$this->resetSession();
					setErrorMessage('sessionOutError', MSG_LOGIN_ANOTHER_SYSTEM);
					setRedirect('index.php?msg=3');
					return false;
				} 
				if(isset($_COOKIE['leadUserId'])){
				    $qry = "UPDATE user_session 
					SET session_login_status = ".STATUS_LOGGED_IN .
					", modified_on= '".UTC_DATE_TIME."' WHERE session_user_id = {$_SESSION['userId']} 
				 	AND session_key = '{$_SESSION['userSessionId']}' AND session_login_type =".LOGIN_USER;
					$rslt = $this->db->query($qry);
					$record['session_key'] = $_SESSION['userSessionId'];
					$record['modified_on'] = UTC_DATE_TIME;
					$_SESSION['lastAccessTime'] = UTC_DATE_TIME;
					$this->updateRecord($record, 'session_key');
					return true;
				}
				$this->resetSession();
				if($rslt['session_login_status'] == STATUS_LOGGED_TIME_OUT){
					setErrorMessage('sessionOutError', MSG_LOGIN_SESSION_TIMEOUT);
				} else {
					setErrorMessage('sessionOutError', MSG_LOGIN_ANOTHER_SYSTEM);
				}
				$loggedIn = false;
			}
		} else if(isset($_COOKIE['leadUserId'])){
			return ($this->loginUsingCookie());
		} else {
			//setErrorMessage('sessionOutError', 'Please Login to access the page!');
			return false;
		}
		return false;
	}
	
	function checkPasswordDate($userId, $clientId)
	{
		$qry  = 'CALL checkPasswordUpdateDate(%d, %d, "%s")';
		$qry = $this->db->prepareQuery($qry, $userId, $clientId, DB_DATE_TIME);
		$rslt = $this->db->getSingleRow($qry);
		$_SESSION['pwdUpdate'] = $rslt['lastUpdatedDate'];
		return $rslt['lastUpdatedDate'];
	}
	
	function loginUsingCookie()
	{
		if(isset($_COOKIE['leadUserId'])){
			$userId = $this->encObj->decrypt(rawurldecode($_COOKIE['leadUserId']));
			$loggedIn = $this->loginUsingId($userId);
		} else {
			return false;
		}
		return $loggedIn;
	}
	
	function getUserInfo($userName, $password, $fromWebService = false)
	{
		$qry  = "SELECT user_email,user_fname,user_lname, user_id, user_role_id, user_image, user_form_completed FROM user
			WHERE user_email='%s' AND user_password = '%s' AND user_record_status IN (0, -1) AND user_role_id >0";
		$qry  = $this->db->prepareQuery($qry, $userName, $password);
		$rslt = $this->db->getSingleRow($qry);
		if ($rslt) {
			//Set the user and id in the session
			return ($this->createSession($rslt));
		} else if ($fromWebService){
			return 0;
		} 
		return false;
	}
	
	function loginUsingId($userId)
	 {
	     $loggedIn = $this->getUserInfoById($userId);
		 if($loggedIn) {
			$this->getClientInfo($this->params['userClientId'], UTC_DATE_TIME);
		   	setcookie('leadUserId', $this->encObj->encrypt($userId), time() + 24*60*60, '/', $this->domain);
		   	return true;
		 } else {
		   return false;
		  }
	 }
	 
	 function getUserInfoById($userId)
	 {
		if(!$userId){
			return false;
		}
		$qry = "SELECT user_email,user_fname,user_lname, user_id, user_role_id,user_image, user_form_completed FROM user 
				WHERE  user_id = %d AND user_record_status IN (0, -1)";
		$qry = $this->db->prepareQuery($qry, $userId);
		$rslt = $this->db->getSingleRow($qry);
		if($rslt) {
		  return ($this->createSession($rslt));  
		}
		return false;
	 }
	 
	 function createSession($rslt)
	 {

		global $params;
		//Cancel the existing logins if any by indicating that the user logged in another system.
		$logoutQry = "UPDATE {$this->table} SET modified_on='".UTC_DATE_TIME."', 
		session_login_status = ".STATUS_LOGGED_IN_ANOTHER_SYSTEM.
		" WHERE session_user_id = {$rslt['user_id']} 
		AND session_login_type =".LOGIN_USER." AND session_login_status = ".STATUS_LOGGED_IN;
		$logoutRslt = $this->db->query($logoutQry);
		$this->userId = $_SESSION['userId']= $rslt['user_id'];
		$_SESSION['userEmail'] = $rslt['user_email'];
		$_SESSION['userName'] = $rslt['user_fname'];
		$this->sessionId = $_SESSION['userSessionId'] =  $this->generateRandID();//$_COOKIE['PHPSESSID'];
		$_SESSION['loginTime'] = UTC_DATE_TIME;
		$_SESSION['userRole'] = $rslt['user_role_id'];
		$_SESSION['userFormComplete'] = $rslt['user_form_completed'];
		$_SESSION['userTimeZone'] = $rslt['user_offset'];
		$_SESSION['lastAccessTime'] = UTC_DATE_TIME;
		$_SESSION['userImage'] = $rslt['user_image'];
		$_SESSION['logout'] = false;
		
		$this->insertSession();
		$moduleObj  = getObject('module');
		$templateId = $moduleObj->getModuleTemplate($rslt['user_id']);
		$_SESSION['modTemplateId'] = $templateId;
		$params = array_merge($params, $_SESSION);
		$this->params = $params;
		return ($this->userId);

	 }
	 
	/* Get the status of each user */
	function getOnlineUserStatus($userId=0)
	{
            if(!$userId) $userId = $_SESSION['userId'];
            if(!$_SESSION['userId']) return;
            $qry = "SELECT user_id, session_login_status AS online
                    FROM user 
                    LEFT JOIN user_session ON user_id = session_user_id AND session_login_status = ".STATUS_LOGGED_IN.
                    " AND session_login_type =".LOGIN_USER."
                    WHERE user.user_record_status IN (0, -1)";
            $rslt = $this->db->getResultSet($qry);
            return $rslt;
	}
	
	function insertSession()
	{
            $record['session_key'] = $_SESSION['userSessionId'];
            $record['session_user_id'] = $_SESSION['userId'];
            $record['session_login_ip'] = getRealIpAddr();
            $record['created_on'] = UTC_DATE_TIME;
            $record['modified_on'] = UTC_DATE_TIME;
            $sessionId = $this->insertRecord($record);
	}
	/*****************************************************************************************
    * generateRandID - Generates a string made up of randomized
    * letters (lower and upper case) and digits and returns
    * the md5 hash of it to be used as a userid.
    ****************************************************************************************/
    function generateRandID()
    {
        return md5($this->generateRandStr(16));
    }
    
  
    /****************************************************************************************
    * generateRandStr - Generates a string made up of randomized
    * letters (lower and upper case) and digits, the length
    * is a specified parameter.
    ***************************************************************************************/
    function generateRandStr($length)
    {
        $randstr = "";
        for($i=0; $i<$length; $i++){
            $randnum = mt_rand(0,61);
            if($randnum < 10){
                $randstr .= chr($randnum+48);
            }else if($randnum < 36){
                $randstr .= chr($randnum+55);
            }else{
                $randstr .= chr($randnum+61);
            }
        }
        return $randstr;
    }
}