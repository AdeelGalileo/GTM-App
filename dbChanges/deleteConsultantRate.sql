DELIMITER //
DROP PROCEDURE IF EXISTS `deleteConsultantRate`//
CREATE PROCEDURE `deleteConsultantRate`(
_userId INT(11),
_rateDelId INT(11),
_dateTime datetime
)

BEGIN
	DECLARE QryCond TEXT;
	
	SET QryCond = CONCAT(' WHERE consultant_rate.cons_rate_id = ',_rateDelId);
	
	SET @IdQry1 = CONCAT(' UPDATE consultant_rate SET cons_rate_record_status = 1 , cons_rate_modified_on = ',Quote(_dateTime), ', cons_rate_modified_by = ',_userId, QryCond); 
	
	PREPARE stmt1 FROM @IdQry1;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

END