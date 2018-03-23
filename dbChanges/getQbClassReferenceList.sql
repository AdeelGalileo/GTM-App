DELIMITER //
DROP PROCEDURE IF EXISTS `getQbClassReferenceList`//
CREATE PROCEDURE `getQbClassReferenceList`(
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
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbClassRef;
	
	SET QryCond = CONCAT(' WHERE qb_class_reference.qb_cls_ref_record_status=0 AND client.client_record_status= 0');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_class_reference.qb_cls_ref_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(qb_class_reference.qb_cls_ref_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND qb_class_reference.qb_cls_ref_client_id = ", _clientId );
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY qb_class_reference.qb_cls_ref_client_id ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpClientQbClassRef engine=memory SELECT SQL_CALC_FOUND_ROWS  qb_cls_ref_id 
		FROM qb_class_reference 
		INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT qb_class_reference.qb_cls_ref_id,qb_cls_ref_client_id,qb_cls_ref_class_id,qb_cls_ref_class_name,qb_cls_ref_record_status,qb_cls_ref_created_by,qb_cls_ref_created_on,qb_cls_ref_modified_by,qb_cls_ref_modified_on FROM qb_class_reference  
	INNER JOIN tmpClientQbClassRef ON tmpClientQbClassRef.qb_cls_ref_id = qb_class_reference.qb_cls_ref_id
	INNER JOIN client ON client.client_id = qb_class_reference.qb_cls_ref_client_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpClientQbClassRef;
	
END