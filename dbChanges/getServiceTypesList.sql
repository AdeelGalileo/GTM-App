DELIMITER //
DROP PROCEDURE IF EXISTS `getServiceTypesList`//
CREATE PROCEDURE `getServiceTypesList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11),
_serviceTypeId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpServiceTypes;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(service_type.serv_type_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(service_type.serv_type_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_serviceTypeId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND service_type.serv_type_id = ", _serviceTypeId );
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND service_type.serv_type_client_id = ", _clientId);
	END IF;
	
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY service_type.serv_type_name ASC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpServiceTypes engine=memory SELECT SQL_CALC_FOUND_ROWS  serv_type_id 
		FROM service_type 
		INNER JOIN client ON client.client_id = service_type.serv_type_client_id
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT service_type.serv_type_id,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
	serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on,serv_type_qb_id,serv_type_task_type,client.client_name
	FROM service_type 
	INNER JOIN tmpServiceTypes ON tmpServiceTypes.serv_type_id = service_type.serv_type_id
	INNER JOIN client ON client.client_id = service_type.serv_type_client_id ', QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpServiceTypes;
	
END