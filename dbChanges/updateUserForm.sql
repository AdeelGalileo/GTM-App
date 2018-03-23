DELIMITER //
DROP PROCEDURE IF EXISTS `updateUserForm`//
CREATE PROCEDURE `updateUserForm`(
_userId INT(11),
_userFormId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user_id = ',_userFormId,' AND user_record_status = 0');
	
	SET @IdQry1 = CONCAT(' UPDATE user SET  user_form_completed = 1, user_modified_on = ',Quote(_dateTime), ', user_modified_by = ',_userId, QryCond); 
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	

END