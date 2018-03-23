<?php
/*****************************************************************************************************
** File Name	: commonSettings.php
** Objective	: Defines the seetings information used all over the application commonly
****************************************************************************************************/
//Using segments
//error_reporting(E_ALL^E_NOTICE);
date_default_timezone_set($_SESSION['myDefaultZone']);

define('ALL_VISITS', 'gaid::-1');
define('NEW_VISITORS', 'gaid::-2');
define('RETURNING_VISITORS', 'gaid::-3');
define('PAID_SEARCH_TRAFFIC', 'gaid::-4');
define('NON_PAID_SEARCH_TRAFFIC', 'gaid::-5');
define('SEARCH_TRAFFIC', 'gaid::-6');
define('DIRECT_TRAFFIC', 'gaid::-7');
define('REFFERAL_TRAFFIC', 'gaid::-8');
define('VISIT_WITH_CONVERSIONS', 'gaid::-9');
define('VISIT_WITH_TRANSACTION', 'gaid::-10');
define('MOBILE_TRAFFIC', 'gaid::-11');
define('NON_BOUNCE_VISIT', 'gaid::-12');

//Seperator field
$seperator = "#@";

//Define DB Date only format
define('DB_DATE', date('Y-m-d', time()));

//Define Database date & time
define('DB_DATE_TIME', date('Y-m-d H:i:s', time()));

//Define Default country
define('DEFAULT_COUNTRY', 'US');


//Define different login status
define('STATUS_LOGGED_OUT', 0);
define('STATUS_LOGGED_IN', 1);
define('STATUS_LOGGED_IN_ANOTHER_SYSTEM', 2);
define('STATUS_LOGGED_TIME_OUT', 3);
//Define Default session login time in minutes
define('DFLT_LOGIN_TIME', 60);

//Define different login Status
define('LOGIN_USER', 0);
define('LOGIN_ADMIN', 1);

//Maximum file upload size
define('MAX_FILE_UPLOAD_SIZE', ini_get('upload_max_filesize'));

