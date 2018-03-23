DELIMITER //
DROP PROCEDURE IF EXISTS `updateTaskContentPriority`//
CREATE PROCEDURE `updateTaskContentPriority`(
_userId INT(11),
_taskContentId INT(11),
_taskPriorityVal TINYINT(1),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_priority = ',_taskPriorityVal, ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END