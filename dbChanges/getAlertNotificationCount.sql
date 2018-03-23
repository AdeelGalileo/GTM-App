DELIMITER //
DROP PROCEDURE IF EXISTS `getAlertNotificationCount`//
CREATE PROCEDURE `getAlertNotificationCount`(
_userId INT(11),
_clientId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	DROP TEMPORARY TABLE IF EXISTS tmpCount;
	
	SET QryCond = CONCAT(' WHERE alert_notification_is_read = 0 AND alert_notification.alert_notification_record_status=0 AND alert_notification_module_user_id = ',_userId,' AND alert_notification_client_id = ',_clientId);
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpCount engine=memory SELECT SQL_CALC_FOUND_ROWS  alert_notification_id 
		FROM alert_notification 
		', QryCond);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;

	DROP TEMPORARY TABLE IF EXISTS tmpCount;
	
END