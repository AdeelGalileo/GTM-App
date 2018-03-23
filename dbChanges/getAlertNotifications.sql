DELIMITER //
DROP PROCEDURE IF EXISTS `getAlertNotifications`//
CREATE PROCEDURE `getAlertNotifications`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	DECLARE DivisionCode VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpAlertNot;
	
	SET QryCond = CONCAT(' WHERE  alert_notification_is_read=0 AND alert_notification.alert_notification_record_status=0 AND user.user_record_status=0 AND alert_notification.alert_notification_module_user_id=',_userId);
	
	SET QryCond = CONCAT(QryCond, " AND alert_notification.alert_notification_client_id = ", _clientId);
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY alert_notification.alert_notification_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpAlertNot engine=memory SELECT SQL_CALC_FOUND_ROWS  alert_notification_id 
		FROM alert_notification 
		INNER JOIN user ON user.user_id = alert_notification.alert_notification_module_user_id
		INNER JOIN modules ON modules.modules_id = alert_notification.alert_notification_module_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT alert_notification.alert_notification_id,alert_notification_is_read,alert_notification_module_user_id,alert_notification_client_id,alert_notification_module_id,alert_notification_email,alert_notification_record_status,alert_notification_created_by,alert_notification_created_on,alert_notification_modified_by,alert_notification_modified_on,alert_notification_task_id,alert_notification_invoice_id,alert_notification_billing_id,alert_notification_message,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,modules_id,modules_name FROM alert_notification  
	INNER JOIN tmpAlertNot ON tmpAlertNot.alert_notification_id = alert_notification.alert_notification_id
	INNER JOIN user ON user.user_id = alert_notification.alert_notification_module_user_id
	INNER JOIN modules ON modules.modules_id = alert_notification.alert_notification_module_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpAlertNot;
	
END