DELIMITER //
DROP PROCEDURE IF EXISTS `getAllClients`//
CREATE PROCEDURE `getAllClients`()
BEGIN
	SELECT client_id,client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client 
	WHERE client_record_status = 0;
END