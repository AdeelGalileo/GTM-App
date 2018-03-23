DELIMITER //
DROP PROCEDURE IF EXISTS `getClientEntityById`//
CREATE PROCEDURE `getClientEntityById`(
	IN `_clientEntityId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT client.client_id,client.client_user_id,client.client_name,client_entity.client_entity_id,client_entity_marsha_code,client_entity_hotel_name,client_entity_client_id,client_entity_user_id,client_entity_division_id,division_code,division_name,client_entity_created_on,client_entity_record_status,client_entity_modified_by,client_entity_modified_on,client_entity_country,client_entity_street,client_entity_city,client_entity_state,client_entity_zipcode
	FROM client_entity  
	INNER JOIN client ON client.client_id = client_entity.client_entity_client_id
	INNER JOIN division ON division.division_id = client_entity.client_entity_division_id
	WHERE client_entity_record_status = 0 AND client_entity_id = _clientEntityId;
END