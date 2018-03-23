DELIMITER //
DROP PROCEDURE IF EXISTS `deleteClientDivision`//
CREATE PROCEDURE `deleteClientDivision`(
_userId INT(11),
_clientQbRefDeleteId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE client_qb_reference.client_qb_ref_id = ',_clientQbRefDeleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE client_qb_reference SET client_qb_ref_record_status = 1 , client_qb_ref_modified_on = ',Quote(_dateTime), ', client_qb_ref_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END