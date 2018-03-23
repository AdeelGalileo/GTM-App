DELIMITER //
DROP PROCEDURE IF EXISTS `getSubTaskCloneCommonId`//
CREATE PROCEDURE `getSubTaskCloneCommonId`(
_taskId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE task_clone.task_clone_record_status=0 AND task_clone.task_clone_task_id = ',_taskId);
	
	SET @IdQry1 = CONCAT(' SELECT task_clone_id,task_clone_task_id,task_clone_is_main_task,task_clone_common_id,task_clone_record_status,task_clone_created_by,task_clone_created_on
	FROM task_clone  ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END