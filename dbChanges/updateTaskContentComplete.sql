DELIMITER //
DROP PROCEDURE IF EXISTS `updateTaskContentComplete`//
CREATE PROCEDURE `updateTaskContentComplete`(
_userId INT(11),
_taskContentId INT(11),
_taskContentCompleteVal TINYINT(1),
_dateTime datetime,
_completedDate date
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_content.task_content_id = ',_taskContentId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_content SET task_content_is_complete = ',_taskContentCompleteVal,', task_content_proj_com_date = ',Quote(_completedDate), ', task_content_modified_on = ',Quote(_dateTime), ', task_content_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END