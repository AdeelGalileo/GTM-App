DELIMITER //
DROP PROCEDURE IF EXISTS `checkActivationLink`//
CREATE PROCEDURE `checkActivationLink`(
_userId INT(11),
_activationCode TEXT
)

BEGIN
	DECLARE QryCond TEXT;
	
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 AND user.user_id = ',_userId, ' AND user.user_activation_link = ',Quote(_activationCode));
	
	SET @IdQry1 = CONCAT(' SELECT user_id,user_activation_link,user_activation_link_expire FROM user ', QryCond, ' LIMIT 1'); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END