DELIMITER //
DROP PROCEDURE IF EXISTS `getModules`//
CREATE PROCEDURE `getModules`()
BEGIN
	SELECT modules_id,modules_name,modules_record_status,modules_created_by,modules_created_on,modules_modified_by,modules_modified_on FROM modules WHERE modules_record_status = 0;
END