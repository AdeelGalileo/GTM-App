DELIMITER //
DROP PROCEDURE IF EXISTS `checkTaskAlert`//
CREATE PROCEDURE `checkTaskAlert`(
_clientId INT(11),
_moduleId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE notification.notification_client_id= ',_clientId,' AND notification.notification_record_status=0 AND modules.modules_record_status=0 AND notification.notification_module_id = ',_moduleId);
	
	SET @IdQry1 = CONCAT(' SELECT notification_id,notification_client_id,notification_module_id,modules_name,modules_desc
	FROM notification  
	INNER JOIN modules ON modules.modules_id = notification.notification_module_id
	', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END