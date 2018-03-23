DELIMITER //
DROP PROCEDURE IF EXISTS addForm//
CREATE PROCEDURE `addForm`(
	IN `_userId` INT(11),
	IN `_clientId` INT(11),
	IN `_formUpdateId` INT(11),
	IN `_formUserId` INT(11),
	IN `_formFirstName` VARCHAR(255),
	IN `_formLastName` VARCHAR(255),
	IN `_formEmail` VARCHAR(100),
	IN `_formContactNo` VARCHAR(50),
	IN `_formStreet` VARCHAR(255),
	IN `_formCity` VARCHAR(255),
	IN `_formState` VARCHAR(255),
	IN `_formZipcode` VARCHAR(100),
	IN `_formCountry` VARCHAR(255),
	IN `_formWNine` VARCHAR(255),
	IN `_formResume` VARCHAR(255),
	IN `_formAch` VARCHAR(255),
	IN `_formConsultantAgree` VARCHAR(255),
	IN `_formNotes` TEXT,
	IN `_formNeeded`  TEXT,
	IN `_dateTime` DATETIME
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Insert or Update form'
BEGIN
		IF(_formUpdateId > 0) THEN
			UPDATE form SET form_user_id = _formUserId,form_client_id = _clientId, form_first_name = _formFirstName,
			form_last_name = _formLastName,form_email = _formEmail, form_contact_no = _formContactNo, form_street = _formStreet,
			form_city = _formCity,form_state = _formState,form_zipcode = _formZipcode,form_country = _formCountry,form_w_nine = _formWNine,form_resume = _formResume,form_ach = _formAch,form_consultant_agree = _formConsultantAgree,form_notes = _formNotes,form_needed = _formNeeded,form_modified_by = _userId,
			form_modified_on =  _dateTime WHERE form_id = _formUpdateId;
		ELSE
			INSERT INTO form(form_user_id,form_client_id,form_first_name,form_last_name,form_email,form_contact_no,form_street,form_city,form_state,form_zipcode,form_country,form_w_nine,form_resume,form_ach,form_consultant_agree,form_notes,form_needed,form_record_status,form_created_by,form_created_on,form_modified_by,form_modified_on)
			VALUES (_formUserId, _clientId,_formFirstName, _formLastName, _formEmail, _formContactNo, _formStreet, _formCity,_formState,_formZipcode,_formCountry,_formWNine,_formResume,_formAch,_formConsultantAgree,_formNotes,_formNeeded,0,_userId,_dateTime,_userId,_dateTime);
			
		END IF;
		
END