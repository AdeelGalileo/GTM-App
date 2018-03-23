DELIMITER //
DROP PROCEDURE IF EXISTS `getAllUserRoles`//
CREATE PROCEDURE `getAllUserRoles`()
BEGIN
	SELECT user_role_id,user_role_name,user_role_record_status,user_role_created_by,user_role_created_on,user_role_modified_by,user_role_modified_on FROM user_role WHERE user_role_record_status = 0;
END