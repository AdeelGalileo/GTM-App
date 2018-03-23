DELIMITER //
DROP PROCEDURE IF EXISTS `getClientEntityList`//
CREATE PROCEDURE `getClientEntityList`(
	IN `_userId` INT(11),
	IN `_filterBy` TINYINT(1),
	IN `_userRole` INT(11),
	IN `_FromDate` DATE,
	IN `_ToDate` DATE,
	IN `_Start` INT,
	IN `_Limit` INT,
	IN `_SortOrder` VARCHAR(100),
	IN `_clientId` INT(11),
	IN `_divisionId` INT(11)

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
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientEntity;
	
	SET QryCond = CONCAT(' WHERE client_entity.client_entity_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_entity.client_entity_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_entity.client_entity_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_divisionId > 0 && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND client_entity.client_entity_division_id =", _divisionId );
	END IF;
	
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND client_entity.client_entity_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY client_entity.client_entity_marsha_code ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientEntity engine=memory SELECT SQL_CALC_FOUND_ROWS client_entity_id 
		FROM client_entity 
		INNER JOIN client ON client.client_id = client_entity.client_entity_client_id
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT client.client_id,client.client_user_id,client.client_name,client_entity.client_entity_id,client_entity_marsha_code,client_entity_hotel_name,client_entity_client_id,client_entity_user_id,client_entity_division_id,division_code,division_name,client_entity_created_on,client_entity_record_status,client_entity_modified_by,client_entity_modified_on,client_entity_country,client_entity_street,client_entity_city,client_entity_state,client_entity_zipcode
	FROM client_entity  
	INNER JOIN tmpClientEntity ON tmpClientEntity.client_entity_id = client_entity.client_entity_id
	INNER JOIN client ON client.client_id = client_entity.client_entity_client_id
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientEntity;
	
END