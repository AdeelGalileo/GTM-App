DELIMITER //
DROP PROCEDURE IF EXISTS `getUserIdByTaskId`//
CREATE PROCEDURE `getUserIdByTaskId`(
_taskId INT(11),
_taskType TINYINT(1)
)

BEGIN
	DECLARE QryCond TEXT;
	
	IF(_taskType = 1) THEN
	
		SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_record_status=0 AND task_keyword.task_keyword_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT task_keyword_user_id AS moduleUserId, user_email, user.user_fname, user.user_lname FROM task_keyword  INNER JOIN user ON user.user_id = task_keyword.task_keyword_user_id ', QryCond, ' LIMIT 1'); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	
	ELSEIF(_taskType = 2) THEN
	
		SET QryCond = CONCAT(' WHERE task_content.task_content_record_status=0 AND task_content.task_content_id = ',_taskId);
		
		SET @IdQry1 = CONCAT(' SELECT task_content_user_id AS moduleUserId, user_email, user.user_fname, user.user_lname FROM task_content  INNER JOIN user ON user.user_id = task_content.task_content_user_id', QryCond, ' LIMIT 1'); 
		
		PREPARE stmt1 FROM @IdQry1;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
		
	END IF;
	
END