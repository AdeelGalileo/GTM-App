DELIMITER //
DROP PROCEDURE IF EXISTS addAlertNotification//
CREATE PROCEDURE `addAlertNotification`(
	IN `_userId` INT(11),
	IN `_notificationUpdateId` INT(11),
	IN `_notificationUserId` INT(11),
	IN `_notificationModuleId` INT(11),
	IN `_notificationEmail` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime,
	IN `_notificationTaskId` INT(11),
	IN `_notificationMsg` TEXT

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update alert notification'
BEGIN

	INSERT INTO alert_notification(alert_notification_module_user_id,alert_notification_client_id,alert_notification_module_id,alert_notification_email,alert_notification_record_status,alert_notification_created_by,alert_notification_created_on,alert_notification_modified_by,alert_notification_modified_on,alert_notification_task_id,alert_notification_message)
	VALUES (_notificationUserId, _clientId,_notificationModuleId, _notificationEmail,0,_userId,_dateTime,_userId,_dateTime,_notificationTaskId,_notificationMsg);
	
	SELECT LAST_INSERT_ID() AS alertNotificationId;
END