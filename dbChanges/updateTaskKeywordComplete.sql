DELIMITER //
DROP PROCEDURE IF EXISTS `updateTaskKeywordComplete`//
CREATE PROCEDURE `updateTaskKeywordComplete`(
_userId INT(11),
_taskKeywordId INT(11),
_taskKeywordCompleteVal TINYINT(1),
_dateTime datetime,
_completedDate date
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_setup_complete = ',_taskKeywordCompleteVal, ', task_keyword_date = ',Quote(_completedDate), ', task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END