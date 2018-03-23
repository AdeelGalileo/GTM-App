DELIMITER //
DROP PROCEDURE IF EXISTS `deleteClientEntity`//
CREATE PROCEDURE `deleteClientEntity`(
_userId INT(11),
_clientEntityId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE client_entity.client_entity_id = ',_clientEntityId);
	
	SET @IdQry1 = CONCAT(' UPDATE client_entity SET client_entity_record_status = 1 , client_entity_modified_on = ',Quote(_dateTime), ', client_entity_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END