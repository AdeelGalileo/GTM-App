DELIMITER //
DROP PROCEDURE IF EXISTS `getClientById`//
CREATE PROCEDURE `getClientById`(
	IN `_clientId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT client_id,client_user_id,client_name,client_qb_associated_reference,client_street,client_city,client_state,client_zipcode,client_country,
	client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on
	FROM client WHERE  client_id = _clientId;
END