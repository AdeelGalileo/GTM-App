DELIMITER //
DROP PROCEDURE IF EXISTS getDivisionById//
CREATE PROCEDURE `getDivisionById`(
	IN `_clientId` INT(11),
	IN `_divisionId` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'get division by id'
BEGIN
	SELECT division.division_id,division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on
	FROM division 
	INNER JOIN client ON client.client_id = division.division_client_id AND client.client_record_status = 0
	WHERE division.division_id=_divisionId AND division_client_id = _clientId LIMIT 1;
END