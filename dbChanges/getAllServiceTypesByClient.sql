DELIMITER //
DROP PROCEDURE IF EXISTS `getAllServiceTypesByClient`//
CREATE PROCEDURE `getAllServiceTypesByClient`(_clientId INT(11))
BEGIN
	SELECT serv_type_id,serv_type_name,serv_type_client_id,serv_type_gal_rate,serv_type_freel_rate,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on FROM service_type WHERE serv_type_record_status = 0 AND serv_type_client_id =_clientId;
END