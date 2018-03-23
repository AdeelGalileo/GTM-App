DELIMITER //
DROP PROCEDURE IF EXISTS `deleteAlert`//
CREATE PROCEDURE `deleteAlert`(
_userId INT(11),
_notificationId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE notification.notification_id = ',_notificationId);
	
	SET @IdQry1 = CONCAT(' UPDATE notification SET notification_record_status = 1 , notification_modified_on = ',Quote(_dateTime), ', notification_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END