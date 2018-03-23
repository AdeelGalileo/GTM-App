DELIMITER //
DROP PROCEDURE IF EXISTS `getKeywordSetupStatus`//
CREATE PROCEDURE `getKeywordSetupStatus`(
_userId INT(11),
_taskCloneId INT(11),
_taskCloneCommonId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_clone.task_clone_record_status=0 AND task_clone.task_clone_is_main_task=1 AND task_clone.task_clone_common_id = ',_taskCloneCommonId);
	
	SET @IdQry1 = CONCAT(' SELECT task_clone_id,task_clone_is_main_task,task_clone_task_id,task_clone_common_id,task_keyword_setup_complete
	
	FROM task_clone  
	INNER JOIN task_keyword ON task_keyword.task_keyword_id = task_clone.task_clone_task_id
	', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END