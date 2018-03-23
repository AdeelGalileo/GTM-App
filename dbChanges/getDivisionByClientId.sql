DELIMITER //
DROP PROCEDURE IF EXISTS getDivisionByClientId//
CREATE PROCEDURE `getDivisionByClientId`(
	IN `_clientId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'get division by marsha code'
BEGIN
	SELECT client_id,division_id,division_code,division_name
	FROM division 
	INNER JOIN client ON client.client_id = division.division_client_id
	WHERE division.division_client_id=_clientId;
END