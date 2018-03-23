DELIMITER //
DROP PROCEDURE IF EXISTS `getServiceTypeByTaskType`//
CREATE PROCEDURE `getServiceTypeByTaskType`(
_clientId INT(11),
_taskType INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE service_type.serv_type_record_status=0 AND service_type.serv_type_client_id = ',_clientId,' AND service_type.serv_type_task_type = ',_taskType);
	
	SET @IdQry1 = CONCAT(' SELECT serv_type_id,serv_type_qb_id,serv_type_task_type,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
			serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on
	FROM service_type  ', QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END