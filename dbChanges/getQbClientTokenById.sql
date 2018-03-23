DELIMITER //
DROP PROCEDURE IF EXISTS `getQbClientTokenById`//
CREATE PROCEDURE `getQbClientTokenById`(
	IN `_tokenId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT qb_client_token.qb_client_token_id,qb_client_token_auth_mode,qb_client_token_client_id,qb_client_token_client_secret,qb_client_token_app_client_id,qb_client_token_refresh_token,qb_client_token_access_token,qb_client_token_qbo_real_id,qb_client_token_base_url,qb_client_token_current_refresh_token,qb_client_token_record_status,qb_client_token_created_by,qb_client_token_created_on,qb_client_token_modified_by,qb_client_token_modified_on FROM qb_client_token  
	INNER JOIN client ON client.client_id = qb_client_token.qb_client_token_app_client_id
	WHERE qb_client_token.qb_client_token_record_status=0 AND client.client_record_status= 0 AND qb_client_token_id = _tokenId;
END