DELIMITER //
DROP PROCEDURE IF EXISTS `getServiceTypeById`//
CREATE PROCEDURE `getServiceTypeById`(
_userId INT(11),
_serviceTypeId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_record_status=0 AND service_type.serv_type_id = ',_serviceTypeId);
	
	SET @IdQry1 = CONCAT(' SELECT serv_type_id,serv_type_qb_id,serv_type_task_type,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
			serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on
	FROM service_type  ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END