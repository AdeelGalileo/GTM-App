DELIMITER //
DROP PROCEDURE IF EXISTS geMarshaIdByMarshaCode//
CREATE PROCEDURE `geMarshaIdByMarshaCode`(
	IN `_marshaCode` VARCHAR(100)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'get marsha id by marsha code'
BEGIN
	SELECT client_entity_id
	FROM client_entity 
	WHERE client_entity.client_entity_marsha_code=_marshaCode LIMIT 1;
END