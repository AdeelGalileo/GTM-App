DELIMITER //
DROP PROCEDURE IF EXISTS addInvoice//
CREATE PROCEDURE `addInvoice`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_invoiceUpdateId` INT(11),
	IN `_invoiceTotal` DECIMAL(15,2),
	IN `_invoiceDate` date,
	IN `_qbProcessed` TINYINT(1),
	IN `_qbReferenceNumber` VARCHAR(100),
	IN `_dateTime` datetime
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update invoice'
BEGIN

		IF(_invoiceUpdateId > 0) THEN
		
			UPDATE invoice SET invoice_user_id = _userId,invoice_client_id = _clientId,invoice_total = _invoiceTotal, invoice_is_qbprocessed = _qbProcessed, invoice_qbreference_no = _qbReferenceNumber, invoice_modified_by = _userId, invoice_modified_on = _dateTime 
			WHERE invoice_id = _invoiceUpdateId;
			
			SELECT _invoiceUpdateId AS invoiceId;
		
		ELSE
		
			INSERT INTO invoice(invoice_user_id,invoice_client_id,invoice_total,invoice_date,invoice_is_qbprocessed,invoice_qbreference_no,invoice_record_status,invoice_created_by,invoice_created_on,invoice_modified_by,invoice_modified_on)
			VALUES (_userId, _clientId, _invoiceTotal, _invoiceDate, _qbProcessed, _qbReferenceNumber, 0, _userId,_dateTime,_userId,_dateTime);
			
			SELECT LAST_INSERT_ID() AS invoiceId;
		
		END IF;
END