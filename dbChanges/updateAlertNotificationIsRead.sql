DELIMITER //
DROP PROCEDURE IF EXISTS `updateAlertNotificationIsRead`//
CREATE PROCEDURE `updateAlertNotificationIsRead`(
_userId INT(11),
_alertId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE alert_notification_id = ',_alertId);
	
	SET @IdQry1 = CONCAT(' UPDATE alert_notification SET alert_notification_is_read = 1, alert_notification_modified_on = ',Quote(_dateTime), ', alert_notification_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END