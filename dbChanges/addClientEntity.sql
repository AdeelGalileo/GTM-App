DELIMITER //
DROP PROCEDURE IF EXISTS addClientEntity//
CREATE PROCEDURE `addClientEntity`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_clientEntityUpateId` INT(11),
	IN `_marshaCode` VARCHAR(100),
	IN `_hotelName` VARCHAR(255),
	IN `_streetName` VARCHAR(255),
	IN `_cityName` VARCHAR(255),
	IN `_stateName` VARCHAR(255),
	IN `_zipCode` VARCHAR(50),
	IN `_countryName` VARCHAR(255),
	IN `_clientDivisionId` INT(11),
	IN `_dateTime` datetime

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update client_entity'
BEGIN

DECLARE _isExistId INT DEFAULT 0;

		IF(_clientEntityUpateId > 0) THEN
			UPDATE client_entity SET  client_entity_marsha_code = _marshaCode,client_entity_hotel_name = _hotelName,client_entity_street = _streetName,client_entity_city = _cityName,client_entity_state = _stateName,client_entity_zipcode = _zipCode,client_entity_country = _countryName, client_entity_division_id= _clientDivisionId, client_entity_modified_by= _userId,client_entity_modified_on =  _dateTime WHERE client_entity_id = _clientEntityUpateId;
		ELSE
		
			SELECT  client_entity_id into _isExistId FROM client_entity WHERE client_entity_client_id = _clientId AND client_entity_marsha_code = _marshaCode AND client_entity_record_status=0;
			SET _isExistId = IFNULL(_isExistId,0);
			
			IF(_isExistId=0) THEN
			
				INSERT INTO client_entity(client_entity_marsha_code,client_entity_hotel_name,client_entity_street,client_entity_city,client_entity_state,client_entity_zipcode,client_entity_country,client_entity_client_id,client_entity_user_id,client_entity_division_id,client_entity_record_status,client_entity_created_by,client_entity_created_on,client_entity_modified_by,client_entity_modified_on)
			VALUES (_marshaCode, _hotelName,_streetName, _cityName, _stateName, _zipCode, _countryName,_clientId,_userId, _clientDivisionId, 0,_userId,_dateTime,_userId,_dateTime);
			
			ELSE
				UPDATE client_entity SET  client_entity_hotel_name = _hotelName,client_entity_street = _streetName,client_entity_city = _cityName,client_entity_state = _stateName,client_entity_zipcode = _zipCode,client_entity_country = _countryName, client_entity_division_id= _clientDivisionId, client_entity_modified_by= _userId,client_entity_modified_on =  _dateTime WHERE client_entity_id = _isExistId;
			
			END IF;
			
		END IF;
END