DELIMITER //
DROP PROCEDURE IF EXISTS `deleteClient`//
CREATE PROCEDURE `deleteClient`(
_userId INT(11),
_clientDelId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE client.client_id = ',_clientDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE client SET client_record_status = 1 , client_modified_on = ',Quote(_dateTime), ', client_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END