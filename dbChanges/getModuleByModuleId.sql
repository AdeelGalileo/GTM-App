DELIMITER //
DROP PROCEDURE IF EXISTS getModuleByModuleId//
CREATE PROCEDURE `getModuleByModuleId`(
	IN `_modulesIp` INT(11)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'get division by marsha code'
BEGIN
	SELECT modules_id,modules_name,modules_desc,modules_record_status,modules_created_by,modules_created_on,modules_modified_by,modules_modified_on FROM modules WHERE modules_record_status = 0 AND modules_id=_modulesIp LIMIT 1;
	 
END