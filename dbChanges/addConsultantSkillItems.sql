DELIMITER //
DROP PROCEDURE IF EXISTS addConsultantSkillItems//
CREATE PROCEDURE `addConsultantSkillItems`(
	IN `_skillId` INT(11),
	IN `_serviceTypeIds` VARCHAR(255)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update consultant_skill items'
BEGIN
		
		DECLARE splitId INT(11);
		
		DECLARE splitIds VARCHAR(255);
		
		SET splitIds =  _serviceTypeIds;
		
		DELETE FROM consultant_skill_items WHERE csi_skill_id = _skillId;

		WHILE splitIds != '' DO
	
		SET splitId = SUBSTRING_INDEX(splitIds, ',', 1); 
		
		INSERT INTO consultant_skill_items(csi_skill_id,csi_service_type_id)VALUES(_skillId,splitId);
		
		IF LOCATE(',', splitIds) > 0 THEN
			SET splitIds = SUBSTRING(splitIds, LOCATE(',', splitIds) + 1);
		ELSE
			SET splitIds = '';
		END IF;
	
		END WHILE;

END