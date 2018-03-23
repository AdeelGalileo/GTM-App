DELIMITER //
DROP PROCEDURE IF EXISTS addCsvImportFields//
CREATE PROCEDURE `addCsvImportFields`(
	IN `_csvImportId` INT(11),
	IN `_fieldId` INT(11),
	IN `_fieldName` VARCHAR(500),
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_isUnique` TINYINT(1)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	INSERT INTO import_csv_fields(icf_ic_id, icf_field_id, icf_field_name,icf_user_id, icf_client_id, icf_is_unique)
		VALUES (_csvImportId, _fieldId, _fieldName,_userId, _clientId, _isUnique);
	SELECT LAST_INSERT_ID() as csvFieldId;
END