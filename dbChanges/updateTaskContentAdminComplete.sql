DELIMITER //
DROP PROCEDURE IF EXISTS `updateTaskContentAdminComplete`//
CREATE PROCEDURE `updateTaskContentAdminComplete`(
_userId INT(11),
_taskContentId INT(11),
_taskContentCompleteVal TINYINT(1),
_dateTime datetime,
_notes TEXT,
_taskReassignUserId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	IF(_taskContentCompleteVal = 2) THEN
		SET @IdQry1 = CONCAT(' UPDATE task_content  SET task_content_user_id = ',_taskReassignUserId,', task_content_admin_complete = ',_taskContentCompleteVal, ', task_content_admin_notes = ',Quote(_notes), ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	ELSE
		SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_admin_complete = ',_taskContentCompleteVal, ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	END IF;
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	INSERT INTO task_content_admin_complete(tcac_task_content_id,tcac_comp_status,tcac_record_status,tcac_created_by,tcac_created_on,tcac_modified_by,tcac_modified_on)
	VALUES (_taskContentId,_taskContentCompleteVal, 0 ,_userId, _dateTime, _userId, _dateTime);

END