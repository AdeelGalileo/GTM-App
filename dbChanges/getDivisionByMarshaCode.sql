DELIMITER //
DROP PROCEDURE IF EXISTS getDivisionByMarshaCode//
CREATE PROCEDURE `getDivisionByMarshaCode`(
	IN `_userId` INT(11),
	IN `_marshaCode` INT(11)
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
	WHERE client_entity.client_entity_id=_marshaCode LIMIT 1;
END