DELIMITER //
DROP PROCEDURE IF EXISTS addAlert//
CREATE PROCEDURE `addAlert`(
	IN `_userId` INT(11),
	IN `_notificationUpdateId` INT(11),
	IN `_notificationUserId` INT(11),
	IN `_notificationModuleId` INT(11),
	IN `_notificationEmail` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update task_keyword'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_notificationUpdateId > 0) THEN
		
		UPDATE notification SET notification_user_id = _notificationUserId,notification_client_id = _clientId, notification_module_id = _notificationModuleId,
		notification_email = _notificationEmail,notification_modified_by = _userId, notification_modified_on = _dateTime
		WHERE notification_id = _notificationUpdateId;
		ELSE
			
			SELECT  notification_id into _isExistId FROM notification WHERE notification_user_id = _notificationUserId AND notification_client_id = _clientId AND notification_module_id = _notificationModuleId AND notification_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			IF(_isExistId=0) THEN
				INSERT INTO notification(notification_user_id,notification_client_id,notification_module_id,notification_email,notification_record_status,notification_created_by,notification_created_on,notification_modified_by,notification_modified_on)
				VALUES (_notificationUserId, _clientId,_notificationModuleId, _notificationEmail,0,_userId,_dateTime,_userId,_dateTime);
			ELSE
				UPDATE notification SET notification_user_id = _notificationUserId,notification_client_id = _clientId, notification_module_id = _notificationModuleId,
				notification_email = _notificationEmail,notification_modified_by = _userId, notification_modified_on = _dateTime
			WHERE notification_id = _isExistId;
			END IF;
		END IF;
END