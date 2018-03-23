DELIMITER //
DROP PROCEDURE IF EXISTS `updateUserPassword`//
CREATE PROCEDURE `updateUserPassword`(
_userId INT(11),
_userPass VARCHAR(255),
_date date
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 AND user.user_id = ',_userId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET user_activation_link="", user_activation_link_expire="0000-00-00",  user_password = ',Quote(_userPass), ', user_modified_on = ',Quote(_date), QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END