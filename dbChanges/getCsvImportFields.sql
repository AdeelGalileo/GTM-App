DELIMITER //
DROP PROCEDURE IF EXISTS getCsvImportFields//
CREATE PROCEDURE `getCsvImportFields`(
	IN `_csvImportId` int
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT ic_id,  ic_file_name,  ic_skip_header, ic_status,ic_user_id, ic_client_id, icf_ic_id, 
	icf_field_id, icf_field_name,  icf_client_id, icf_is_unique, ic_import_opt
	FROM import_csv_file 
	INNER JOIN import_csv_fields ON ic_id = icf_ic_id 
	WHERE ic_id = _csvImportId;
END