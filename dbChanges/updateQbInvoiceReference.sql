DELIMITER //
DROP PROCEDURE IF EXISTS `updateQbInvoiceReference`//
CREATE PROCEDURE `updateQbInvoiceReference`(
_userId INT(11),
_taskId INT(11),
_taskType TINYINT(11),
_clientId INT(11),
_invoiceReference BIGINT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE invoice_task_reference.invoice_reference_task_id = ',_taskId,' AND invoice_task_reference.invoice_reference_task_type = ',_taskType, ' AND invoice_task_reference.invoice_reference_task_client_id = ',_clientId);
	
	
	SET @IdQry1 = CONCAT(' UPDATE invoice_task_reference SET  invoice_reference_doc_number = ',_invoiceReference, ', invoice_reference_modified_on = ',Quote(_dateTime), ', invoice_reference_modified_by = ',_userId, QryCond); 
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	

END