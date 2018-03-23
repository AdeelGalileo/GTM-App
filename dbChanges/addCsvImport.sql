DELIMITER //
DROP PROCEDURE IF EXISTS addCsvImport//
CREATE PROCEDURE `addCsvImport`(
	IN `_csvFileName` VARCHAR(500),
	IN `_importOpt` TINYINT(1),
	IN `_importType` TINYINT(1),
	IN `_importKeywordDate` DATE,
	IN `_importStatus` TINYINT(1),
	IN `_uniqueField` INT(11),
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_sysDate` DATETIME
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	INSERT INTO import_csv_file (ic_file_name,ic_import_opt,ic_import_type,ic_import_keyword_date,ic_status,ic_record_status,ic_user_id,ic_client_id,ic_unique_field,created_by, created_date,updated_date) 
	VALUES (_csvFileName,_importOpt,_importType,_importKeywordDate,_importStatus,0,_userId,_clientId,_uniqueField,_userId,_sysDate,_sysDate);
	SELECT LAST_INSERT_ID() AS importCsvID;
END