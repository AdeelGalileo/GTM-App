DELIMITER //
DROP PROCEDURE IF EXISTS addAdminPersonnel//
CREATE PROCEDURE `addAdminPersonnel`(
	IN `_userId` INT(11),
	IN `_userUpdateId` INT(11),
	IN `_userFirstName` VARCHAR(155),
	IN `_userLastName` VARCHAR(155),
	IN `_userRole` INT(11),
	IN `_userEmail` VARCHAR(200),
	IN `_userPassword` VARCHAR(100),
	IN `_userDateTime` datetime,
	IN `_userQbId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update User for admin personnel'
BEGIN
		IF(_userUpdateId > 0) THEN
		
		UPDATE user SET user_fname = _userFirstName,user_lname = _userLastName, user_email=_userEmail, user_role_id = _userRole, user_modified_by = _userId, user_modified_on = _userDateTime , user_qb_ref_id = _userQbId WHERE user_id = _userUpdateId;
		ELSE
			INSERT INTO user(user_fname,user_lname,user_role_id,user_email,user_password,user_record_status,user_created_by,user_created_on,user_modified_by,user_modified_on,user_qb_ref_id)
			VALUES (_userFirstName, _userLastName, _userRole,_userEmail,_userPassword,0,_userId,_userDateTime,_userId,_userDateTime,_userQbId);
		END IF;
END