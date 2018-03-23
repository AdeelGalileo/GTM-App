DELIMITER //
DROP PROCEDURE IF EXISTS addClientDivision//
CREATE PROCEDURE `addClientDivision`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_clientQbRefUpateId` INT(11),
	IN `_clientDivisionId` INT(11),
	IN `_clientQbId` INT(11),
	IN `_clientQbClass` INT(11),
	IN `_dateTime` datetime

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update client_qb_reference'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_clientQbRefUpateId > 0) THEN
			UPDATE client_qb_reference SET  client_qb_ref_division_id = _clientDivisionId,client_qb_ref_qb_id = _clientQbId,client_qb_ref_qb_class = _clientQbClass, client_qb_ref_modified_by= _userId,client_qb_ref_modified_on =  _dateTime WHERE client_qb_ref_id = _clientQbRefUpateId;
		ELSE
		
			SELECT  client_qb_ref_id into _isExistId FROM client_qb_reference WHERE client_qb_ref_client_id = _clientId AND client_qb_ref_division_id = _clientDivisionId AND client_qb_ref_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			
			IF(_isExistId=0) THEN
			
				INSERT INTO client_qb_reference(client_qb_ref_client_id,client_qb_ref_division_id,client_qb_ref_qb_id,client_qb_ref_qb_class,client_qb_ref_record_status,client_qb_ref_created_by,client_qb_ref_created_on,client_qb_ref_modified_by,client_qb_ref_modified_on)
			VALUES (_clientId, _clientDivisionId,_clientQbId, _clientQbClass, 0,_userId,_dateTime,_userId,_dateTime);
			
			ELSE
				UPDATE client_qb_reference SET  client_qb_ref_division_id = _clientDivisionId,client_qb_ref_qb_id = _clientQbId,client_qb_ref_qb_class = _clientQbClass, client_qb_ref_modified_by= _userId,client_qb_ref_modified_on =  _dateTime WHERE client_qb_ref_id = _isExistId;
			
			END IF;
			
		END IF;
END