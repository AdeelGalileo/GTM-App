DELIMITER //
DROP PROCEDURE IF EXISTS `updateTaskKeywordAdminComplete`//
CREATE PROCEDURE `updateTaskKeywordAdminComplete`(
_userId INT(11),
_taskKeywordId INT(11),
_taskKeywordCompleteVal TINYINT(1),
_dateTime datetime,
_notes TEXT,
_taskReassignUserId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	IF(_taskKeywordCompleteVal = 2) THEN
		SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_user_id = ',_taskReassignUserId,',  task_keyword_admin_complete = ',_taskKeywordCompleteVal, ', task_keyword_admin_notes = ',Quote(_notes), ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	ELSE
		SET @IdQry1 = CONCAT(' UPDATE task_keyword SET  task_keyword_admin_complete = ',_taskKeywordCompleteVal, ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	END IF;
		
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	
	INSERT INTO task_keyword_admin_complete(tkac_task_keyword_id,tkac_comp_status,tkac_record_status,tkac_created_by,tkac_created_on,tkac_modified_by,tkac_modified_on)
	VALUES (_taskKeywordId,_taskKeywordCompleteVal, 0 ,_userId, _dateTime, _userId, _dateTime);

END