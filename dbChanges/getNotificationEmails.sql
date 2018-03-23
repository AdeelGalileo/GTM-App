DELIMITER //
DROP PROCEDURE IF EXISTS `getNotificationEmails`//
CREATE  PROCEDURE `getNotificationEmails`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_moduleId` TINYINT(1)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE QryCond TEXT;
		SET QryCond = CONCAT(' WHERE notification_record_status=0 AND notification_client_id = ',_clientId,' AND notification_module_id = ',_moduleId);
		
		SET @IdQry1 = CONCAT(' SELECT notification_id,notification_module_id,notification_client_id,notification_email FROM notification', QryCond); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	
END