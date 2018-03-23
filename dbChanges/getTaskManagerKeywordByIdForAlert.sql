DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskManagerKeywordByIdForAlert`//
CREATE PROCEDURE `getTaskManagerKeywordByIdForAlert`(
_taskKeywordId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' SELECT client_entity_id,client_entity_marsha_code AS attrCode,division_id,division_code AS attrDivCode,division_name,
	task_keyword.task_keyword_id,task_keyword.task_keyword_marsha_code,service_type.serv_type_id,service_type.serv_type_name AS attrServiceTypeName
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT  JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END