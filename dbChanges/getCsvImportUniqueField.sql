DELIMITER //
DROP PROCEDURE IF EXISTS getCsvImportUniqueField//
CREATE PROCEDURE `getCsvImportUniqueField`(
	IN `_importId` int
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT icf_id, icf_ic_id, icf_field_id, icf_field_name,  icf_user_id, icf_client_id, icf_is_unique 
	FROM import_csv_fields 
	WHERE icf_is_unique = 1 AND icf_ic_id = _importId;
END