DELIMITER //
DROP PROCEDURE IF EXISTS `deleteTaskManagerKeyword`//
CREATE PROCEDURE `deleteTaskManagerKeyword`(
_userId INT(11),
_taskKeywordId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_keyword.task_keyword_id = ',_taskKeywordId);
	
	SET @IdQry1 = CONCAT(' UPDATE task_keyword SET task_keyword_record_status = 1 , task_keyword_modified_on = ',Quote(_dateTime), ', task_keyword_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END