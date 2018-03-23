DELIMITER //
DROP PROCEDURE IF EXISTS addConsultantSkill//
CREATE PROCEDURE `addConsultantSkill`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_skillUpdateId` INT(11),
	IN `_skillUserId` INT(11),
	IN `_dateTime` DATETIME
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update consultant_skill'
BEGIN
DECLARE _isExistSkillId INT DEFAULT 0;

		IF(_skillUpdateId > 0) THEN
			UPDATE consultant_skill SET cons_user_id = _skillUserId,cons_client_id = _clientId,cons_modified_by = _userId,
			cons_modified_on =  _dateTime WHERE cons_skill_id = _skillUpdateId;
			SELECT _skillUpdateId AS skillId;
		ELSE
			SELECT  cons_skill_id into _isExistSkillId FROM consultant_skill WHERE cons_user_id = _skillUserId AND cons_client_id = _clientId AND consultant_skill.cons_record_status=0;
			SET _isExistSkillId = IFNULL(_isExistSkillId,0);
			IF(_isExistSkillId=0) THEN
				INSERT INTO consultant_skill(cons_client_id,cons_user_id,cons_record_status,cons_created_by,cons_created_on,cons_modified_by,cons_modified_on)
				VALUES (_clientId, _skillUserId,0, _userId, _dateTime, _userId, _dateTime);
				SELECT LAST_INSERT_ID() AS skillId;
			ELSE
				UPDATE consultant_skill SET cons_user_id = _skillUserId,cons_client_id = _clientId,cons_modified_by = _userId,
				cons_modified_on =  _dateTime WHERE cons_skill_id = _isExistSkillId;
				SELECT _isExistSkillId AS skillId;
			END IF;
		END IF;
END