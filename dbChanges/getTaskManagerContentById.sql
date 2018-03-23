DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskManagerContentById`//
CREATE PROCEDURE `getTaskManagerContentById`(
_userId INT(11),
_taskContentId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_content.task_content_id,task_content.task_content_marsha_code,task_content.task_content_service_type_id,task_content.task_content_tire,task_content.task_content_priority,task_content.task_content_added_box_date,task_content.task_content_due_date,task_content.task_content_due_plus_date,task_content.task_content_added_box_due_date,task_content.task_content_rev_req,task_content.task_content_rev_com,task_content.task_content_rev_sec_req,task_content.task_content_rev_sec_com,task_content.task_content_ass_writer_date,task_content.task_content_is_complete,task_content.task_content_proj_com_date,task_content.task_content_user_id,task_content.task_content_no_of_units,task_content.task_content_link_to_file,task_content.task_content_notes,task_content.task_content_record_status,task_content.task_content_created_by,task_content.task_content_created_on,task_content.task_content_modified_by,task_content.task_content_modified_on,service_type.serv_type_id,service_type.serv_type_name,task_content.task_content_upload_link
	FROM task_content 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_content.task_content_marsha_code
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id 
	LEFT JOIN user ON user.user_id = task_content.task_content_user_id
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id
	LEFT JOIN service_type ON service_type.serv_type_id = task_content.task_content_service_type_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END