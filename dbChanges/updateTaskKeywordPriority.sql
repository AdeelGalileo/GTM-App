DELIMITER //
DROP PROCEDURE IF EXISTS `updateTaskKeywordPriority`//
CREATE PROCEDURE `updateTaskKeywordPriority`(
_userId INT(11),
_taskKeywordId INT(11),
_taskPriorityVal TINYINT(1),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_priority = ',_taskPriorityVal, ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END