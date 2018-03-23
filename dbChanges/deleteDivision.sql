DELIMITER //
DROP PROCEDURE IF EXISTS `deleteDivision`//
CREATE PROCEDURE `deleteDivision`(
_userId INT(11),
_deleteId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE division.division_id = ',_deleteId);
	
	SET @IdQry1 = CONCAT(' UPDATE division SET division_record_status = 1 , division_modified_on = ',Quote(_dateTime), ', division_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END