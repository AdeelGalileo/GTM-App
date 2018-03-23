DELIMITER //
DROP PROCEDURE IF EXISTS checkUserEmailExistForUpdate//
CREATE PROCEDURE `checkUserEmailExistForUpdate`(
	IN `_userEmail` VARCHAR(200),
	IN `_userId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Check User Email Exist for update'
BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_email) = lower(_userEmail) AND user_record_status = 0 AND user_id != _userId;
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END