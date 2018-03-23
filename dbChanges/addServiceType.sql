DELIMITER //
DROP PROCEDURE IF EXISTS addServiceType//
CREATE PROCEDURE `addServiceType`(
	IN `_userId` INT(11),
	IN `_serviceTypeUpdateId` INT(11),
	IN `_serviceTypeName` VARCHAR(255),
	IN `_galRatePerUnit` DECIMAL(15,2),
	IN `_freelRatePerUnit` DECIMAL(15,2),
	IN `_clientId` INT(11),
	IN `_dateTime` datetime,
	IN `_serviceQbId` INT(11),
	IN `_taskTypeId` TINYINT(11)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update service_type'
BEGIN
		IF(_serviceTypeUpdateId > 0) THEN
		
		UPDATE service_type SET serv_type_client_id = _clientId, serv_type_name = _serviceTypeName,
		serv_type_gal_rate = _galRatePerUnit,serv_type_freel_rate = _freelRatePerUnit,serv_type_modified_by = _userId, serv_type_modified_on = _dateTime, serv_type_qb_id = _serviceQbId, serv_type_task_type = _taskTypeId
		WHERE serv_type_id = _serviceTypeUpdateId;
		ELSE
			INSERT INTO service_type(serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,
			serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on,serv_type_qb_id,serv_type_task_type)
			VALUES (_serviceTypeName, _clientId,_galRatePerUnit, _freelRatePerUnit,0,_userId,_dateTime,_userId,_dateTime,_serviceQbId,_taskTypeId);
		END IF;
END