DELIMITER //
DROP PROCEDURE IF EXISTS `getQbClientTokenList`//
CREATE PROCEDURE `getQbClientTokenList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbToken;
	
	SET QryCond = CONCAT(' WHERE qb_client_token.qb_client_token_record_status=0 AND client.client_record_status= 0');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_client_token.qb_client_token_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_client_token.qb_client_token_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY qb_client_token.qb_client_token_app_client_id ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientQbToken engine=memory SELECT SQL_CALC_FOUND_ROWS  qb_client_token_id 
		FROM qb_client_token 
		INNER JOIN client ON client.client_id = qb_client_token.qb_client_token_app_client_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT qb_client_token.qb_client_token_id,qb_client_token_auth_mode,qb_client_token_client_id,qb_client_token_client_secret,qb_client_token_app_client_id,qb_client_token_refresh_token,qb_client_token_access_token,qb_client_token_qbo_real_id,qb_client_token_base_url,qb_client_token_current_refresh_token,qb_client_token_record_status,qb_client_token_created_by,qb_client_token_created_on,qb_client_token_modified_by,qb_client_token_modified_on FROM qb_client_token  
	INNER JOIN tmpClientQbToken ON tmpClientQbToken.qb_client_token_id = qb_client_token.qb_client_token_id
	INNER JOIN client ON client.client_id = qb_client_token.qb_client_token_app_client_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbToken;
	
END