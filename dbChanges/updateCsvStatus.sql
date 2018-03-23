DELIMITER //
DROP PROCEDURE IF EXISTS updateCsvStatus//
CREATE PROCEDURE `updateCsvStatus`(
	IN `_csvImportId` int,
	IN `_status` int,
	IN `_sysTime` datetime
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	UPDATE import_csv_file SET ic_status = _status, updated_date = _sysTime WHERE ic_id = _csvImportId;
END