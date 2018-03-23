DELIMITER //
DROP PROCEDURE IF EXISTS `getUsersByRole`//
CREATE PROCEDURE `getUsersByRole`(IN `_roleId` INT(11))
BEGIN

	DECLARE QryCond TEXT;
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 ');
	IF(_roleId > 0) THEN
		SET QryCond = CONCAT(QryCond, ' AND user_role.user_role_id =  ',_roleId);
	END IF;
	
	SET @IdQry = CONCAT(' SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status 
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id ', QryCond );
	
	PREPARE stmt1 FROM @IdQry;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END