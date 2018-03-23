DELIMITER //
DROP PROCEDURE IF EXISTS `getInvoiceTaskList`//
CREATE PROCEDURE `getInvoiceTaskList`(
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
_divisionId INT(11),
_serviceTypeName VARCHAR(255),
_marshaCode VARCHAR(200),
_invNo BIGINT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	DECLARE QryOrder VARCHAR(100);
	DECLARE QryLimit VARCHAR(50);
	
	DROP TEMPORARY TABLE IF EXISTS tmpInvoice;
	
	SET QryCond = CONCAT(' WHERE invoice_task_reference.invoice_reference_record_status=0 ');
	
	
	IF(_FromDate && _FromDate = _ToDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(invoice_task_reference.invoice_reference_created_on) = ", Quote(_FromDate) );
	ELSEIF(_FromDate && _filterBy = 2) THEN
	  SET QryCond = CONCAT(QryCond, " AND DATE(invoice_task_reference.invoice_reference_created_on) BETWEEN '", _FromDate ,"' AND '",_ToDate, "'" );
	ELSEIF(_writerId > 0 && _filterBy = 3) THEN
	 SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_user_id = ", _writerId );
	ELSEIF(_divisionId && _filterBy = 4) THEN
	  SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_division_code =", Quote(_divisionId) );
	ELSEIF(_serviceTypeName !='0' && _filterBy = 6) THEN
	  SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_service_type_name =", Quote(_serviceTypeName) );
	ELSEIF(_marshaCode !='0' && _filterBy = 5) THEN
	  SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_marsha_code =", Quote(_marshaCode) );
	ELSEIF(_invNo > 0 && _filterBy = 7) THEN
	 SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_doc_number = ", _invNo );
	END IF;
	
	
	IF(_userRole > 1) THEN
		SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_user_id = ", _userId);
	END IF;
	
	IF(_clientId > 0) THEN
		SET QryCond = CONCAT(QryCond, " AND invoice_task_reference.invoice_reference_task_client_id = ", _clientId);
	END IF;
	
	IF(_SortOrder IS NULL OR _SortOrder = '') THEN
	SET QryOrder = ' ORDER BY invoice_task_reference.invoice_reference_created_on DESC ';
	ELSE
	SET QryOrder = CONCAT(' ORDER BY ', _sortOrder);
	END IF;
	
	SET QryLimit = '';
	IF(_Limit) THEN 
	SET QryLimit = CONCAT(' LIMIT ', _Start, ',', _Limit);
	END IF;
	
	SET @IdQry1 = CONCAT('CREATE TEMPORARY TABLE tmpInvoice engine=memory SELECT SQL_CALC_FOUND_ROWS  invoice_reference_id 
		FROM invoice_task_reference 
		', QryCond, QryOrder, QryLimit);
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	SELECT FOUND_ROWS() as total;
	
	SET @IdQry2 = CONCAT(' SELECT invoice_task_reference.invoice_reference_id,invoice_reference_invoice_id,invoice_reference_client_name,invoice_reference_user_fname,invoice_reference_user_lname,invoice_reference_task_id,invoice_reference_task_user_id,invoice_reference_task_client_id,invoice_reference_task_type,invoice_reference_marsha_code,invoice_reference_division_code,invoice_reference_service_type_name,invoice_reference_rate_per_unit,invoice_reference_no_of_units,invoice_reference_tire,invoice_reference_record_status,invoice_reference_created_by,invoice_reference_created_on,invoice_reference_modified_by,invoice_reference_modified_on,invoice_reference_doc_number FROM invoice_task_reference  
	INNER JOIN tmpInvoice ON tmpInvoice.invoice_reference_id = invoice_task_reference.invoice_reference_id
	', QryOrder); 
	
	
	PREPARE stmt2 FROM @IdQry2;
	EXECUTE stmt2;
	DEALLOCATE PREPARE stmt2;
	
	DROP TEMPORARY TABLE IF EXISTS tmpInvoice;
	
END