DELIMITER //
DROP PROCEDURE IF EXISTS `updateActivationLink`//
CREATE PROCEDURE `updateActivationLink`(
_userId INT(11),
_activationLink TEXT,
_dateExpire date
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE user.user_record_status=0 AND user.user_id = ',_userId);
	
	SET @IdQry1 = CONCAT(' UPDATE user SET  user_activation_link = ',Quote(_activationLink), ', user_activation_link_expire = ',Quote(_dateExpire), QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END