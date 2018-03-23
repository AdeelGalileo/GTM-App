DELIMITER //
DROP PROCEDURE IF EXISTS `getConsultantSkillById`//
CREATE PROCEDURE `getConsultantSkillById`(_skillId INT(11))
BEGIN
	SELECT consultant_skill.cons_skill_id,cons_client_id,cons_user_id,cons_record_status,cons_created_by,cons_created_on,cons_modified_by,cons_modified_on
	FROM  consultant_skill
	WHERE cons_record_status = 0 AND cons_skill_id = _skillId;
	
	SELECT consultant_skill.cons_skill_id ,GROUP_CONCAT(serv_type_name) AS service_type ,GROUP_CONCAT(serv_type_id) AS service_type_id
	FROM service_type
	INNER JOIN consultant_skill_items ON csi_service_type_id = serv_type_id
	INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = csi_skill_id
	WHERE consultant_skill.cons_skill_id = _skillId AND consultant_skill.cons_record_status = 0
	GROUP BY consultant_skill.cons_skill_id;
END