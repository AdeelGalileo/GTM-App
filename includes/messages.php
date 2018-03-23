<?php
	//Common Labels
	define('LBL_YES', 'Yes');
	define('LBL_NO', 'No');
	define('LBL_TODAY', 'Today');
	define('LBL_OK', 'OK');
	define('LBL_NO_EMAILS', 'No Email Found');
	define('LBL_CANCEL', 'Cancel');
	define('LBL_RECORDS', 'Record(s)');
	define('LBL_NO_RECORDS', 'No Record(s)');
	define('LBL_NO_RECORDS_FOUND', 'No Record(s) Found');
	define('LBL_EMPTY', 'Empty');
	define('UPDATE_SUCCESS_MSG', 'Updated successfully');
	define('ADD_SUCCESS_MSG', 'Added successfully');
	define('CONFIRM_DELETE', 'Are you sure you want to delete?');
	define('MSG_EMAIL_NOT_EXISTS','Email Id does not exist');
	define('MSG_EMAIL_REQUIRED','Email Id Required');
	define('FORGET_PASSWORD_SENT','Password reset link sent your email id.');
	define('UPLOAD_FAILED', 'Upload failed');
	define('UPLOAD_SUCCESS', 'Uploaded successfully');
	define('MSG_FILE_UPLOAD_SUCCESS', 'File Uploaded Successfully!');
	define('MSG_SUCCESS', 'Success');
	define('MSG_DELETE_SUCCESS', 'Deleted successfully');
	define('MSG_NO_BATCH', 'No batches found');
	define('ERR_SESSION_TIMEOUT', "Oops..you're session timed out");
	define('ENTER_MSG', 'Please enter value');
	define('INVALID_USERNAME', 'Invalid username/password');
	define('EMAIL_EXISTS','This email already exists');
	define('PASSWORD_NOT_VALID','Invalid password, please check again');
	define('PASSWORD_CHANGED','Your password has been changed');
	define('WRONG_PASSWORD','Incorrect password or username');
	define('ERR_SERVICE_TYPE', 'Service Type Required');
	define('ERR_TIRE', 'Tire Required');
	define('ERR_NO_OF_UNITS', 'Number of units Required');
	define('ERR_LINK_TO_FILE', 'Link to file Required');
	define('ERR_NOTES', 'Notes Required');
	define('SET_CLIENT', 'Client set  successfully');
	define('ACTIVATION_CODE_EXPIRED', 'Your Activation code is expired. Please reset your password again.');
	define('ACTIVATION_CODE_INVALID', 'Seems your activation link is invalid. Please reset your password again.');
	define('WELCOME_EMAIL', 'Welcome to Galileo Tech Media Task Management System');

	//client  
	define('ERR_CLIENT_NAME', 'Client Name Required');
	define('CLIENT_CREATED_SUCCESSFULLY', 'Client Created Successfully');
	define('CLIENT_UPDATED_SUCCESSFULLY', 'Client Updated Successfully');
	define('CONFIRM_DELETE_CLIENT','Do you want to delete the client?');
	define('CLIENT_DELETED_SUCCESSFULLY','Client Deleted Successfully');
	
	//user  
	define('ERR_USER_FIRST_NAME', 'User First Name Required');
	define('ERR_USER_LAST_NAME', 'User Last Name Required');
	define('ERR_USER_ROLE', 'User Role Required');
	define('ERR_USER_EMAIL', 'User Email Required');
	define('ERR_INVALID_USER_EMAIL', 'Invalid User Email Address');
	define('ERR_USER_EMAIL_EXISTS', 'Email already exists');
	define('ERR_USER_NAME_EXISTS', 'User Name already exists');
	define('ERROR_USER_PASSWORD', 'Password Required');
	define('ERROR_USER_CONFIRM_PASSWORD', 'Confirm Password Required');
	define('ERROR_PASSWORD_MISMATCH', 'Password & Confirm Password Should be Same');
	define('USER_CREATED_SUCCESSFULLY', 'User Created Successfully');
	define('USER_UPDATED_SUCCESSFULLY', 'User Updated Successfully');
	define('CONFIRM_DELETE_USER','Do you want to delete the user?');
	define('USER_DELETED_SUCCESSFULLY','User Deleted Successfully');
	define('PASSWORD_UPDATED_SUCCESSFULLY', 'Password updated successfully');
	
	//TASK_KEYWORD  
	define('ERR_TASK_KEYWORD_MARSHA_CODE', 'Location Code Required');
	define('ERR_TASK_KEYWORD_NO_OF_PAGES', 'Number of Pages Required');
	define('ERR_TASK_KEYWORD_FOUN_PROG', 'Foundation Program Required');
	define('ERR_TASK_KEYWORD_EXPANDED_SEO', 'Expanded Seo Required');
	define('ERR_TASK_KEYWORD_OUTLET_MARK', 'Outlet Marketing Bundle Page Required');
	define('ERR_TASK_KEYWORD_NOTES', 'Notes Required');
	define('ERR_TASK_KEYWORD_BOX_LOCATION', 'Box Location Required');
	define('ERR_TASK_KEYWORD_ADDED_BOX_DATE', 'Added box date Required');
	define('ERR_TASK_KEYWORD_LINK_DB_FILE', 'Link to db file Required');
	define('ERR_TASK_KEYWORD_SETUP_DUE_DATE', 'Kw set up due date Required');
	define('ERR_TASK_KEYWORD_SETUP_UPLBOX_DATE', 'Kw set up file date Required');
	define('ERR_TASK_KEYWORD_COM_DUE_DATE', 'Kw date Required');
	define('ERR_TASK_KEYWORD_COM_DATE', 'Kw submitted date Required');
	define('ERR_TASK_KEYWORD_USER_ID', 'Consultant Required');
	define('TASK_KEYWORD_CREATED_SUCCESSFULLY', 'Task Keyword Created Successfully');
	define('TASK_KEYWORD_UPDATED_SUCCESSFULLY', 'Task Keyword Updated Successfully');
	define('CONFIRM_DELETE_TASK_KEYWORD','Do you want to delete the task keyword?');
	define('TASK_KEYWORD_DELETED_SUCCESSFULLY','Task Keyword Deleted Successfully');
	define('CONFIRM_COMP_TASK_KEYWORD','Do you want to update the task?');
	define('CONFIRM_COMP_ADMIN_TASK_KEYWORD','Do you want to complete the task?');
	define('CONFIRM_REASSIGN_TASK_KEYWORD','Do you want to reassign the task?');
	define('TASK_KEYWORD_REASSIGN_SUCCESSFULLY', 'Task Keyword Reassigned Successfully');

	//TASK_CONTENT  
	define('ERR_TASK_CONTENT_ADDED_BOX_DATE', 'Added to box date Required');
	define('ERR_TASK_CONTENT_DUE_DATE', 'Due by date Required');
	define('ERR_TASK_CONTENT_SERVICE_TYPE_ID', 'Service Type Required');
	define('ERR_TASK_CONTENT_ADDED_BOX_DUE_DATE', 'Date(Done) added to box Required');
	define('ERR_TASK_CONTENT_ASS_WRITER_DATE', 'Assigned to consultant date Required');
	define('ERR_TASK_CONTENT_PROJ_COM_DATE', 'Projected Completion date Required');
	define('ERR_TASK_CONTENT_USER_ID', 'Consultant Required');
	define('TASK_CONTENT_CREATED_SUCCESSFULLY', 'Task Content Created Successfully');
	define('TASK_CONTENT_UPDATED_SUCCESSFULLY', 'Task Content Updated Successfully');
	define('CONFIRM_DELETE_TASK_CONTENT','Do you want to delete the task content?');
	define('TASK_CONTENT_DELETED_SUCCESSFULLY','Task Content Deleted Successfully');
	define('CONFIRM_COMP_ADMIN_TASK_CONTENT','Do you want to complete the task?');
	define('CONFIRM_REASSIGN_TASK_CONTENT','Do you want to reassign the task?');
	define('TASK_CONTENT_REASSIGN_SUCCESSFULLY', 'Task Content Reassigned Successfully');

	//Authorization
	define('MSG_ACCOUNT_DELETED','Your account is deleted,');
	define('MSG_LOGOUT_SUCCESS','You are logged out successfully,');
	define('MSG_LOGIN_ANOTHER_SYSTEM','You are logged into another system.');
	define('MSG_LOGIN_SESSION_TIMEOUT','To ensure security, you have been automatically logged out due to inactivity.');
	define('MSG_ENSURE_SECURITY','To ensure security, you have been automatically logged out due to inactivity');
	
	//Import Wizard
	define('ERR_IMPORT_TYPE', 'Import Type is Required');
	define('ERR_MONTH_YEAR', 'Month & Year is Required');
	define('MSG_IMPORT_CHOOSE_FILE', 'Please upload a CSV file');
	define('CSV_FILE_PATH_INSERT_SUCCESS','Csv file path created Successfully');
	define('REMOVE_FIRST_ROW','Do not import column titles from the imported CSV file into '.NOTIFICATION_NAME.'. This is usually data that is shown in the first row of the CSV file');
	define('SELECT_IMPORT_FIELDS', 'Please select fields to import');
	define('SELECT_IMPORT_FIELDS', 'Please select fields to import');
	define('SELECT_ALL_REQUIRED_FIELDS','Please select all required fields:');
	define('DUPLICATE_FIELDS','You have selected the field multiple times. Field name -');
	define('REMOVE_FIRST_ROW','Do not import column titles from the imported CSV file into '.NOTIFICATION_NAME.'. This is usually data that is shown in the first row of the CSV file');
	define('MSG_SELECT_REPRESENTATIVES', 'Please select representatives');
	//Import Lead Page
	define('UPLOAD_AUTHORIZE_ERROR','You are not authorized to upload the file');
	define('IMPORT_REQUIRED', 'Import as required');
	define('IMPORT_CSV_IN_QUEUE', 'Great! Your data is being imported, please allow up to 10 minutes for processing');
	define('MSG_IMPROT_SUCCESS', 'Great news! Your data imported successfully');
	
	//Alerts
	define('ERR_ALERT_USER', 'User is Required');
	define('ERR_ALERT_MODULE', 'Module is Required');
	define('ALERT_CREATED_SUCCESSFULLY', 'Alert Created Successfully');
	define('ALERT_UPDATED_SUCCESSFULLY', 'Alert Updated Successfully');
	define('CONFIRM_DELETE_ALERT','Do you want to delete the alert?');
	define('ALERT_DELETED_SUCCESSFULLY','Alert Deleted Successfully');
	
	//FORMS
	define('ERR_FORM_USER_ID', 'Consultant is Required');
	define('ERR_FORM_FIRST_NAME', 'First Name is Required');
	define('ERR_FORM_LAST_NAME', 'Last Name is Required');
	define('ERR_FORM_CONTACT_NO', 'Contact Number is Required');
	define('ERR_FORM_EMAIL', 'Email is Required');
	define('ERR_INVALID_EMAIL', 'Invalid Email Address');
	define('FORM_CREATED_SUCCESSFULLY', 'Form Created Successfully');
	define('FORM_UPDATED_SUCCESSFULLY', 'Form Updated Successfully');
	define('CONFIRM_DELETE_FORM','Do you want to delete the form?');
	define('FORM_DELETED_SUCCESSFULLY','Form Deleted Successfully');
	define('MSG_IMPORT_CHOOSE_W9_FORM_FILE', 'Please upload a W9 Form file');
	define('MSG_IMPORT_CHOOSE_ACH_FORM_FILE', 'Please upload a ACH Form file');
	define('MSG_IMPORT_CHOOSE_CA_FORM_FILE', 'Please upload a Consultant Agreement Form file');
	define('ERR_FORMS_REQUIRED','Your W9,ACH Form,Consultant Agreement Forms still not uploaded. Please contact your administrator for further actions.');
	

	//SKILLS
	define('ERR_SKILL_TYPE', 'Please select a skill');
	define('SKILL_CREATED_SUCCESSFULLY', 'Skill Created Successfully');
	define('SKILL_UPDATED_SUCCESSFULLY', 'Skill Updated Successfully');
	define('CONFIRM_DELETE_SKILL','Do you want to delete the skill?');
	define('SKILL_DELETED_SUCCESSFULLY','Skill Deleted Successfully');
	
	
	//SKILLS
	define('CONSULTANT_RATE_CREATED_SUCCESSFULLY', 'Rate Created Successfully');
	define('CONSULTANT_RATE_UPDATED_SUCCESSFULLY', 'Rate Updated Successfully');
	define('CONFIRM_DELETE_CONSULTANT_RATE','Do you want to delete the Rate?');
	define('CONSULTANT_RATE_DELETED_SUCCESSFULLY','Rate Deleted Successfully');
	define('ERR_CONS_RATE_PER_UNIT', 'Rate per unit is required');
	define('ERR_INVALID_CONS_RATE_PER_UNIT', 'Rate per unit should be valid format');
	
	//Admin Consultant 
	define('CONFIRM_PRIRORITY_TASK','Do you want to update the priority?');
	define('PRIRORITY_UPDATED_SUCCESSFULLY', 'Priority Updated Successfully');
	define('MOVE_TO_QB_SUCCESSFULLY', 'Moved to Quick book successfully');
	define('ERR_QB_SELECT', 'Please select the task(s) to move Quick book');
	
	//Service Types
	define('SERVICE_TYPE_CREATED_SUCCESSFULLY', 'Service Type Created Successfully');
	define('SERVICE_TYPE_UPDATED_SUCCESSFULLY', 'Service Type Updated Successfully');
	define('CONFIRM_DELETE_SERVICE_TYPE','Do you want to delete the Service Type?');
	define('SERVICE_TYPE_DELETED_SUCCESSFULLY','Service Type Deleted Successfully');
	define('ERR_GAL_RATE', ' Invoice Rate is Required');
	define('ERR_FREEL_RATE', ' Bill Rate is Required');
	define('INVALID_GAL_RATE', ' Invoice Rate  should be valid format');
	define('INVALID_FREEL_RATE', ' Bill Rate should be valid format');
	define('ERR_FREEL_GAL_RATE', ' Bill Rate must be lesser than Invoice Rate');
	

		
	//client division
	define('CLIENT_DIVISION_CREATED_SUCCESSFULLY', 'Client Division Created Successfully');
	define('CLIENT_DIVISION_UPDATED_SUCCESSFULLY', 'Client Division Updated Successfully');
	define('CONFIRM_DELETE_CLIENT_DIVISION','Do you want to delete the Client Division?');
	define('CLIENT_DIVISION_DELETED_SUCCESSFULLY','Client Division Deleted Successfully');
	define('ERR_DIVISION', ' Division is Required');
	define('ERR_LOCATION_NAME', ' Location Name is Required');

	define('ERR_CLIENT_QB_REF_QB_ID', ' Quick book Reference Id is Required');
	define('ERR_CLIENT_QB_REF_QB_CLASS', ' Quick book Reference Class is Required');

	//client entity
	define('CLIENT_ENTITY_CREATED_SUCCESSFULLY', 'Client Entity Created Successfully');
	define('CLIENT_ENTITY_UPDATED_SUCCESSFULLY', 'Client Entity Updated Successfully');
	define('CONFIRM_DELETE_CLIENT_ENTITY','Do you want to delete the Client Entity?');
	define('CLIENT_ENTITY_DELETED_SUCCESSFULLY','Client Entity Deleted Successfully');
	define('ERR_MARSHA_CODE', ' Location Code is Required');

	
	//qb class reference
	define('QB_CLASS_CREATED_SUCCESSFULLY', 'Qb Class Reference Created Successfully');
	define('QB_CLASS_UPDATED_SUCCESSFULLY', 'Qb Class Reference Updated Successfully');
	define('CONFIRM_DELETE_QB_CLASS','Do you want to delete the Qb Class Reference?');
	define('QB_CLASS_DELETED_SUCCESSFULLY','Qb Class Reference Deleted Successfully');
	define('ERR_CLIENT_QB_REF_QB_CLASS_ID', ' Quick book Reference Id is Required');
	define('ERR_CLIENT_QB_REF_QB_CLASS_NAME', ' Quick book Reference Class is Required');
	
	
	//qb client token
	define('QB_CLIENT_TOKEN_CREATED_SUCCESSFULLY', 'Qb Client Token Created Successfully');
	define('QB_CLIENT_TOKEN_UPDATED_SUCCESSFULLY', 'Qb Client Token Updated Successfully');
	define('CONFIRM_DELETE_CLIENT_TOKEN','Do you want to delete the Qb Client Token?');
	define('QB_CLIENT_TOKEN_DELETED_SUCCESSFULLY','Qb Client Token  Deleted Successfully');
	define('ERR_QB_CLIENT_TOKEN_CLIENT_ID', ' Quick book Client Id is Required');
	define('ERR_QB_CLIENT_TOKEN_CLIENT_SECRET', ' Quick book Client Secret is Required');
	define('ERR_QB_CLIENT_TOKEN_CLIENT_REAL_ID', ' Quick book Client Real MID is Required');
	define('ERR_QB_CLIENT_TOKEN_CLIENT_BASE_URL', ' Quick book Client Base URL is Required');
	define('ERR_QB_CLIENT_TOKEN_REFRESH_TOKEN', ' Quick book Refresh Token is Required');
	define('ERR_QB_CLIENT_TOKEN_ACCESS_TOKEN', ' Quick book Access Token is Required');
	
	
	//Division
	define('DIVISION_CREATED_SUCCESSFULLY', 'Division Created Successfully');
	define('DIVISION_UPDATED_SUCCESSFULLY', 'Division Updated Successfully');
	define('CONFIRM_DELETE_DIVISION','Do you want to delete the Division?');
	define('DIVISION_DELETED_SUCCESSFULLY','Division Deleted Successfully');
	define('ERR_DIVISION_CODE', ' Division Code is Required');
	define('ERR_DIVISION_NAME', ' Division Name is Required');
