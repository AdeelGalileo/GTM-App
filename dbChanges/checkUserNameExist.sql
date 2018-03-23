DELIMITER //
DROP PROCEDURE IF EXISTS checkUserNameExist//
CREATE PROCEDURE `checkUserNameExist`(
	IN `_userName` VARCHAR(155)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Check User Name Exist'
BEGIN
DECLARE _existId INT DEFAULT 0;
DECLARE _userExist INT DEFAULT 0;
	SELECT user_id INTO _existId FROM user WHERE lower(user_name) = lower(_userName);
	SET _existId = IFNULL(_existId, 0);
	IF(_existId > 0) THEN 
		SET _userExist = 1;
	END IF;
	SELECT _userExist as userExist;
END