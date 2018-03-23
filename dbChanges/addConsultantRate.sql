DELIMITER //
DROP PROCEDURE IF EXISTS addConsultantRate//
CREATE PROCEDURE `addConsultantRate`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_rateUpdateId` INT(11),
	IN `_rateUserId` INT(11),
	IN `_ratePerUnit` VARCHAR(255),
	IN `_serviceTypeId` INT(11),
	IN `_dateTime` DATETIME
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update consultant_rate'
BEGIN
	
	DECLARE _isExistRateId INT DEFAULT 0;

		IF(_rateUpdateId > 0) THEN
			UPDATE consultant_rate SET cons_rate_client_id = _clientId, cons_rate_per_unit = _ratePerUnit,
			cons_rate_modified_by = _userId,cons_rate_modified_on =  _dateTime WHERE cons_rate_id = _rateUpdateId;
		ELSE
		
			SELECT  cons_rate_id into _isExistRateId FROM consultant_rate WHERE cons_rate_user_id = _rateUserId AND cons_rate_client_id = _clientId AND cons_rate_service_type_id = _serviceTypeId AND consultant_rate.cons_rate_record_status=0;
			SET _isExistRateId = IFNULL(_isExistRateId,0);
			IF(_isExistRateId=0) THEN
				INSERT INTO consultant_rate(cons_rate_user_id,cons_rate_client_id,cons_rate_service_type_id,cons_rate_per_unit,cons_rate_record_status,cons_rate_created_by,cons_rate_created_on,cons_rate_modified_by,cons_rate_modified_on)
				VALUES (_rateUserId, _clientId,_serviceTypeId,_ratePerUnit,0,_userId,_dateTime,_userId,_dateTime);
			ELSE
				UPDATE consultant_rate SET cons_rate_client_id = _clientId,  cons_rate_per_unit = _ratePerUnit,
			cons_rate_modified_by = _userId,cons_rate_modified_on =  _dateTime WHERE cons_rate_id = _isExistRateId;
			END IF;
		
		END IF;
END