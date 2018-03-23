DELIMITER //
DROP PROCEDURE IF EXISTS `getUserById`//
CREATE PROCEDURE `getUserById`(IN `_userId` INT(11))
BEGIN
	SELECT user.user_id, user.user_salutation, user.user_fname, user.user_lname, user.user_image, user.user_email, user.user_password, user.user_address, user.user_notes, user.user_city, user.user_state, user.user_country, user.user_zip, user.user_role_id, user.user_job_title, user.user_record_status, user.user_created_on,  user.user_created_by,  user.user_modified_on,  user.user_modified_by,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status, user.user_qb_ref_id
	FROM user 
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	WHERE user.user_id = _userId AND user.user_record_status = 0;
END