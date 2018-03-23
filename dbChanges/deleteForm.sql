DELIMITER //
DROP PROCEDURE IF EXISTS `deleteForm`//
CREATE PROCEDURE `deleteForm`(
_userId INT(11),
_formDelId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE form.form_id = ',_formDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE form SET form_record_status = 1 , form_modified_on = ',Quote(_dateTime), ', form_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END