DELIMITER //
DROP PROCEDURE IF EXISTS `getFormStatus`//
CREATE PROCEDURE `getFormStatus`(
_clientId INT(11),
_formUserId INT(11)
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE form.form_client_id= ',_clientId,' AND form.form_user_id= ',_formUserId);
	
	SET @IdQry1 = CONCAT(' SELECT * FROM form ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END