DELIMITER //
DROP PROCEDURE IF EXISTS addRefreshTokenError//
CREATE  PROCEDURE `addRefreshTokenError`(
	IN `_errorMsg` VARCHAR(255),
	IN `_dateTime` datetime

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert Error Message'
BEGIN
		
	INSERT INTO refresh_token_error(error_message,created_on)
	VALUES (_errorMsg, _dateTime);

END