DELIMITER //
DROP PROCEDURE IF EXISTS `deleteServiceType`//
CREATE PROCEDURE `deleteServiceType`(
_userId INT(11),
_serviceTypeId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_id = ',_serviceTypeId);
	
	SET @IdQry1 = CONCAT(' UPDATE service_type SET serv_type_record_status = 1 , serv_type_modified_on = ',Quote(_dateTime), ', serv_type_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END