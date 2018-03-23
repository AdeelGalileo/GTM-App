DELIMITER //
DROP PROCEDURE IF EXISTS `getMaxTaskCloneCommonId`//
CREATE PROCEDURE `getMaxTaskCloneCommonId`()
BEGIN
	SELECT IF(MAX(task_clone_common_id)+1 IS NULL, 1, MAX(task_clone_common_id)+1)  AS commonId FROM task_clone;
END