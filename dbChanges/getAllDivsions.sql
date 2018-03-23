DELIMITER //
DROP PROCEDURE IF EXISTS `getAllDivsions`//
CREATE PROCEDURE `getAllDivsions`()
BEGIN
	SELECT division_id,division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on FROM division WHERE division_record_status = 0;
END