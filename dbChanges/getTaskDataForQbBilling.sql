DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskDataForQbBilling`//
CREATE PROCEDURE `getTaskDataForQbBilling`(
_taskIds VARCHAR(255),
_taskType TINYINT(1)
)

BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id IN (', _taskIds, ')');
		
		SET @IdQry1 = CONCAT(' SELECT  task_keyword_no_of_pages AS unitNo, (IFNULL(cons_rate_per_unit, serv_type_freel_rate)) * task_keyword_no_of_pages AS sumRate, user.user_qb_ref_id, 
		"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_id,client_name,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_keyword 
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		LEFT  JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_keyword.task_keyword_user_id AND consultant_rate.cons_rate_client_id = task_keyword_client_id AND cons_rate_service_type_id = task_keyword.task_keyword_service_type_id AND cons_rate_record_status = 0
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		', QryCond); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id IN (', _taskIds, ')');
	
		SET @IdQry1 = CONCAT(' SELECT task_content_no_of_units AS unitNo, (IFNULL(cons_rate_per_unit, serv_type_freel_rate)) * task_content_no_of_units  AS sumRate,   user.user_qb_ref_id,
	 "Task Content" AS TaskTypeVal,2 AS TaskType,client_id,client_name,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_content 
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		LEFT JOIN consultant_rate ON consultant_rate.cons_rate_user_id = task_content.task_content_user_id AND consultant_rate.cons_rate_client_id = task_content_client_id AND cons_rate_service_type_id = task_content.task_content_service_type_id AND cons_rate_record_status = 0
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		', QryCond); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END