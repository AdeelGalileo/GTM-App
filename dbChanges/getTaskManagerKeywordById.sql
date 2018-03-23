DELIMITER //
DROP PROCEDURE IF EXISTS `getTaskManagerKeywordById`//
CREATE PROCEDURE `getTaskManagerKeywordById`(
_userId INT(11),
_taskKeywordId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' SELECT user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name, user_role.user_role_record_status,client_entity_id,client_entity_marsha_code,division_id,division_code,division_name,
	task_keyword.task_keyword_id,task_keyword.task_keyword_marsha_code,task_keyword_tire,task_keyword.task_keyword_no_of_pages,task_keyword.task_keyword_notes,task_keyword.task_keyword_box_location,task_keyword.task_keyword_added_box_date,task_keyword.task_keyword_setup_due_date,task_keyword.task_keyword_setup_complete,task_keyword.task_keyword_due,task_keyword.task_keyword_submitted,task_keyword.task_keyword_user_id,task_keyword.task_keyword_link_db_file,task_keyword.task_keyword_date,task_keyword.task_keyword_admin_complete,task_keyword.task_keyword_client_id,task_keyword.task_keyword_admin_notes,task_keyword.task_keyword_record_status,task_keyword.task_keyword_created_by,task_keyword.task_keyword_created_on,task_keyword.task_keyword_modified_by,task_keyword.task_keyword_modified_on,task_keyword.task_keyword_priority,task_keyword.task_keyword_service_type_id,task_keyword.task_is_sub_task,task_clone_id,task_clone_task_id,task_clone_is_main_task,task_clone_common_id
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	LEFT  JOIN task_clone ON task_clone.task_clone_task_id = ',_taskKeywordId,'
	LEFT JOIN user ON user.user_id = task_keyword.task_keyword_user_id
	LEFT JOIN user_role ON user_role.user_role_id = user.user_role_id
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END