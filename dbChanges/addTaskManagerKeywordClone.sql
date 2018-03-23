DELIMITER //
DROP PROCEDURE IF EXISTS addTaskManagerKeywordClone//
CREATE PROCEDURE `addTaskManagerKeywordClone`(
	IN `_userId` INT(11),
	IN `_taskCloneTaskId` INT(11),
	IN `_taskCloneCommonId` INT(11),
	IN `_dateTime` datetime,
	IN `_isMainTask` INT(11)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update task_clone'
BEGIN
DECLARE _isExistId INT DEFAULT 0;

SELECT  task_clone_id into _isExistId FROM task_clone WHERE task_clone_task_id = _taskCloneTaskId  AND task_clone_record_status=0;
SET _isExistId = IFNULL(_isExistId,0);
IF(_isExistId=0) THEN
	INSERT INTO task_clone(task_clone_task_id,task_clone_common_id,task_clone_record_status,task_clone_created_by,task_clone_created_on,task_clone_is_main_task)
	VALUES (_taskCloneTaskId, _taskCloneCommonId ,0,_userId,_dateTime,_isMainTask);
END IF;
END