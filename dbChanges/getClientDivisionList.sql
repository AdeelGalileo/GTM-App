DELIMITER //
DROP PROCEDURE IF EXISTS `getClientDivisionList`//
CREATE PROCEDURE `getClientDivisionList`(
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
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbRef;
	
	SET QryCond = CONCAT(' WHERE client_qb_reference.client_qb_ref_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_qb_reference.client_qb_ref_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(client_qb_reference.client_qb_ref_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND client_qb_reference.client_qb_ref_client_id = ", _clientId );
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY client_qb_reference.client_qb_ref_client_id ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientQbRef engine=memory SELECT SQL_CALC_FOUND_ROWS  client_qb_ref_id 
		FROM client_qb_reference 
		INNER JOIN client ON client.client_id = client_qb_reference.client_qb_ref_client_id
		INNER JOIN division ON division.division_id = client_qb_reference.client_qb_ref_division_id
		INNER JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT client_qb_reference.client_qb_ref_id,client_qb_ref_client_id,client_qb_ref_division_id,client_qb_ref_qb_id,client_qb_ref_qb_class,client_qb_ref_record_status,client_qb_ref_created_by,client_qb_ref_created_on,client_qb_ref_modified_by,client_qb_ref_modified_on,division_code,division_name,client_name,client_id,
	qb_class_reference.qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
	FROM client_qb_reference  
	INNER JOIN tmpClientQbRef ON tmpClientQbRef.client_qb_ref_id = client_qb_reference.client_qb_ref_id
	INNER JOIN client ON client.client_id = client_qb_reference.client_qb_ref_client_id
	INNER JOIN division ON division.division_id = client_qb_reference.client_qb_ref_division_id
	INNER JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbRef;
	
END