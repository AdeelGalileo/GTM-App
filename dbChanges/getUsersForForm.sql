DELIMITER //
DROP PROCEDURE IF EXISTS `getUsersForForm`//
CREATE PROCEDURE `getUsersForForm`()
BEGIN
	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(" WHERE user.user_form_completed = 0 AND user.user_record_status = 0 AND user_id NOT IN( SELECT form_user_id FROM form WHERE form_record_status=0) ");
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname FROM user ', QryCond );
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END