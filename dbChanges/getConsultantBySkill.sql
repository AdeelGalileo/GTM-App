DELIMITER //
DROP PROCEDURE IF EXISTS `getConsultantBySkill`//
CREATE PROCEDURE `getConsultantBySkill`(
_skillId INT(11),
_clientId INT(11),
_formStatus TINYINT(11)
)
BEGIN
SELECT user_id,user_fname,user_lname,consultant_skill_items.csi_skill_id, consultant_skill_items.csi_service_type_id , consultant_skill.cons_user_id
FROM consultant_skill_items
INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = consultant_skill_items.csi_skill_id AND consultant_skill.cons_record_status = 0
INNER JOIN user ON  user.user_id = consultant_skill.cons_user_id AND user.user_record_status = 0 AND user.user_role_id = 4 AND user.user_form_completed = _formStatus
WHERE consultant_skill_items.csi_service_type_id = _skillId AND consultant_skill.cons_client_id =_clientId;
END