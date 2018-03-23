DELIMITER //
DROP PROCEDURE IF EXISTS addInvoiceTaskReference//
CREATE PROCEDURE `addInvoiceTaskReference`(
	IN `_invoiceId` INT(11),
	IN `_clientName` VARCHAR(255),
	IN `_uFname` VARCHAR(155),
	IN `_uLname` VARCHAR(155),
	IN `_taskId` INT(11),
	IN `_taskUserId` INT(11),
	IN `_taskClientId` INT(11),
	IN `_taskType` TINYINT(1),
	IN `_marshaCode` VARCHAR(200),
	IN `_divisionCode` VARCHAR(50),
	IN `_serviceTypeName` VARCHAR(255),
	IN `_ratePerUnit` DECIMAL(15,2),
	IN `_noOfUnits` INT(11),
	IN `_tire` VARCHAR(255),
	IN `_userId` INT(11),
	IN `_dateTime` datetime,
	IN `_qbServiceRefId` INT(11)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert invoice task reference'
BEGIN

	INSERT INTO invoice_task_reference(invoice_reference_invoice_id,invoice_reference_client_name,invoice_reference_user_fname,invoice_reference_user_lname,invoice_reference_task_id,invoice_reference_task_user_id,invoice_reference_task_client_id,invoice_reference_task_type,invoice_reference_marsha_code,invoice_reference_division_code,invoice_reference_service_type_name,invoice_reference_rate_per_unit,invoice_reference_no_of_units,invoice_reference_tire,invoice_reference_record_status,invoice_reference_created_by,invoice_reference_created_on,invoice_reference_modified_by,invoice_reference_modified_on,invoice_reference_service_qb_ref_id)
	VALUES (_invoiceId, _clientName,_uFname, _uLname, _taskId,_taskUserId,_taskClientId, _taskType, _marshaCode, _divisionCode, _serviceTypeName,_ratePerUnit,_noOfUnits,_tire,0,_userId,_dateTime,_userId,_dateTime,_qbServiceRefId);
	
	SELECT LAST_INSERT_ID() AS invoiceRefId;
	
	IF(_taskType = 1) THEN
	
		UPDATE task_keyword SET task_keyword_qb_inv_process = 1 WHERE task_keyword_id = _taskId;
	
	ELSEIF(_taskType = 2) THEN
	
		UPDATE task_content SET task_content_qb_inv_process = 1 WHERE task_content_id = _taskId;
	
	END IF;
		
END