//Url of current page
$url = ( (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' ) ? 'https://': 'http://' ). $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];

//User Permissions
$permissionArray = array(0=>'None', 1=>'Read Only', 2=>'Read & Edit', 4=>'Read, Edit & Create');

$depArray = array(1=>'Read Only', 2=>'Edit Access', 3=>'No Access');

define('LEAD_TABLE_NAME', 'Lead');

$monthArray = array('1' => 'Jan', '2' => 'Feb', '3' => 'Mar', '4' => 'Apr', '5' => 'May', '6' => 'Jun', 
					'7' => 'Jul', '8' => 'Aug', '9' => 'Sep', '10' => 'Oct', '11' => 'Nov', '12' => 'Dec');

//Define Smarty display date format
define('CALENDAR_DATE_FORMAT', '%m/%d/%Y');
//Define Smarty display date time format
define('CALENDAR_DATE_TIME_FORMAT', '%m/%d/%Y %I:%M %p');

$yesNoArr = array(1=> 'Yes', 0 => 'No');
$dateRangeArr = array('5'=>'Custom', 1=>'Today', 2=>'Last Week', 3=>'Last Month', 4=>'Last Year');
$rolesArray = array(1=>'Full Access', 2=>'Billing', 3=>'Project Manager', 4=>'Consultant');
$recCountArr = array(10=>10, 25=>25, 50=>50, 100=>100, 0=>'All');


$paperSizeArr = array('A4', 'Letter', 'Legal', 'Executive');

$exportArr = array('CSV', 'HTML');
/* $exportArr = array('CSV', 'PDF', 'HTML'); */
$permissionArr = array(1=>'Add', 'Edit', 'View', 'Delete', 'Report', 'Import/Export',
'Analytics', 'AllAssociateLeads', 'ManageTemplate', 'AllManagerLeads' );


/* Define different roles */
define('ROLE_ADMIN', 1);
define('ROLE_MANAGER', 2);
define('ROLE_ASSOCIATE', 3);
define('ROLE_SUBMANAGER', 4);
define('ROLE_SUPERADMIN', 5);
define('ROLE_AGENT', 6);
define('ROLE_SALES_REP', 7);

$roleArr = array(ROLE_ADMIN => 'Administrator', ROLE_MANAGER => 'Manager', ROLE_ASSOCIATE => 'Associate', ROLE_SUBMANAGER=> 'Sub-Manager', ROLE_AGENT=> 'Agent');

//Notification email address
define('NOTIFICATION_EMAIL', 'support@sam.ai');
define('NOTIFICATION_NAME', 'Galileo Tech Media Task Management System');

define('DATE_FOR_COMMON', '%b %d, %Y');
define('DATE_TIME_FOR_COMMON', '%b %d, %Y at %I:%M %p');
define('TIME_ONLY', '%I:%M %p');
define('DATE_TIME_WITH_MONTH', '%B %d, %Y at %I:%M %p');
define('DATE_TIME_FOR_COMMON_NEW', '%b %d, %Y at %I:%M %p');

//User Roles
define('USER_ROLE_ADMIN', 1);
define('USER_ROLE_BILLING', 2);
define('USER_ROLE_PROJECT_MANAGER', 3);
define('USER_ROLE_CONSULTANT', 4);

//Import CSV Status
define('CSV_STATUS_INCOMPLETE', 0);
define('CSV_STATUS_QUEUE', 1);
define('CSV_STATUS_IN_PROCESS', 2);
define('CSV_STATUS_COMPLETE', 3);
define('CSV_STATUS_NOTICED', 4);

define('IMPORT_APPEND', 1);
define('IMPORT_REPLACE', 2);
define('IMPORT_REPLACE_ALL', 3);


$filterByArray = array(1=>'--Select Filter--', 2=>'Start Date', 3=>'Tactic Due Date', 4=>'Division');
$filterByContentArray = array(1=>'--Select Filter--', 2=>'Tactic Due Date', 3=>'Consultant', 4=>'Division');
$filterByContentConsultantArray = array(1=>'--Select Filter--', 2=>'Due Date', 3=>'Consultant');
$filterByClientArray = array(1=>'--Select Filter--', 2=>'Created On', 3=>'Client', 4=>'Division');
$adminReviewArray = array(1=>'--Select Review--', 2=>'Complete', 3=>'Re-Assign');
$formFilterArray = array(1=>'--Select Filter--', 2=>'Created On', 3=>'Consultant', 4=>'Role');
//$divisionArray = array(3=>'--Select Division--', 1=>'2546', 2=>'2210', 3=>'2712', 4=>'2713');

$skillArray = array(1=>'--Select Filter--',  3=>'Consultant', 5=>'Skill', 4=>'All Filters');
$rateArray = array(1=>'--Select Filter--', 2=>'Created On', 3=>'Consultant');
$adminConsultantArray = array(1=>'--Select Filter--', 2=>'Content Due Date', 3=>'Consultant', 4=>'Division');
$adminConsultantBillingArray = array(1=>'--Select Filter--', 2=>'Billed Date', 3=>'Consultant', 4=>'Division', 5=>'Qb Id');
$userManagerArray = array(1=>'--Select Filter--', 2=>'Role', 3=>'Forms', 4=>'All Filters');

$clientFilterArray = array(1=>'--Select Filter--', 2=>'Client', 3=>'Client Status');


$serviceTypeFilterArray = array(1=>'--Select Filter--', 2=>'Created On', 3=>'Service Type');
$invoiceFilterArray = array(1=>'--Select Filter--',  3=>'Consultant', 4=>'Division', 5=>'Location Code', 6=>'Service Type');
$billingFilterArray = array(1=>'--Select Filter--', 2=>'Billed Date', 3=>'Consultant', 4=>'Division', 5=>'Location Code', 6=>'Service Type');

$taskTypeArray = array(3=>'--Select Filter--', 1=>'Task Keyword', 2=>'Task Content');


define('MARRIOTT_CLIENT_ID', 1);
define('STARWOOD_CLIENT_ID', 2);

define('MARRIOTT_CODE_LABEL', 'Location Code');
define('STARWOOD_CODE_LABEL', 'CLIENT Code');

define('IMPORT_TYPE_KEYWORD', 1);

//import wizard
$keywordHeaderArray = array(
	1=>'MARSHA', 
	2=>'Number of Pages', 
	3=>'Notes',
	4=>'BOX Link',
	5=>'Date Added to BOX',
	6=>'Keyword File Set Up Due',
	7=>'Keywords Due'
);

//import wizard
$keywordHeaderUpdateArray = array(
	1=>'MARSHA', 
);

define('IMPORT_CSV_IN_QUEUE', 'Great! Your data is being imported, please allow up to 5 minutes for processing');

//Quick Book ouath & access token configuration
define('QB_OAUTH2', 'oauth2');
define('QB_CLIENTID', 'Q0YaXtyl1AGdmPRxrPLIYd2WLOgHrEVSZynMwaLEisOuB8Jhwd');
define('QB_CLIENTSECRET', 'rfXGiCkmTul7CRQ3D37yIrM12MTA8M7hBWoxs1sz');
define('QB_ACCESSTOKENKEY', 'eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..krknJwX6GdctPYtr10E_Jw.z2SqxcYupB1qj2lNVmYez_G4jRSYr1CJN0BAvyGT3le_-lA8aZhkE2hTIy4qNNU3BJLvPuJt54_djaw6SGbLWpQcvi0bJBoDdEC7uCcfoqnMsjE6-MWDk6YEgsbJjdnZMuaSK1XNEUqqfMpqZJIcj3qMagcuXqdY0n5NQHJnplKplmGujFBIBizLfKnRSxTKYitn4qOSsHZlOm-AEMeYsqY_WZOzXNf-IalRoCovmmXlSQVLWRW8WVoxGtQQ_GEbzwzm3sa1d6WbsBQQ-m97OM9FZtZTNdA2pv8eVPys7xNr-Rg3aKnefANGXcUhU6LBVPr_VYCEJjphJ592SdAL8U1fxc3kFAGmkJL-e94Vpty8ZgAMg3iWrn2OFDnbwZW6xQzC6Q8MOBasAZ6N42O3OmpP2NmLbupfOIG0d5oJf61bewVqeaWimQ3P4I9lihs8U8SoUr3v3oTWywrf3UhK4N9W8IgxKF2v5dqpSu0joOfIv21meNimWbW25gG4yy5Txygq4CrwKqH-NQxs9dEY6ig2FDlO9_yNZ5_Hg4_LHhgHQZJJoNi5Yg7jBWmEc5oEXItfvF9re-DwUEHA01Gj0jqT89ernC_vH8TnHoGZ2y2-PGjX7gTUu1mS7dzWQGI2a5qkXNg8K_7F1KlzlKPGS9sRC051V6Noyo9yL5UIYVBvYhrj_u6Asuemo6KvnCDnleHfjKJ7tddu9DiV4i2ifuBvS_7hT79-i6aDPTo9kn4_77nlOwjVyoH_vU7OgnX1.k99kM3mw9u7S8l_D4d_Lfw');
define('QB_REFRESHTOKENKEY', 'L011525004245qHnmECxR4DmtirCJoGVkWqrSBSj2fINAvjup7');
define('QB_QBOREALMID', '193514687654644');
define('QB_BASEURL', 'Development');


//
define('NOTIFICATION_MODULE_INVOICE_ID', 1);
define('NOTIFICATION_MODULE_TASK_KEYWORD_ID', 2);
define('NOTIFICATION_MODULE_TASK_CONTENT_ID', 3);

define('FORM_COMPLETE', 1);
define('FORM_UNCOMPLETE', 0);

define('SERVICE_TYPE_KEYWORD_SETUP_ID', 62);
define('TASK_KEYWORD_UPDATE_DISABLE_MSG', "Note : You cannot update this task until the Keyword Setup will complete.");

define('QB_ACCOUNT_REFERENCE_FOR_ALL', 36);
define('QB_ACCOUNT_REFERENCE_FOR_GALILEO', 45);

//
define('ALERT_NOTIFICATION_MODULE_TASK_KEYWORD_ID', 1);
define('ALERT_NOTIFICATION_MODULE_TASK_CONTENT_ID', 2);
define('ALERT_NOTIFICATION_TASK_KEYWORD_ADMIN_COMPLETE_MSG', "Task Keyword Completed by Admin");
define('ALERT_NOTIFICATION_TASK_KEYWORD_ADMIN_REASSIGN_MSG', "Task Keyword Reassigned by Admin");
define('ALERT_NOTIFICATION_TASK_CONTENT_ADMIN_COMPLETE_MSG', "Task Content Completed by Admin");
define('ALERT_NOTIFICATION_TASK_CONTENT_ADMIN_REASSIGN_MSG', "Task Content Reassigned by Admin");
define('ALERT_NOTIFICATION_TASK_KEYWORD_ADMIN_ASSIGN', "Task Keyword Assigned by Admin");
define('ALERT_NOTIFICATION_TASK_CONTENT_ADMIN_ASSIGN', "Task Content Assigned by Admin");


define('TACTIC_DUE_BUSINESS_DAY_KEYWORD_SETUP', 3);
define('TACTIC_DUE_BUSINESS_DAY_FOR_OTHERS', 10);


define('QB_TOKEN_DEFAULT_ID', 1);

define('ALERT_SHOW_ADMIN_USER_ID', 4);
define('TASK_KEYWORD_ALERT_FOR_CONSULTANT', 5);
define('TASK_CONTENT_ALERT_FOR_CONSULTANT', 6);
define('TASK_KEYWORD_COMPLETE_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX', "Admin has Completed the task");
define('TASK_KEYWORD_REASSIGN_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX', "Admin has Re-Assigned the task");
define('TASK_CONTENT_COMPLETE_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX', "Admin has Completed the task");
define('TASK_CONTENT_REASSIGN_ALERT_FOR_CONSULTANT_FROM_MESSAGE_PREFIX', "Admin has Re-Assigned the task");

define('WELCOME_EMAIL_UPDATE', ' Galileo Tech Media Task Management System - Email Updated');
