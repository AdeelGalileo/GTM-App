DELIMITER //
DROP PROCEDURE IF EXISTS updateQbClientToken//
CREATE PROCEDURE `updateQbClientToken`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_tokenUpateId` INT(11),
	IN `_tokenClientId` VARCHAR(255),
	IN `_tokenClientSecretId` VARCHAR(255),
	IN `_tokenRealId` VARCHAR(255),
	IN `_tokenBaseUrl` VARCHAR(255),
	IN `_refreshToken` VARCHAR(255),
	IN `_accessToken` TEXT,
	IN `_dateTime` datetime

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Update qb_client_token'
BEGIN
		UPDATE qb_client_token SET  qb_client_token_refresh_token = _refreshToken,qb_client_token_access_token = _accessToken ,qb_client_token_current_refresh_token = _refreshToken ,qb_client_token_modified_by= _userId,qb_client_token_modified_on =  _dateTime WHERE qb_client_token_id = _tokenUpateId;
		
END