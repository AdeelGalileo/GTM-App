DELIMITER //
DROP PROCEDURE IF EXISTS updateCsvImport//
CREATE PROCEDURE `updateCsvImport`(
	IN `_csvImportId` int,
	IN `_hasHeader` tinyint,
	IN `_status` int,
	IN `_importOpt` int
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	UPDATE import_csv_file SET ic_skip_header = _hasHeader, ic_status = _status, ic_import_opt =_importOpt  WHERE ic_id = _csvImportId;
END