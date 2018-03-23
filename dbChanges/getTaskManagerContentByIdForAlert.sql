DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskManagerContentByIdForAlert`//
CREATE PROCEDURE `getTaskManagerContentByIdForAlert`(
_taskContentId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE  task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' SELECT client_entity_marsha_code AS attrCode,division_id,division_code AS attrDivCode, service_type.serv_type_name AS attrServiceTypeName
	FROM task_content 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END