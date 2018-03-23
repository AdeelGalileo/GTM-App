DELIMITER //
DROP PROCEDURE IF EXISTS addDivision//
CREATE PROCEDURE `addDivision`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_divisionUpdateId` INT(11),
	IN `_divisionCode` VARCHAR(50),
	IN `_divisionName` VARCHAR(255),
	IN `_dateTime` datetime

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update division'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_divisionUpdateId > 0) THEN
			UPDATE division SET  division_code = _divisionCode,division_name = _divisionName,division_modified_by= _userId,division_modified_on =  _dateTime WHERE division_id = _divisionUpdateId;
		ELSE
		
			SELECT  division_id into _isExistId FROM division WHERE LOWER(division_code) =  LOWER(_divisionCode) AND division_client_id = _clientId AND division_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			
			IF(_isExistId=0) THEN
			
				INSERT INTO division(division_code,division_name,division_client_id,division_record_status,division_created_by,division_created_on,division_modified_by,division_modified_on)
			VALUES (_divisionCode, _divisionName,_clientId, 0,_userId,_dateTime,_userId,_dateTime);
			
			ELSE
				UPDATE division SET  division_name = _divisionName, division_modified_by= _userId,division_modified_on =  _dateTime WHERE division_id = _isExistId;
			
			END IF;
			
		END IF;
END