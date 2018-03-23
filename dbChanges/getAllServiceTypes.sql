DELIMITER //
DROP PROCEDURE IF EXISTS `getAllServiceTypes`//
CREATE PROCEDURE `getAllServiceTypes`()
BEGIN
	SELECT serv_type_id,serv_type_name,serv_type_record_status,serv_type_created_by,serv_type_created_on,serv_type_modified_by,serv_type_modified_on FROM service_type WHERE serv_type_record_status = 0;
END