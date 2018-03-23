DELIMITER //
DROP PROCEDURE IF EXISTS `deleteSkill`//
CREATE PROCEDURE `deleteSkill`(
_userId INT(11),
_skillDelId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE consultant_skill.cons_skill_id = ',_skillDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE consultant_skill SET cons_record_status = 1 , cons_modified_on = ',Quote(_dateTime), ', cons_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END