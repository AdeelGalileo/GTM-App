DELIMITER //
DROP PROCEDURE IF EXISTS `updateQbBillingReference`//
CREATE PROCEDURE `updateQbBillingReference`(
_userId INT(11),
_taskId INT(11),
_taskType TINYINT(11),
_clientId INT(11),
_billingReference BIGINT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE billing_task_reference.billing_reference_task_id = ',_taskId,' AND billing_task_reference.billing_reference_task_type = ',_taskType, ' AND billing_task_reference.billing_reference_task_client_id = ',_clientId);
	
	
	SET @IdQry1 = CONCAT(' UPDATE billing_task_reference SET  billing_reference_doc_number = ',_billingReference, ', billing_reference_modified_on = ',Quote(_dateTime), ', billing_reference_modified_by = ',_userId, QryCond); 
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	

END