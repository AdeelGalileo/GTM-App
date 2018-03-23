DELIMITER //
DROP PROCEDURE IF EXISTS `getDivisionList`//
CREATE PROCEDURE `getDivisionList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_clientId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpDivision;
	
	SET QryCond = CONCAT(' WHERE division.division_record_status=0 AND client.client_record_status = 0 AND division.division_client_id = ', _clientId);
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(division.division_created_on) =", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 1) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(division.division_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY division.division_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpDivision engine=memory SELECT SQL_CALC_FOUND_ROWS  division_id 
		FROM division 
		INNER JOIN client ON client.client_id = division.division_client_id ', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT division.division_id,division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on
	FROM division 
	INNER JOIN tmpDivision ON tmpDivision.division_id = division.division_id
	INNER JOIN client ON client.client_id = division.division_client_id ', QryCond, QryOrder); 
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpDivision;
	
END