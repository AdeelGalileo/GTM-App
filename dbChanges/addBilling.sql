DELIMITER //
DROP PROCEDURE IF EXISTS addBilling//
CREATE PROCEDURE `addBilling`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_billingUpdateId` INT(11),
	IN `_invoiceId` INT(11),
	IN `_billingTotal` DECIMAL(15,2),
	IN `_billingDate` date,
	IN `_qbProcessed` TINYINT(1),
	IN `_qbReferenceNumber` VARCHAR(100),
	IN `_dateTime` datetime
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update billing'
BEGIN

		IF(_billingUpdateId > 0) THEN
		
			UPDATE billing SET billing_user_id = _userId,billing_client_id = _clientId, billing_invoice_id = _invoiceId,
			billing_total = _billingTotal, billing_is_qbprocessed = _qbProcessed, billing_qbreference_no = _qbReferenceNumber, billing_modified_by = _userId, billing_modified_on = _dateTime WHERE billing_id = _billingUpdateId;
			
			SELECT _billingUpdateId AS billingId;
		
		ELSE
		
			INSERT INTO billing(billing_user_id,billing_client_id,billing_invoice_id,billing_total,billing_date,billing_is_qbprocessed,billing_qbreference_no,billing_record_status,billing_created_by,billing_created_on,billing_modified_by,billing_modified_on)
			VALUES (_userId, _clientId,_invoiceId, _billingTotal, _billingDate, _qbProcessed, _qbReferenceNumber, 0, _userId,_dateTime,_userId,_dateTime);
			
			SELECT LAST_INSERT_ID() AS billingId;
		
		END IF;
END