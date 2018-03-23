DELIMITER //
DROP PROCEDURE IF EXISTS `getAlertById`//
CREATE PROCEDURE `getAlertById`(
_userId INT(11),
_notificationId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	
	SET QryCond = CONCAT(' WHERE notification.notification_record_status=0 AND notification.notification_id = ',_notificationId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,notification.notification_id,notification_user_id,notification_client_id,notification_module_id,notification_email,
	notification_record_status,notification_created_by,notification_created_on,notification_modified_by,notification_modified_on,client.client_name,
	modules.modules_id,modules.modules_name,modules.modules_record_status,modules.modules_created_by,modules.modules_created_on,modules.modules_modified_by,modules.modules_modified_on
	FROM notification 
	INNER JOIN user ON user.user_id = notification.notification_user_id
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN client ON client.client_id = notification.notification_client_id
	INNER JOIN modules ON modules.modules_id = notification.notification_module_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END