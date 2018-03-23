DELIMITER //
DROP PROCEDURE IF EXISTS getMarshaCodes//
CREATE PROCEDURE `getMarshaCodes`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'get division by marsha code'
BEGIN
	SELECT client_entity_id,client_entity_marsha_code,division_id,division_code,division_name
	FROM client_entity 
	INNER JOIN division ON division_id = client_entity_division_id
	WHERE client_entity.client_entity_client_id=_clientId;
END