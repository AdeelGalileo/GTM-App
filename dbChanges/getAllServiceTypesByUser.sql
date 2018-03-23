DELIMITER //
DROP PROCEDURE IF EXISTS `getAllServiceTypesByUser`//
CREATE PROCEDURE `getAllServiceTypesByUser`(_userId INT(11),_clientId INT(11))
BEGIN

	SELECT serv_type_id,serv_type_name,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on
	FROM consultant_skill_items
	INNER JOIN consultant_skill ON consultant_skill.cons_skill_id = consultant_skill_items.csi_skill_id AND consultant_skill.cons_record_status = 0 AND consultant_skill.cons_user_id = _userId
	INNER JOIN service_type ON service_type.serv_type_id = consultant_skill_items.csi_service_type_id
	WHERE consultant_skill.cons_client_id =_clientId;

END



