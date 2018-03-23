DELIMITER //
DROP PROCEDURE IF EXISTS `deleteAdminPersonnel`//
CREATE PROCEDURE `deleteAdminPersonnel`(
_userId INT(11),
_userDeleteId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_id = ',_userDeleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET user_record_status = 1 , user_modified_on = ',Quote(_dateTime), ', user_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END