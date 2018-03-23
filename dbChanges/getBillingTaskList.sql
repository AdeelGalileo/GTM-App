DELIMITER //
DROP PROCEDURE IF EXISTS `getBillingTaskList`//
CREATE PROCEDURE `getBillingTaskList`(
_userId INT(11),
_filterBy TINYINT(1),
_userRole INT(11),
_FromDate DATE, 
_ToDate DATE,
_Start INT, 
_Limit INT,
_SortOrder VARCHAR(100),
_writerId INT(11),
_clientId INT(11),
_divisionText VARCHAR(100),
_divisionId INT(11),
_qbBillId BIGINT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpBilling;
	
	SET QryCond = CONCAT(' WHERE billing_task_reference.billing_reference_record_status=0 ');
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(billing_task_reference.billing_reference_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(billing_task_reference.billing_reference_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_user_id = ", _writerId );
	ELSEIF(_divisionId  > 0 && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_division_code =", Quote(_divisionId) );
	ELSEIF(_qbBillId > 0 && _filterBy = 5) THEN
	 SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_doc_number = ", _qbBillId );
	END IF;
	
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_user_id = ", _userId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND billing_task_reference.billing_reference_task_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY billing_task_reference.billing_reference_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpBilling engine=memory SELECT SQL_CALC_FOUND_ROWS  billing_reference_id 
		FROM billing_task_reference 
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT billing_task_reference.billing_reference_id,billing_reference_billing_id,billing_reference_client_name,billing_reference_user_fname,billing_reference_user_lname,billing_reference_task_id,billing_reference_task_user_id,billing_reference_task_client_id,billing_reference_task_type,billing_reference_marsha_code,billing_reference_division_code,billing_reference_service_type_name,billing_reference_rate_per_unit,billing_reference_no_of_units,billing_reference_tire,billing_reference_record_status,billing_reference_created_by,billing_reference_created_on,billing_reference_modified_by,billing_reference_modified_on,billing_reference_doc_number FROM billing_task_reference  
	INNER JOIN tmpBilling ON tmpBilling.billing_reference_id = billing_task_reference.billing_reference_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpBilling;
	
END