DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskDataForInvoiceReference`//
CREATE PROCEDURE `getTaskDataForInvoiceReference`(
_taskId INT(11),
_taskType TINYINT(1),
_invQty INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	  
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND user.user_record_status=0 AND task_keyword.task_keyword_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT ',_invQty,' AS  invQty,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name, user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
		task_keyword.task_keyword_id AS taskId ,"Task Keyword" AS TaskTypeVal,1 AS TaskType,task_keyword.task_keyword_marsha_code,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due AS contentDue ,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on,task_keyword.task_keyword_priority,service_type.serv_type_id,service_type.serv_type_qb_id,service_type.serv_type_name,client_id,client_name,task_keyword_tire AS tire,service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,client_qb_ref_division_id,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_keyword 
		INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_keyword_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_keyword.task_keyword_client_id
		INNER JOIN service_type ON service_type.serv_type_id = task_keyword.task_keyword_service_type_id ', QryCond, ' LIMIT 1'); 
			
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	ELSEIF(_taskType = 2) THEN
		
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND user.user_record_status=0 AND task_content.task_content_id = ',_taskId);
	
		SET @IdQry1 = CONCAT(' SELECT ',_invQty,' AS  invQty, user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
		task_content.task_content_id AS taskId ,"Task Content" AS TaskTypeVal,2 AS TaskType,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire AS tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date AS contentDue,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_qb_id,service_type.serv_type_name,client_id,client_name,service_type.serv_type_gal_rate AS servTypeGalRate, service_type.serv_type_freel_rate AS servTypeFreeLRate,client_qb_ref_division_id,client_qb_ref_id,client_qb_ref_qb_id,client_qb_ref_qb_class,qb_cls_ref_id,qb_cls_ref_class_id,qb_cls_ref_class_name
		FROM task_content 
		INNER JOIN user ON user.user_id = task_content.task_content_user_id
		INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
		INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
		INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
		LEFT  JOIN client_qb_reference ON client_qb_reference.client_qb_ref_division_id = client_entity.client_entity_division_id AND client_qb_reference.client_qb_ref_record_status=0 AND task_content_client_id = client_qb_ref_client_id
		LEFT  JOIN qb_class_reference ON qb_class_reference.qb_cls_ref_id = client_qb_reference.client_qb_ref_qb_class
		INNER JOIN client ON client.client_id = task_content.task_content_client_id
		INNER JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;


END