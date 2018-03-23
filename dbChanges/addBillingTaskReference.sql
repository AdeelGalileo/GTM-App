DELIMITER //
DROP PROCEDURE IF EXISTS addBillingTaskReference//
CREATE  PROCEDURE `addBillingTaskReference`(
	IN `_billingId` INT(11),
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
COMMENT 'Insert billing task reference'
BEGIN

	INSERT INTO billing_task_reference(billing_reference_billing_id,billing_reference_client_name,billing_reference_user_fname,billing_reference_user_lname,billing_reference_task_id,billing_reference_task_user_id,billing_reference_task_client_id,billing_reference_task_type,billing_reference_marsha_code,billing_reference_division_code,billing_reference_service_type_name,billing_reference_rate_per_unit,billing_reference_no_of_units,billing_reference_tire,billing_reference_record_status,billing_reference_created_by,billing_reference_created_on,billing_reference_modified_by,billing_reference_modified_on,billing_reference_service_qb_ref_id)
	VALUES (_billingId, _clientName,_uFname, _uLname, _taskId,_taskUserId,_taskClientId, _taskType, _marshaCode, _divisionCode, _serviceTypeName,_ratePerUnit,_noOfUnits,_tire,0,_userId,_dateTime,_userId,_dateTime,_qbServiceRefId);
	
	SELECT LAST_INSERT_ID() AS billingRefId;
	
	IF(_taskType = 1) THEN
	
		UPDATE task_keyword SET task_keyword_qb_process = 1 WHERE task_keyword_id = _taskId;
	
	ELSEIF(_taskType = 2) THEN
	
		UPDATE task_content SET task_content_qb_process = 1 WHERE task_content_id = _taskId;
	
	END IF;
		
END