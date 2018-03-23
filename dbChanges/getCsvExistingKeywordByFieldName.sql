DELIMITER //
DROP PROCEDURE IF EXISTS getCsvExistingKeywordByFieldName//
CREATE PROCEDURE `getCsvExistingKeywordByFieldName`(
	IN `_fieldName` varchar(255),
	IN `_userId` int(11),
	IN `_clientId`  int(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SET @Query = CONCAT('SELECT task_keyword_id, client_entity_marsha_code,  ', _fieldName ,' 
	FROM task_keyword 
	INNER JOIN client_entity ON client_entity.client_entity_id = task_keyword.task_keyword_marsha_code
	WHERE task_keyword_client_id = ',_clientId, ' AND task_keyword_created_by =', _userId);
	PREPARE stmnt FROM @Query;
	EXECUTE stmnt;
END