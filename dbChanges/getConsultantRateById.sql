DELIMITER //
DROP PROCEDURE IF EXISTS `getConsultantRateById`//
CREATE PROCEDURE `getConsultantRateById`(_rateId INT(11))
BEGIN
	SELECT consultant_rate.cons_rate_id,cons_rate_user_id,cons_rate_service_type_id,cons_rate_client_id,cons_rate_per_unit,cons_rate_record_status,cons_rate_created_by,cons_rate_created_on,cons_rate_modified_by,cons_rate_modified_on,user.user_id, user.user_fname, user.user_lname,  user.user_email,  user.user_record_status,  user_role.user_role_id,  user_role.user_role_name,  user_role.user_role_record_status, serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate
	FROM consultant_rate 
	INNER JOIN service_type ON service_type.serv_type_id = consultant_rate.cons_rate_service_type_id
	INNER JOIN user ON user.user_id = consultant_rate.cons_rate_user_id AND user.user_record_status = 0
	INNER JOIN user_role ON user_role.user_role_id = user.user_role_id
	WHERE cons_rate_record_status = 0 AND cons_rate_id = _rateId;
END