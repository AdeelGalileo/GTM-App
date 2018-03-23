DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskDataForQbInvoice`//
CREATE PROCEDURE `getTaskDataForQbInvoice`(
_taskIds VARCHAR(255),
_taskType TINYINT(1)
)

BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id IN (', _taskIds, ')');
		
		SET @IdQry1 = CONCAT(' SELECT 
		"Task Keyword" AS TaskTypeVal,1 AS TaskType,client_id,client_name,client_qb_ref_id, IF(client_qb_associated_reference>0, client_qb_associated_reference, client_qb_ref_qb_id) AS client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name,
		division_code AS divisionCode, serv_type_qb_id, service_type.serv_type_name , service_type.serv_type_gal_rate,
		SUM(task_keyword_no_of_pages) AS  invQty, SUM(task_keyword_no_of_pages) * serv_type_gal_rate AS qtyRate, serv_type_id
		FROM task_keyword 
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		', QryCond, ' GROUP by division.division_id,service_type.serv_type_id '); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id IN (', _taskIds, ')');
	
		SET @IdQry1 = CONCAT(' SELECT  
	 "Task Content" AS TaskTypeVal,2 AS TaskType,client_id,client_name,client_qb_ref_id,IF(client_qb_associated_reference>0, client_qb_associated_reference, client_qb_ref_qb_id) AS client_qb_ref_qb_id ,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name,
		division_code AS divisionCode, serv_type_qb_id, service_type.serv_type_name , service_type.serv_type_gal_rate,
		SUM(task_content_no_of_units) AS invQty, SUM(task_content_no_of_units) * serv_type_gal_rate AS qtyRate,serv_type_id
		FROM task_content 
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id 
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		', QryCond, ' GROUP by division.division_id,service_type.serv_type_id '); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END