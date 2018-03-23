DELIMITER //
DROP PROCEDURE IF EXISTS `getClientList`//
CREATE PROCEDURE `getClientList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_recordStatus` TINYINT(1)
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
	
	DROP TEMPORARY TABLE IF EXISTS tmpClient;
	
	SET QryCond = CONCAT(' WHERE client.client_record_status= ', _recordStatus);
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 5) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client.client_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 5) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client.client_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_clientId > 0 && _filterBy = 2) THEN
	 SET QryCond = CONCAT(QryCond, " AND client.client_id = ", _clientId );
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY client.client_name ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClient engine=memory SELECT SQL_CALC_FOUND_ROWS  client_id 
		FROM client ', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT client.client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country,client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on FROM client  
	INNER JOIN tmpClient ON tmpClient.client_id = client.client_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClient;
	
END