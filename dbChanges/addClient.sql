DELIMITER //
DROP PROCEDURE IF EXISTS addClient//
CREATE  PROCEDURE `addClient`(
	IN `_userId` INT(11),
	IN `_clientUpateId` INT(11),
	IN `_clientName` VARCHAR(255),
	IN `_clientStreet` VARCHAR(255),
	IN `_clientCity` VARCHAR(255),
	IN `_clientState` VARCHAR(255),
	IN `_clientZipcode` VARCHAR(50),
	IN `_clientCountry` VARCHAR(255),
	IN `_dateTime` datetime,
	IN `_recordStatus` TINYINT(1),
	IN `_clientQbRef` INT(11)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update client'
BEGIN
		IF(_clientUpateId > 0) THEN
			UPDATE client SET client_name = _clientName,client_street = _clientStreet, client_city = _clientCity,
			client_state = _clientState,client_zipcode = _clientZipcode, client_country = _clientCountry, client_modified_by = _userId, client_modified_on =  _dateTime,client_record_status=_recordStatus, client_qb_associated_reference=_clientQbRef WHERE client_id = _clientUpateId;
		ELSE
			INSERT INTO client(client_user_id,client_name,client_street,client_city,client_state,client_zipcode,client_country,client_record_status,client_created_by,client_created_on,client_modified_by,client_modified_on,client_qb_associated_reference)
			VALUES (_userId, _clientName,_clientStreet, _clientCity, _clientState, _clientZipcode, _clientCountry, 0,
			_userId,_dateTime,_userId,_dateTime,_clientQbRef);
		END IF;
END